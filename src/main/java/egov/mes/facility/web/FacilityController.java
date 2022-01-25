package egov.mes.facility.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.facility.dao.FacilityVO;
import egov.mes.facility.service.FacilityService;

@Controller
public class FacilityController {
	
	@Autowired FacilityService service ;
	
	@RequestMapping("facilityManagement")
	public String facilityManagement() {
		return "facility/facilityManagement.tiles" ;
	}
	
	@RequestMapping("facilityList")
	public ModelAndView facilityList(FacilityVO facility) {
		if (facility.getFacCode().equals("null")) {
			facility.setFacCode(null) ;
		}
		if (facility.getFacStatus().equals("null")) {
			facility.setFacStatus(null) ;
		}
		if (facility.getCheckDatestart().equals("1910-12-25")) {
			facility.setCheckDatestart(null) ;
		}
		if (facility.getCheckDateend().equals("1910-12-25")) {
			facility.setCheckDateend(null) ;
		}
		List<FacilityVO> list = service.facilityList(facility) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("facilitylist" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("findFacility/{codeName}")
	public ModelAndView findFacility(FacilityVO facility) {
		List<FacilityVO> list = service.findFacility(facility) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("findfacility" , list) ;
		return jsonView ; 
	}
	
	@RequestMapping("facilityBreakInfo/{facNo}")
	public ModelAndView facilityBreakInfo(FacilityVO facility) {
		List<FacilityVO> list = service.facilityBreakInfo(facility) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("facilitybreakinfo" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("facilityStatusUpdate")
	public ModelAndView facilityStatusUpdate(FacilityVO facility) {
		service.facilityStatusUpdate(facility) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("facilitystatusupdate" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("selectFacOptions")
	public ModelAndView selectFacOptions(FacilityVO facility) {
		List<FacilityVO> list = service.selectFacOptions(facility) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("selectfacoptions" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("insertFacility")
	public ModelAndView insertFacility(FacilityVO facility) {
		service.insertFacility(facility) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("insertfacility" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("deleteFacility/{facNo}")
	public ModelAndView deleteFacility(FacilityVO facility) {
		service.deleteFacility(facility) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("deletefacility" , result) ;
		return jsonView ;
	}
}
