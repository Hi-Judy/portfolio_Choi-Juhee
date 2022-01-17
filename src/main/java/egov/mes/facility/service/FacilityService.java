package egov.mes.facility.service;

import java.util.List;

import egov.mes.facility.dao.FacilityVO;

public interface FacilityService {
	List<FacilityVO> facilityList(FacilityVO facility) ;
	List<FacilityVO> findFacility(FacilityVO facility) ;
	List<FacilityVO> facilityBreakInfo(FacilityVO facility) ;
}
