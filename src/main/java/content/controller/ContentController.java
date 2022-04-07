package content.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import content.bean.AnnounceDTO;
import content.bean.ContentPaging;
import content.service.ContentService;

@Controller
@Component
@RequestMapping(value="/adminViews/content")
public class ContentController {
	@Autowired
	private ContentService contentService;
	
	// 공지사항 기본 폼
	@GetMapping(value = "announceList")
	public String announce(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/content/announceList.jsp");
		return "/admin/adminIndex";
	}
	
	// 공지사항 등록
	@PostMapping(value = "writeAnnounce")
	@ResponseBody
	public void writeAnnounce(@ModelAttribute AnnounceDTO announceDTO) {
		contentService.writeAnnounce(announceDTO);
	}
	
	// 공지사항 리스트 / 페이징 처리
	@PostMapping(value = "getAnnounceList")
	@ResponseBody
	public Map<String, Object> getAnnounceList(@RequestParam(required = false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashedMap<String, Object>();		
		
		// 리스트 뽑아오기
		List<AnnounceDTO> list = contentService.getAnnounceList(pg);
		// 페이징 처리하기
		ContentPaging announcePaging = contentService.announcePaging(pg);
				
		map.put("announcePaging", announcePaging);
		map.put("list", list);
		return map;
	}
	
	// 공지사항 검색결과
	@PostMapping(value = "searchAnnounce")
	@ResponseBody
	public Map<String, Object> searchList(@RequestParam Map<String, Object> map){		
		//페이징처리
		ContentPaging announcePaging = contentService.serachAnnouncePaging(map);
		// 검색 결과 리스트
		List<AnnounceDTO> list = contentService.searchAnnounce(map);
		
		// data로 보낼 결과물
		Map<String, Object> map2 = new HashMap<String, Object>();
		// 검색 결과 리스트
		map2.put("list", list);
		// 페이징처리의 결과 값
		map2.put("announcePaging", announcePaging);
		return map2;
	}
	
	// 공지사항 수정 폼 띄우기
	@GetMapping(value = "updateAnnounceView")
	public String updateAnnounceView(Model model, @RequestParam String pg, @RequestParam String announcementId) {
		model.addAttribute("announcementId", announcementId);
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/content/updateAnnounceView.jsp");
		return "/admin/adminIndex";
	}
	
	// 공지사항 수정 시 기본 글 가져오기
	@PostMapping(value = "getUpdateView")
	@ResponseBody
	public AnnounceDTO getUpdateView(@RequestParam String announcementId) {
		return contentService.getUpdateView(announcementId);
	}
	
	// 공지사항 수정
	@PostMapping(value = "updateAnnounce")
	@ResponseBody
	public void updateAnnounce(@ModelAttribute AnnounceDTO announceDTO) {
		contentService.updateAnnounce(announceDTO);
	}
	
	// 공지사항 작성 기본 폼
	@GetMapping(value = "announceWrite")
	public String announceWrite(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/content/announceWrite.jsp");
		return "/admin/adminIndex";
	}
		
	// 공지사항 삭제
	@GetMapping(value = "deleteAnnounce")
	public String deleteAnnounce(Model model, @RequestParam String announcementId) {
		contentService.deleteAnnounce(announcementId);

		model.addAttribute("display", "/WEB-INF/adminViews/content/announceList.jsp");
		return "/admin/adminIndex";
	}
	
	// 체크박스에 표시된 모든 공지사항 삭제
	@PostMapping(value = "deleteAllAnnounce")
	@ResponseBody
	public void deleteAllAnnounce(@RequestParam(value="checkBoxArr[]") String[] checkBoxArr) {
		contentService.deleteAllAnnounce(checkBoxArr);
	}
	
}
