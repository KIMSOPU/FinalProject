package style.dao;

import java.util.List;
import java.util.Map;

import style.bean.StyleBoardDTO;
import style.bean.StyleCardDTO;
import style.bean.StyleLikeDTO;
import style.bean.StyleReplyDTO;
import user.bean.UserDTO;

public interface StyleDAO {

	public List<StyleCardDTO> getListOrderByPopularity();

	public int totalComment(int styleId);
	
	public int totalLike(int styleId);

	public UserDTO getUserByUserId(int userId);
	
	public UserDTO getUserByUsername(String username);

	public Integer getLowestPriceByProductId(int productId);

	public List<StyleCardDTO> getListOrderByRecentDate();

	public int totalStyleCount(int userId);

	public List<StyleReplyDTO> getReplyList(int styleId);

	// 관리자
	public List<StyleBoardDTO> getStyleList(Map<String, Object> map);

	public int getTotalStyle(String option);

	public List<StyleBoardDTO> searchStyleList(Map<String, Object> map);

	public int getTotalSearchStyle(Map<String, Object> map);

	public void deleteStyle(String styleId);

	public StyleLikeDTO getLikeOnOff(Map<String, Integer> map);

	public List<StyleCardDTO> getUserFeed(String username);

	public void plusLike(Map<String, Integer> map);

	public void minusLike(Map<String, Integer> map);

	public StyleCardDTO getOneStyleCardDTO(int styleId);

	public List<StyleReplyDTO> getLikeUserList(int styleId);
	
	public void styleWrite(StyleBoardDTO styleBoardDTO);

	public int replyWrite(Map<String, Object> map);

	public void replyModify(Map<String, Object> map);

	public void replyDelete(Map<String, Object> map);
	
	public StyleReplyDTO getReplyOne(int styleReplyId);

	public void styleDelete(int styleId);

	public void styleModify(Map<String, Object> map);

	public List<StyleCardDTO> getProductsFeed(String productId);

	public Object getProductByProductId(String productId);

	public List<StyleCardDTO> getProductsFeedFour(String productId);
	
	public void addReport(String styleId);
	
}
