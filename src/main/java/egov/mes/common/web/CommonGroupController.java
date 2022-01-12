package egov.mes.common.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.common.service.CommonGroupService;

@Controller
public class CommonGroupController {
	
	@Autowired CommonGroupService service;
	
	//공통코드 페이지로 이동
	@RequestMapping("CommonGroup")
	public String find() {
		//	System.out.println("공통그룹페이지 이동");
		return "view/CommonGroupInfo.tiles";
	}

	//고통코드 조회 ajax
	@ResponseBody
	@RequestMapping("findIn")
	public ModelAndView findIn () {
	//	System.out.println("공통그룹 테이블 호출");
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data",service.find());
	return jsonView ;
		
	}
	
	
	//단건조회
	@ResponseBody
	@RequestMapping("findSelect/{groupCode}")
	public ModelAndView findSelect(@PathVariable String groupCode) {
		System.out.println(groupCode);
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data",service.findSelect(groupCode));
		System.out.println(jsonView);
		return jsonView;
		
	}

}
