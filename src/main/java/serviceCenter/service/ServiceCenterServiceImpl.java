package serviceCenter.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CookieValue;

import serviceCenter.bean.AnnouncementBoardDTO;
import serviceCenter.bean.BoardPaging;
import serviceCenter.bean.QnaTableDTO;
import serviceCenter.dao.ServiceCenterDAO;

@Service
public class ServiceCenterServiceImpl implements ServiceCenterService {
	@Autowired
	private ServiceCenterDAO serviceCenterDAO;
	@Autowired
	private BoardPaging boardPaging;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpServletResponse response;
	@Autowired
	private HttpSession session;
	
	//공지사항 글 목록
	@Override
	public List<AnnouncementBoardDTO> getAnnouncementList(String pg) {	
		//쿠키 여부 확인 및 생성
		Cookie[] cookies = request.getCookies();
		int checkVisit = 0;
		for(Cookie cookie : cookies) {
			if (cookie.getName().equals("view")) {
				checkVisit = 1;
			}
		}
		
		if(checkVisit == 0) {
			Cookie newCookie = new Cookie("view", null);
			newCookie.setMaxAge(60*60);
			response.addCookie(newCookie);
		}
		
		//글 목록 불러오기
		List<AnnouncementBoardDTO> list = serviceCenterDAO.getAnnouncementList(this.getPageRange(pg));
		return list;
	}
	
	@Override
	public AnnouncementBoardDTO getAnnouncementDetail(String announcementId, @CookieValue(name = "view") String cookie) {
		//쿠키 사용
		if(!(cookie.contains(String.valueOf(announcementId)))) {
			cookie += announcementId + "/";
			serviceCenterDAO.hit(announcementId);
		}
		response.addCookie(new Cookie("view", cookie));
		
		//글 데이터
		return serviceCenterDAO.getAnnouncementDetail(announcementId);
	}
	
	//1:1문의 글 목록
	@Override
	public List<QnaTableDTO> getQnaList(String pg) {
		List<QnaTableDTO> list = serviceCenterDAO.getQnaList(this.getPageRange(pg));
		return list;
	}
	
	@Override
	public String checkPwd(String qnaId, String qnaPwd) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qnaId", qnaId);
		map.put("qnaPwd", qnaPwd);
		
		if(serviceCenterDAO.checkPwd(map) != null)
			return "true";
		else
			return "false";
	}
	
	@Override
	public QnaTableDTO getQnaReply(String qnaId) {
		return serviceCenterDAO.getQnaReply(qnaId);
	}
	
	@Override
	public QnaTableDTO getQnaDetail(String qnaId) {
		return serviceCenterDAO.getQnaDetail(qnaId);
	}
	
	@Override
	public void qnaRegister(Map<String, Object> map) {
		serviceCenterDAO.qnaRegister(map);
	}
	
	@Override
	public void qnaDelete(String qnaId) {
		serviceCenterDAO.qnaDelete(qnaId);
	}
	
	@Override
	public void qnaUpdate(Map<String, Object> map) {
		serviceCenterDAO.qnaUpdate(map);
	}
	
	//페이징 객체 생성
	@Override
	public BoardPaging boardPaging(String pg, String tableName) {
		int totalA = serviceCenterDAO.getTotalDB(tableName); //총글수
		boardPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		boardPaging.setPageBlock(5);
		boardPaging.setPageSize(10);
		boardPaging.setTotalA(totalA);
		boardPaging.makePagingHTML();
		
		return boardPaging;
	}
	
	//페이지 글 범위 생성
	private Map<String, Integer> getPageRange(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		int pgNum = Integer.parseInt(pg);
		int qtyInPage = 10; // 한 페이지에 보여줄 갯수
		int endNum = pgNum * qtyInPage; //선택 페이지의 끝 글번호
		int startNum = endNum - (qtyInPage-1); //선택 페이지의 시작 글번호
		
		map.put("startNum",startNum);
		map.put("endNum",endNum);		
		return map;
	}
}
