package style.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.multipart.MultipartFile;

import style.bean.StyleBoardDTO;
import style.bean.StyleBoardPaging;
import style.bean.StyleCardDTO;
import style.bean.StyleReplyDTO;
import style.dao.StyleDAO;
import user.bean.UserDTO;

@Service
public class StyleServiceImpl implements StyleService {
	@Autowired
	private StyleDAO styleDAO;
	@Autowired
	private HttpSession session;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpServletResponse response;
	@Autowired
	private StyleBoardPaging styleBoardPaging; 
	
	@Override
	public List<StyleCardDTO> getPopularList() {
		//조인한 테이블에서 정렬 기준(인기순)에 맞게 list로 뽑아오기
		List<StyleCardDTO> styleCardDTOList = styleDAO.getListOrderByPopularity();
		
		//조인한 테이블의 컬럼 외에 필요한 데이터를 list안에 객체별로 넣고 list로 다시 리턴하기
		List<StyleCardDTO> list = this.makeStyleCardDTOList(styleCardDTOList);
		
		return list;
	}
	
	@Override
	public List<StyleCardDTO> getRecentList() {
		//조인한 테이블에서 정렬 기준(최신순)에 맞게 list로 뽑아오기
		List<StyleCardDTO> styleCardDTOList = styleDAO.getListOrderByRecentDate();
		
		//조인한 테이블의 컬럼 외에 필요한 데이터를 list안에 객체별로 넣고 list로 다시 리턴하기
		List<StyleCardDTO> list = this.makeStyleCardDTOList(styleCardDTOList);
		
		return list;
	}
	
	@Override
	public List<StyleCardDTO> getUserFeed(String username) {
		//하단 유저 게시글 list (최신순 리스트에 username 조건만 추가)
		List<StyleCardDTO> styleCardDTOList = styleDAO.getUserFeed(username);
		//조인한 테이블의 컬럼 외에 필요한 데이터를 list안에 객체별로 넣고 list로 다시 리턴하기
		List<StyleCardDTO> list = this.makeStyleCardDTOList(styleCardDTOList);
		return list;
	}
	
	@Override
	public Map<String, Object> userInform(String username) {
		//상단 유저정보
		UserDTO userDTO = styleDAO.getUserByUsername(username);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("userImg", userDTO.getImg());
		map.put("userIntroMsg", userDTO.getIntroMsg());
		map.put("totalStyleCount", styleDAO.totalStyleCount(userDTO.getUserId())); //총 게시글 갯수
		return map;
	}
	
	@Override
	public StyleCardDTO getDeatilsReplyList(int styleId) {
		StyleCardDTO styleCardDTO = styleDAO.getOneStyleCardDTO(styleId);
		return styleCardDTO;
	}
	
	// 정렬 기준(인기, 최신)에 맞춰 가져온 StyleBoardDTOList에 일부 데이터를 추가해 Style페이지 리스트 카드 목록 형태로 가공
	private List<StyleCardDTO> makeStyleCardDTOList(List<StyleCardDTO> styleCardDTOList){

		for(StyleCardDTO styleCardDTO : styleCardDTOList) {  //페이징 객체 추가되면 조건식 변경
			
			//해당 스타일 게시물 좋아요 클릭 여부 (로그인 여부 확인 필요)
			if(session.getAttribute("ssUserId") != null) {
				int userId = (int) session.getAttribute("ssUserId");
				
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("styleId", styleCardDTO.getStyleId());
				map.put("userId", userId);
				
				if(styleDAO.getLikeOnOff(map) == null) styleCardDTO.setLikeOnOff("off");
				else styleCardDTO.setLikeOnOff("on");
				
			} else styleCardDTO.setLikeOnOff("off"); //비로그인 상태면 무조건 off
			
			//상품의 판매 최저가 검색 후 세팅
			Integer price = styleDAO.getLowestPriceByProductId(styleCardDTO.getProductId()); //판매 테이블에서 최저 가격 1개 추출 (조건)상품번호, 판매상태=0, 가격 오름차순
			if (price == null) styleCardDTO.setPrice(0);
			else styleCardDTO.setPrice(price);
			
			//댓글 리스트
			if(styleCardDTO.getReplyCount() != 0) 
				styleCardDTO.setReplyList(styleDAO.getReplyList(styleCardDTO.getStyleId()));
		}
		
		return styleCardDTOList;
	}
	
	@Override
	public String switchLike(int styleId) {
		//로그인 여부 확인 
		if(session.getAttribute("ssUserId") == null) {
			return "non-login";
		} else {
			//로그인 된 상태일 경우
			int userId = (int) session.getAttribute("ssUserId");
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("styleId", styleId);
			map.put("userId", userId);
			
			if(styleDAO.getLikeOnOff(map) == null) { //공감 내역 없을 경우 공감 추가
				styleDAO.plusLike(map); //style_like 테이블 데이터 insert, style_board 테이블 like컬럼 +1
				return "on";
				
			} else { //공감 내역 있을 경우 공감 취소
				styleDAO.minusLike(map); //style_like 테이블 데이터 delete, style_board 테이블 like컬럼 -1
				return "off";
			}
		}
	}
	
