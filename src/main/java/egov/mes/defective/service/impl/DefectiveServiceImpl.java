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
	
	

}
