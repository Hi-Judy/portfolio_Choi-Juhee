package egov.mes.Proc.dao;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProcessControlVO {
	
	//페이지 이동
	@RequestMapping("ProcessControl")
	public String PageView() {
		return "view/ProcessControlInfo.tiles";
	}

}
