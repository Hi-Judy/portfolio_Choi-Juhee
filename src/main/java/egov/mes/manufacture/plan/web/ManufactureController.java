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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.plan.dao.ManufacturePlanVO;
import egov.mes.manufacture.plan.dao.ModifyVO;
import egov.mes.manufacture.plan.service.ManufactureService;

@Controller
public class ManufactureController {

	@Autowired
	ManufactureService manService;

	// egov 메인에서 manufacture.jsp로 연결
	@RequestMapping("/manufacture")
	public String conManufacture() {
		return "manufacture/manufacture.tiles";
	}

	// 생산계획 조회
	@PostMapping("/manufacture/manPlan")
	public String selectManPlan(ManufacturePlanVO planVO, Model model) {

		//System.out.println(planVO);
		model.addAttribute("result", manService.selectManPlan(planVO));
		//System.out.println("생산계획 조회: " + manService.selectManPlan(planVO));

		return "jsonView";
	}

	// 생산계획 디테일 조회(생산계획조회)
	@GetMapping("/manufacture/manPlanDetail/{manPlanNo}")
	public String selectManPlanDetail(@PathVariable String manPlanNo, 
									  ManufacturePlanVO planVO, 
									  Model model) {
		//System.out.println(planVO);
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", manService.selectManPlanDetail(planVO));
		 
		Map<String, Object> map = new HashMap<>(); 
		map.put("data", maps);
		 
		model.addAttribute("result",true); 
		model.addAttribute("data", maps);

		//model.addAttribute("result", manService.selectManPlanDetail(planVO));
		//System.out.println("생산계획 데테일 조회: " + manService.selectManPlanDetail(planVO));

		return "jsonView";
	}

	// 생산계획 디테일 조회(미계획조회)
	@PostMapping("/manufacture/manPlanDetailByPlan")
	public String selectManPlanDetailByPlan(@RequestBody List<ManufacturePlanVO> planVO, 
									  		Model model) {
									  		
		System.out.println(planVO);
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", manService.selectPlanToMain(planVO));
		 
		Map<String, Object> map = new HashMap<>(); 
		map.put("data", maps);
		 
		model.addAttribute("result",true); 
		model.addAttribute("data", maps);

		//model.addAttribute("result", manService.selectManPlanDetail(planVO));
		System.out.println("미계획 조회: " + manService.selectPlanToMain(planVO));

		return "jsonView";
	}
		
	// 자재 조회 모달에서 매핑
	@PostMapping("/manufacture/resource")
	public String selectRes(ManufacturePlanVO planVO, Model model) {

		// System.out.println("@@@@@@@@"+planVO.getPodtCode());

		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", manService.selectRes(planVO));
		System.out.println("planVO: "+ planVO);
		System.out.println("자재조회"+maps);

		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);

		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		return "jsonView";
	}

	// 미계획 조회 모달에서 매핑
	@RequestMapping("/manufacture/plan")
	public String selectPlan1(ManufacturePlanVO planVO, Model model) {
							 

		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		// 쿼리 결과를 contents 안의 배열로 넣기. contents 이름으로 maps에 담기.
		maps.put("contents", manService.selectPlan(planVO));

		Map<String, Object> map = new HashMap<>();
		// contents를 담은 maps를 data 이름으로 map에 담기.
		map.put("data", maps);

		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		return "jsonView";
	}

	// 생산계획에서 한 건 추가
	@PostMapping("/manufacture/main")
	public String modifyDataInsert(@RequestBody ModifyVO<ManufacturePlanVO> list, Model model) {
		System.out.println("!!!!생산계획추가^^!!!!!!!!!!!!!" + list);
		System.out.println("!!!!생산계획 주문상태 수정^^!!!!!!!!!!!!!" + list);
		manService.insertPlan(list);

		// System.out.println("!!!!생산계획삭제^^!!!!!!!!!!!!!"+list);
		model.addAttribute("result", true);

		return "jsonView";
	}

}
