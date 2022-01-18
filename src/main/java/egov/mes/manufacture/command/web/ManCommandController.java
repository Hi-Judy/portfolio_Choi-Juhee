package egov.mes.manufacture.command.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//생산계획 디테일 조회
	@PostMapping("/selectManPlan")
	public String selectManPlan(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectManPlan(commandVO));
		System.out.println("생산계획 조회: " + service.selectManPlan(commandVO));
		
		return "jsonView";
	}
	
	//생산계획 디테일 상세 조회
	@GetMapping("/selectManPlanDetail/{planNoDetail}")
	public String selectManPlanDetail(@PathVariable String planNoDetail, 
									  ManCommandVO commandVO, 
									  Model model) {
		Map<String, List<ManCommandVO>> maps = new HashMap<>();
		maps.put("contents", service.selectManPlanDetail(commandVO));
		
		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		
		System.out.println("생산계획 디테일 상세조회: "+ service.selectManPlanDetail(commandVO));
		return "jsonView";
	}
} 
