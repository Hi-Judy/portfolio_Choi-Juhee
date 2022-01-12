package egov.mes.resources.order.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesOrderVO;
import egov.mes.resources.order.service.ResourcesOrderService;

@Controller
public class ResourcesOrderController {
	@Autowired ResourcesOrderService service;
	
	//발주리스트 조회
	@RequestMapping("orderList")
	public String list(Model model, ResourcesOrderVO vo) {
		model.addAttribute("list", service.find(vo));
		return "resources/orderList.tiles";
	}
	
	//grid dataSource
	@RequestMapping("order")
		public String order(Model model, ResourcesOrderVO vo) {
		  model.addAttribute("result",true);
	      Map<String,Object> map = new HashMap();
	      map.put("contents", service.find(vo));
	      model.addAttribute("data", map);
	      return "jsonView";
	}
	
	//발주리스트->모달창(자재조회)
	@RequestMapping("recList")
	public String recList(Model model, ResourcesOrderVO vo) {
		model.addAttribute("recList", service.searchRec(vo));
		return "resources/searchRsc";
	}

	//grid dataSource
	@RequestMapping("search")
	public String search(Model model, ResourcesOrderVO vo) {
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap();
		map.put("contents", service.searchRec(vo));
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//자재발주
	@RequestMapping("/modifyData")
	@ResponseBody
	public boolean modifyData(@RequestBody ModifyVO<ResourcesOrderVO> mvo) {
		System.out.println(mvo);
		return true;
	}
	
	
}
