package check.bean;

import org.springframework.stereotype.Component;
import lombok.Data;

@Component
@Data
public class CheckDTO {
	
	private int checkId;
	private int productId;
	
	private int userId;
	private int checkState;
	private int checkResult;
	
	// 검수관리 페이지 회원 아이디
	private String userName;
	// 검수과리 페이지 상품이름
	private String productName;
	
	private int salesId;
	
}
