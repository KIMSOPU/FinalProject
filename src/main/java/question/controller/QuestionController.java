package question.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import question.bean.QuestionDTO;
import question.bean.QuestionPaging;
import question.service.QuestionService;

@Controller
@Component
@RequestMapping(value="/adminViews/question")
public class QuestionController {
	@Autowired
	private QuestionService questionService;
	@Autowired
	private QuestionPaging questionPaging;
	@Autowired
	private QuestionDTO questionDTO;
	
	// 문의사항 기본 폼
	@GetMapping(value = "qnaList")
	public String qnaList(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/question/qnaList.jsp");
		return "/admin/adminIndex";
	}
	
	// 문의사항 전체 리스트 가져오기
	@PostMapping(value = "getQnaList")
	@ResponseBody
	public Map<String, Object> getQnaList(@RequestParam(required = false, defaultValue = "1") String pg, String option) {
		Map<String, Object> map = new HashedMap<String, Object>();		
		// 전체목록
		List<QuestionDTO> list = questionService.getQnaList(pg, option);
		// 페이징처리
		questionPaging = questionService.questionPaging(pg, option);
	
		map.put("questionPaging", questionPaging);
		map.put("list", list);
		return map;
	}
	
	// 문의사항 검색
	@PostMapping(value = "searchQnaList")
	@ResponseBody
	public Map<String, Object> searchQnaList(@RequestParam Map<String, Object> map) {
		Map<String, Object> map2 = new HashedMap<String, Object>();		
		// 전체목록
		List<QuestionDTO> list = questionService.searchQnaList(map);
		// 페이징처리
		questionPaging = questionService.searchQuestionPaging(map);
		
		map2.put("questionPaging", questionPaging);
		map2.put("list", list);
		return map2;
	}
	
	// 문의사항 개별보기 기본 폼
	@GetMapping(value = "qnaView")
	public String questionView(Model model, @RequestParam String qnaId, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("qnaId", qnaId);
		model.addAttribute("display", "/WEB-INF/adminViews/question/qnaView.jsp");
		return "/admin/adminIndex";
	}
	
	// 문의사항 개별보기
	@PostMapping(value = "getQnaView")
	@ResponseBody
	public QuestionDTO getQnaView(String qnaId) {		
		return questionService.getQnaView(qnaId);
	}
		
	// 문의사항 답글작성 기본 폼
	@GetMapping(value = "qnaWrite")
	public String qnaWrite(Model model, @RequestParam String qnaId) {
		model.addAttribute("qnapwd", questionService.getQnaView(qnaId).getQnaPwd());
		model.addAttribute("display", "/WEB-INF/adminViews/question/qnaWrite.jsp");
		return "/admin/adminIndex";
	}
	
	// 문의사항 답변작성
	@PostMapping(value = "writeQna")
	@ResponseBody
	public void writeQna(@RequestParam Map<String, Object> map) {		
		questionService.writeQna(map);
	}
	
	// 수정할 문의사항 답변 기본 폼
	@GetMapping(value = "updateQnaForm")
	public String updateQnaForm(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/question/updateQnaForm.jsp");
		return "/admin/adminIndex";
	}
	
	// 답변 수정
	@PostMapping(value = "updateQna")
	@ResponseBody
	public void updateQna(@RequestParam Map<String, Object> map) {		
		questionService.updateQna(map);
	}
	
	// 문의사항 삭제
	@GetMapping(value = "deleteQna")
	public String deleteQna(@RequestParam String qnaId, Model model) {
		questionService.deleteQna(qnaId);
		
		model.addAttribute("display", "/WEB-INF/adminViews/question/qnaList.jsp");
		return "/admin/adminIndex";
	}
	
	// 체크된 문의사항 모두 삭제
	@PostMapping(value = "deletQnaList")
	@ResponseBody
	public void deletQnaList(@RequestParam(value="checkBoxArr[]") String[] checkBoxArr){			
		questionService.deletQnaList(checkBoxArr);				
	}
}
