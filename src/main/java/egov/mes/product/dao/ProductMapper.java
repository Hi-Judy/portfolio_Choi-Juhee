package egov.mes.product.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("productMapper")
public interface ProductMapper {
	List<ProductVO> podtList(ProductVO product) ;
	List<ProductVO> findProduct(ProductVO product) ;
	List<ProductVO> findProductAll(ProductVO product) ;
	void insertInOut(ProductVO product) ;
	void updateLotno(ProductVO product) ;
	void deleteInOut(ProductVO product) ;
	List<ProductVO> selectOptions(ProductVO product) ;
	List<ProductVO> selectPodtOptions(ProductVO product) ;
	List<ProductVO> selectMatLot(ProductVO product) ;
	
	// 테스트
	void productTest(ProductVO product) ;
	List<ProductVO> selectQR(ProductVO product) ;
	// 테스트
}
