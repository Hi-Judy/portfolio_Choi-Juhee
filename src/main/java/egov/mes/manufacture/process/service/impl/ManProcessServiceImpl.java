package egov.mes.manufacture.process.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.process.dao.ManProcessMapper;
import egov.mes.manufacture.process.dao.ManProcessVO;
import egov.mes.manufacture.process.service.ManProcessService;

@Service("manProcessService")
public class ManProcessServiceImpl implements ManProcessService {
	
	@Autowired
	private ManProcessMapper mapper;
	
	//진행공정 테이블을 조회한 시점의 생산완료량 vs 스케쥴러에서 추가된 생산량 비교
	//두 가지 값이 같지 않다면(10초가 지나서 값이 추가 되었다면)
	//화면에 변화시켜줄 무한 루프를 만든다
	//작업완료량 합계에 변화가 있으면 화면에 보여주기
	@Override
	public List<ManProcessVO> selectSumManQnt(ManProcessVO processVO) {
		String sumQnt = mapper.selectSumManQnt(processVO); 
		//System.out.println(processVO);
		//System.out.println("생산량 합계111: "+ sumQnt);
		
		while(true) {
			String sumQnt2 = mapper.selectSumManQnt(processVO);
			//System.out.println("생산량 합계222: "+ sumQnt2);
			if( !sumQnt.equals(sumQnt2) ) {
				return mapper.selectProcList(processVO);
			}
		}
		
	}

	
	//시작버튼 누르면 진행공정 테이블에 값 추가
	@Override
	public ManProcessVO selectProc(ManProcessVO processVO) {
		List<ManProcessVO> pList = new ArrayList<>();
		pList = mapper.selectProc(processVO);
		System.out.println(pList.size());
		
		for(ManProcessVO pVO : pList) {
			pVO.setPodtCode(processVO.getPodtCode());
			mapper.insertProcess(pVO);
			System.out.println("0202 INSERT TEST: "+ pVO);
		}
		//System.out.println("UPDATE TEST...ㅠㅠ" + mapper.updateFirstProc(processVO));
		
		return processVO;
	}
	
	
	//첫 번째 공정만 시작시간을 sysdate로 업데이트
	@Override
	public int updateFirstProc(ManProcessVO processVO) {
		
		mapper.updateComEtc(processVO);
		return mapper.updateFirstProc(processVO);
	}
	
	
	//스케쥴러
	@Scheduled(fixedDelay=10000) //10초마다 실행된다(10000). 5초마다 실행된다.(5000)
	public void selectProcessTimer() { // 주기적으로 실행될 processTimer
		
		//주기적으로 진행공정 테이블을 조회해온다. 조회한 행들을 담아줄 배열 pList
		List<ManProcessVO> pList = new ArrayList<>(); 
		pList = mapper.selectProcTable(); 
//		System.out.println("주기적으로 진행공정 테이블을 조회 111: "+ pList);
		
		for(ManProcessVO processVO : pList) { //주기적으로 조회한 행들 갯수만큼 for문
			
//			System.out.println("000");
//			
//			//System.out.println("주기적으로 진행공정 테이블을 조회 222:  "+ processVO);
//			System.out.println("이전공정 조회: " + mapper.selectPreManQnt(processVO));
//			System.out.println("다음공정 조회:  "+ mapper.selectNextProc(processVO));
			
			System.out.println("!*111*다음 공정의 시작 시간이 0");
			if((mapper.selectNextProc(processVO)).getManStarttime().equals("0") //다음 공정의 시작 시간이 0이면
				&& (mapper.selectPreManQnt(processVO)).getManQnt() != null 	//이전 공정의 작업완료량이 null이 아니면(값이 들어오면)
					) {  //다음공정 시작시간 update
				System.out.println("111");
				System.out.println("현재 공정 찾아서 시간 값 추가");
				System.out.println(processVO.getProcCode() + " : " + processVO.getManQnt());
				
				mapper.updateNowProc(mapper.selectNextProc(processVO));
				
				//현재 공정의 인덱스와 마지막 공정의 인덱스가 같지 않으면 (마지막 공정 전 모든 공정) -> 현재 공정을 update
				
			}
//			else if((mapper.selectNextProc(processVO)).getManStarttime().equals("0")) {
////				System.out.println("***************eeeeee*******");
//				mapper.updateNowProc(mapper.selectNextProc(processVO));
//			}
			
			//작업 목표량이 실제 작업 완료량보다 크면 10초당 생산량을 up.
			System.out.println("!*111*작업 목표량이 실제 작업 완료량보다 크면 10초당 생산량을 up");
			if (Integer.parseInt(processVO.getManGoalqnt()) > Integer.parseInt(processVO.getManQnt())) {
				ManProcessVO secondQnt = mapper.selectSecondQnt(processVO); //10초당 생산량 조회
				
//				System.out.println("222");
//				System.out.println(secondQnt);
				
				//기존의 생산량 + 10초당 생산량 => VO의 작업완료량에 set해주기
				processVO.setManQnt(String.valueOf((Integer.parseInt(secondQnt.getQntPer10Second()) 
						+ Integer.parseInt(processVO.getManQnt()) ) ) ); 
				
//				System.out.println("스케쥴러 테스트2: "+processVO);
				
				System.out.println("!*111*proc001이면 10초가 지났을 때 작업완료량 update");
				if(processVO.getProcCode().equals("PROC001")) { //proc001이면 10초가 지났을 때 작업완료량 update
//					System.out.println("333");
					mapper.updateSecondQnt(processVO);
//					System.out.println("진행공정 TEST11: "+ processVO);
				} 
				
				//proc001이 아니고, 현재 공정 앞전 공정의 생산수량이 있으면,
				//앞전 공정의 작업완료량이 무조건 뒷 공정보다 많으면,
				//10초가 지났을 때 작업완료량 update
//				System.out.println("!*111*10초가 지났을 때 작업완료량 update");
				else if(mapper.selectPreManQnt(processVO) != null 
						&& Integer.parseInt((mapper.selectPreManQnt(processVO)).getManQnt()) >= 
							Integer.parseInt(processVO.getManQnt()) + ( Integer.parseInt(secondQnt.getQntPer10Second()) )
					   ) {
//								System.out.println("진행공정 TEST22: "+ processVO);
//								if((mapper.selectNextProc(processVO).getManStarttime())==null) { //현재공정(vo)을 조회해왔을 때 거기의 startTime== null => sysdate 로 update
//									System.out.println("다음공정 찾기");
//									mapper.updateNowProc(processVO);
//									System.out.println("444");
//								}
								System.out.println("444");
								System.out.println(processVO.getProcCode() + " : " + processVO.getManQnt());
								mapper.updateSecondQnt(processVO);
								
						}
				//작업 지시량 < 현재 공정의 축적된 10초당 uph (최종 작업량)
				//작업 지시량만큼 생산하고 끝내라.
//				else if(Integer.parseInt(mapper.selectManGoalQnt(processVO)) <= 
//						Integer.parseInt(processVO.getManQnt()) + ( Integer.parseInt(secondQnt.getQntPer10Second()) )) {
//					
//				}
				
			} 
			
		System.out.println("!*111*작업지시량만큼 update");
		if(Integer.parseInt(processVO.getManGoalqnt()) <= Integer.parseInt(processVO.getManQnt())) {
			System.out.println("표시: "+processVO);
			mapper.updateEndTime(processVO);
			System.out.println("작업지시량만큼 update");
			mapper.updateManQnt(processVO);
		}
		
		}
		
	}

	//생산지시서 조회
	@Override
	public List<ManProcessVO> selectCommand(ManProcessVO processVO) {
	return mapper.selectCommand(processVO);
	}

	
	//지시된 제품에 해당하는 공정 조회
	@Override
	public List<ManProcessVO> selectProcess(ManProcessVO processVO) {
		return mapper.selectProcess(processVO);
	}


}