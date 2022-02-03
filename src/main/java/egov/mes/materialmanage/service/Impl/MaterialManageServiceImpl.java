package egov.mes.materialmanage.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.materialmanage.dao.MaterialManageMapper;
import egov.mes.materialmanage.dao.MaterialManageVO;
import egov.mes.materialmanage.service.MaterialManageService;

@Service
public class MaterialManageServiceImpl implements MaterialManageService {
	
	@Autowired MaterialManageMapper mapper;
	
	//자재정보 간략조회
	@Override
	public List<MaterialManageVO> MaterialListAllFind() {
		return mapper.MaterialListAllFind();
	}
	
	//자재 테이블에서 단건조회
	@Override
	public MaterialManageVO resSearch(String RscCode) {
		
		return mapper.resSearch(RscCode) ;
	}
	
	//자재입/출고 테이블 조건 검색
	@Override
	public List<MaterialManageVO> resStListSearch(String RscCode) {
		
		return mapper.resStListSearch(RscCode) ;
	}
	
	//사원조회(자재반장만)
	@Override
	public List<MaterialManageVO> EmpFind() {
		
		return mapper.EmpFind();
	}
	
	//입고업체 조회
	@Override
	public List<MaterialManageVO> ClientFind() {
		
		return mapper.ClientFind();
	}
	
	//월별자재재고 조회
	@Override
	public List<MaterialManageVO> MonthlyInventory( String RscCode ) {
		
		return mapper.MonthlyInventory(RscCode);
	}
	
	
	//자재 신규등록
	@Override
	public void AddMat(MaterialManageVO matVO) {
		mapper.AddMat(matVO);
		
	}
	
	//코드구분 테이블 신규자재등록
	@Override
	public void AddCommon(MaterialManageVO matVO) {
		mapper.AddCommon(matVO);
		
	}
	
	//자재정보 수정
	@Override
	public void UpdateMat(MaterialManageVO matVO) {
		
		mapper.UpdateMat(matVO);
	}


	



}
