package egov.mes.resources.store.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.resources.order.dao.ModifyVO;
import egov.mes.resources.store.dao.ResourcesStoreVO;
import egov.mes.resources.store.service.ResourceStoreService;

@Controller
public class ResourceStoreController {
	@Autowired ResourceStoreService service;
	
	//입출고 조회 페이지
	@RequestMapping("resourcesStore")
	public String resourcesStore() {
		System.out.println("=================입/출고 조회 페이지 이동================");
		return "resources/resourceStore.tiles";
	}
	
	//입고검사 미완료 조회
	@RequestMapping("resourcesStoreList")
	public String resourcesStoreList(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.findResourcesStore(vo));
      System.out.println(service.findResourcesStore(vo));
      model.addAttribute("data", map);
	  System.out.println("================입/출고 테이블 select================");
      return "jsonView";
	}
	
	//입고완료 insert
	@PostMapping("resourcesStoreModify")
	public String modifyCheck(Model model,@RequestBody ModifyVO<ResourcesStoreVO> mvo) {
		System.out.println(mvo);
		System.out.println("=================입고완료 insert================");
		service.modifyStore(mvo);
		return "jsonView";
	}
	
	
}
	
