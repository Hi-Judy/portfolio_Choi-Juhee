package egov.mes.defective.dao;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;

import lombok.Data;

@Data
public class ModifyVO<T> {
	
	List<T> createdRows ;
	List<T> updatedRows ;
	List<T> deletedRows ;
}
