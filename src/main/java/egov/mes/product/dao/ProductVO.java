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
	String comNoDetail ;
}
