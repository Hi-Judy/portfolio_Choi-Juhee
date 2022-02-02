package egov.mes.Employee.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.Employee.dao.EmployeeVO;
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
	
	//사원ID 조건조회
	@ResponseBody
	@RequestMapping(value = "IdFind")
	public ModelAndView IdFind(@RequestBody EmployeeVO empVO ) {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.IdFind(empVO));
		return jsonView ;
	}
	
	//사원정보 추가
	@ResponseBody
	@PostMapping(value = "EmpAddData" )
	public void ProcInsert (@RequestBody EmployeeVO empVO ) {
		service.EmpAddData(empVO);
			
	}
	
	//사원정보 수정
	@ResponseBody
	@PostMapping(value = "UpdateDatas" )
	public void UpdateDatas (@RequestBody List<EmployeeVO> empVO ) {
		service.UpdateDatas(empVO);
				
	}

}
