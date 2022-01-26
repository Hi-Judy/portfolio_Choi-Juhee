package egov.mes.Employee.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class EmployeeController {
	
	@Autowired
	
	//페이지 이동
	@RequestMapping("EmployeeView")
	public String PageView() {
		return "view/EmployeeInfo.tiles";
	}

}
