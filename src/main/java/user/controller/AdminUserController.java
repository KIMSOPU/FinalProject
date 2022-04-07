package user.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import user.bean.UserDTO;
import user.bean.UserDTO2;
import user.bean.UserPaging;
import user.service.UserService;


@Controller
@RequestMapping(value = "/adminViews/user")
public class AdminUserController {
	@Autowired
	private UserService userService;
	
	// 유저목록 기본
	@GetMapping(value="userForm")
	public String userForm(@RequestParam(required = false, defaultValue = "1") String pg, Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/user/userForm.jsp");
		return "/admin/adminIndex";
	}
	
	// 유저 상세보기
	@GetMapping(value="userView")
	public String userView(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/user/userView.jsp");
		return "/admin/adminIndex";
	}
	
	// 크림하고 즉시거래
	@GetMapping(value = "purchaseForm")
	public String purchaseForm(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/user/purchaseForm.jsp");
		return "/admin/adminIndex";
	}
	
	// 회원으로부터의 입찰구매
	@GetMapping(value = "bidPurchaseForm")
	public String bidPurchaseForm(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/user/bidPurchaseForm.jsp");
		return "/admin/adminIndex";
	}
	
	// 판매내역
	@GetMapping(value = "sellForm")
	public String sellForm(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/user/sellForm.jsp");
		return "/admin/adminIndex";
	}
	
	
	
	
	// 유저목록 전체 리스트
	@PostMapping(value = "getUserForm")
	@ResponseBody
	public Map<String, Object> getUserForm(@RequestParam(required = false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashedMap<String, Object>();		
		
		// 리스트 뽑아오기
		List<UserDTO> list = userService.getUserForm(pg);
		// 페이징 처리하기
		UserPaging userPaging = userService.userPaging(pg);

		map.put("userPaging", userPaging);
		map.put("list", list);
		
		return map;
	}
	
	

	
	// ajax에서 getUserId값 넘겨주기 위해 사용
	@PostMapping(value="getAdminUserId")
	@ResponseBody
	public UserDTO getAdminUserId(@RequestParam String userId) {
		return userService.getAdminUserId(userId);
	}
	
	
	// 거래내역 조회
	@PostMapping(value="getTradeForm")
	@ResponseBody
	public List<UserDTO2> getTradeForm(@RequestParam(required=false, defaultValue="1") String pg) {
		System.out.println("pg: "+pg);
		List<UserDTO2> list = userService.getTradeForm(pg);
		System.out.println("list: "+list);
		
		return list;
	}
	
	
	
	
	// 등급변경
	@PostMapping(value="ratingChange")
	@ResponseBody
	public void ratingChange(@RequestParam Map<String, Object> map) {
		 userService.ratingChange(map);

	}	
	
	// 유저 검색
		@PostMapping(value = "searchUser")
		@ResponseBody
		public Map<String, Object> searchUser(@RequestParam Map<String, Object> map){		
			//페이징처리
			UserPaging userPaging = userService.searchUserPaging(map);
			// 검색 결과 리스트
			List<UserDTO> list = userService.searchUser(map);

			// data로 보낼 결과물
			Map<String, Object> map2 = new HashMap<String, Object>();
			// 검색 결과 리스트
			map2.put("list", list);
			// 페이징처리의 결과 값
			map2.put("userPaging", userPaging);
			return map2;
		}
	
}
