package check.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import check.bean.CheckDTO;


@Repository
@Transactional
public class CheckDAOMybatis implements CheckDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CheckDTO> getCheckForm(Map<String, Integer> map) {
		return sqlSession.selectList("checkSQL.getCheckForm", map);
	}

	@Override
	public List<Object> searchBtnForm( Map<String, Object> map) {
		return sqlSession.selectList("checkSQL.searchBtnForm", map);

	}

	@Override
	public int getTotalCheck() {
		return sqlSession.selectOne("checkSQL.getTotalCheck");

	}

	@Override
	public CheckDTO getCheckChgForm(String checkId) {
		return sqlSession.selectOne("checkSQL.getCheckChgForm",checkId);

	}

	@Override
	public void situationChg(Map<String, Object> map) {
		 sqlSession.selectOne("checkSQL.situationChg", map);

	}

	@Override
	public void resultChg(Map<String, Object> map) {
		 sqlSession.selectOne("checkSQL.resultChg", map);

	}

}
