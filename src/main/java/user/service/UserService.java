package user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import user.bean.UserDTO;
import user.bean.UserDTO2;
import user.bean.UserPaging;

public interface UserService {

public String chkUsername(String username);
	
	public String chkEmail(String email);

	public String chkPhoneNum(String phoneNum);
	
	public void joinOk(UserDTO userDTO);

	public String findUserOk(String phoneNum);

	public String loginOk(Map<String, String> map);
	
	public void logout();

	public String findPwdOk(Map<String, String> map);

	public String sendSMS(Map<String, String> map);

	public void updatePwd(Map<String, String> map);
	
	public int authEmail(String email) throws Exception;

	public String getAccessToken(String code);

	public HashMap<String, Object> getUserInfo(String access_Token);

	public void kakaoLoginOk(String email, String access_Token);

	public void joinSocialOk(UserDTO userDTO);

	public Map<String, String> authPhonNum(String phoneNum);
	
	// 관리자 
	public List<UserDTO> getUserForm(String pg);
	
	public UserDTO getAdminUserId(String userId);
	
	public List<UserDTO2> getTradeForm(String pg);

	public UserDTO getUserId(int userId);

	public void ratingChange( Map<String, Object> map);
	
	public UserPaging userPaging(String pg);

	public UserPaging searchUserPaging(Map<String, Object> map);

	public List<UserDTO> searchUser(Map<String, Object> map);
	
}
