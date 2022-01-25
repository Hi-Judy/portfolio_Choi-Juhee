package egov.mes.manufacture.plan.dao;

import java.util.List;

import lombok.Data;
@Data
public class ModifyVO<T> {
	
	List<T> createdRows;
	List<T> updatedRows;
	List<T> deletedRows;
}