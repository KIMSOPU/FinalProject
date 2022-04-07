package serviceCenter.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import serviceCenter.bean.AnnouncementBoardDTO;
import serviceCenter.bean.QnaTableDTO;

@Repository
public class ServiceCenterDAOImpl implements ServiceCenterDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getTotalDB(String tableName) {
		return sqlSession.selectOne("serviceCenterSQL.getTotalDB", tableName);
	}
	
	@Override
	public List<AnnouncementBoardDTO> getAnnouncementList(Map<String, Integer> map) {
		return sqlSession.selectList("serviceCenterSQL.getAnnouncementList", map);
	}
	
	@Override
	public void hit(String announcementId) {
		sqlSession.update("serviceCenterSQL.hit",announcementId);
	}
	
	@Override
	public AnnouncementBoardDTO getAnnouncementDetail(String announcementId) {
		return sqlSession.selectOne("serviceCenterSQL.getAnnouncementDetail", announcementId);
	}
	
	@Override
	public List<QnaTableDTO> getQnaList(Map<String, Integer> map) {
		return sqlSession.selectList("serviceCenterSQL.getQnaList", map);
	}
	
	@Override
	public QnaTableDTO checkPwd(Map<String, Object> map) {
		return sqlSession.selectOne("serviceCenterSQL.checkPwd", map);
	}
	
	@Override
	public QnaTableDTO getQnaDetail(String qnaId) {
		return sqlSession.selectOne("serviceCenterSQL.getQnaDetail", qnaId);
	}
	
	@Override
	public QnaTableDTO getQnaReply(String qnaId) {
		return sqlSession.selectOne("serviceCenterSQL.getQnaReply", qnaId);
	}
	
	@Override
	public void qnaRegister(Map<String, Object> map) {
		sqlSession.insert("serviceCenterSQL.qnaRegister", map); // title, qnaName, contents, qnaPwd
	}
	
	@Override
	public void qnaDelete(String qnaId) {
		sqlSession.delete("serviceCenterSQL.qnaDelete", qnaId);
	}
	
	@Override
	public void qnaUpdate(Map<String, Object> map) {
		System.out.println("DAO >> " + map);
		sqlSession.update("serviceCenterSQL.qnaUpdate", map); // qnaId, title, qnaName, contents, qnaPwd
	}
}
