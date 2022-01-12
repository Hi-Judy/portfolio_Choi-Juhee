package egov.mes.manufacture.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.dao.ManufacturePlanVO;
import egov.mes.manufacture.service.ManufactureService;

@Controller
public class ManufactureController {

	@Autowired ManufactureService manService;
	
	//egov 메인에서 manufacture.jsp로 연결
	@RequestMapping("/manufacture/manufacture")
	public String selectPlan(ManufacturePlanVO planVO, Model model )  {
		System.out.println("123");
		model.addAttribute("manList",manService.selectPlan(planVO));
		System.out.println("345");
		return "manufacture/manufacture.tiles";
	}
	
	//미계획 조회 모달에서 매핑
	@RequestMapping("/manufacture/plan")
	public String selectPlan2(ManufacturePlanVO planVO, Model model )  {
		
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		//쿼리 결과를 contents 안의 배열로 넣기. contents 이름으로 maps에 담기.
		maps.put("contents", manService.selectPlan(planVO));

		Map<String, Object> map = new HashMap<>();
		//contents를 담은 maps를 data 이름으로 map에 담기.
		map.put("data", maps);
		
		model.addAttribute("result",true);
		model.addAttribute("data", maps);
		return "jsonView";
	}
	
	//자재 조회 모달에서 매핑
	@PostMapping("/manufacture/resource")
	public String selectRes(ManufacturePlanVO planVO, Model model) {
		
		//System.out.println("@@@@@@@@"+planVO.getPodtCode());
		
		Map<String, List<ManufacturePlanVO>> maps = new HashMap<>();
		maps.put("contents", manService.selectRes(planVO));

		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result",true);
		model.addAttribute("data", maps);
		return "jsonView";
	}
	
	//생산계획에서 한 건 추가
	@PutMapping("/manufacture/main")
	public boolean modifyData(ManufacturePlanVO planVO) {
		System.out.println("!!!!"+planVO);
		
		//여기서 어떻게 해야하지?
		//insert는 테이블 2개에 해야한다면 쿼리2, 메소드2, ...? 
		//service.modify() 처럼 서비스 메소드 부르기?????
		
		return true;
	}
}
