package egov.mes.product.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.product.dao.ProductVO;
import egov.mes.product.service.ProductService;

@Controller 
public class ProductController {
	
	@Autowired ProductService service ;
	
	@RequestMapping("productInfo")
	public String productInfo () {
		return "product/productInOut.tiles" ;
	}
	
	@RequestMapping("productList")
	public ModelAndView productList(ProductVO product) {
		if (product.getPodtCode().equals("null")) {
			product.setPodtCode(null) ;	
		}
		if (product.getManDatestart().equals("1910-12-25")) {
			product.setManDatestart(null) ;
		}
		if (product.getManDateend().equals("1910-12-25")) {
			product.setManDateend(null) ;
		}
		
		List<ProductVO> list = service.podtList(product) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("productlist" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("findProduct/{podtCode}")
	public ModelAndView findProduct(ProductVO product) {
		List<ProductVO> list = service.findProduct(product) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("findproduct" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("productInOut")
	public ModelAndView productInOut(ProductVO product) {
		service.insertInOut(product) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("productinOut" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("updateLotno")
	public ModelAndView updateLotno(ProductVO product) {
		service.updateLotno(product) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("updatelotno" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("deleteInOut/{qntInfono}")
	public ModelAndView deleteInOut(ProductVO product) {
		service.deleteInOut(product) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("deleteinout" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("selectOptions")
	public ModelAndView selectOptions(ProductVO product) {
		List<ProductVO> list = service.selectOptions(product) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("selectoptions" , list) ;
		return jsonView ;
	}
}
