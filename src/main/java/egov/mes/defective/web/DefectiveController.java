package egov.mes.defective.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.defective.dao.DefectiveVO;
import egov.mes.defective.service.DefectiveService;

@Controller
public class DefectiveController {

	@Autowired DefectiveService service ;
	
	// egov 메인에서 defective_product.jsp로 연결
	@RequestMapping("DefectiveProduct")
	public String DefectiveManagement() {
		return "defective_product/defective_product.tiles" ;
	}
	
	
}
