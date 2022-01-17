package egov.mes.resources.check.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.resources.check.dao.ResourcesCheckVO;
import egov.mes.resources.check.service.ResourcesCheckService;
import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.order.dao.ResourcesOrderVO;
import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;

@Controller
public class ResourcesCheckController {
	@Autowired ResourcesCheckService service;
	
	//입고검사 페이지 이동
	@RequestMapping("resourcesCheck")
	public String resourcesCheck() {
		System.out.println("=================입고검사 미완료 조회 페이지 이동================");
		return "resources/resourcesCheck.tiles";
	}
	//입고검사 미완료 조회
	@RequestMapping("resourcesCheckList")
	public String resourcesCheckList(Model model, ResourcesCheckVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.findResourcesCheck(vo));
      System.out.println(service.findResourcesCheck(vo));
      model.addAttribute("data", map);
	  System.out.println("================발주테이블 select================");
      return "jsonView";
}
	
	//발주리스트->모달창(불량코드 조회)
	@RequestMapping("rtnList")
	public String rtnList(Model model, ResourcesRtngdVO vo) {
		model.addAttribute("rtnList", service.searchRtngd(vo));
		System.out.println("=================자재입고검사->모달창(불량코드)================");
		return "resources/searchRtn";
	}
	
	//발주리스트->모달창(불량코드 조회)
	@RequestMapping("searchRtngd")
	public String searchRtngd(Model model, ResourcesRtngdVO vo) {
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contents", service.searchRtngd(vo));
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//입고검사 insert
	@PostMapping("resourcesCheckModify")
	public String modifyCheck(Model model,@RequestBody ModifyVO<ResourcesCheckVO> mvo) {
		System.out.println(mvo);
		System.out.println("=================입고검사 insert================");
		service.modifyCheck(mvo);
		model.addAttribute("mod", "upd");
		return "jsonView";
	}
}
