package egov.mes.product.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.product.dao.ProductMapper;
import egov.mes.product.dao.ProductVO;
import egov.mes.product.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired ProductMapper mapper ;

	@Override
	public List<ProductVO> podtList(ProductVO product) {
		return mapper.podtList(product) ;
	}

	@Override
	public List<ProductVO> findProduct(ProductVO product) {
		return mapper.findProduct(product) ;
	}

	@Override
	public void insertInOut(ProductVO product) {
		mapper.insertInOut(product) ;
	}

	@Override
	public void updateLotno(ProductVO product) {
		mapper.updateLotno(product) ;
	}

	@Override
	public void deleteInOut(ProductVO product) {
		mapper.deleteInOut(product) ;
	}

	@Override
	public List<ProductVO> selectOptions(ProductVO product) {
		return mapper.selectOptions(product) ;
	}
}
