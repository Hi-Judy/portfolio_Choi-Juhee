package egov.mes.facility.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.facility.dao.FacilityMapper;
import egov.mes.facility.dao.FacilityVO;
import egov.mes.facility.service.FacilityService;

@Service
public class FacilityServiceImpl implements FacilityService {

	@Autowired FacilityMapper mapper ;

	@Override
	public List<FacilityVO> facilityList(FacilityVO facility) {
		return mapper.facilityList(facility) ;
	}

	@Override
	public List<FacilityVO> findFacility(FacilityVO facility) {
		return mapper.findFacility(facility) ;
	}
	
}
