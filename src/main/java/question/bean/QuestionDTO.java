package question.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Component
public class QuestionDTO {
		private int qnaId;
		private String qnaName;
		private String title;
		private String contents;
		private String qnaPwd;
		private int step;
		private int pseq;
		private int status;
		@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
		private Date regDate;
}
