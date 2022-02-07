package egov.mes.manufacture.process.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.mes.manufacture.process.dao.ManProcessVO;
import egov.mes.manufacture.process.service.ManProcessService;

@Controller
public class ManProcessController {

	@Autowired 
	ManProcessService service;
	
	@RequestMapping("/manProcess")
	public String conProcess() {
		return "manufacture/manProcess.tiles";
	}
	
	//브라우저 화면에 보여줄 진행공정 테이블
	@PostMapping("/selectProcList")
	public String selectProcList(@RequestBody ManProcessVO processVO, Model model ) {
		model.addAttribute("result", service.selectSumManQnt(processVO));
		//System.out.println("브라우저 화면에 보여줄 진행공정 테이블 TEST");
		return "jsonView";
	}
	
	
	//제품에 해당하는 공정 조회
	@PostMapping("/selectProc")
	public String selectProc(@RequestBody ManProcessVO processVO, Model model) {
		//System.out.println("제품에 해당하는 공정 조회: "+ service.selectProc(processVO));
		ManProcessVO vo = service.selectProc(processVO); //insert 하는 impl 메소드
		model.addAttribute("result", vo);
		
		service.updateFirstProc(vo); //insert 하는 impl 메소드 끝 -> update 메소드 부른다.
		return "jsonView";
	}
	
	
	//지시된 제품에 해당하는 공정 조회
	@GetMapping("/selectProcess/{podtCode}/{comCode}")
	public String selectedCommand(@PathVariable String podtCode, 
								  @PathVariable String comCode,
								  ManProcessVO processVO,
								  Model model) {
		
		Map<String, List<ManProcessVO>> maps = new HashMap<>();
		maps.put("contents", service.selectProcess(processVO));
		
		Map<String, Object> map = new HashMap<>();
		map.put("data", maps);
		
		model.addAttribute("result", true);
		model.addAttribute("data", maps);
		
		//System.out.println("조회된 생산지시서 : "+ service.selectedCommand(processVO));
		
		return "jsonView";
	}
		
	
	//생산지시서 조회
	@PostMapping("/selCommand")
	public String selectCommand(@RequestBody ManProcessVO processVO, Model model ) { //쿼리 실행한 결과를 모델에 담아서 jsp 페이지에서 보여준다.
		//System.out.println(processVO.getManStartDate());
		
		model.addAttribute("result", service.selectCommand(processVO));
		
		//System.out.println("생산지시서 조회: "+ service.selectCommand(processVO));
		return "jsonView";
	}
	
	
}
