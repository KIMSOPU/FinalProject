package question.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import question.bean.QuestionDTO;
import question.bean.QuestionPaging;
import question.dao.QuestionDAO;

@Service
public class QuestionServiceImpl implements QuestionService {
	@Autowired
	private QuestionDAO questionDAO;
	@Autowired
	private QuestionPaging questionPaging;
	
	@Override
	public List<QuestionDTO> getQnaList(String pg, String option) {
		int endNum = Integer.parseInt(pg) * 10;
		int startNum = endNum - 9;
		
		Map<String, Object> map = new HashedMap<String, Object>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		map.put("option", option);
			
		return questionDAO.getQnaList(map);
	}
	
	@Override
	public QuestionPaging questionPaging(String pg, String option) {
		int total = questionDAO.getTotalQna(option);

		questionPaging.setCurrentPage(Integer.parseInt(pg));
		questionPaging.setPageBlock(5);
		questionPaging.setPageSize(10);
		questionPaging.setTotalA(total);
		questionPaging.makePagingHTML();
		
		return questionPaging;
	}
	
	
	@Override
	public List<QuestionDTO> searchQnaList(Map<String, Object> map) {
		int endNum = Integer.parseInt(map.get("searchPg") + "") * 10;
		int startNum = endNum - 9;
		
		map.put("startNum", startNum);
		map.put("endNum", endNum);
			
		return questionDAO.searchQnaList(map);
	}
	
	@Override
	public QuestionPaging searchQuestionPaging(Map<String, Object> map) {
		int total = questionDAO.getSearchTotalQna(map);

		questionPaging.setCurrentPage(Integer.parseInt(map.get("searchPg") + ""));
		questionPaging.setPageBlock(5);
		questionPaging.setPageSize(10);
		questionPaging.setTotalA(total);
		questionPaging.makePagingHTML();
		
		return questionPaging;
	}
	
	@Override
	public QuestionDTO getQnaView(String qnaId) {
		return questionDAO.getQnaView(qnaId);
	}
	
	@Override
	public void writeQna(Map<String, Object> map) {
		questionDAO.writeQna(map);
	}
	
	@Override
	public void updateQna(Map<String, Object> map) {
		questionDAO.updateQna(map);
	}
	
	@Override
	public void deleteQna(String qnaId) {
		questionDAO.deleteQna(qnaId);
	}
	
	@Override
	public void deletQnaList(String[] checkBoxArr) {
		for(String qnaId : checkBoxArr) {
			questionDAO.deleteQna(qnaId);
		}
	}
}
