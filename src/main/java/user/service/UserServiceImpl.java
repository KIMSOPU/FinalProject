package user.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import user.bean.UserDTO;
import user.bean.UserDTO2;
import user.bean.UserPaging;
import user.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private HttpSession session;
	@Autowired
	private UserPaging userPaging;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public List<UserDTO> getUserForm(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		// map.put("pg", Integer.parseInt(pg));

		map.put("endNum", Integer.parseInt(pg) * 10);
		map.put("startNum", (Integer.parseInt(pg) * 10) - 9);

		List<UserDTO> list = userDAO.getUserForm(map);
		System.out.println("userService list: " + list);
		return list;
	}

	@Override
	public String chkUsername(String username) {
		UserDTO userDTO = userDAO.chkUsername(username);

		if (userDTO == null)
			return "not_exist";
		else
			return "exist";
	}

	@Override
	public String chkEmail(String email) {
		UserDTO userDTO = userDAO.chkEmail(email);

		if (userDTO == null)
			return "not_exist";
		else
			return "exist";
	}

	@Override
	public String chkPhoneNum(String phoneNum) {
		UserDTO userDTO = userDAO.chkPhoneNum(phoneNum);

		if (userDTO == null)
			return "not_exist";
		else
			return "exist";
	}

	@Override
	public void joinOk(UserDTO userDTO) {
		String inputPwd = userDTO.getPwd();
		String pwd = passwordEncoder.encode(inputPwd);
		userDTO.setPwd(pwd);
		userDAO.joinOk(userDTO);
	}

	@Override
	public String loginOk(Map<String, String> map) {
		// 아이디, 비밀번호 확인
		String username = map.get("username");
		String inputPwd = map.get("pwd");
		UserDTO userDTO = userDAO.chkUsername(username);

		if (userDTO != null) {			
			// 블랙 리스트 확인
			if (userDTO.getAuth() == 3) {
				return "restriction";
			}
			
			// 탈퇴 회원 확인
			if (userDTO.getAuth() == 5) {
				return "withdrawn";
			}

			// 입력된 비밀번호, 암호화된 비밀번호 비교
			boolean pwdMatch = passwordEncoder.matches(inputPwd, userDTO.getPwd());

			if (pwdMatch == true) {
				// 관리자 확인
				if (userDTO.getAuth() == 2) {
					session.setAttribute("ssAdmin", userDTO.getAuth());
				}
				
				session.setAttribute("ssUserId", userDTO.getUserId());
				session.setAttribute("ssUsername", userDTO.getUsername());
				session.setAttribute("ssUserImg", userDTO.getImg());

				// 로그인 성공, 최종접속일 수정
				userDAO.loginOk(userDTO.getUsername());
				return "success";
			}
		}
		return "fail";
	}

	@Override
	public void logout() {
		session.invalidate();
	}

	@Override
	public String findUserOk(String phoneNum) {
		String username = userDAO.findUserOk(phoneNum);

		if (username == null)
			return "not_exist";
		else
			return username;
	}

	@Override
	public String findPwdOk(Map<String, String> map) {
		UserDTO userDTO = userDAO.findPwdOk(map);

		if (userDTO == null || userDTO.getAccessToken() != null)
			return "not_exist";
		else
			return "exist";
	}

	/* 비밀번호 찾기 */
	// 임시 비밀번호 생성
	public static String tempPassword() {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		// 특수문자 아스키 코드
		int arr[] = { 33, 42, 94 };
		int n = 0;

		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(4);
			switch (rIndex) {
			case 0:
				// a-z 영어소문자 아스키코드
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z 영어대문자 아스키코드
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9 숫자 아스키코드
				temp.append((rnd.nextInt(10)));
				break;
			case 3:
				// arr[]에 담긴 특수문자
				n = rnd.nextInt(3);
				temp.append((char) arr[n]);
				break;
			}
		}

		String password = temp.toString();
		System.out.println(password);
		return password;
	}

	// SMS 발송
	@Override
	public String sendSMS(Map<String, String> map) {
		String api_key = "NCSEINWFODTYVXTL";
		String api_secret = "HMRHSZRIH9DVPPROJ8MKQ4AKXNP03GLN";
		Message coolsms = new Message(api_key, api_secret);

		String pwd = tempPassword();

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", map.get("phoneNum")); // 수신번호
		params.put("from", "01048611073"); // 발신번호
		params.put("text", "[SHOECREAM] 임시 비밀번호 [" + pwd + "] 입니다."); // 문자내용
		params.put("type", "SMS"); // 문자 타입
		params.put("app_version", "test app 1.2");

		map.put("newPwd", passwordEncoder.encode(pwd));

		try {
			JSONObject obj = coolsms.send(params);
			System.out.println(obj.toString());
			// 임시 비밀번호 update
			userDAO.updatePwd(map);
			return "success";

		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
			return "fail";
		}
	}

	@Override
	public void updatePwd(Map<String, String> map) {
		userDAO.updatePwd(map);
	}

	/* 이메일 인증 */
	@Override
	public int authEmail(String email) throws Exception {
		// 인증번호(난수) 생성
		Random random = new Random();
		int authNum = random.nextInt(888888) + 111111;

		// 메일 전송
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[SHOECREAM] 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증 코드]</h1>").append("<p>안녕하세요. SHOECREAM입니다.</p>")
				.append("<p>아래의 인증번호를 입력하시면 이메일 인증이 완료됩니다.</p>").append("<a")
				.append("' target='_blenk'>" + authNum + "</a>").toString());
		sendMail.setFrom("username", "password");
		sendMail.setTo(email);
		sendMail.send();

		return authNum;
	}

	/* 카카오 로그인 */
	// access_Token 요청
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");

			sb.append("&client_id=8f0cf6601a7a42e678ddd67614c593ab"); // 본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8090/shoeCream/user/kakaoLogin"); // 본인이 설정한 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}

	// 사용자 정보 요청
	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {
		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		// url로 request하여 userInfo를 가져올 것
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonElement id = element.getAsJsonObject().get("id");
			System.out.println(id);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			// String profile_image =
			// properties.getAsJsonObject().get("profile_image").getAsString();
			String profile_image = kakao_account.getAsJsonObject("profile").getAsJsonObject().get("profile_image_url")
					.getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();

			userInfo.put("nickname", nickname);
			userInfo.put("profile_image", profile_image);
			userInfo.put("email", email);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}

	@Override
	public void joinSocialOk(UserDTO userDTO) {
		userDAO.joinSocialOk(userDTO);

		userDTO = userDAO.chkEmail(userDTO.getEmail());
		// 세션에 사용자 정보 저장
		session.setAttribute("ssUserId", userDTO.getUserId());
		session.setAttribute("ssUsername", userDTO.getUsername());
		session.setAttribute("ssAccessToken", userDTO.getAccessToken());
	}

	@Override
	public void kakaoLoginOk(String email, String access_Token) {
		UserDTO userDTO = userDAO.chkEmail(email);
		// 세션에 사용자 정보 저장
		session.setAttribute("ssUserId", userDTO.getUserId());
		session.setAttribute("ssUsername", userDTO.getUsername());
		session.setAttribute("ssAccessToken", access_Token);

		userDAO.kakaoLoginOk(email);
	}

	/* 휴대폰 본인인증 */
	@Override
	public Map<String, String> authPhonNum(String phoneNum) {
		String api_key = "NCSEINWFODTYVXTL";
		String api_secret = "HMRHSZRIH9DVPPROJ8MKQ4AKXNP03GLN";
		Message coolsms = new Message(api_key, api_secret);

		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNum); // 수신번호
		params.put("from", "01048611073"); // 발신번호
		params.put("text", "[SHOECREAM] 인증번호는 [" + randomNumber + "] 입니다."); // 문자내용
		params.put("type", "SMS"); // 문자 타입
		params.put("app_version", "test app 1.2");

		Map<String, String> map = new HashMap<String, String>();
		map.put("randomNumber", randomNumber + "");

		try {
			JSONObject obj = coolsms.send(params);
			System.out.println(obj.toString());
			map.put("result", "success");
			return map;

		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
			map.put("result", "fail");
			return map;
		}
	}

	@Override
	public UserDTO getUserId(int userId) {
		return userDAO.getUserId(userId);
	}

	@Override
	public List<UserDTO2> getTradeForm(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("endNum", Integer.parseInt(pg) * 5);
		map.put("startNum", (Integer.parseInt(pg) * 5) - 4);

		List<UserDTO2> list = userDAO.getTradeForm(map);
		System.out.println("userService list: " + list);
		System.out.println("map" + map);
		return list;
	}

	@Override
	public UserDTO getAdminUserId(String userId) {
		return userDAO.getAdminUserId(userId);
	}

	@Override
	public void ratingChange(Map<String, Object> map) {
		userDAO.ratingChange(map);
	}

	@Override
	public UserPaging userPaging(String pg) {
		int total = userDAO.getTotalUser();

		userPaging.setCurrentPage(Integer.parseInt(pg));
		userPaging.setPageBlock(5);
		userPaging.setPageSize(10);
		userPaging.setTotalA(total);
		userPaging.makePagingHTML();

		return userPaging;
	}

	@Override
	public UserPaging searchUserPaging(Map<String, Object> map) {
		int total = userDAO.getSearchTotalUser(map);

		userPaging.setCurrentPage(Integer.parseInt((String) map.get("searchPg")));
		userPaging.setPageBlock(5);
		userPaging.setPageSize(10);
		userPaging.setTotalA(total);
		userPaging.makePagingHTML();

		return userPaging;
	}

	@Override
	public List<UserDTO> searchUser(Map<String, Object> map) {
		int endNum = Integer.parseInt((String) map.get("searchPg")) * 10;
		int startNum = endNum - 9;

		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return userDAO.searchUser(map);
	}
}
