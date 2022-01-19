package egov.mes.resources.rtngd.web;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.resources.rtngd.dao.ResourcesRtngdVO;
import egov.mes.resources.rtngd.service.ResourcesRtngdService;


@Controller
public class ResourcesRtngdController {
	@Autowired ResourcesRtngdService service;
	
	//자재반품 리스트 조회
	@RequestMapping("resourcesRtngdList")
	public String resourcesRtngdList() {
		return "resources/rtngdList.tiles";
	}
	
	//자재반품 select
	@RequestMapping("resourcesRtngd")
		public String order(Model model, ResourcesRtngdVO vo) {
		  model.addAttribute("result",true);
		  System.out.println(vo);
	      Map<String,Object> map = new HashMap<String,Object>();
	      map.put("contents", service.findResourcesRtngd(vo));
	      model.addAttribute("data", map);
		  System.out.println("=================자재반품 테이블 select================");
	      return "jsonView";
	}
	
}
