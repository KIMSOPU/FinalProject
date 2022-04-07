package account.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class AccountDTO {
	private int accountId;
	private int userId;
	private String bank;
	private String accountNum;
	private String accountHolder;
}