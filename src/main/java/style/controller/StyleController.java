package style.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import style.bean.StyleBoardDTO;
import style.bean.StyleCardDTO;
import style.bean.StyleReplyDTO;
import style.service.StyleService;

@Controller
@RequestMapping(value="/style")
public class StyleController {
	@Autowired
	private StyleService styleService;
	@Autowired
	private HttpSession session;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpServletResponse response;
	
	// 페이지) 스타일 메뉴 메인화면 (인기순 목록)
	@RequestMapping(value="/trending")
	public String trending(Model model) {
		model.addAttribute("display", "/WEB-INF/views/style/styleList.jsp");
		return "/index";
	}
	
	// Data) 인기순 목록
	@RequestMapping(value="/getPopularList")
	@ResponseBody
	public List<StyleCardDTO> getPopularList() { 
		return styleService.getPopularList();
	}
	
	// 페이지) 최신순 목록
	@RequestMapping(value="/newest")
	public String newest(Model model) {
		model.addAttribute("display", "/WEB-INF/views/style/styleListRecent.jsp");
		return "/index";
	}
	
	// Data) 최신순 목록
	@RequestMapping(value="/getRecentList")
	@ResponseBody
	public List<StyleCardDTO> getRecentList() { 
		return styleService.getRecentList();
	}
	
	// 페이지) 선택 글 상세
	@RequestMapping(value="/details")
	public String details(@RequestParam int styleId, Model model) {
		// 게시글 신고 쿠키에 내역 추가
		Cookie[] cookies = request.getCookies();
		int checkCookie = 0;
		for(Cookie cookie : cookies) { //쿠키 생성 내역이 있는지 확인
			if (cookie.getName().equals("report")) {
				checkCookie = 1;
			} 
		}
		
		if(checkCookie == 0) { //생성 내역 없을 경우 새로 생성
			System.out.println("쿠키 생성!");
			Cookie newCookie = new Cookie("report", null); 
			newCookie.setMaxAge(60*60*24);
			response.addCookie(newCookie); //쿠키 생성
		}
				
		model.addAttribute("styleId", styleId);
		model.addAttribute("display", "/WEB-INF/views/style/styleView.jsp");
		return "/index";
	}

	// Data) 선택 글, 댓글 리스트
	@RequestMapping(value="/getDeatilsReplyList")
	@ResponseBody
	public StyleCardDTO getDeatilsReplyList(@RequestParam String styleId) {
		return styleService.getDeatilsReplyList(Integer.parseInt(styleId));
	}
	
	// 페이지) 회원 피드
	@RequestMapping(value="/user")
	public String userFeed(@RequestParam(required=false) String username, Model model) {
		if(username == null) {
			username = String.valueOf(session.getAttribute("ssUsername")); 
		}
		model.addAttribute("username", username);
		model.addAttribute("userInform", styleService.userInform(username));
		model.addAttribute("display", "/WEB-INF/views/style/styleUserFeed.jsp");
		return "/index";
	}
	
	// Data) 회원 피드
	@RequestMapping(value="/getUserFeed")
	@ResponseBody
	public List<StyleCardDTO> getUserFeed(@RequestParam(required=false) String username) { 
		return styleService.getUserFeed(username);
	}
	
	//좋아요(공감) 클릭 반영/취소 
	@ResponseBody
	@RequestMapping(value="/switchLike")
	public String switchLike(@RequestParam String styleId) {
		return styleService.switchLike(Integer.parseInt(styleId));
	}
	
	//게시글에 공감한 회원 목록
	@ResponseBody
	@RequestMapping(value="/getLikeUserList")
	public Map<String, Object> getLikeUserList(@RequestParam int styleId) {
		return styleService.getLikeUserList(styleId);
	}

	//게시글 등록
	@ResponseBody
	@RequestMapping(value="/styleWrite")
	public void styleWrite(@ModelAttribute StyleBoardDTO styleBoardDTO, @RequestParam MultipartFile croppedImg) { 
		styleService.styleWrite(styleBoardDTO, croppedImg); //userId, contents, productId만 넘어올 예정
	}
	
	// 게시글 수정
	@ResponseBody
	@RequestMapping(value="/styleModify")
	public void styleModify(@RequestParam Map<String, Object> map) {
		styleService.styleModify(map); //styleId, contents, productId
	}
	
	// 게시글 삭제
	@ResponseBody
	@RequestMapping(value="/styleDelete")
	public void styleDelete(@RequestParam String styleId) {
		styleService.styleDelete(Integer.parseInt(styleId)); 
	}
	
	// 게시글 신고
	@ResponseBody
	@RequestMapping(value="/styleReport")
	public String styleReport(@RequestParam String styleId, @CookieValue(name = "report", required=false) String cookie) {
		return styleService.styleReport(styleId, cookie); 
	}
	
	//댓글 등록
	@ResponseBody
	@RequestMapping(value="/replyWrite")
	public StyleReplyDTO replyWrite(@RequestParam Map<String, Object> map) {
		//System.out.println(map.toString());
		return styleService.replyWrite(map); //styleId, contents
	}
	
	//댓글 수정
	@ResponseBody
	@RequestMapping(value="/replyModify")
	public void replyModify(@RequestParam Map<String, Object> map) {
		styleService.replyModify(map); //styleReplyId, contents
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value="/replyDelete")
	public void replyDelete(@RequestParam Map<String, Object> map) {
		styleService.replyDelete(map); //styleReplyId, styleId
	}
	
	// 상품이 태그된 스타일 피드 목록
	@RequestMapping(value="/products")
	public String products(@RequestParam String productId, Model model) {
		model.addAttribute("productId", productId);
		model.addAttribute("productInfo", styleService.getProductInfo(productId));
		model.addAttribute("productPrice", styleService.getProductPrice(productId));
		model.addAttribute("display", "/WEB-INF/views/style/styleProductFeed.jsp");
		return "/index";
	}
	
	// 상품 피드 데이터
	@RequestMapping(value="/getProductsFeed")
	@ResponseBody
	public List<StyleCardDTO> getProductsFeed(@RequestParam String productId) { 
		return styleService.getProductsFeed(productId);
	}
	
	// 상품 피드 데이터 4개만
	@RequestMapping(value="/getProductsFeedFour")
	@ResponseBody
	public List<StyleCardDTO> getProductsFeedFour(@RequestParam String productId) { 
		return styleService.getProductsFeedFour(productId);
	}
}
