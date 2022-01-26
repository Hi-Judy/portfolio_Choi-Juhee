package egov.mes.manufacture.command.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Controller
public class SelectCommandController {

	@Autowired
	ManCommandService service;
	
	// egov 메인에서 manufactureSelect.jsp로 연결
	@RequestMapping("/manCommandSelect")
	public String selectPlan() {
		return "manufacture/manCommandSelect.tiles";
	}
	
	
	//생산지시서 조회(생산지시서 조회 페이지)
	@PostMapping("/selectCommand")
	public String commandByManDate(ManCommandVO commandVO, Model model) {
		
		List<ManCommandVO> list = new ArrayList<>();
		list = service.selectCommand(commandVO);
		model.addAttribute("result", list);
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
	
	
}
