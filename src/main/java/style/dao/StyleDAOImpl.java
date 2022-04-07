package style.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import style.bean.StyleBoardDTO;
import style.bean.StyleCardDTO;
import style.bean.StyleLikeDTO;
import style.bean.StyleReplyDTO;
import user.bean.UserDTO;

@Repository
public class StyleDAOImpl implements StyleDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<StyleCardDTO> getListOrderByPopularity() {
		return sqlSession.selectList("styleSQL.getListOrderByPopularity");
	}
	
	@Override
	public List<StyleCardDTO> getListOrderByRecentDate() {
		return sqlSession.selectList("styleSQL.getListOrderByRecentDate");
	}
	
	@Override
	public List<StyleCardDTO> getUserFeed(String username) {
		return sqlSession.selectList("styleSQL.getUserFeed", username);
	}
	
	@Override
	public StyleCardDTO getOneStyleCardDTO(int styleId) {
		return sqlSession.selectOne("styleSQL.getOneStyleCardDTO", styleId);
	}
	
	@Override
	public int totalComment(int styleId) {
		return sqlSession.selectOne("styleSQL.totalComment", styleId);
	}
	
	@Override
	public int totalLike(int styleId) {
		return sqlSession.selectOne("styleSQL.totalLike", styleId);
	}
	
	@Override
	public StyleLikeDTO getLikeOnOff(Map<String, Integer> map) {
		return sqlSession.selectOne("styleSQL.getLikeOnOff", map);
	}
	
	@Override
	public void plusLike(Map<String, Integer> map) {
		sqlSession.insert("styleSQL.plusLike1", map);
		sqlSession.update("styleSQL.plusLike2", map.get("styleId"));
	}
	
	@Override
	public void minusLike(Map<String, Integer> map) {
		sqlSession.delete("styleSQL.minusLike1", map);
		sqlSession.update("styleSQL.minusLike2", map.get("styleId"));
	}
	
	@Override
	public int totalStyleCount(int userId) {
		return sqlSession.selectOne("styleSQL.totalStyleCount", userId);
	}
	
	@Override
	public UserDTO getUserByUserId(int userId) {
		return sqlSession.selectOne("styleSQL.getUserByUserId", userId);
	}
	
	@Override
	public UserDTO getUserByUsername(String username) {
		return sqlSession.selectOne("styleSQL.getUserByUsername", username);
	}
	
	@Override
	public Integer getLowestPriceByProductId(int productId) {
		return sqlSession.selectOne("styleSQL.getLowestPriceByProductId", productId);
	}
	
	@Override
	public List<StyleReplyDTO> getReplyList(int styleId) {
		return sqlSession.selectList("styleSQL.getReplyList", styleId);
	}
	
	@Override
	public List<StyleReplyDTO> getLikeUserList(int styleId) {
		return sqlSession.selectList("styleSQL.getLikeUserList", styleId);
	}

	@Override
	public void styleWrite(StyleBoardDTO styleBoardDTO) {
		sqlSession.insert("styleSQL.styleWrite", styleBoardDTO);
	}
	
	@Override
	public void styleModify(Map<String, Object> map) {
		sqlSession.update("styleSQL.styleModify", map);
	}
	
	@Override
	public void styleDelete(int styleId) {
		sqlSession.delete("styleSQL.styleDelete", styleId);
	}
	
	@Override
	public int replyWrite(Map<String, Object> map) {
		sqlSession.update("styleSQL.replyWrite2", Integer.parseInt((String)map.get("styleId")));
		sqlSession.insert("styleSQL.replyWrite", map);
		return (int) map.get("styleReplyId");
	}
	
	@Override
	public StyleReplyDTO getReplyOne(int styleReplyId) {
		return sqlSession.selectOne("styleSQL.getReplyOne", styleReplyId);
	}
	
	@Override
	public void replyModify(Map<String, Object> map) {
		sqlSession.update("styleSQL.replyModify", map);
	}
	
	@Override
	public void replyDelete(Map<String, Object> map) {
		sqlSession.delete("styleSQL.replyDelete", map);
		sqlSession.update("styleSQL.replyDelete2", Integer.parseInt((String)map.get("styleId")));
	}
	
	// 관리자
	@Override
	public List<StyleBoardDTO> getStyleList(Map<String, Object> map) {
		return sqlSession.selectList("styleSQL.getStyleList", map);
	}
	
	@Override
	public int getTotalStyle(String option) {
		return sqlSession.selectOne("styleSQL.getTotalStyle", option);
	}
	
	@Override
	public List<StyleBoardDTO> searchStyleList(Map<String, Object> map) {
		return sqlSession.selectList("styleSQL.searchStyleList", map);
	}
	
	@Override
	public int getTotalSearchStyle(Map<String, Object> map) {
		return sqlSession.selectOne("styleSQL.getTotalSearchStyle", map);
	}
	
	@Override
	public void deleteStyle(String styleId) {
		sqlSession.delete("styleSQL.deleteStyle",Integer.parseInt(styleId));
	}
	
	@Override
	public List<StyleCardDTO> getProductsFeed(String productId) {
		return sqlSession.selectList("styleSQL.getProductsFeed", Integer.parseInt(productId));
	}
	
	@Override
	public Object getProductByProductId(String productId) {
		return sqlSession.selectOne("styleSQL.getProductByProductId", Integer.parseInt(productId));
	}
	
	@Override
	public List<StyleCardDTO> getProductsFeedFour(String productId) {
		return sqlSession.selectList("styleSQL.getProductsFeedFour", Integer.parseInt(productId));
	}
	
	@Override
	public void addReport(String styleId) {
		sqlSession.update("styleSQL.addReport", Integer.parseInt(styleId));
	}
}
