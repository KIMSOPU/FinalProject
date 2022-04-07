package mypage.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class WishListDTO {
	private int wishListId, userId, productId;
}
