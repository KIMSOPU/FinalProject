package product.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Component
public class ProductDTO {
	private int productId;
	private String brandName;
	private String productName;
	private String productNameKor;
	private String modelId;
	private int releasePrice;
	private int productSize;
	private String productCollection;
	private String img1;
	private String img2;
	private String img3;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date releaseDate;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date regDate;
    private int todaysPrice;
}
