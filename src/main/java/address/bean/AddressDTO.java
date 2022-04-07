package address.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class AddressDTO {
	private int addressId;
	private int userId;
	private String recipient;
	private String addr1;
	private String addr2;
	private String zipcode;
	private String defaultAddr;
	private Date regDate;
}