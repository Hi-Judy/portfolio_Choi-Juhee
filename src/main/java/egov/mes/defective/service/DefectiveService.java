package egov.mes.defective.service;

import java.util.List;

import egov.mes.defective.dao.DefectiveVO;

public interface DefectiveService {
	List<DefectiveVO> findPodtCode(DefectiveVO defective) ;	
	List<DefectiveVO> selectDefective(DefectiveVO defective) ;
	List<DefectiveVO> selectProcess(DefectiveVO defective) ;
	List<DefectiveVO> selectChart(DefectiveVO defective) ;
	List<DefectiveVO> selectChart2(DefectiveVO defective) ;
}
