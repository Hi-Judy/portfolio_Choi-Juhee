package egov.mes.BOM.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductBomController {
	
	//페이지 이동
	@RequestMapping("ProductBom")
	public String PageView() {
		return "view/ProductBomInfo.tiles";
	}

}
