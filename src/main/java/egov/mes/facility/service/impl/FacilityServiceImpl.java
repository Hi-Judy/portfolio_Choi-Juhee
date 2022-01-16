package egov.mes.facility.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.facility.dao.FacilityMapper;
import egov.mes.facility.service.FacilityService;

@Service
public class FacilityServiceImpl implements FacilityService {

	@Autowired FacilityMapper mapper ;
	
}
