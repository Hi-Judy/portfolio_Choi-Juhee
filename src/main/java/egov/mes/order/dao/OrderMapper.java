package egov.mes.order.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("orderMapper")
public interface OrderMapper {
	List<OrderVO> orderList(OrderVO order) ;
	List<OrderVO> orderSelect(OrderVO order) ;
	int noManRelease(OrderVO order) ;
	List<OrderVO> noManSelect(OrderVO order) ;
}
