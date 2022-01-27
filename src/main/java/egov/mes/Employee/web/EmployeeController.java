package egov.mes.Employee.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.Employee.service.EmployeeService;
@Controller
public class EmployeeController {
	
	@Autowired EmployeeService service;
	
	//페이지 이동
	@RequestMapping("EmployeeView")
	public String PageView() {
		return "view/EmployeeInfo.tiles";
	}
	
	//사원정보 전체조회
	@RequestMapping("EmpAllFind")
	public ModelAndView EmpAllFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.EmpAllFind());
		return jsonView;
	}

}
