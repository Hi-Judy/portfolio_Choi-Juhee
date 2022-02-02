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
	public void insertCustomer(CustomerVO customer) {
		mapper.insertCustomer(customer) ;
	}

	@Override
	public void deleteCustomer(CustomerVO customer) {
		mapper.deleteCustomer(customer) ;
	}

	@Override
	public List<CustomerVO> findCustomerAll(CustomerVO customer) {
		return mapper.findCustomerAll(customer) ;
	}

}
