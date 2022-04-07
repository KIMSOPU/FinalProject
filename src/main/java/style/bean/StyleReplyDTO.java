package style.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class StyleReplyDTO { //조인 테이블
	private int styleReplyId;
	private String img;
	private String username;
	private String intromsg;
	private String contents;
	@JsonFormat(pattern = "M월 d일 H시", timezone = "Asia/Seoul")
	private Date regDate;
}
