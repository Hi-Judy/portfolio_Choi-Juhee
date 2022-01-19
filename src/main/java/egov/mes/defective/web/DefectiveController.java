package egov.mes.defective.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.defective.service.DefectiveService;

@Controller
public class DefectiveController {

	@Autowired DefectiveService service ;
	
	@RequestMapping("DefectiveProduct")
	public String DefectiveManagement() {
		return "defective_product/defective_product.tiles" ;
	}
	
}
