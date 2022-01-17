package egov.mes.product.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("productMapper")
public interface ProductMapper {
	List<ProductVO> podtList(ProductVO product) ;
	List<ProductVO> findProduct(ProductVO product) ;
	void insertInOut(ProductVO product) ;
	void updateLotno(ProductVO product) ;
	void deleteInOut(ProductVO product) ;
	List<ProductVO> selectOptions(ProductVO product) ;
}
