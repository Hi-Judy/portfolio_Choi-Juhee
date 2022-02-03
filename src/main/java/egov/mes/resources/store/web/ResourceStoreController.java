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
	public String modifyCheck(Model model, @RequestBody ModifyVO<ResourcesStoreVO> mvo) {
		System.out.println(mvo);
		System.out.println("=================입고완료 insert================");
		service.modifyStore(mvo);
		model.addAttribute("mod", "upd");
		return "jsonView";
	}
	
	//입출고 조회 페이지
	@RequestMapping("resourceStoreInOut")
	public String resourceStoreInOut() {
		System.out.println("=================입/출고 조회 페이지 이동================");
		return "resources/resourceStoreInOut.tiles";
	}
	
	//자재입고 조회
	@RequestMapping("resourceStoreInList")
	public String resourceStoreInList(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.ResourcesStoreIn(vo));
      model.addAttribute("data", map);
	  System.out.println("================입고 조회 select================");
      return "jsonView";
	}
	
	//자재출고 조회
	@RequestMapping("resourceStoreOutList")
	public String resourceStoreOutList(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.ResourcesStoreOut(vo));
      System.out.println( service.ResourcesStoreOut(vo));
      model.addAttribute("data", map);
	  System.out.println("================출고 조회 select================");
      return "jsonView";
	}
	
	//자재 LOT 관리 페이지
	@RequestMapping("resourcesInventory")
	public String resourcesInventory() {
		System.out.println("=================자재 LOT 관리 페이지 이동================");
		return "resources/resourcesInventory.tiles";
	}
	
	//자재재고조정관리->모달창(LOT별 입고 조회)
	@RequestMapping("resourcesInventoryIn")
	public String resourcesInventoryIn(Model model, ResourcesStoreVO vo) {
		model.addAttribute("resourcesInventoryIn", service.searchResourcesStoreIn(vo));
		System.out.println("=================자재재고조정관리->모달창(LOT별 입고 조회)================");
		return "resources/searchInventoryIn";
	}
	
	//모달창(LOT별 입고 조회)
	@RequestMapping("resourcesInventoryInList")
	public String resourcesInventoryInList(Model model, ResourcesStoreVO vo) {
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("contents", service.searchResourcesStoreIn(vo));
		model.addAttribute("data", map);
		System.out.println("=================모달창(자재조회)================");
		return "jsonView";
	}
	
	//자재LOT조회 페이지
	@RequestMapping("resourcesInventoryList")
	public String resourcesInventoryList() {
		System.out.println("=================자재 LOT 조회 페이지 이동================");
		return "resources/resourcesInventoryList.tiles";
	}
	
	//자재입고 조회
	@RequestMapping("resourcesInven")
	public String resourcesInven(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.findResourcesInventory(vo));
      model.addAttribute("data", map);
	  System.out.println("================자재 LOT 조회 select================");
      return "jsonView";
	}
	
	//자재LOT재고조회 페이지
	@RequestMapping("resourcesInvenList")
	public String resourcesInvenList() {
		System.out.println("=================자재 LOT 재고 조회 페이지 이동================");
		return "resources/resourcesInvenList.tiles";
	}
	
	//자재LOT재고 조회 
	@RequestMapping("resourceStoreInventory")
	public String resourceStoreInventory(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.resourceStoreInventory(vo));
      model.addAttribute("data", map);
	  System.out.println("================자재 LOT 재고 조회================");
      return "jsonView";
	}
	
	//자재안전재고 조회
	@RequestMapping("rscStoreInv")
	public String rscStoreInv(Model model, ResourcesStoreVO vo) {
	  model.addAttribute("result",true);
      Map<String,Object> map = new HashMap<String,Object>();
      map.put("contents", service.rscStoreInv(vo));
      model.addAttribute("data", map);
	  System.out.println("================자재 LOT 재고 조회================");
      return "jsonView";
	}
	
}
	
