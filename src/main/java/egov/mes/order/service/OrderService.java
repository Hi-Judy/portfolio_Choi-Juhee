package egov.mes.order.service;

import java.util.List;

import egov.mes.order.dao.OrderVO;

public interface OrderService {
	List<OrderVO> orderList(OrderVO order) ;
	List<OrderVO> orderSelect(OrderVO order) ;
}
