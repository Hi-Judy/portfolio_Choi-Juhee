package egov.mes.manufacture.command.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manCommandMapper")
public interface ManCommandMapper {

	//생산계획 디테일 조회(생산지시 관리 페이지)
	List<ManCommandVO> selectManPlan(ManCommandVO commandVO);
	
	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO);
}
