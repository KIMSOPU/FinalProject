package question.dao;

import java.util.List;
import java.util.Map;

import question.bean.QuestionDTO;

public interface QuestionDAO {

	public List<QuestionDTO> getQnaList(Map<String, Object> map);

	public int getTotalQna(String option);

	public List<QuestionDTO> searchQnaList(Map<String, Object> map);

	public int getSearchTotalQna(Map<String, Object> map);

	public QuestionDTO getQnaView(String qnaId);

	public void writeQna(Map<String, Object> map);

	public void updateQna(Map<String, Object> map);

	public void deleteQna(String qnaId);

}
