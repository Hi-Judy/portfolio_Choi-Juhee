package egov.mes.manufacture.perfomance.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.perfomance.dao.ManPerformanceVO;
import egov.mes.manufacture.perfomance.service.ManPerformanceService;

@Controller
public class ManPerformanceController {

	@Autowired
	ManPerformanceService service;


	@RequestMapping("/manPerformance")
	public String selectCommand() {
		return "manufacture/manPerformance.tiles";
	}
	
	
	//생산실적조회
	@PostMapping("/findPerformance")
	public String findPerformance(ManPerformanceVO performanceVO,
								  Model model) {
		
		System.out.println("생산실적조회: "+ service.selectDef(performanceVO));
		model.addAttribute("result", service.selectDef(performanceVO));
		
		
		return "jsonView";
	}
}
