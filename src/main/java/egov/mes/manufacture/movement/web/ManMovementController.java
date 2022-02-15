package egov.mes.manufacture.movement.web;

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

import egov.mes.manufacture.movement.dao.ManMovementVO;
import egov.mes.manufacture.movement.service.ManMovementService;
import egov.mes.manufacture.process.dao.ManProcessVO;

@Controller
public class ManMovementController {

	@Autowired
	ManMovementService service;
	
	@RequestMapping("/manMovement")
	public String selectCommand() {
		return "manufacture/manMovement.tiles";
	}
	
	//생산지시서 조회
	@PostMapping("/findCommand")
	public String findCommand(ManMovementVO movementVO,
							  Model model) {
		//System.out.println(movementVO);

		model.addAttribute("result", service.findCommand(movementVO));
		return "jsonView";
	}
	
	
	//공정이동표
	@GetMapping("/selectMovement/{comCode}")
	public String selectMovement(@PathVariable String comCode,
								 ManMovementVO movementVO,
								 Model model) {
		
		Map<String, List<ManMovementVO>> maps = new HashMap<>();
		maps.put("contents", service.selectMovement(movementVO));
		
		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		
		//System.out.println("공정이동표 : "+ service.selectMovement(movementVO));
		
		return "jsonView";
	}
	
	
	//공정이동표에서 자재 조회
	@GetMapping("/selectResLot/{comCode}")
	public String selectResLot(@PathVariable String comCode,
								 ManMovementVO movementVO,
								 Model model) {
		
		Map<String, List<ManMovementVO>> maps = new HashMap<>();
		maps.put("contents", service.selectResLot(movementVO));
		
		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		
		//System.out.println("공정이동표 자재조회 : "+ service.selectResLot(movementVO));
		
		return "jsonView";
	}
	
	
	//공정이동표
	@GetMapping("/selectComInfo/{comCode}")
	public String selectComInfo(@PathVariable String comCode,
								 ManMovementVO movementVO,
								 Model model) {
		
		Map<String, List<ManMovementVO>> maps = new HashMap<>();
		maps.put("contents", service.selectComInfo(movementVO));
		
		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		
		//System.out.println("공정이동표 : "+ service.selectComInfo(movementVO));
		
		return "jsonView";
	}

}

