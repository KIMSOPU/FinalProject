package shop.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter @Setter @ToString
public class ShopDTO {
	//product
	private int productId;
	private String productName;
	private String productNameKor;
	private String modelId;
	private int releasePrice;
	private String img1;
	private String img2;
	private String img3;
	@JsonFormat(pattern="yyyy/MM/dd")
	private Date releaseDate;
	private String brandName;
	private int productSize;
	private String productCollection;
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss")
	private Date productRegDate;
	//상품이 태그된 게시글 갯수
	private int styleCount;
	//관심상품으로 등록된 갯수
	private int wishListCount;
	//price (즉시구매가=최저가 , 즉시판매가=최고가)
	private int todaysPrice;
	private int lowest; //todaysPrice
	private int highest;
	//위시 등록 여부
	private String wishOnOff; 
	
}
