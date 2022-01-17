package egov.mes.manufacture.command.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.command.service.ManCommandService;

@Controller
public class ManCommandController {
	
	@Autowired
	ManCommandService service;
	
	@RequestMapping("/manufacture/manCommand")
	public String selectCommand() {
		return "manufacture/manCommand.tiles";
	}
	
}
