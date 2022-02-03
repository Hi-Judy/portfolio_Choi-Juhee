package egov.mes.manufacture.movement.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.movement.dao.ManMovementVO;
import egov.mes.manufacture.movement.service.ManMovementService;

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
		model.addAttribute("result", service.selectCommand(movementVO));
		
		return "jsonView";
	}
}
