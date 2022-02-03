package egov.mes.customer.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.customer.dao.CustomerVO;
import egov.mes.customer.service.CustomerService;

@Controller
public class CustomerController {

	@Autowired CustomerService service ;
	
	@RequestMapping("customerInfo")
	public String customerInfo () {
		return "customer/customerInfo.tiles" ;
	}
	
	@RequestMapping("customerList/{cusCode}")
	public ModelAndView customerList(@PathVariable String cusCode , CustomerVO customer) {
		if (cusCode.equals("null")) {
			customer.setCusCode(null) ;	
		}
		List<CustomerVO> list = service.customerList(customer) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("data" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("findCustomer/{codeName}")
	public ModelAndView findCustomer(CustomerVO customer) {
		List<CustomerVO> list = service.findCustomer(customer) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("customer" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("findCustomerAll")
	public ModelAndView findCustomerAll(CustomerVO customer) {
		List<CustomerVO> list = service.findCustomerAll(customer) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("customerall" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("selectTradeInfo/{cusCode}")
	public ModelAndView selectTradeInfo(CustomerVO customer) {
		List<CustomerVO> list = service.selectTradeInfo(customer) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("trade" , list) ;
		return jsonView ;
	}
	
	@RequestMapping("updateCustomer")
	public ModelAndView updateCustomer(CustomerVO customer) {
		service.updateCustomer(customer) ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		int r = 1 ;
		jsonView.addObject("update" , r) ;
		return jsonView ;
	}
	
	@RequestMapping("customerInsert")
	public ModelAndView insertCustomer(CustomerVO customer) {
		service.insertCustomer(customer) ;
		String result = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("insert" , result) ;
		return jsonView ;
	}
	
	@RequestMapping("deleteCustomer/{cusCode}")
	public ModelAndView deleteCustomer(CustomerVO customer) {
		service.deleteCustomer(customer) ;
		String del = "" ;
		ModelAndView jsonView = new ModelAndView("jsonView") ;
		jsonView.addObject("delete" , del) ;
		return jsonView ;
	}
}
