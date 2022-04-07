package deal.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter @Setter @ToString
public class DealDTO {
	//deal
	private int dealId;
	private int purchaseId;
	private int salesId;
	private int checkId;
	private int deliveryId;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date dealRegDate;
	//purchase
	private int purchaseUserId;
	private int purchaseProductId;
	private int status;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date purchaseRegDate;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date purchaseDueDate;
	//sales
	private int salesUserId;
	private int salesProductId;
	private int salesPrice;
	private int salesStatus;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date salesRegDate;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date salesDueDate;
	//product
	private String productName;
	private String modelId;
	private int releasePrice;
	private String img1;
	private String img2;
	private String img3;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date releaseDate;
	private String brandName;
	private int productSize;
	private String productCollection;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date productRegDate;
	//check
	private int checkProductId;
	private int checkUserId;
	private int checkState;
	private int checkResult;
	//delivery
	private int deliveryStatus;
	private String trackingNum;
	private Date deliveryRegDate;
	//user(sales)
	private String email;
	private String username;
	private String pwd;
	private String nickname;
	private int auth;
	private String phoneNum;
	private int reportCount;
	private String img;
	//user(purchase)
	private String pEmail;
	private String pUsername;
	private String pPwd;
	private String pNickname;
	private int pAuth;
	private String pPhoneNum;
	private int pReportCount;
	private String pImg;
	
}
