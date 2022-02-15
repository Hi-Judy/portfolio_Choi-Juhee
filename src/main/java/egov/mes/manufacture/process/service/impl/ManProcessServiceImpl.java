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
		System.out.println("pList: "+pList);
		
		for(ManProcessVO pVO : pList) {
			pVO.setPodtCode(processVO.getPodtCode());
			mapper.insertProcess(pVO);
			System.out.println("공정 현황 INSERT TEST: "+ pVO);
		}
		//System.out.println("UPDATE TEST...ㅠㅠ" + mapper.updateFirstProc(processVO));
		
		return processVO;
	}
	
	
	//첫번째 공정이 시작되면 지시 테이블에 '생산중'으로 변경 -> 시작시간 update
	@Override
	public int updateFirstProc(ManProcessVO processVO) {
		
		mapper.updateComEtc(processVO);
		return mapper.updateFirstProc(processVO);
	}
	
	
	//스케쥴러
	@Scheduled(fixedDelay=5000)
	public void selectProcessTimer() { 
		
		List<ManProcessVO> pList = new ArrayList<>(); 
		pList = mapper.selectProcTable(); 
		//System.out.println("스케쥴러 pList: "+ pList);
		
		for(ManProcessVO processVO : pList) {
			//System.out.println("스케쥴러"+processVO);
			if(!processVO.getProcCode().equals("PROC011")) { //마지막 공정이 아니면
				
				if( (mapper.selectNextProc(processVO)).getManStarttime().equals("0") ) {//다음 공정의 시작 시간이 0이면
				
					mapper.updateNowProc(mapper.selectNextProc(processVO));
				}	
			}
			
			
			if (Integer.parseInt(processVO.getManGoalqnt()) > Integer.parseInt(processVO.getManQnt()) ) {
				
				ManProcessVO secondQnt = mapper.selectSecondQnt(processVO); //해당 공정의 10초당 생산량
				
				processVO.setManQnt(String.valueOf((Integer.parseInt(secondQnt.getQntPer10Second()) 
						+ Integer.parseInt(processVO.getManQnt()) ) ) ); 
				
				if(processVO.getProcCode().equals("PROC001")) { 

					if(Integer.parseInt(processVO.getManGoalqnt()) <= 
							Integer.parseInt(processVO.getManQnt())) {
						mapper.updateManQnt(processVO);
					} else {
						mapper.updateSecondQnt(processVO);
					}
					
				}else if(mapper.selectPreManQnt(processVO) != null 
						&& 
						Integer.parseInt( (mapper.selectPreManQnt(processVO)).getManQnt() ) >= 
							Integer.parseInt(processVO.getManQnt() ) ) {
				
					mapper.updateSecondQnt(processVO);
				}
				
			} 
			
			
			if(Integer.parseInt(processVO.getManGoalqnt()) <= Integer.parseInt(processVO.getManQnt()) //현재 공정의 종료시간 update
//			   &&
//			   //앞전 공정의 종료시간에 값이 들어오면
//			   mapper.selectPreEndTime(processVO).getManEndtime() != null
			   ) {
				//System.out.println("앞전공정의 종료시간: "+processVO.getProcCode() +mapper.selectPreEndTime(processVO).getManEndtime());
				mapper.updateEndTime(processVO);
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
		//System.out.println("impl: "+processVO);
		return mapper.selectProcess(processVO);
	}

	//생산중 & 생산완료 제품에 해당하는 공정 정보
	@Override
	public List<ManProcessVO> findProcess(ManProcessVO processVO) {
		return mapper.findProcess(processVO);
	}


}