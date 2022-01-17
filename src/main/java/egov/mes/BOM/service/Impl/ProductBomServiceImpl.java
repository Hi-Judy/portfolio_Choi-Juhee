package egov.mes.BOM.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.BOM.dao.ProductBomMapper;
import egov.mes.BOM.dao.ProductBomVO;
import egov.mes.BOM.service.ProductBomService;

@Service
public class ProductBomServiceImpl implements ProductBomService {
	
	@Autowired ProductBomMapper bomMapper;
	
	//제품조회 처리
	@Override
	public List<ProductBomVO> ProFind() {
		
		return bomMapper.ProFind();
	}
	
	//자재 코드 조회
	@Override
	public List<ProductBomVO> rscFind() {
		// TODO Auto-generated method stub
		return bomMapper.rscFind();
	}
	//자재코드로 제품명 조회
	@Override
	public ProductBomVO rscName(ProductBomVO bomVO ) {
		// TODO Auto-generated method stub
		return bomMapper.rscName(bomVO);
	}
	
	
	//제품단건조회
	@Override
	public List<ProductBomVO> ProDetail(String groupCode) {
		// TODO Auto-generated method stub
		return bomMapper.ProDetail(groupCode);
	}
	
	//BOM(자재) 상세조회
	@Override
	public List<ProductBomVO> rscDetail(String groupCode) {
		// TODO Auto-generated method stub
		return bomMapper.rscDetail(groupCode) ;
	}
	
	//공정흐름 조회
	@Override
	public List<ProductBomVO> ProcDetail(String groupCode) {
		// TODO Auto-generated method stub
		return bomMapper.ProcDetail(groupCode) ;
	}
	
	//공정코드만 조회
	@Override
	public List<ProductBomVO> ProcFind() {
		// TODO Auto-generated method stub
		return bomMapper.ProcFind();
	}





}
