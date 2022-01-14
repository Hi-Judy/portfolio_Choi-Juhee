package egov.mes.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.order.dao.OrderMapper;
import egov.mes.order.dao.OrderVO;
import egov.mes.order.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired OrderMapper mapper ;
	
	@Override
	public List<OrderVO> orderList(OrderVO order) {
		return mapper.orderList(order) ;
	}

	@Override
	public List<OrderVO> orderSelect(OrderVO order) {
		return mapper.orderSelect(order) ;
	}

}
