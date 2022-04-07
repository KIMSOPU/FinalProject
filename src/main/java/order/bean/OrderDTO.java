package order.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter @Setter @ToString
public class OrderDTO {
	//order
	private int orderId;
	private int userId;
	private int paymentId;
	private int productId;
	private int deliveryId;
	private int addressId;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date orderDate;
	private String orderPhoneNum;
	//product
	private int brandId;
	private String productName;
	private String modelId;
	private int price;
	private int releasePrice;
	private int salesPrice;
	private int productSize;
	private String img1;
	private String img2;
	private String img3;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date releaseDate;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date productRegDate;
	//payment
	private String paymentMethod;
	private String bank;
	private String accountNum;
	private String accountHolder;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date paymentDate;
	//user
	private String email;
	private String username;
	private String pwd;
	private String nickname;
	private int auth;
	private String userPhoneNum;
	private String introMsg;
	private int reportCount;
	private String userImg; // inner join SQL문에 추가 해야됌(슬랙 insert문도)
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date lastDate;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date userRegDate;
	//delivery
	private int deliveryStatus;
	private String trackingNum;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date deliveryRegDate;
	//address
	private int addressUserId;
	private String recipient;
	private String addr1;
	private String addr2;
	private String zipcode;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date addressRegDate;
	
}
