package product.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ProductPaging {
	private int currentPage;
	private int pageBlock;
	private int pageSize;
	private int totalA;
	private StringBuffer pagingHTML;
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		int totalP = (totalA + pageSize-1) / pageSize    ;//총 페이지 수		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1; //1 4 7 	
		int endPage = startPage + pageBlock - 1;//9	
		
		
		if(endPage > totalP) {
			endPage = totalP;
		}

		if(startPage > pageBlock)
			pagingHTML.append("<span id=paging onclick=boardPaging(" + (startPage-1) + ")>이전</span>");
				
		for(int i=startPage; i<=endPage; i++) {
			if(i == currentPage)
				pagingHTML.append("<span id=currentPaging onclick=boardPaging(" + i + ")>" + i + "</span>");
			else
				pagingHTML.append("<span id=paging onclick=boardPaging(" + i + ")>" + i + "</span>");
		}
		
		if(endPage < totalP)
			pagingHTML.append("<span id=paging onclick=boardPaging(" + (endPage+1) + ")>다음</span>");
		
	}

}