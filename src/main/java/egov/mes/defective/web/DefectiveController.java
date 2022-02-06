package egov.mes.defective.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.defective.dao.DefectiveVO;
import egov.mes.defective.service.DefectiveService;

@Controller
public class DefectiveController {

	@Autowired DefectiveService service ;
	
	// egov 메인에서 defective_product.jsp로 연결
	@RequestMapping("DefectiveProduct")
	public String DefectiveManagement() {
		return "defective_product/defective_product.tiles" ;
	}
	
	// 작업일자별 제품조회
	@PostMapping("/defective/findProduct")
	public String findPodtCode(DefectiveVO defective , Model model) {
		
		if(defective.getFromDate().equals("null")) {
			defective.setFromDate(null) ;
		}
		if(defective.getToDate().equals("null")) {
			defective.setToDate(null) ;
		}
		
		model.addAttribute("result" , service.findPodtCode(defective)) ;
		
		return "jsonView" ;
	}
	
	@PostMapping("/defective/main")
	public String selectDefective(DefectiveVO defective , Model model) {
		
		model.addAttribute("result" , service.selectDefective(defective)) ;
		
		return "jsonView" ;	
	}
	
	@PostMapping("/defective/selectProcess")
	public String selectProcess(DefectiveVO defective , Model model) {
		
		model.addAttribute("result" , service.selectProcess(defective)) ;
		
		return "jsonView" ;
	}
	
	@RequestMapping("viewChart")
	public String viewChart() {
		return "defective_product/chart" ;
	}
	
	@RequestMapping("chartData")
	public ModelAndView chartData(DefectiveVO defective) {
		
		List<DefectiveVO> list = service.selectChart(defective) ;
		
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("chartData" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("chartData2")
	public ModelAndView chartData2(DefectiveVO defective) {
		
		List<DefectiveVO> list = service.selectChart2(defective) ;
		
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("chartData2" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("checkProduct")
	public String checkProduct() {
		return "defective_product/check_product.tiles" ;
	}
	
	@RequestMapping("checkProductList")
	public ModelAndView checkProductList(DefectiveVO defective) {
		if (defective.getFromDate().equals("1910-12-25")) {
			defective.setFromDate(null) ;
		}
		if (defective.getToDate().equals("1910-12-25")) {
			defective.setToDate(null) ;
		}
		
		List<DefectiveVO> list = service.checkProductList(defective) ;
		
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("checklist" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("defList")
	public ModelAndView defList(DefectiveVO defective) {
		
		List<DefectiveVO> list = service.defList(defective) ;
		
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("deflist" , list) ;
		return jsonView ;		
	}
}
