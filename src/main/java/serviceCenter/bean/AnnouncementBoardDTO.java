package serviceCenter.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class AnnouncementBoardDTO {
	private int announcementId;
	private String title;
	private String contents;
	private int hit;
	private String img1, img2, img3;
	private Date regDate;
}
