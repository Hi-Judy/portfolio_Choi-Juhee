package egov.mes.manufacture.plan.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.manufacture.plan.dao.ManufactureMapper;
import egov.mes.manufacture.plan.dao.ManufacturePlanVO;
import egov.mes.manufacture.plan.dao.ModifyVO;
import egov.mes.manufacture.plan.service.ManufactureService;


@Service("manufactureService")
public class ManufactureServiceImpl implements ManufactureService {

	@Autowired
	private ManufactureMapper manMapper;

	//생산계획 조회
	@Override
	public List<Map<String, String>> selectManPlan(ManufacturePlanVO planVo) {
		return manMapper.selectManPlan(planVo);
	}

	//생산계획 디테일 조회
	@Override
	public List<ManufacturePlanVO> selectManPlanDetail(ManufacturePlanVO planVo) {
		return manMapper.selectManPlanDetail(planVo);
	}

	//자재조회
	@Override
	public List<ManufacturePlanVO> selectRes(ManufacturePlanVO mPlanVo) {
		return manMapper.selectRes(mPlanVo);
	}
	
	//미계획조회
	@Override
	public List<ManufacturePlanVO> selectPlan(ManufacturePlanVO mPlanVO) {
		return manMapper.selectPlan(mPlanVO);
	}
	
	//생산계획추가
	@Override
	public int insertPlan(ModifyVO<ManufacturePlanVO> list ) {
	
		System.out.println("*******************MODIFY_INSERT_test**************");
		if(list.getUpdatedRows() != null) {
			for(ManufacturePlanVO planVO : list.getUpdatedRows()) {
				System.out.println("12321S");
				manMapper.insertPlanDetail(planVO);
				System.out.println(planVO);
			}
			manMapper.insertPlan(list.getUpdatedRows().get(0));
		}
	
		
		System.out.println("*******************MODIFY_DELETE_test**************");
		if(list.getDeletedRows() != null) {
			for(ManufacturePlanVO planVO : list.getDeletedRows()) {
				System.out.println(planVO);
				manMapper.deletePlan(planVO);
				System.out.println(planVO);
			}
		}
		
	
		
		System.out.println("*******************MODIFY_UPDATE_test**************");
		if(list.getUpdatedRows() != null) {
			for(ManufacturePlanVO planVO : list.getUpdatedRows()) {
				manMapper.updateOrdStatus(planVO);
				System.out.println(planVO);
			}
		}
		
		return 1;
	}

	
	//생산계획 조회(조회페이지)
	@Override
	public List<ManufacturePlanVO> selectManufacturePlan(ManufacturePlanVO mPlanVo) {
		return manMapper.selectManufacturePlan(mPlanVo);
	}

	
	//생산계획 디테일 조회(조회페이지)
	@Override
	public List<ManufacturePlanVO> selectManufactureDetail(ManufacturePlanVO planVo) {
		return manMapper.selectManufactureDetail(planVo);
	}

	
}
