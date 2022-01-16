package egov.mes.facility.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.facility.service.FacilityService;

@Controller
public class FacilityController {
	
	@Autowired FacilityService service ;
	
	@RequestMapping("facilityManagement")
	public String facilityManagement() {
		return "facility/facilityManagement.tiles" ;
	}
}
