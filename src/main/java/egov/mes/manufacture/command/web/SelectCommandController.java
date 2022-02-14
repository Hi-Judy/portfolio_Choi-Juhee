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
import egov.mes.manufacture.plan.dao.ManufacturePlanVO;

@Controller
public class SelectCommandController {

	@Autowired
	ManCommandService service;
	
	// egov 메인에서 manufactureSelect.jsp로 연결
	@RequestMapping("/manCommandSelect")
	public String conSelectCommand() {
		return "manufacture/manCommandSelect.tiles";
	}
	
	
	//생산지시서 조회(생산지시서 조회 페이지)
	@PostMapping("/selectCommand")
	public String commandByManDate(ManCommandVO commandVO, Model model) {
		
		//List<ManCommandVO> list = new ArrayList<>();
		//list = service.selectCommand(commandVO);
		model.addAttribute("result", service.selectCommand(commandVO));
		System.out.println("작업일자별 지시조회: "+ service.selectCommand(commandVO));
		
		
//		Map<String, List<ManCommandVO>> maps = new HashMap<>();
//		maps.put("contents", service.selectCommand(commandVO));
//
//		Map<String, Object> map = new HashMap<>();
//		map.put("data", maps);
//		
//		model.addAttribute("result",true);
//		model.addAttribute("data", maps);
//		
//		System.out.println("작업일자별 지시조회: "+ service.selectCommand(commandVO));
		
		return "jsonView";
	}
	
	//자재조회
	@GetMapping("/findResource/{podtCode}/{comCode}")
	public String findResource(@PathVariable String podtCode,
							   @PathVariable String comCode,
							   ManCommandVO commandVO,
							   Model model) {
		
		Map<String, List<ManCommandVO>> maps = new HashMap<>();
		maps.put("contents", service.findResource(commandVO));
//		System.out.println("planVO: "+ planVO);
//		System.out.println("자재조회"+maps);

		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);

		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		return "jsonView";
	}
	
	
}
