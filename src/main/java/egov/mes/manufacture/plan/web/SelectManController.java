package egov.mes.manufacture.plan.web;

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

import egov.mes.manufacture.plan.dao.ManufacturePlanVO;
import egov.mes.manufacture.plan.service.ManufactureService;

@Controller
public class SelectManController {
	@Autowired
	ManufactureService service;
	
	// egov 메인에서 manufactureSelect.jsp로 연결
	@RequestMapping("/manufactureSelect")
	public String conSelectMan() {
		return "manufacture/manufactureSelect.tiles";
	}
	
	//생산계획 조회(조회페이지)
	@PostMapping("/manufacture/selectManufacturePlan")
	public String selectManufacturePlan(ManufacturePlanVO planVO, Model model) {
		System.out.println(planVO);
		model.addAttribute("result", service.selectManufacturePlan(planVO));
		System.out.println("생산계획 조회: " + service.selectManufacturePlan(planVO));
		
		return "jsonView";
	}
	
	//자재 조회 모달에서 매핑
	@PostMapping("/manufacture/selectResource")
	public String selectRes(ManufacturePlanVO planVO, Model model) {
		
		
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", service.selectRes(planVO));

		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result",true);
		model.addAttribute("data", maps);
		return "jsonView";
	}
	
	
	//생산계획 디테일 조회
	@GetMapping("/manufacture/selectManDetail/{manPlanNo}")
	public String selectManPlanDetail(@PathVariable String manPlanNo, ManufacturePlanVO planVO, Model model) {
		
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", service.selectManufactureDetail(planVO));

		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result",true);
		model.addAttribute("data", maps);

		System.out.println(planVO);
		System.out.println("생산계획 데테일 조회: " + service.selectManufactureDetail(planVO));

		return "jsonView";
	}
		
}
