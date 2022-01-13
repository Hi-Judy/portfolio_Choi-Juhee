package egov.mes.customer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egov.mes.customer.dao.CustomerMapper;
import egov.mes.customer.dao.CustomerVO;
import egov.mes.customer.service.CustomerService;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired CustomerMapper mapper ;
	
	@Override
	public List<CustomerVO> customerList(CustomerVO customer) {
		return mapper.customerList(customer) ;
	}

	@Override
	public List<CustomerVO> findCustomer(CustomerVO customer) {
		return mapper.findCustomer(customer) ;
	}

	@Override
	public List<CustomerVO> selectTradeInfo(CustomerVO customer) {
		return mapper.selectTradeInfo(customer) ;
	}

	@Override
	public int updateCustomer(CustomerVO customer) {
		return mapper.updateCustomer(customer) ;
	}

	@Override
	public String insertCustomer(CustomerVO customer) {
		return mapper.insertCustomer(customer) ;
	}

	@Override
	public String deleteCustomer(CustomerVO customer) {
		return mapper.deleteCustomer(customer) ;
	}

}
