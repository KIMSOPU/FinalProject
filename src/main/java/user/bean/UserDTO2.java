package user.bean;

import java.sql.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class UserDTO2 {

	private int orderId;
	private int stockId;
	  @JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date orderDate;
	private int stockProductId;
	//@NumberFormat
	private int pricePrice;
	private int purchaseProductId;
	private int purchaseId;
	private int purchaseStatus;
	  @JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date purchaseDueDate;
	private String productName;
	private int salesId;
	private int salesProductId;
	private int salesStatus;
	private int salesPrice;
	  @JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date salesDueDate;
	private String productProductName;
	

	
}
