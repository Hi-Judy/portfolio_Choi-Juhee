package egov.mes.manufacture.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.dao.ManufactureMapper;
import egov.mes.manufacture.dao.ManufacturePlanVO;
import egov.mes.manufacture.service.ManufactureService;

@Service("manufactureService")
public class ManufactureServiceImpl implements ManufactureService {

	@Autowired
	private ManufactureMapper manMapper;

	@Override
	public List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVO) {
		return manMapper.selectPlan(mPlanVO);
	}

	@Override
	public List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo) {
		return manMapper.selectRes(mPlanVo);
	}

}
