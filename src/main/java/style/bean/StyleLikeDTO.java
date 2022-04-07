package style.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class StyleLikeDTO {
	private int likeId;
	private int userId;
	private int styleId;
}
