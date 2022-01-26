package egov.mes.manufacture.command.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.command.dao.ManCommandMapper;
import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Service("manCommandService")
public class ManCommandServiceImpl implements ManCommandService{

	@Autowired
	private ManCommandMapper mapper;
	
	
	//지시가 없는 생산계획 디테일 조회(생산지시 관리 페이지)
	@Override
	public List<ManCommandVO> selectManPlan(ManCommandVO commandVO) {
		return mapper.selectCommand(commandVO);
	}

	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	@Override
	public List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO) {
		return mapper.selectManPlanDetail(commandVO);
	}
	
	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	@Override
	public List<ManCommandVO> selectRes(ManCommandVO commandVO) {
		return mapper.selectRes(commandVO);
	}

	//제품 만드는데 필요한 공정에 해당하는 설비 조회
	@Override
	public List<ManCommandVO> selectFac(ManCommandVO commandVO) {
		return mapper.selectFac(commandVO);
	}

	//자재코드에 해당하는 자재LOT 조회
	@Override
	public List<ManCommandVO> selectResLot(ManCommandVO commandVO) {
		return mapper.selectResLot(commandVO);

	}

	//이전 생산지시 조회
	@Override
	public List<ManCommandVO> selectPreCommand(ManCommandVO commandVO) {
		return mapper.selectPreCommand(commandVO);
	}

	
	//히든그리드 내용
	@Override
	public int hidden(Map<String, List<ManCommandVO>> commandVO ) {
		
		//생산지시 추가
		System.out.println("1");
		String seq = ( ( mapper.selectSeq() ) ); //시퀀스 쿼리 실행해서 seq 변수에 담기
		System.out.println(seq);
		
		ManCommandVO insertVO = new ManCommandVO();
		insertVO = (commandVO.get("command")).get(0); //vo 객체에 히든 그리드 command의 한 행을 담기
		System.out.println("2");
		
		insertVO.setComCode(seq); //히든그리드 command를 담은 vo객체에 시퀀스 담기
		System.out.println("3");
		System.out.println( "생산지시추가: "+ insertVO);
		
		mapper.insertCommand( insertVO ); //히든그리드 command를 매개변수로 쿼리 실행
		System.out.println("4");
		
		
		//생산지시 디테일 추가
		ManCommandVO insertDetailVO = new ManCommandVO();
		insertDetailVO = (commandVO.get("commandDetail")).get(0); //vo 객체에 히든 그리드 command의 한 행을 담기
		
		insertDetailVO.setComCode(seq);
		System.out.println( "생산지시 디테일 추가: "+ insertDetailVO);
		
		mapper.insertCommandDetail(insertDetailVO);
		
		
		//계획디테일 테이블에 '생산지시중'으로 변경
		ManCommandVO planVO = new ManCommandVO();
		planVO = (commandVO.get("plan")).get(0);
		
		planVO.setComCode(seq);
		System.out.println("생산지시중 변경: "+ planVO);
		
		mapper.updatePlanStatus(planVO);
		
		
		//자재 테이블에 출고량, 생산지시디테일 번호 넣어주기
		String resSeq = ( ( mapper.selectResSeq() ) ); //자재에서 쓸 생산지시 디테일 번호
		
		List<ManCommandVO> voList = new ArrayList<>();
		voList = (commandVO.get("res"));
		
		if(voList.size() != 0) { //VO에 담긴 자재코드에 값이 있으면
			for(ManCommandVO vo : voList) {//VO에 담긴 자재코드 갯수 만큼 for문. 안에서 쿼리돌기
				vo.setComCode(resSeq);
				System.out.println("자재테이블 추가: " + voList);

				mapper.insertRes(vo);
			}
		
		}
		
		return 0;
	}
	
	
	//생산지시서 조회(지시서 조회 페이지)
	@Override
	public List<ManCommandVO> selectCommand(ManCommandVO commandVO) {
		return mapper.selectCommand(commandVO);
	}
	
	

}
