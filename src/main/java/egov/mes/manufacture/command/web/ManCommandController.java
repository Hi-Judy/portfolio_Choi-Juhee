package egov.mes.manufacture.command.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Controller
public class ManCommandController {
	
	@Autowired
	ManCommandService service;
	
	@RequestMapping("/manCommand")
	public String selectCommand() {
		return "manufacture/manCommand.tiles";
	}
	
	//생산계획 조회
	@PostMapping("/selectManPlan")
	public String selectManPlan(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectManPlan(commandVO));
		System.out.println("생산계획 조회: " + service.selectManPlan(commandVO));
		
		return "jsonView";
	}
} 
