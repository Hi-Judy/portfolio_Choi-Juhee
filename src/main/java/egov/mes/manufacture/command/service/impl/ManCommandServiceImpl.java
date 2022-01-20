package egov.mes.manufacture.command.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.command.dao.ManCommandMapper;
import egov.mes.manufacture.command.dao.ManCommandVO;
import egov.mes.manufacture.command.service.ManCommandService;

@Service("manCommandService")
public class ManCommandServiceImpl implements ManCommandService{

	@Autowired
	private ManCommandMapper mapper;
	
	//지시가 없는 생산계획 디테일 조회(생산지시 관리 페이지)
	@Override
	public List<ManCommandVO> selectManPlan(ManCommandVO commandVO) {
		return mapper.selectManPlan(commandVO);
	}

	//생산계획 디테일 상세 조회(생산지시서 관리 페이지)
	@Override
	public List<ManCommandVO> selectManPlanDetail(ManCommandVO commandVO) {
		return mapper.selectManPlanDetail(commandVO);
	}
	
	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	@Override
	public List<ManCommandVO> selectRes(ManCommandVO commandVO) {
		return mapper.selectRes(commandVO);
	}

	//제품 만드는데 필요한 공정에 해당하는 설비 조회
	@Override
	public List<ManCommandVO> selectFac(ManCommandVO commandVO) {
		return mapper.selectFac(commandVO);
	}
	

	//제품 코드 입력했을 때 필요한 공정별 자재 조회
	@Override
	public List<ManCommandVO> selectRes(ManCommandVO commandVO) {
		return mapper.selectRes(commandVO);
	}

}
