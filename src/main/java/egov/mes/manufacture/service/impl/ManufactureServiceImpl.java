package egov.mes.manufacture.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.dao.ManufactureMapper;
import egov.mes.manufacture.dao.ManufacturePlanVO;
import egov.mes.manufacture.dao.ModifyVO;
import egov.mes.manufacture.service.ManufactureService;


@Service("manufactureService")
public class ManufactureServiceImpl implements ManufactureService {

	@Autowired
	private ManufactureMapper manMapper;

	//미계획조회
	@Override
	public List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVO) {
		return manMapper.selectPlan(mPlanVO);
	}

	//자재조회
	@Override
	public List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo) {
		return manMapper.selectRes(mPlanVo);
	}
	
	//생산계획추가
	@Override
	public int insertPlan(ModifyVO<ManufacturePlanVO> list ) {
		
		for(ManufacturePlanVO planVO : list.getUpdatedRows()) {
			manMapper.insertPlanDetail(planVO);
		}
		manMapper.insertPlan(list.getUpdatedRows().get(0));
		
		return 1;
	}

	//생산계획조회
	@Override
	public List<ManufacturePlanVO> selectManPlan(ManufacturePlanVO mPlanVo) {

		return manMapper.selectManPlan(mPlanVo);
	}


}
