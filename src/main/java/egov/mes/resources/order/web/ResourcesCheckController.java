package egov.mes.resources.order.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.resources.order.dao.ResourcesCheckVO;
import egov.mes.resources.order.service.ResourcesCheckService;

@Controller
public class ResourcesCheckController {
	@Autowired ResourcesCheckService service;
	
	//입고검사 미완료 조회
	@RequestMapping("resourcesCheckList")
	public String resourcesCheckList(Model model, ResourcesCheckVO vo) {
		model.addAttribute("list", service.findResourcesCheck(vo));
		System.out.println("=================입고검사 미완료 조회 페이지================");
		return "resources/resourcesCheckList.tiles";
	}
}
