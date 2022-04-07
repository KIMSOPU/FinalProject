package user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import user.bean.UserDTO;
import user.bean.UserDTO2;

@Repository
@Transactional
public class UserDAOMybatis implements UserDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<UserDTO> getUserForm(Map<String, Integer> map) {
		return sqlSession.selectList("userSQL.getUserForm", map);
	}

	@Override
	public UserDTO chkUsername(String username) {
		return sqlSession.selectOne("userSQL.chkUsername", username);
	}

	@Override
	public UserDTO chkEmail(String email) {
		return sqlSession.selectOne("userSQL.chkEmail", email);
	}

	@Override
	public UserDTO chkPhoneNum(String phoneNum) {
		return sqlSession.selectOne("userSQL.chkPhoneNum", phoneNum);
	}
	
	@Override
	public void joinOk(UserDTO userDTO) {
		sqlSession.insert("userSQL.joinOk", userDTO);
	}

	@Override
	public void loginOk(String username) {
		sqlSession.update("userSQL.loginOk", username);
	}

	@Override
	public String findUserOk(String phoneNum) {
		return sqlSession.selectOne("userSQL.findUserOk", phoneNum);
	}

	@Override
	public UserDTO findPwdOk(Map<String, String> map) {
		return sqlSession.selectOne("userSQL.findPwdOk", map);
	}

	@Override
	public void updatePwd(Map<String, String> map) {
		sqlSession.update("userSQL.updatePwd", map);
	}

	@Override
	public UserDTO chkAccessToken(String access_Token) {
		return sqlSession.selectOne("userSQL.chkAccessToken", access_Token);
	}

	@Override
	public void joinSocialOk(UserDTO userDTO) {
		sqlSession.insert("userSQL.joinSocialOk", userDTO);
	}

	@Override
	public void kakaoLoginOk(String email) {
		sqlSession.update("userSQL.kakaoLoginOk", email);
	}

	@Override
	public void updateUsername(UserDTO userDTO) {
		sqlSession.update("userSQL.updateUsername", userDTO);
	}
	
	@Override
	public void updateEmail(UserDTO userDTO) {
		sqlSession.update("userSQL.updateEmail", userDTO);
	}

	@Override
	public void updateFullName(UserDTO userDTO) {
		sqlSession.update("userSQL.updateFullName", userDTO);
	}

	@Override
	public void updatePhoneNum(UserDTO userDTO) {
		sqlSession.update("userSQL.updatePhoneNum", userDTO);
	}

	@Override
	public void updateImg(Map<String, String> map) {
		sqlSession.update("userSQL.updateImg", map);
	}
	
	@Override
	public void withdrawal(int userId) {
		sqlSession.update("userSQL.withdrawal", userId);
	}

	@Override
	public void updateIntroMsg(Map<String, String> map) {
		sqlSession.update("userSQL.updateIntroMsg", map);
	}
	
	@Override
	public UserDTO getUserId(int userId) {
		return sqlSession.selectOne("userSQL.getUserId", userId);
	}

	@Override
	public void ratingChange( Map<String, Object> map) {
		 sqlSession.selectOne("userSQL.ratingChange", map);
	}

	@Override
	public List<UserDTO2> getTradeForm(Map<String, Integer> map) {
		System.out.println(map+"map");
		return sqlSession.selectList("userSQL.getTradeForm", map);
	}

	@Override
	public UserDTO getAdminUserId(String userId) {
		return sqlSession.selectOne("userSQL.getAdminUserId",userId);
	}


	@Override
	public int getTotalUser() {
		return sqlSession.selectOne("userSQL.getTotalUser");
	}

	@Override
	public int getSearchTotalUser(Map<String, Object> map) {
		return sqlSession.selectOne("userSQL.getSearchTotalUser", map);

	}

	@Override
	public List<UserDTO> searchUser(Map<String, Object> map) {
		return sqlSession.selectList("userSQL.searchUser", map);

	}

}