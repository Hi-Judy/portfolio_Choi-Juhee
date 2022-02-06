package egov.mes.defective.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.defective.dao.DefectiveMapper;
import egov.mes.defective.dao.DefectiveVO;
import egov.mes.defective.service.DefectiveService;

@Service
public class DefectiveServiceImpl implements DefectiveService {

	@Autowired DefectiveMapper mapper ;

	@Override
	public List<DefectiveVO> findPodtCode(DefectiveVO defective) {
		return mapper.findPodtCode(defective) ;
	}

	@Override
	public List<DefectiveVO> selectDefective(DefectiveVO defective) {
		return mapper.selectDefective(defective) ;
	}

	@Override
	public List<DefectiveVO> selectProcess(DefectiveVO defective) {
		return mapper.selectProcess(defective) ;
	}

	@Override
	public List<DefectiveVO> selectChart(DefectiveVO defective) {
		return mapper.selectChart(defective) ;
	}

	@Override
	public List<DefectiveVO> selectChart2(DefectiveVO defective) {
		return mapper.selectChart2(defective) ;
	}

	@Override
	public List<DefectiveVO> checkProductList(DefectiveVO defective) {
		return mapper.checkProductList(defective) ;
	}

	@Override
	public List<DefectiveVO> defList(DefectiveVO defective) {
		return mapper.defList(defective) ;
	}
}
