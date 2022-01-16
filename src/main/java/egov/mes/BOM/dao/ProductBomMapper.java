package egov.mes.BOM.dao;

import java.util.List;

public interface ProductBomMapper {
	
	List<ProductBomVO> ProFind();		//제품 조회
	List<ProductBomVO> rscFind();		//자재코드 조회
	List<ProductBomVO> ProcFind();		//골정코드 조회
	ProductBomVO rscName(ProductBomVO bomVO);			//자재코드 로 제품명 조회
	
	
	List<ProductBomVO> ProDetail(String groupCode); 	//제품 단건조회
	List<ProductBomVO> rscDetail(String groupCode); 	//BOM(자재) 상세조회
	List<ProductBomVO> ProcDetail(String groupCode);	//공정흐름 조회
}
