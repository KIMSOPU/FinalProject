package shop.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ShopPaging {
	private int currentPage;
	private int pageBlock; // [1][2][3] [다음]
	private int pageSize; //1페이지당 5개씩
	private int totalA; //총 글수
	private StringBuffer pagingHTML;
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		int totalP = (totalA + pageSize-1) / pageSize    ;//총 페이지 수
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1; //1 4 7 
		
		int endPage = startPage + pageBlock - 1;//9
		if(endPage > totalP) endPage = totalP;
			
		if(startPage > pageBlock)
			pagingHTML.append("<span id=paging onclick=shopPaging(" + (startPage-1) + ")>이전</span>");
				
		for(int i=startPage; i<=endPage; i++) {
			if(i == currentPage)
				pagingHTML.append("<span id=currentPaging onclick=shopPaging(" + i + ")>" + i + "</span>");
			else
				pagingHTML.append("<span id=paging onclick=shopPaging(" + i + ")>" + i + "</span>");
		}
		
		if(endPage < totalP)
			pagingHTML.append("<span id=paging onclick=shopPaging(" + (endPage+1) + ")>다음</span>");
		
	}

}





















