package egov.mes.manufacture.command.service.impl;

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
		return mapper.selectManPlan(commandVO);
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
		String seq = ( ( mapper.selectSeq() ) ); //시퀀스 쿼리를 변수에 담기
		System.out.println("시퀀스: "+seq);
		
		ManCommandVO insertVO = new ManCommandVO();
		insertVO = (commandVO.get("command")).get(0); //새로 만든 vo객체에 히든 그리드 command 의 첫번째 행을 담는다.
		System.out.println( "생산지시추가:"+ insertVO );
		System.out.println("2");
		
		insertVO.setComCode(seq); //히든 그리드 command 의 첫번째 행에 시퀀스를 설정해주고.
		System.out.println("3");
		
		mapper.insertCommand( insertVO ); //시퀀스까지 담긴 히든그리드 command를 매개변수로 쿼리 실행
		System.out.println("4");
		
		
		//생산지시 디테일 추가
		ManCommandVO insertDetailVO = new ManCommandVO();
		insertDetailVO = (commandVO.get("commandDetail")).get(0);
		System.out.println( "생산지시 디테일 추가:"+ insertDetailVO );
		
		insertDetailVO.setComCode(seq);
		mapper.insertCommandDetail(insertDetailVO);
		
		
		//
		
//		mapper.insertCommandDetail((commandVO.get("commandDetail").get(0)).setComCode((mapper.selectSeq()).getComCode()));
//		mapper.insertRes((commandVO.get("res").get(0)).setComCode((mapper.selectSeq()).getComCode()));
//		mapper.updatePlanStatus((commandVO.get("plan").get(0)).setComCode((mapper.selectSeq()).getComCode()));
		
		
		
		
		
		return 0;
	}

	

	

	
	
	

}
