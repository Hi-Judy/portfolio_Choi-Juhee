package egov.mes.resources.order.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesOrderVO;
import egov.mes.resources.order.service.ResourcesOrderService;

@Controller
public class ResourcesOrderController {
	@Autowired ResourcesOrderService service;
	
	//발주리스트 조회 페이지
	@RequestMapping("resourceorderList")
	public String list() {
		System.out.println("=================발주조회페이지================");
		return "resources/orderList.tiles";
	}
	
	//발주 select
	@RequestMapping("resourcesOrder")
		public String order(Model model, ResourcesOrderVO vo) {
		  model.addAttribute("result",true);
		  System.out.println(vo);
	      Map<String,Object> map = new HashMap<String,Object>();
	      map.put("contents", service.findResourcesOrder(vo));
	      model.addAttribute("data", map);
		  System.out.println("=================발주테이블 select================");
	      return "jsonView";
	}
	
	//발주리스트->모달창(자재조회)
	@RequestMapping("recList")
	public String recList(Model model, ResourcesOrderVO vo) {
		model.addAttribute("recList", service.searchRec(vo));
		System.out.println("=================발주리스트->모달창(자재조회)================");
		return "resources/searchRsc";
	}
	
	//발주 -> 모달창(자재면,코드,단가 등등..조회)
	@RequestMapping("recList2")
	public String recList2(Model model, ResourcesOrderVO vo) {
		model.addAttribute("recList2", service.searchRec(vo));
		System.out.println("=================발주리스트->모달창(자재조회)================");
		return "resources/searchRsc2";
	}
	
	//모달창(자재조회)
	@RequestMapping("searchRsc")
	public String searchRsc(Model model, ResourcesOrderVO vo) {
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contents", service.searchRec(vo));
		model.addAttribute("data", map);
		System.out.println("=================모달창(자재조회)================");
		return "jsonView";
	}
	
	//발주리스트->모달창(업체조회)
	@RequestMapping("sucList")
	public String sucList(Model model, ResourcesOrderVO vo) {
		model.addAttribute("sucList", service.searchRec(vo));
		System.out.println("=================발주리스트->모달창(업체조회)================");
		return "resources/searchSuc";
	}
	
	//모달창(업체조회)
	@RequestMapping("searchSuc")
	public String searchSuc(Model model, ResourcesOrderVO vo) {
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contents", service.searchSuc(vo));
		model.addAttribute("data", map);
		System.out.println("=================모달창(업체조회)================");
		return "jsonView";
	}
	
	//발주리스트->모달창(업체조회)
		@RequestMapping("searchOrderList")
		public String orderList(Model model, ResourcesOrderVO vo) {
			model.addAttribute("searchOrderList", service.searchResourcesOrder(vo));
			System.out.println("=================발주리스트->모달창(업체조회)================");
			return "resources/searchOrderList";
		}
		
		//모달창(업체조회)
		@RequestMapping("searchResourcesOrder")
		public String searchResourcesOrder(Model model, ResourcesOrderVO vo) {
			model.addAttribute("result",true);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("contents", service.searchResourcesOrder(vo));
			model.addAttribute("data", map);
			System.out.println("=================모달창(업체조회)================");
			return "jsonView";
		}

	
	//자재 발주 페이지
	@RequestMapping("orderInsert")
	public String orderInsert() {
		System.out.println("=================자재 발주 페이지================");
		return "resources/orderInsert.tiles";
	}
	
	
	//자재발주 insert
	@PostMapping(value= "resourcesOrderModify" , consumes = "application/json; charset=UTF-8")
	@ResponseBody
	public String modifyOrder(@RequestBody ModifyVO<ResourcesOrderVO> mvo) throws Exception {
		System.out.println(mvo);
		service.modifyOrder(mvo);
		System.out.println("=================자재발주 insert================");
		return "dddd";
	}
	
}
