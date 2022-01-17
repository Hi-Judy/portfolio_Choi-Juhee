package egov.mes.resources.store.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ResourceStoreController {
	@Autowired
	
	@RequestMapping("ResourcesStoreList")
	public String ResourcesStoreList() {
		return "resources/resourceStore.tiles";
	}
}
