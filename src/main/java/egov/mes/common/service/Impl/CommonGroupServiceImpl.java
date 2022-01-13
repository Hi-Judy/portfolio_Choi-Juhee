package egov.mes.common.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.common.dao.CommonGroupMapper;
import egov.mes.common.dao.CommonGroupVO;
import egov.mes.common.service.CommonGroupService;

@Service
public class CommonGroupServiceImpl implements CommonGroupService {
	
	@Autowired CommonGroupMapper commonGroupMapper;
	
	//공통그룹 테이블 조회
	@Override
	public List<CommonGroupVO> find() {
		return commonGroupMapper.find();
	}
	//단건조회(코드구분에서)
	@Override
	public List<CommonGroupVO> findSelect(String groupCode) {
		// TODO Auto-generated method stub
		return commonGroupMapper.findSelect(groupCode);
	}
	
	//코드구분 테이블에 데이트 <추가>
	@Override
	public int DataAdd(List<CommonGroupVO> cgVO) {
		for (CommonGroupVO rsts : cgVO)  //List 
		 commonGroupMapper.DataAdd(rsts);
		int a = 0;
		return a ;
	}
	//수정
	@Override
	public int dataUpdate(List<CommonGroupVO> cgVO) {
		for (CommonGroupVO rsts : cgVO)
			commonGroupMapper.dataUpdate(rsts);
		return 0;
	}

}
