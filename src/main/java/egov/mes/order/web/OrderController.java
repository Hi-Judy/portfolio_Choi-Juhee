package egov.mes.order.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	public ModelAndView orderList( OrderVO order) {
		if (order.getCusCode().equals("null")) {
			order.setCusCode(null) ;	
		}
		List<OrderVO> list = service.orderList(order) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("orderlist" , list) ;
		return jsonView ;
	}
}
