package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import account.bean.AccountDTO;
import address.bean.AddressDTO;
import mypage.service.MypageService;

@Controller
@RequestMapping(value="/my")
public class MypageController {
	@Autowired
	private MypageService mypageService;
	@Autowired
	private HttpSession session;
	
	//관심상품 페이지
	@RequestMapping(value="/wish")
	public String wish(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		if(session.getAttribute("ssUserId") == null) return "/WEB-INF/views/login";
		else {
			int userId = (int) session.getAttribute("ssUserId");
			model.addAttribute("wishList", mypageService.getWishList(pg, userId)); 
			model.addAttribute("pg", pg);
			model.addAttribute("paging", mypageService.paging(pg, "wish_list", userId)); 
			model.addAttribute("pageName", "wish");
			model.addAttribute("display", "/WEB-INF/views/wish.jsp");
			return "/WEB-INF/views/mypage"; 
		}
	}
	
	//관심상품 삭제
	@RequestMapping(value="/deleteWish")
	@ResponseBody
	public void deleteWish(int wishListId) {
		mypageService.deleteWish(wishListId);
	}
	
	//관심상품 등록 여부 확인
	@ResponseBody
	@RequestMapping(value="/checkWish")
	public String checkWish(int productId) {
		return mypageService.checkWish(productId);
	}
	
	//관심상품 등록/취소 (샵 페이지 아이콘)
	@ResponseBody
	@RequestMapping(value="/addWish")
	public String switchWish(int productId) {
		return mypageService.switchWish(productId);
	}
	
	// 총 구매내역 폼
	@GetMapping(value="/buying")
	public String buying(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getTotalBuying(userId));
		model.addAttribute("ingCount", mypageService.getTotalIngBuying(userId));	
		model.addAttribute("endCount", mypageService.getEndBuying(userId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "buying");
		model.addAttribute("display2", "/WEB-INF/views/buying1.jsp");
		model.addAttribute("display", "/WEB-INF/views/buying.jsp");
		return "/WEB-INF/views/mypage"; 
	}
	
	// 총 구매내역 가져오기
	@PostMapping(value = "getBuyingList")
	@ResponseBody
	public Map<String, Object> getBuyingList(@RequestParam(required=false, defaultValue = "1") String pg){
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("buyList", mypageService.getBuyList(pg, userId)); 
		map.put("paging", mypageService.buyPaging(pg, userId)); 
		return map;
	}

