package egov.mes.order.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.order.dao.OrderVO;
import egov.mes.order.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired OrderService service ;
	
	@RequestMapping("orderManagement")
	public String orderManagement () {
		return "order/orderManagement.tiles" ;
	}

	@RequestMapping("orderList")
	public ModelAndView orderList(OrderVO order) {
		if (order.getCusCode().equals("null")) {
			order.setCusCode(null) ;	
		}
		if (order.getOrdStatus().equals("null")) {
			order.setOrdStatus(null) ;	
		}
		if (order.getOrdDatestart().equals("1910-12-25")) {
			order.setOrdDatestart(null) ;
		}
		if (order.getOrdDateend().equals("1910-12-25")) {
			order.setOrdDateend(null) ;
		}
		if (order.getOrdDuedatestart().equals("1910-12-25")) {
			order.setOrdDuedatestart(null) ;	
		}
		if (order.getOrdDuedateend().equals("1910-12-25")) {
			order.setOrdDuedateend(null) ;	
		}
		List<OrderVO> list = service.orderList(order) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("orderlist" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("orderSelect/{ordCode}")
	public ModelAndView orderSelect(OrderVO order) {
		List<OrderVO> list = service.orderSelect(order) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("orderSelect" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("noManRelease")
	public ModelAndView noManRelease(OrderVO order) {
		service.noManRelease(order) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		int result = 1 ;
		jsonView.addObject("noManRelease" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("noManReleaseInfo")
	public String noManRelease () {
		return "order/noManRelease.tiles" ;
	}
	
	@RequestMapping("noManSelect")
	public ModelAndView noManSelect(OrderVO order) {
		if (order.getCusCode().equals("null")) {
			order.setCusCode(null) ;	
		}
		if (order.getOrdDuedatestart().equals("1910-12-25")) {
			order.setOrdDuedatestart(null) ;	
		}
		if (order.getOrdDuedateend().equals("1910-12-25")) {
			order.setOrdDuedateend(null) ;	
		}
		List<OrderVO> list = service.noManSelect(order) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("nomanlist" , list) ;
		return jsonView ;
	}
}
