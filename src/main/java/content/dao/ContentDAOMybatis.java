package content.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import content.bean.AnnounceDTO;

@Repository
public class ContentDAOMybatis implements ContentDAO {
	@Autowired
	private SqlSession sqlSession;

	// 공지사항 리스트 뽑아오기
	@Override
	public List<AnnounceDTO> getAnnounceList(Map<String, Integer> map) {
		return sqlSession.selectList("contentSQL.getAnnounceList",map);
	}

	// 총 글의 갯수
	@Override
	public int getTotalAnnounce() {
		return sqlSession.selectOne("contentSQL.getTotalAnnounce");
	}

	// 공지사항 작성하기
	@Override
	public void writeAnnounce(AnnounceDTO announceDTO) {
		System.out.println(announceDTO);
		sqlSession.insert("contentSQL.writeAnnounce", announceDTO);
	}

	// 공지사항 검색결과
	@Override
	public List<AnnounceDTO> searchAnnounce(Map<String, Object> map) {
		return sqlSession.selectList("contentSQL.searchAnnounce", map);
	}
	
	// 공지사항 검색결과 페이징
	@Override
	public int searchTotalAnnounce(Map<String, Object> map) {
		return sqlSession.selectOne("contentSQL.searchTotalAnnounce", map);
	}
	
	// 공지사항 삭제
	@Override
	public void deleteAnnounce(String announcementId) {
		sqlSession.delete("contentSQL.deleteAnnounce", Integer.parseInt(announcementId));
	}
	
	// 체크박스 표시된 모든 공지사항 삭제
	@Override
	public void deleteAnnounce(String[] checkBoxArr) {
		for(String announcementId : checkBoxArr) {
			sqlSession.delete("contentSQL.deleteAnnounce", Integer.parseInt(announcementId));
		}
	}
	
	// 수정시 기본글의 정보 가져오기
	@Override
	public AnnounceDTO getUpdateView(String announcementId) {
		return sqlSession.selectOne("contentSQL.getUpdateView", Integer.parseInt(announcementId));
	}
	
	// 공지사항 수정
	@Override
	public void updateAnnounce(AnnounceDTO announceDTO) {	
		System.out.println("DSsdsdds" + announceDTO);
		sqlSession.update("contentSQL.updateAnnounce", announceDTO);
	}
}
