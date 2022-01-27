package egov.mes.BOM.service;

import java.util.List;

import egov.mes.BOM.dao.ProductBomVO;

public interface ProductBomService {
	
	List<ProductBomVO> ProFind(); 		//제품 조회
	List<ProductBomVO> rscFind();		//자재코드 조회
	List<ProductBomVO> ProcFind();		//골정코드 조회
	ProductBomVO rscName(ProductBomVO bomVO);			//자재코드로 자재명조회
	ProductBomVO RscUnit (ProductBomVO bomVO);			//자재코드로 자재단위 조회	
	ProductBomVO ProcName(ProductBomVO bomVO);			//공정코드로 공정명 조회
	
	List<ProductBomVO> ProDetail(String groupCode); 	//제품 단건조회
	List<ProductBomVO> rscDetail(String groupCode); 	//BOM(자재) 상세조회
	List<ProductBomVO> ProcDetail(String groupCode);	//공정흐름 조회
	
	int ProcInsert  (List<ProductBomVO> bomVO);	//공정흐름 데이터 추가
	int ProcDelete  (ProductBomVO BomVO); 		//공정흐름 전체삭제
	void ProcUpdate (List<ProductBomVO> bomVO); //공정흐름 데이터수정
	
	int ResInsert (List<ProductBomVO> bomVO); //자재데이터 추가
	int ResDelete (List<ProductBomVO> bomVO); //자제 데이터 삭제
	void ResUpdate (List<ProductBomVO> bomVO); //자재 데이터 업데이트
	
	int ResAllDelete (ProductBomVO BomVO); //자재BOM 전체 삭제

}
