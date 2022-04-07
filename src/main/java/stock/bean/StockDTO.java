package stock.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class StockDTO {
	private int stockId;
	private String modelId;
	private int productSize;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date exportDate;
	
	private int productId;
	private long price;
}
