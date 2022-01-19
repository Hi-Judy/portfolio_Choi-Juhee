package egov.mes.BOM.dao;

import java.util.List;

public interface ProductBomMapper {
	
	List<ProductBomVO> ProFind();		//제품 조회
	List<ProductBomVO> rscFind();		//자재코드 조회
	List<ProductBomVO> ProcFind();		//공정코드 조회
	ProductBomVO rscName(ProductBomVO bomVO);			//자재코드 로 제품명 조회
	ProductBomVO ProcName(ProductBomVO bomVO);			//공정코드로 공정명 조회
	
	List<ProductBomVO> ProDetail(String groupCode); 	//제품 단건조회
	List<ProductBomVO> rscDetail(String groupCode); 	//BOM(자재) 상세조회
	List<ProductBomVO> ProcDetail(String groupCode);	//공정흐름 조회
	
	
	int ProcInsert (ProductBomVO BomVO); //공정흐름 데이터 추가
	int ProcDelete (ProductBomVO BomVO); //공정흐름 전체삭제
	
	
	int ResInsert (ProductBomVO BomVO); //자재데이터 추가
	int ResDelete (ProductBomVO BomVO); //자재 데이터 삭제
	void ResUpdate (ProductBomVO BomVO); //자재 데이터 업데이트
	
	int ResAllDelete (ProductBomVO BomVO); //자재BOM 전체 삭제
	
}
