package egov.mes.customer.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("customerMapper")
public interface CustomerMapper {
	List<CustomerVO> customerList(CustomerVO customer) ;
	List<CustomerVO> findCustomer(CustomerVO customer) ;
	List<CustomerVO> selectTradeInfo(CustomerVO customer) ;
	int updateCustomer(CustomerVO customer) ;
	void insertCustomer(CustomerVO customer) ;
	void deleteCustomer(CustomerVO customer) ;
}
