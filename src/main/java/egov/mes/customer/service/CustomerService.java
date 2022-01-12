package egov.mes.customer.service;

import java.util.List;

import egov.mes.customer.dao.CustomerVO;

public interface CustomerService {
	List<CustomerVO> customerList(CustomerVO customer) ;
	List<CustomerVO> findCustomer(CustomerVO customer) ;
	List<CustomerVO> selectTradeInfo(CustomerVO customer) ;
	int updateCustomer(CustomerVO customer) ;
	String insertCustomer(CustomerVO customer) ;
	String deleteCustomer(CustomerVO customer) ;
}
