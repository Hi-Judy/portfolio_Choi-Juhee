package egov.mes.Proc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
		service.ProcDelete(procVO);
		service.CommonDelete(procVO);
		return null ;
	}
	
	//데이터 추가
	@ResponseBody
	@PostMapping(value = "AddData" ) 
	public String AddData (@RequestBody List<ProcessControlVO> procVO) {
		service.ProcAddData(procVO);
		service.CommonAddData(procVO);
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
	
	//설비 전체목록 조회
	@RequestMapping("FacFind")
	public ModelAndView FacFind() {
//		System.out.println("공정전체조회 준비");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.FacFind());
		return jsonView;
	}
	
	//데이터 추가
	@ResponseBody
	@PostMapping(value = "FacProcInput" ) 
	public void FacProcInput (@RequestBody List<ProcessControlVO> procVO) {
//		System.out.println(procVO);
		service.FacProcInput(procVO);
	}
	
	//사용중인 설비목록 조회
	@ResponseBody
	@RequestMapping("SelectedFac/{procCode}")
	public ModelAndView SelectedFac(@PathVariable String procCode) {
		System.out.println("설비");
		System.out.println(procCode);
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.SelectedFac(procCode));
		System.out.println(jsonView);
		return jsonView;
	}
	

}
