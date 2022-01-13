package egov.mes.common.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egov.mes.common.dao.CommonGroupVO;
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
		/*
		 * List<CommonGroupVO> list = new ArrayList<>(); list = service.find();
		 * System.out.println(list);
		 */
		//위에 List 형식은 egov 에서 사용할수없어서 아래에 형식으로 jsonView 를 만들어서 리턴해야한다
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data",service.find());
	return jsonView ;
		
	}
	
	
	//단건조회 처리
	@ResponseBody
	@RequestMapping("findSelect/{groupCode}")
	public ModelAndView findSelect(@PathVariable String groupCode) {
	//	System.out.println(groupCode);
		ModelAndView jsonView = new ModelAndView("jsonView");
		jsonView.addObject("data",service.findSelect(groupCode));
	//	System.out.println(jsonView);
		return jsonView;
		
	}
	
	//추가
	@ResponseBody
	@PostMapping(value = "Insert" ) //보내줄떄 배열로 보냈기떄문에 받을때로 List 배열로 받아야한다.
	public String NewData (@RequestBody List<CommonGroupVO> cgVO) {
			
		service.DataAdd(cgVO);
			
		return null ;
	}
	
	//업데이트
	@ResponseBody
	@PostMapping(value = "dataUpdate")
	public String dataUpdate (@RequestBody List<CommonGroupVO> cgVO) {
		System.out.println("업데이트준비");
		System.out.println(cgVO);
		service.dataUpdate(cgVO);
		System.out.println("업데이트완료");
		return null;
	}
	

}