	// 총 거래내역 기간
	@PostMapping(value = "getMonthBuyingList")
	@ResponseBody
	public Map<String, Object> getMonthBuyingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam Map<String, Object> map){
		Map<String, Object> map2 = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
		
		map2.put("monthBuyList", mypageService.getMonthBuyingList(map)); 
		map2.put("paging", mypageService.monthPaging(map)); 
		return map2;
	}
	
	// 거래중 폼
	@GetMapping(value="/ingBuying")
	public String ingBuying(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getTotalBuying(userId));
		model.addAttribute("ingCount", mypageService.getTotalIngBuying(userId));
		model.addAttribute("endCount", mypageService.getEndBuying(userId));
		model.addAttribute("pg", pg);		
		
		model.addAttribute("pageName", "buying");
		model.addAttribute("display2", "/WEB-INF/views/buying2.jsp");
		model.addAttribute("display", "/WEB-INF/views/buying.jsp");		
		return "/WEB-INF/views/mypage"; 
	}
	 
	// 거래중
	@PostMapping(value="/getIngBuyingList")
	@ResponseBody
	public Map<String, Object> getIngBuyingList(@RequestParam(required=false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("buyList", mypageService.getIngBuyingList(pg, userId));
		map.put("paging", mypageService.ingPaging(pg, userId)); 	
		return map; 
	}
	
	// 거래 완료 폼
	@GetMapping(value="/endBuying")
	public String endBuying(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getTotalBuying(userId));
		model.addAttribute("ingCount", mypageService.getTotalIngBuying(userId));
		model.addAttribute("endCount", mypageService.getEndBuying(userId));
		model.addAttribute("pg", pg);
		
		model.addAttribute("pageName", "buying");
		model.addAttribute("display2", "/WEB-INF/views/buying3.jsp");
		model.addAttribute("display", "/WEB-INF/views/buying.jsp");			
		return "/WEB-INF/views/mypage"; 
	}
	
	// 거래완료
	@PostMapping(value="/getEndBuyingList")
	@ResponseBody
	public Map<String, Object> getEndBuyingList(@RequestParam(required=false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("buyList", mypageService.getEndBuyingList(pg, userId));
		System.out.println(map.get("buyList"));
		map.put("paging", mypageService.endPaging(pg, userId)); 
		return map; 
	}
	
	// 거래완료시 기간
	@PostMapping(value = "getMonthEndBuyingList")
	@ResponseBody
	public Map<String, Object> getMonthEndBuyingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam Map<String, Object> map){
		Map<String, Object> map2 = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
		
		map2.put("monthBuyList", mypageService.getMonthEndBuyingList(map)); 
		map2.put("paging", mypageService.endMonthPaging(map)); 
		return map2;
	}
	
	// 판매
		
	// 총 판매 내역 폼
	@GetMapping(value="selling")
	public String selling(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getSellingCount(userId));
		model.addAttribute("ingCount", mypageService.getIngCount(userId));
		model.addAttribute("endCount", mypageService.getEndCount(userId));
		model.addAttribute("pageName", "selling");
		model.addAttribute("pg", pg);
		model.addAttribute("display2", "/WEB-INF/views/selling1.jsp");
		model.addAttribute("display", "/WEB-INF/views/selling.jsp");
		return "/WEB-INF/views/mypage";  		
	}
	
	// 총 판매내역
	@PostMapping(value = "getSellingList")
	@ResponseBody
	public Map<String, Object> getSellingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam String option, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("sellList", mypageService.getSellingList(pg, userId, option)); 
		map.put("paging", mypageService.sellpaging(pg, userId, option)); 		
		return map;
	}
	
	// 판매입찰 날짜필터
	@PostMapping(value = "getMonthSellingList")
	@ResponseBody
	public Map<String, Object> getMonthSellingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam Map<String, Object> map){
		Map<String, Object> map2 = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("userId", userId);
		map2.put("sellList", mypageService.getMonthSellingList(pg, map)); 
		map2.put("paging", mypageService.getMonthSellingPaging(pg, map)); 		
		return map2;
	} 
	
	// 판매 거래중 폼
	@GetMapping(value="/ingSelling")
	public String ingSelling(@RequestParam(required=false, defaultValue = "1") String pg, Model model) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getSellingCount(userId));
		model.addAttribute("ingCount", mypageService.getIngCount(userId));
		model.addAttribute("endCount", mypageService.getEndCount(userId));
		model.addAttribute("pageName", "selling");
		model.addAttribute("pg", pg);		
		model.addAttribute("display2", "/WEB-INF/views/selling2.jsp");
		model.addAttribute("display", "/WEB-INF/views/selling.jsp");		
		return "/WEB-INF/views/mypage"; 
	}
	
	// 거래중 리스트
	@PostMapping(value="/getIngSellingList")
	@ResponseBody
	public Map<String, Object> getIngSellingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam String option) {
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("sellList", mypageService.getIngSellingList(pg, userId, option));
		map.put("paging", mypageService.ingSellpaging(pg, userId, option)); 		
		return map; 
	}
	
	// 판매완료 폼
	@GetMapping(value="/endSelling")
	public String endSelling(@RequestParam(required=false, defaultValue = "1") String pg, Model model, @RequestParam(required=false, defaultValue = "1") String option) {
		int userId = (int) session.getAttribute("ssUserId");
		
		model.addAttribute("totalCount", mypageService.getSellingCount(userId));
		model.addAttribute("ingCount", mypageService.getIngCount(userId));
		model.addAttribute("endCount", mypageService.getEndCount(userId));
		model.addAttribute("pageName", "selling");
		model.addAttribute("pg", pg);		
		model.addAttribute("display2", "/WEB-INF/views/selling3.jsp");
		model.addAttribute("display", "/WEB-INF/views/selling.jsp");		
		return "/WEB-INF/views/mypage"; 
	}
	
	// 판매완료 리스트
	@PostMapping(value="/getEndSellingList")
	@ResponseBody
	public Map<String, Object> getEndSellingList(@RequestParam(required=false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		
		map.put("sellList", mypageService.getEndSellingList(pg, userId));
		map.put("paging", mypageService.endSellpaging(pg, userId));
		return map; 
	}
	
	// 판매완료 기간 내
	@PostMapping(value="/getMonthEndSellingList")
	@ResponseBody
	public Map<String, Object> getMonthEndSellingList(@RequestParam(required=false, defaultValue = "1") String pg, @RequestParam Map<String, Object> map) {
		Map<String, Object> map2 = new HashMap<String, Object>();
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
		
		map2.put("sellList", mypageService.getMonthEndSellingList(pg, map));
		map2.put("paging", mypageService.endSellpaging2(pg, map));
		return map2; 
	}
	
	/* 마이페이지 내정보 */
	@RequestMapping(value = "myProfile")
	public String myProfile(Model model) {
		if (session.getAttribute("ssUserId") == null)
			return "/WEB-INF/views/login";
		else {
			int userId = (int) session.getAttribute("ssUserId");
			model.addAttribute("userDTO", mypageService.getUser(userId));
			System.out.println(userId);
			System.out.println(mypageService.getUser(userId));
			model.addAttribute("pageName", "myProfile");
			model.addAttribute("display", "/WEB-INF/views/myProfile.jsp");
			return "/WEB-INF/views/mypage";
		}
	}

	@RequestMapping(value = "myAddress")
	public String myAddress(@RequestParam(required = false, defaultValue = "1") String pg, Model model) {
		if (session.getAttribute("ssUserId") == null)
			return "/WEB-INF/views/login";
		else {
			int userId = (int) session.getAttribute("ssUserId");
			model.addAttribute("addressList", mypageService.getAddressList(pg, userId));
			model.addAttribute("pg", pg);
			model.addAttribute("paging", mypageService.paging(pg, "address_table", userId));
			model.addAttribute("pageName", "myAddress");
			model.addAttribute("display", "/WEB-INF/views/myAddress.jsp");
			return "/WEB-INF/views/mypage";
		}
	}

	@RequestMapping(value = "myAccount")
	public String myAccount(Model model) {
		if (session.getAttribute("ssUserId") == null)
			return "/WEB-INF/views/login";
		else {
			int userId = (int) session.getAttribute("ssUserId");
			model.addAttribute("accountDTO", mypageService.getAccount(userId));
			model.addAttribute("pageName", "myAccount");
			model.addAttribute("display", "/WEB-INF/views/myAccount.jsp");
			return "/WEB-INF/views/mypage";
		}
	}

	@RequestMapping(value = "myStyle")
	public String myStyle(Model model) {
		if (session.getAttribute("ssUserId") == null)
			return "/WEB-INF/views/login";
		else {
			model.addAttribute("pageName", "myStyle");
			model.addAttribute("display", "/WEB-INF/views/myStyle.jsp");
			return "/WEB-INF/views/mypage";
		}
	}

	@RequestMapping(value = "myWithdrawal")
	public String myWithdrawal(Model model) {
		if (session.getAttribute("ssUserId") == null)
			return "/WEB-INF/views/login";
		else {
			model.addAttribute("pageName", "myWithdrawal");
			model.addAttribute("display", "/WEB-INF/views/myWithdrawal.jsp");
			return "/WEB-INF/views/mypage";
		}
	}

	@RequestMapping(value = "updateUsername")
	@ResponseBody
	public void updateUsername(@RequestParam String username) {
		mypageService.updateUsername(username);
	}

	@RequestMapping(value = "updateEmail")
	@ResponseBody
	public void updateEmail(@RequestParam String email) {
		mypageService.updateEmail(email);
	}

	@RequestMapping(value = "updatePwd")
	@ResponseBody
	public String updatePwd(@RequestParam Map<String, String> map) {
		return mypageService.updatePwd(map);
	}

	@RequestMapping(value = "updateFullName")
	@ResponseBody
	public void updateFullName(@RequestParam String fullName) {
		mypageService.updateFullName(fullName);
	}

	@RequestMapping(value = "updatePhoneNum")
	@ResponseBody
	public void updatePhoneNum(@RequestParam String phoneNum) {
		mypageService.updatePhoneNum(phoneNum);

	}

	@RequestMapping(value = "registerAccount")
	@ResponseBody
	public void registerAccount(@ModelAttribute AccountDTO accountDTO) {
		mypageService.registerAccount(accountDTO);
	}

	@RequestMapping(value = "updateAccount")
	@ResponseBody
	public void updateAccount(@ModelAttribute AccountDTO accountDTO) {
		mypageService.updateAccount(accountDTO);
	}

	@RequestMapping(value = "registerAddress")
	@ResponseBody
	public void registerAddress(@ModelAttribute AddressDTO addressDTO) {
		mypageService.registerAddress(addressDTO);
	}

	@RequestMapping(value = "updateAddress")
	@ResponseBody
	public void updateAddress(@ModelAttribute AddressDTO addressDTO) {
		mypageService.updateAddress(addressDTO);
	}

	@RequestMapping(value = "deleteAddress")
	@ResponseBody
	public void deleteAddress(@RequestParam int addressId) {
		mypageService.deleteAddress(addressId);
	}

	@RequestMapping(value = "setDefaultAddr")
	@ResponseBody
	public void setDefaultAddr(@RequestParam int addressId) {
		mypageService.setDefaultAddr(addressId);
	}

	@RequestMapping(value = "updateProfileImg")
	@ResponseBody
	public void updateProfileImg(@RequestParam MultipartFile image, HttpSession session) {
		String filePath = "C:\\shoeCream_images\\images\\userProfile";
		String fileName = image.getOriginalFilename();
		String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		
		// UUID로 파일 이름 중복 방지하기
		UUID uuid = UUID.randomUUID();
		fileName = uuid.toString() + extension;

		File file = new File(filePath, fileName);

		try {
			image.transferTo(file);

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		session.removeAttribute("ssUserImg");
		session.setAttribute("ssUserImg", fileName);
		
		mypageService.updateProfileImg(fileName);
	}

	@RequestMapping(value = "deleteProfileImg")
	@ResponseBody
	public void deleteProfileImg(@RequestParam String img, HttpSession session) {
		String filePath = "C:\\shoeCream_images\\images\\userProfile";
		String fileName = img;
		File file = new File(filePath, fileName);

		file.delete(); // 원본 파일 삭제
		mypageService.deleteProfileImg(); // DB 삭제
	}

	@RequestMapping(value = "withdrawal")
	@ResponseBody
	public void withdrawal() {
		mypageService.withdrawal();
	}
	
	@GetMapping(value = "updateIntroMsg")
	@ResponseBody
	public void updateIntroMsg(@RequestParam String introMsg) {
		mypageService.updateIntroMsg(introMsg);
	}
	
	// 구매 상세페이지
	@GetMapping(value="/buyingView")
	public String buyingView(Model model, @RequestParam int purchaseId, @RequestParam int productId, @RequestParam(required = false, defaultValue = "1") String pg,  @RequestParam String count, @RequestParam(required = false, defaultValue = "0") int orderId,  @RequestParam(required = false, defaultValue = "0") int dealId) {
		
		model.addAttribute("pg", pg);
		model.addAttribute("count", count);
		model.addAttribute("productId", productId);
		model.addAttribute("orderId", orderId);
		model.addAttribute("dealId", dealId);
		model.addAttribute("purchaseId", purchaseId);
		model.addAttribute("pageName", "buying");
		model.addAttribute("display", "/WEB-INF/views/buyingView.jsp");		
		return "/WEB-INF/views/mypage"; 
	}
	
	@PostMapping(value = "/getByingInfo")
	@ResponseBody
	public Map<String, Object> getByingInfo(@RequestParam Map <String, Object> map){
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
	    return mypageService.getByingInfo(map);
	}

	// 판매상세페이지
	@GetMapping(value="/sellingView")
	public String sellingView(Model model, @RequestParam String salesId, @RequestParam(required = false, defaultValue = "1") String pg, @RequestParam String count, @RequestParam(required = false, defaultValue = "0") String dealId) {

		model.addAttribute("pg", pg);
		model.addAttribute("count", count);
		model.addAttribute("salesId", salesId);
		model.addAttribute("dealId", dealId);
		model.addAttribute("pageName", "selling");
		model.addAttribute("display", "/WEB-INF/views/sellingView.jsp");		
		return "/WEB-INF/views/mypage"; 
	}
	
	@PostMapping(value = "/getSellingInfo")
	@ResponseBody
	public Map<String, Object> getSellingInfo(@RequestParam Map <String, Object> map){
		int userId = (int) session.getAttribute("ssUserId");
		map.put("userId", userId);
	    return mypageService.getSellingInfo(map);
	}
	
	@GetMapping(value="getMyAccount")
	@ResponseBody
	public AccountDTO getMyAccount() {
		return mypageService.getMyAccount();
	}
		
}
