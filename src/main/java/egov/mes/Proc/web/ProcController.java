package egov.mes.Proc.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.Proc.service.ProcessControlService;

@Controller
public class ProcController {
	
	@Autowired ProcessControlService service;
	
	//페이지 이동
	@RequestMapping("ProcessControl")
	public String PageView() {
		return "view/ProcessControlInfo.tiles";
	}
	
	//공정전체조회
	@RequestMapping("AllFind")
	public ModelAndView AllFind() {
		System.out.println("공정전체조회 준비");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.AllFind());
		
		return jsonView;
	}

}
