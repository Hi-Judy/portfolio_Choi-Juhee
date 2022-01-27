package egov.mes.product.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ProductVO {
	String qntInfono ;
	String podtCode ;
	String codeName ;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date manDate ; 
	String manDatestart ;
	String manDateend ;
	String podtInput ;
	String podtOutput ;
	String podtEtc ;
	String podtLot ;
	String qnt ;
	
	String comCode ;
	String manPlanNo ;
	String podtName ;
	String ordCode ;
	String manDate2 ;
	
	String code ;
	String comNoDetail ;
	
	String matNo ; 
	String matLotno ;
	String rscLot ;
}
