package egov.mes.Proc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.BOM.dao.ProductBomVO;
import egov.mes.Proc.dao.ProcessControlVO;
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
//		System.out.println("공정전체조회 준비");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.AllFind());
		
		return jsonView;
	}
	
	//사원조회(반장만)
	@RequestMapping("EmpFind")
	public ModelAndView EmpFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.EmpFind());
		return jsonView;
	}
	
	//공정 데이터 삭제
	@ResponseBody
	@PostMapping(value = "Delete" ) 
	public String ResDelete (@RequestBody List<ProcessControlVO> procVO) {
		System.out.println("삭제준비");
		service.ProcDelete(procVO);
		service.CommonDelete(procVO);
		System.out.println("삭제완료");	
		return null ;
	}
	
	//데이터 추가
	@ResponseBody
	@PostMapping(value = "AddData" ) 
	public String AddData (@RequestBody List<ProcessControlVO> procVO) {
		System.out.println("데이터입력준비");
		service.ProcAddData(procVO);
		System.out.println("데이터입력 1차 완료");
		service.CommonAddData(procVO);
		System.out.println("데이터입력모두완료");
		return null ;
	}
	
	//데이터 추가
	@ResponseBody
	@PostMapping(value = "ChangeData" ) 
	public String ChangeData (@RequestBody List<ProcessControlVO> procVO) {
		service.ProcChangeData(procVO);
		service.CommonChangeData(procVO);
		return null ;
	}

}
