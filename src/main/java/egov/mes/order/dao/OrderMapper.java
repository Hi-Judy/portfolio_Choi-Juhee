package egov.mes.order.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("orderMapper")
public interface OrderMapper {
	List<OrderVO> orderList(OrderVO order) ;
}
