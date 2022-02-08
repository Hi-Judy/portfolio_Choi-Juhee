package egov.mes.manufacture.perfomance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.perfomance.dao.ManPerformanceMapper;
import egov.mes.manufacture.perfomance.dao.ManPerformanceVO;
import egov.mes.manufacture.perfomance.service.ManPerformanceService;

@Service("ManPerformanceService")
public class ManPerformanceServiceImpl implements ManPerformanceService {
	
	@Autowired 
	private ManPerformanceMapper mapper;

	//생산실적관리
	@Override
	public List<ManPerformanceVO> selectDef(ManPerformanceVO performanceVO) {
		System.out.println("11");

		if(performanceVO.getPerformanceSort().equals("podtCode")) {
			System.out.println("제품별 실적조회: " + mapper.selectPodtDef(performanceVO));
			return mapper.selectPodtDef(performanceVO);
		} else if(performanceVO.getPerformanceSort().equals("monthCode") ) {
			System.out.println("월별 실적조회: " + mapper.selectMonthDef(performanceVO));
			return mapper.selectMonthDef(performanceVO);
		}
		
		return null;
	}


//	@Override
//	public ManPerformanceVO selectPodtDef(ManPerformanceVO performanceVO) {
//		return mapper.selectPodtDef(performanceVO);
//	}
//
//	@Override
//	public ManPerformanceVO selectMonthDef(ManPerformanceVO performanceVO) {
//		return mapper.selectMonthDef(performanceVO);
//	}

	

	

}
