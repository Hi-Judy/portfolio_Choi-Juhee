package egov.mes.BOM.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.BOM.dao.ProductBomVO;
import egov.mes.BOM.service.ProductBomService;

@Controller
public class ProductBomController {
	
	@Autowired ProductBomService service;
	
	//페이지 이동
	@RequestMapping("ProductBom")
	public String PageView() {
		return "view/ProductBomInfo.tiles";
	}
	
	//자재코드 조회
	@RequestMapping("rscFind")
	public ModelAndView rscFind() {
//		System.out.println("자재코드 조회 시작");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.rscFind());
//		System.out.println(jsonView);
		return jsonView;
	}
	
	//자재코드로 자재명 호출
	@ResponseBody
	@RequestMapping(value = "proNameFind")
	public ModelAndView proNameFind(@RequestBody ProductBomVO bomVO ) {
//		System.out.println("자재코드로 자재명 호출");
		
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.rscName(bomVO));

//		System.out.println(jsonView);

		return jsonView ;
	}
	
	//제품조회 처리
	@ResponseBody
	@RequestMapping("ProFind")
	public ModelAndView ProFind() {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.ProFind());
//		System.out.println(jsonView);
		return jsonView;
	}
	
	//제품코드 기준으로 모든 제품상세 & 자재소모량 & 공정흐름 조회 처리
	@ResponseBody
	@RequestMapping("DetailAll/{proCode}")
	public ModelAndView ProFind2(@PathVariable String proCode) {
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("ProDetail" , service.ProDetail(proCode));
		jsonView.addObject("rscDetail" , service.rscDetail(proCode));
		jsonView.addObject("ProcDetail" , service.ProcDetail(proCode));
//		System.out.println(jsonView);
		return jsonView;
	}
	
	//공정코드만 조회
	@RequestMapping("ProcFind")
	public ModelAndView ProcFind() {
		System.out.println("공정코드 조회 시작");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data" , service.ProcFind());
		System.out.println(jsonView);
		return jsonView;
	}
	
	
	

}
