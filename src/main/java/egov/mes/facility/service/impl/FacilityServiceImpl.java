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

	@Override
	public List<FacilityVO> facilityBreakInfo(FacilityVO facility) {
		return mapper.facilityBreakInfo(facility) ;
	}

	@Override
	public void facilityStatusUpdate(FacilityVO facility) {
		mapper.facilityStatusUpdate(facility) ;
	}

	@Override
	public List<FacilityVO> selectFacOptions(FacilityVO facility) {
		return mapper.selectFacOptions(facility) ;
	}

	@Override
	public void insertFacility(FacilityVO facility) {
		mapper.insertFacility(facility) ; 
	}

	@Override
	public void deleteFacility(FacilityVO facility) {
		mapper.deleteFacility(facility) ;
	}
	
}
