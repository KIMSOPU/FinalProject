package question.service;

import java.util.List;
import java.util.Map;

import question.bean.QuestionDTO;
import question.bean.QuestionPaging;

public interface QuestionService {

	public List<QuestionDTO> getQnaList(String pg, String option);

	public QuestionPaging questionPaging(String pg, String option);

	public List<QuestionDTO> searchQnaList(Map<String, Object> map);

	public QuestionPaging searchQuestionPaging(Map<String, Object> map);

	public QuestionDTO getQnaView(String qnaId);

	public void writeQna(Map<String, Object> map);

	public void updateQna(Map<String, Object> map);

	public void deleteQna(String qnaId);

	public void deletQnaList(String[] checkBoxArr);





}
