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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Controller
public class ManCommandController {
	
	@Autowired
	ManCommandService service;
	
	@RequestMapping("/manCommand")
	public String conCommand() {
		return "manufacture/manCommand.tiles";
	}
	
	//히든그리드 가져오기
	@PostMapping("/hidden")
	public String hidden(@RequestBody Map<String, List<ManCommandVO>> map) {

		//System.out.println("hiddenTest");

		service.hidden(map);
		
		return "jsonView";
	}
	
	//이전 생산지시 조회
	@PostMapping("/selectPreCommand")
	public String selectPreCommand(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectPreCommand(commandVO));
		System.out.println("이전 생산 지시 조회: "+ service.selectPreCommand(commandVO));
		
		return "jsonView";
	}
	
	//자재코드에 해당하는 자재LOT 조회
	@PostMapping("/selectResLot")
	public String selectResLot(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectResLot(commandVO));
		//System.out.println("자재 로트 조회: "+ service.selectResLot(commandVO));
		
		return "jsonView";
	}
	
	//제품 만드는데 필요한 공정에 해당하는 설비 조회
	@PostMapping("/selectFac")
	public String selectFac(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectFac(commandVO));
		//System.out.println("설비조회: "+ service.selectFac(commandVO));
		
		return "jsonView";
	}
	
	
	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	@PostMapping("/selectRes")
	public String selectRes(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectRes(commandVO));
		//System.out.println("자재조회: " + service.selectRes(commandVO));
		
		return "jsonView";
	}
	
	//지시가 없는 생산계획 디테일 조회
	@PostMapping("/selectManPlan")
	public String selectManPlan(ManCommandVO commandVO, Model model) {
		model.addAttribute("result", service.selectManPlan(commandVO));
		//System.out.println("생산계획 조회: " + service.selectManPlan(commandVO));
		
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
		
		//System.out.println("생산계획 디테일 상세조회: "+ service.selectManPlanDetail(commandVO));
		return "jsonView";
	}
} 
