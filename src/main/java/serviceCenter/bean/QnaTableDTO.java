package serviceCenter.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class QnaTableDTO {
	private int qnaId;
	private String qnaName, title, contents, qnaPwd;
	private int step, pseq, status;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy.MM.dd")
	private Date regDate;
}
