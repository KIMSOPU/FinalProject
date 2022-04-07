package stats.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class StatsDTO {
	public int productId;
	public int price;
	@JsonFormat(pattern="MM/dd(EEE)")
	public Date regDate;
}
