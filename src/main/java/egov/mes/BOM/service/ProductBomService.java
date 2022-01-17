package egov.mes.BOM.service;

import java.util.List;

import egov.mes.BOM.dao.ProductBomVO;

public interface ProductBomService {
	
	List<ProductBomVO> ProFind(); 		//제품 조회
	List<ProductBomVO> rscFind();		//자재코드 조회
	List<ProductBomVO> ProcFind();		//골정코드 조회
	ProductBomVO rscName(ProductBomVO bomVO);			//자재코드로 자재명조회
	
	List<ProductBomVO> ProDetail(String groupCode); 	//제품 단건조회
	List<ProductBomVO> rscDetail(String groupCode); 	//BOM(자재) 상세조회
	List<ProductBomVO> ProcDetail(String groupCode);	//공정흐름 조회

}
