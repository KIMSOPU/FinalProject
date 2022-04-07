package style.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import style.bean.StyleBoardDTO;
import style.bean.StyleBoardPaging;
import style.service.StyleService;

@Controller
@RequestMapping(value="/adminViews/style")
public class AdminStyleController {
	@Autowired
	private StyleService styleService;
	
	// 게시글 기본 폼
	@GetMapping(value = "styleList")
	public String styleList(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		
		model.addAttribute(pg, "pg");
		model.addAttribute("display", "/WEB-INF/adminViews/style/styleList.jsp");
		return "/admin/adminIndex";
	}
	
	// 게시글 목록 뽑기
	@PostMapping(value = "getStyleList")
	@ResponseBody
	public Map<String, Object> getStyleList(@RequestParam(required = false, defaultValue = "1") String pg, String option) {
		Map<String, Object> map = new HashedMap<String, Object>();		
		// 전체목록
		List<StyleBoardDTO> list = styleService.getStyleList(pg, option);
		// 페이징처리
		StyleBoardPaging  styleBoardPaging = styleService.styleBoardPaging(pg, option);
	
		map.put("styleBoardPaging", styleBoardPaging);
		map.put("list", list);
		return map;
	}
	
	// 게시글 검색
	@PostMapping(value = "searchStyleList")
	@ResponseBody
	public Map<String, Object> searchStyleList(@RequestParam Map<String, Object> map){			
		// 전체목록
		List<StyleBoardDTO> list = styleService.searchStyleList(map);
		// 페이징처리
		StyleBoardPaging  styleBoardPaging = styleService.searchStyleBoardPaging(map);
				
		// data로 보낼 결과물
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("styleBoardPaging", styleBoardPaging);
		map2.put("list", list);
		return map2;
	}
	
	// 게시글 삭제
	@GetMapping(value = "deleteStyle")
	public String deleteStyle(Model model, @RequestParam String styleId) {
		
		styleService.deleteStyle(styleId);
		
		model.addAttribute("display", "/WEB-INF/adminViews/style/styleList.jsp");
		return "/admin/adminIndex";
	}
	
	// 체크된 게시물 모두 삭제
	@PostMapping(value = "deletStyleList")
	@ResponseBody
	public void deletStyleList(@RequestParam(value="checkBoxArr[]") String[] checkBoxArr){			
		styleService.deletStyleList(checkBoxArr);				
	}
	

}
