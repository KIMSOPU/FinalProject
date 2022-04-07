package user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import user.bean.UserDTO;
import user.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private HttpSession session;
	
	@GetMapping(value = "/join")
	public String join() {
		if(session.getAttribute("ssUserId") != null)
			return "/index";
		else
			return "/WEB-INF/views/join";
	}

	@GetMapping(value = "/joinSocial")
	public String joinSocial() {
		return "/WEB-INF/views/joinSocial";
	}

	@PostMapping(value = "/chkUsername")
	@ResponseBody
	public String chkUsername(@RequestParam String username) {
		return userService.chkUsername(username);
	}

	@PostMapping(value = "/chkEmail")
	@ResponseBody
	public String chkEmail(@RequestParam String email) {
		return userService.chkEmail(email);
	}

	@PostMapping(value="/chkPhoneNum")
	@ResponseBody
	public String chkPhoneNum(@RequestParam String phoneNum) {
		return userService.chkPhoneNum(phoneNum);
	}
	
	@PostMapping(value = "/joinOk")
	@ResponseBody
	public void joinOk(@ModelAttribute UserDTO userDTO) {
		userService.joinOk(userDTO);
	}

	@GetMapping(value = "/login")
	public String login() {
		if (session.getAttribute("ssUserId") != null)
			return "/index";
		else
			return "/WEB-INF/views/login";
	}

	@PostMapping(value = "/loginOk")
	@ResponseBody
	public String loginOk(@RequestParam Map<String, String> map) {
		return userService.loginOk(map);
	}

	@GetMapping(value = "/logout")
	public String logout() {
		userService.logout();
		return "redirect:/";
	}

	@GetMapping(value = "/findUser")
	public String findUser() {
		if (session.getAttribute("ssUserId") != null)
			return "/index";
		else
			return "/WEB-INF/views/findUser";
	}

	@PostMapping(value = "/findUserOk")
	@ResponseBody
	public String findUserOk(@RequestParam String phoneNum) {
		return userService.findUserOk(phoneNum);
	}

	@GetMapping(value = "/findUserResult")
	public String findUserResult(@RequestParam String username, Model model) {
		if (session.getAttribute("ssUserId") != null) {
			return "/index";
		} else {
			model.addAttribute("username", username);
			return "/WEB-INF/views/findUserResult";
		}
	}

	@GetMapping(value = "/findPwd")
	public String findPwd() {
		if (session.getAttribute("ssUserId") != null)
			return "/index";
		else
			return "/WEB-INF/views/findPwd";
	}

	@PostMapping(value = "/findPwdOk")
	@ResponseBody
	public String findPwdOk(@RequestParam Map<String, String> map) {
		return userService.findPwdOk(map);
	}

	@PostMapping(value = "/sendSMS")
	@ResponseBody
	public String sendSMS(@RequestParam Map<String, String> map) {
		return userService.sendSMS(map);
	}

	@PostMapping(value = "/updatePwd")
	@ResponseBody
	public void updatePwd(@RequestParam Map<String, String> map) {
		userService.updatePwd(map);
	}

	@GetMapping(value = "/findPwdResult")
	public String findPwdResult() {
		if (session.getAttribute("ssUserId") != null)
			return "/index";
		else
			return "/WEB-INF/views/findPwdResult";
	}

	@PostMapping(value = "/authEmail")
	@ResponseBody
	public int authEmail(@RequestParam String email) throws Exception {
		return userService.authEmail(email);
	}

	/* 서비스 호출 및 사용자 정보 출력 */
	@GetMapping(value = "/kakaoLogin")
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model,
			HttpSession session) throws Exception {

		System.out.println("#########" + code);

		// 위에서 만든 코드 아래에 추가
		String access_Token = userService.getAccessToken(code);
		System.out.println("###access_Token#### : " + access_Token);

		// 위에서 만든 코드 아래에 코드 추가
		HashMap<String, Object> userInfo = userService.getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###profile_image#### : " + userInfo.get("profile_image"));
		System.out.println("###email#### : " + userInfo.get("email"));

		// DB에 사용자 정보가 있는지 확인
		String email = userService.chkEmail((String) userInfo.get("email"));
		
		// 사용자 정보가 없으면 회원가입
		if (email == "not_exist") {
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("accessToken", access_Token);
			return "/WEB-INF/views/joinSocial";

		// 사용자 정보가 있으면 로그인
		} else {
			userService.kakaoLoginOk((String) userInfo.get("email"), access_Token);
			return "/index";
		}
	}

	@PostMapping(value = "/joinSocialOk")
	@ResponseBody
	public void joinSocialOk(@ModelAttribute UserDTO userDTO) {
		userService.joinSocialOk(userDTO);
	}

	// 휴대폰 본인인증
	@PostMapping(value = "/authPhoneNum")
	@ResponseBody
	public Map<String, String> authPhoneNum(@RequestParam("phoneNum") String phoneNum) throws Exception {
		return userService.authPhonNum(phoneNum);
	}

}
