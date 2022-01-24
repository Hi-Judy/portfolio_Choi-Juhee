package egov.mes.manufacture.command.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manCommandMapper")
public interface ManCommandMapper {
	
	//생산지시번호 시퀀스
	String selectSeq();
	
	//계획디테일 테이블에 '생산지시중'으로 변경
	int updatePlanStatus(ManCommandVO commandVO);
	
	//자재 테이블에 출고량, 생산지시디테일 번호 넣어주기
	int insertRes(ManCommandVO commandVO);
	
	//생산 지시 테이블 insert
	int insertCommand(ManCommandVO commandVO);
	
	//생산 지시 디테일 테이블 insert
	int insertCommandDetail(ManCommandVO commandVO);

	//지시가 없는 생산계획 디테일 조회(생산지시 관리 페이지)
	List<ManCommandVO> selectManPlan(ManCommandVO commandVO);
	
	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO);
	
	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	List<ManCommandVO> selectRes(ManCommandVO commandVO);

	//제품 만드는데 필요한 공정에 해당하는 설비 조회
	List<ManCommandVO> selectFac(ManCommandVO commandVO);
	
	//자재코드에 해당하는 자재LOT 조회
	List<ManCommandVO> selectResLot(ManCommandVO commandVO);
	
	//이전 생산지시 조회
	List<ManCommandVO> selectPreCommand(ManCommandVO commandVO);
	

}
