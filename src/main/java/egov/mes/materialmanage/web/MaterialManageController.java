package egov.mes.materialmanage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.materialmanage.dao.MaterialManageVO;
import egov.mes.materialmanage.service.MaterialManageService;


@Controller
public class MaterialManageController {
	
	@Autowired MaterialManageService service;
	
	//페이지 이동
	@RequestMapping("MaterialManagement")
	public String PageView() {
		return "view/MaterialManageInfo.tiles";
	}
	
	//자재 간략정보조회
	@RequestMapping("MaterialListAllFind")
	public ModelAndView MaterialListAllFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.MaterialListAllFind());
		return jsonView;
	}
	
	//자재 단건 상세조회 (월별자재재고 조회)
	@ResponseBody
	@RequestMapping("Details/{RscCode}")
	public ModelAndView DetailsList( @PathVariable String RscCode ) {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("OneData" , service.resSearch(RscCode));
		jsonView.addObject("Datas" , service.resStListSearch(RscCode));
		jsonView.addObject("MatInven" , service.MonthlyInventory(RscCode,service.selectpmonth(RscCode)));	//월별자재재고 조회
		return jsonView;
	}
	
	//제품조회 처리
	@ResponseBody
	@RequestMapping("MatPresFind")
	public ModelAndView EmpFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.EmpFind());
		return jsonView;
	}
	
	//제품조회 처리
	@ResponseBody
	@RequestMapping("ClientFind")
	public ModelAndView ClientFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("datas" , service.ClientFind());
		return jsonView;
	}
	
	//자재정보 수정
	@ResponseBody
	@PostMapping(value = "UpdateMat" )
	public void UpdateMat (@RequestBody MaterialManageVO matVO) {
		service.UpdateMat(matVO);
			
	}	
	
	//자재 신규정보 등록
	@ResponseBody
	@PostMapping(value = "AddMat" )
	public void AddMat (@RequestBody MaterialManageVO matVO) {
		service.AddMat(matVO);
		service.AddCommon(matVO);
			
	}
	
}