	@Override
	public Map<String, Object> getLikeUserList(int styleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		StyleCardDTO styleCardDTO = styleDAO.getOneStyleCardDTO(styleId);
		int likeCount = styleCardDTO.getLikeCount();
		map.put("likeCount", likeCount);
		if(likeCount != 0) {
			List<StyleReplyDTO> UserList = styleDAO.getLikeUserList(styleId);
			map.put("UserList", UserList);
		}
		
		return map;
	}
	
	@Override
	public void styleWrite(StyleBoardDTO styleBoardDTO, MultipartFile croppedImg) {
		String filePath = "C:\\shoeCream_images\\images\\style_board"; 
		String fileName = croppedImg.getOriginalFilename();
		UUID uuid = UUID.randomUUID(); //파일명 중복 방지를 위해 UUID 생성
		
		String uploadFileName = uuid.toString()+"_"+fileName;
		
		File file = new File(filePath, uploadFileName);
	
		try {  	
			croppedImg.transferTo(file); //임시파일을 실제폴더로 이동 
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		styleBoardDTO.setImg1(uploadFileName); //필드에 저장될 파일명
		
		styleDAO.styleWrite(styleBoardDTO);
	}
	
	@Override
	public void styleModify(Map<String, Object> map) {
		styleDAO.styleModify(map);
	}
	
	@Override
	public void styleDelete(int styleId) {
		styleDAO.styleDelete(styleId);
	}
	
	@Override
	public StyleReplyDTO replyWrite(Map<String, Object> map) { //styleId, contents
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
		int styleReplyId = styleDAO.replyWrite(map);
		return styleDAO.getReplyOne(styleReplyId);
	}
	
	@Override
	public void replyModify(Map<String, Object> map) { //styleReplyId, contents
		styleDAO.replyModify(map);
	}
	
	@Override
	public void replyDelete(Map<String, Object> map) {
		styleDAO.replyDelete(map); //styleReplyId, styleId
	}
	
	@Override
	public List<StyleBoardDTO> getStyleList(String pg, String option) {
		int endNum = Integer.parseInt(pg) * 10;
		int startNum = endNum - 9;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		map.put("option", option);
			
		return styleDAO.getStyleList(map);
	}
	
	@Override
	public StyleBoardPaging styleBoardPaging(String pg, String option) {
		int total = styleDAO.getTotalStyle(option);

		styleBoardPaging.setCurrentPage(Integer.parseInt(pg));
		styleBoardPaging.setPageBlock(5);
		styleBoardPaging.setPageSize(10);
		styleBoardPaging.setTotalA(total);
		styleBoardPaging.makePagingHTML();
		
		return styleBoardPaging;
	}
	
	@Override
	public List<StyleBoardDTO> searchStyleList(Map<String, Object> map) {
		int endNum = Integer.parseInt(map.get("searchPg") + "") * 10;
		int startNum = endNum - 9;

		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return styleDAO.searchStyleList(map);
	}
	
	@Override
	public StyleBoardPaging searchStyleBoardPaging(Map<String, Object> map) {
		int total = styleDAO.getTotalSearchStyle(map);

		styleBoardPaging.setCurrentPage(Integer.parseInt(map.get("searchPg") + ""));
		styleBoardPaging.setPageBlock(5);
		styleBoardPaging.setPageSize(10);
		styleBoardPaging.setTotalA(total);
		styleBoardPaging.makePagingHTML();
		
		return styleBoardPaging;
	}
	
	@Override
	public void deleteStyle(String styleId) {
		styleDAO.deleteStyle(styleId);
	}
	
	@Override
	public void deletStyleList(String[] checkBoxArr) {
		for(String styleId : checkBoxArr) {
			styleDAO.deleteStyle(styleId);
		}
	}
	
	@Override
	public List<StyleCardDTO> getProductsFeed(String productId) {
		List<StyleCardDTO> styleCardDTOList = styleDAO.getProductsFeed(productId);
		
		//조인한 테이블에서 정렬 기준(최신순)에 맞게 list로 뽑아오기
		List<StyleCardDTO> list = this.makeStyleCardDTOList(styleCardDTOList);
		
		return list;
	}
	
	@Override
	public Object getProductInfo(String productId) {
		return styleDAO.getProductByProductId(productId);
	}
	
	@Override
	public Object getProductPrice(String productId) {
		//상품의 판매 최저가 검색 후 세팅
		Integer price = styleDAO.getLowestPriceByProductId(Integer.parseInt(productId)); //판매 테이블에서 최저 가격 1개 추출 (조건)상품번호, 판매상태=0, 가격 오름차순
		if (price == null) return 0;
		else return price;
	}
	
	@Override
	public List<StyleCardDTO> getProductsFeedFour(String productId) {
		List<StyleCardDTO> styleCardDTOList = styleDAO.getProductsFeedFour(productId);
		
		//조인한 테이블에서 정렬 기준(최신순)에 맞게 list로 뽑아오기
		List<StyleCardDTO> list = this.makeStyleCardDTOList(styleCardDTOList);
		
		return list;
	}
	
	@Override
	public String styleReport(String styleId, @CookieValue(name = "report", required=false) String cookie) {
		String result;
		if(!(cookie.contains(String.valueOf(styleId)))){ //신고 내역 없음
			styleDAO.addReport(styleId);
			cookie += styleId + "/";
			result =  "success";
		} else result = "fail"; //신고 내역 있음

		response.addCookie(new Cookie("report", cookie)); //쿠키에 내역 추가 후 돌려주기
		return result;
	}
	
}
