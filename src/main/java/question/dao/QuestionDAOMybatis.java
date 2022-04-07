package question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import question.bean.QuestionDTO;

@Repository
public class QuestionDAOMybatis implements QuestionDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<QuestionDTO> getQnaList(Map<String, Object> map) {
		return sqlSession.selectList("questionSQL.getQnaList", map);
	}
	
	@Override
	public int getTotalQna(String option) {
		return sqlSession.selectOne("questionSQL.getTotalQna", option);
	}
	
	@Override
	public List<QuestionDTO> searchQnaList(Map<String, Object> map) {
		return sqlSession.selectList("questionSQL.searchQnaList", map);
	}
	
	@Override
	public int getSearchTotalQna(Map<String, Object> map) {
		
		return sqlSession.selectOne("questionSQL.getSearchTotalQna", map);
	}
	
	@Override
	public QuestionDTO getQnaView(String qnaId) {
		return sqlSession.selectOne("questionSQL.getQnaView", Integer.parseInt(qnaId));
	}
	
	@Override
	public void writeQna(Map<String, Object> map) {
		map.put("pseq", Integer.parseInt((String) map.get("pseq")));
		sqlSession.insert("questionSQL.writeQna", map);
		sqlSession.update("questionSQL.updateStatus", map.get("pseq"));
	}
	
	@Override
	public void updateQna(Map<String, Object> map) {
		sqlSession.update("questionSQL.updateQna", map);
	}
	
	@Override
	public void deleteQna(String qnaId) {
		sqlSession.delete("questionSQL.deleteQna", Integer.parseInt(qnaId));
	}

}
