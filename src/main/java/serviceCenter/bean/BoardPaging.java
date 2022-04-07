package serviceCenter.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class BoardPaging {
	private int currentPage; //현재 페이지
	private int pageBlock; //한 번에 보여줄 페이지 갯수 [1][2][3][다음]
	private int pageSize; //1 페이지에 보여줄 글 갯수 
	private int totalA; //현재 db의 총 글수
	private StringBuffer pagingHTML; 
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		//총 페이지 수
		int totalP = ( totalA + (pageSize-1) ) / pageSize; 
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		
		int endPage = startPage + pageBlock - 1;
		if(endPage > totalP) endPage = totalP;
		
		//이전
		if(startPage > pageBlock)
			pagingHTML.append("<span id=paging onclick=paging(" + (startPage-1) + ")>이전</span>");
		
		//페이지번호
		for(int i=startPage; i<=endPage; i++) {
			if(i == currentPage)
				pagingHTML.append("<span id=currentPaging onclick=paging(" + i + ")>" + i + "</span>");
			else
				pagingHTML.append("<span id=paging onclick=paging(" + i + ")>" + i + "</span>");
		}
		
		//다음
		if(endPage < totalP)
			pagingHTML.append("<span id=paging onclick=paging(" + (endPage+1) + ")>다음</span>");
	}
	
}
