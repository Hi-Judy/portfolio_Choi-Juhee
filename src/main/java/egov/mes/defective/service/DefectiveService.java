package egov.mes.defective.service;

import java.util.List;

import egov.mes.defective.dao.DefectiveVO;

public interface DefectiveService {
	List<DefectiveVO> findPodtCode(DefectiveVO defective) ;	
	List<DefectiveVO> selectDefective(DefectiveVO defective) ;
}
