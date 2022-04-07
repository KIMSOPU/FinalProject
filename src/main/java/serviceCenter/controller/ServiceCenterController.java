package serviceCenter.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import serviceCenter.bean.QnaTableDTO;
import serviceCenter.service.ServiceCenterService;

@Controller
@RequestMapping(value="/serviceCenter")
public class ServiceCenterController {
	@Autowired
	private ServiceCenterService serviceCenterService;
	
	//공지사항 index, 목록, 페이징
	@RequestMapping(value="/announcement")
	public String announcement(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		model.addAttribute("list", serviceCenterService.getAnnouncementList(pg));
		model.addAttribute("paging", serviceCenterService.boardPaging(pg, "announcement_board"));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "announcement");
		model.addAttribute("display", "/WEB-INF/views/announcement.jsp");
		return "/WEB-INF/views/serviceCenter"; 
	}
	
	//공지사항 상세페이지
	@RequestMapping(value="/announcementDetail")
	public String announcementDetail(@RequestParam String pg, @RequestParam String announcementId, @CookieValue(name = "view", required=false) String cookie, Model model) {
		model.addAttribute("content", serviceCenterService.getAnnouncementDetail(announcementId, cookie));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "announcement");
		model.addAttribute("display", "/WEB-INF/views/announcementDetail.jsp");
		return "/WEB-INF/views/serviceCenter";
	}

	//1:1문의 index, 페이징
	@RequestMapping(value="/qna")
	public String qna(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		model.addAttribute("paging", serviceCenterService.boardPaging(pg, "qna_table"));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "qna");
		model.addAttribute("display", "/WEB-INF/views/qna.jsp");
		return "/WEB-INF/views/serviceCenter"; 
	}
	
	
	//1:1문의 목록
	@RequestMapping(value="/getQnaList")
	@ResponseBody
	public List<QnaTableDTO> getQnaList(@RequestParam(required=false, defaultValue = "1") String pg) {
		return serviceCenterService.getQnaList(pg);
	}
	
	//1:1문의 비밀번호 체크
	@RequestMapping(value="/checkPwd")
	@ResponseBody
	public String checkPwd(@RequestParam String qnaId, String qnaPwd) {
		return serviceCenterService.checkPwd(qnaId, qnaPwd);
	}
	
	//1:1문의 상세페이지
	@RequestMapping(value="/qnaDetail")
	public String qnaDetail(@RequestParam String pg, @RequestParam String qnaId, Model model) {
		model.addAttribute("content", serviceCenterService.getQnaDetail(qnaId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "qna");
		model.addAttribute("display", "/WEB-INF/views/qnaDetail.jsp");
		return "/WEB-INF/views/serviceCenter";
	}
	
	//1:1문의 답글 가져오기
	@RequestMapping(value="/getQnaReply")
	@ResponseBody
	public QnaTableDTO getQnaReply(@RequestParam String qnaId) {
		return serviceCenterService.getQnaReply(qnaId);
	}
	
	//1:1문의 작성 페이지
	@RequestMapping(value="/qnaWrite")
	public String qnaWrite(Model model) {
		model.addAttribute("pageName", "qna");
		model.addAttribute("display", "/WEB-INF/views/qnaWrite.jsp");
		return "/WEB-INF/views/serviceCenter";
	}
	
	//1:1문의 등록
	@RequestMapping(value="/qnaRegister")
	@ResponseBody
	public void qnaRegister(@RequestParam Map<String, Object> map) {
		serviceCenterService.qnaRegister(map); // title, qnaName, contents, qnaPwd
	}
	
	//1:1문의 삭제
	@RequestMapping(value="/qnaDelete")
	@ResponseBody
	public void qnaDelete(@RequestParam String qnaId) { 
		serviceCenterService.qnaDelete(qnaId); 
	}
	
	//1:1문의 수정 페이지
	@RequestMapping(value="/qnaModify")
	public String qnaModify(@RequestParam String pg, @RequestParam String qnaId, Model model) {
		model.addAttribute("content", serviceCenterService.getQnaDetail(qnaId));
		model.addAttribute("qnaId", qnaId);
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "qna");
		model.addAttribute("display", "/WEB-INF/views/qnaModify.jsp");
		return "/WEB-INF/views/serviceCenter";
	}
	
	//1:1문의 수정
	@RequestMapping(value="/qnaUpdate")
	@ResponseBody
	public void qnaUpdate(@RequestParam Map<String, Object> map) { 
		serviceCenterService.qnaUpdate(map); // qnaId, title, qnaName, contents, qnaPwd
	}
	
}
