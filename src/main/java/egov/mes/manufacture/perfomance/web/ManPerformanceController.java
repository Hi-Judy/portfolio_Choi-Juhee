package egov.mes.manufacture.perfomance.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.perfomance.service.ManPerformanceService;

@Controller
public class ManPerformanceController {

	@Autowired
	ManPerformanceService service;


	@RequestMapping("/manPerformance")
	public String selectCommand() {
		return "manufacture/manPerformance.tiles";
	}
}
