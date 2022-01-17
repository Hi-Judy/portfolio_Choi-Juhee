package egov.mes.facility.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("facilityMapper")
public interface FacilityMapper {
	List<FacilityVO> facilityList(FacilityVO facility) ;
	List<FacilityVO> findFacility(FacilityVO facility) ;
	List<FacilityVO> facilityBreakInfo(FacilityVO facility) ;
	void facilityStatusUpdate(FacilityVO facility) ;
}
