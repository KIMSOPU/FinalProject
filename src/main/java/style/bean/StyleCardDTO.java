package style.bean;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Component
@Data
public class StyleCardDTO { 
	//스타일 테이블
	private int styleId;
	private int userId;
	private int productId;
	private String contents;
	private int likeCount;
	private int replyCount;
	private int reportCount;
	private String likeOnOff; //스타일 게시물 공감 여부 on/off로 리턴 >> db 갔다와야함
	private String img1;
	private String img2;
	private String img3;
	@JsonFormat(pattern = "M월 d일 H시", timezone = "Asia/Seoul")
	private Date regDate;
	
	//회원 테이블
	private String username; 
	private String img; //회원 프로필사진 src
	private String introMsg; //소개글

	//상품 테이블
	private String productName; //게시물에 태그된 상품명
	private String productImg; //게시물에 태그된 상품 썸네일
	
	//판매
	private int price; //판매 테이블에서 최저 가격 1개 추출 (조건)상품번호, 판매상태=0, 가격 오름차순 >> 집계 필요
	
	//댓글 리스트
	private List<StyleReplyDTO> replyList; 
}
