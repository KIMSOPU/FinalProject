package shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mypage.service.MypageService;
import shop.service.ShopService;

@Controller
@RequestMapping(value="shop")
public class ShopController {
	@Autowired
	private ShopService shopService;
	@Autowired
	private MypageService mypageService;
	
	@GetMapping(value="shopList")
	public String shopList(@RequestParam(required=false, defaultValue="1") String pg,
		      				Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/views/shop/shopList.jsp");
		return "/index";
	}
	
	@RequestMapping(value="search") 
	@ResponseBody
	public Map<String, Object> getShopList(@RequestParam(required=false, value="brand[]") List<String> brand 
											, @RequestParam(required=false, value="size[]") List<String> size
											, @RequestParam(required=false, defaultValue="1") String pg 
											, @RequestParam(required=false) Map<String, Object> map) {
		return shopService.getShopList(brand, size, map, pg);
	}
	
	@GetMapping(value="shopView")
	public String shopView(@RequestParam String productId, Model model) {
		model.addAttribute("productId", productId);
		model.addAttribute("display", "/WEB-INF/views/shop/shopView.jsp");
		return "/index";
	}
	
	@PostMapping(value="getShop")
	@ResponseBody
	public Map<String, Object> getShop(@RequestParam String productId) {
		return shopService.getShop(productId);
	}

	@PostMapping(value="shopPurchaseBidView")
	public String shopPurchaseBidView(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String pg = "1";
		System.out.println("shopPurchaseBidView: "+map);
		model.addAttribute("map", map);
		model.addAttribute("account", shopService.getMyAccount());
		
		int userId = (int) session.getAttribute("ssUserId");

		model.addAttribute("addressList", mypageService.getAddressList(pg, userId));
		model.addAttribute("paging", mypageService.paging(pg, "address_table", userId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "myAddress");
		model.addAttribute("display", "/WEB-INF/views/shop/shopPurchaseBidView.jsp");
		return "/index";
	}
	
	@PostMapping(value="shopPurchaseNowView")
	public String shopPurchaseNowView(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String pg = "1";
		System.out.println("shopPurchaseNowView: "+map);
		model.addAttribute("map", map);
		model.addAttribute("account", shopService.getMyAccount());
		
		int userId = (int) session.getAttribute("ssUserId");

		model.addAttribute("addressList", mypageService.getAddressList(pg, userId));
		model.addAttribute("paging", mypageService.paging(pg, "address_table", userId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "myAddress");
		model.addAttribute("display", "/WEB-INF/views/shop/shopPurchaseNowView.jsp");
		return "/index";
	}
	
	@PostMapping(value="shopSalesBidView")
	public String shopSalesBidView(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String pg = "1";
		System.out.println(map);
		model.addAttribute("map", map);
		model.addAttribute("account", shopService.getMyAccount());
		
		int userId = (int) session.getAttribute("ssUserId");

		model.addAttribute("addressList", mypageService.getAddressList(pg, userId));
		model.addAttribute("paging", mypageService.paging(pg, "address_table", userId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "myAddress");
		model.addAttribute("display", "/WEB-INF/views/shop/shopSalesBidView.jsp");
		return "/index";
	}
	
	@PostMapping(value="getShopSalesView")
	@ResponseBody
	public Map<String, Object> getShopSalesView(@RequestParam Map<String, String> map) {
		return shopService.getShopSalesView(map);
	}
	
	@PostMapping(value="getShopPurchaseBidView")
	@ResponseBody
	public Map<String, Object> getShopPurchaseBidView(@RequestParam Map<String, String> map) {
		System.out.println("getShopPurchaseBidView: "+map);
		return shopService.getShopPurchaseBidView(map);
	}
	
	@PostMapping(value="getShopSearchList")
	@ResponseBody
	public Map<String, Object> getShopSearchList(@RequestParam Map<String, String> map, Model model) { //searchOption, keyword, pg(id=searchPg)
		System.out.println(map.get("searchOption")+", "+map.get("keyword")+", "+map.get("pg"));
		
		
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("list", shopService.getShopSearchList(map));
		tempMap.put("shopPaging", shopService.shopPaging(map.get("pg")));
		
		return tempMap;
	}
	
	@GetMapping(value="getBrandList")
	@ResponseBody
	public Map<String, Object> getBrandList(){
		return shopService.getBrandList();
	}
	
	
	@PostMapping(value="insertSalesData")
	@ResponseBody
	public void insertSalesData(@RequestParam Map<String, Object> map) {
		System.out.println("insertSalesData: "+map);
		shopService.insertSalesData(map);
	}
	
	@PostMapping(value="insertPurchaseData")
	@ResponseBody
	public void insertPurchaseData(@RequestParam Map<String, Object> map) {
		System.out.println("insertPurchaseData: "+map);
		shopService.insertPurchaseData(map);
	}
	
	@PostMapping(value="getRecentlyAddedPurchaseId")
	@ResponseBody
	public int getRecentlyAddedPurchaseId() {
		return shopService.getRecentlyAddedPurchaseId();
	}
	
	@PostMapping(value="getRecentlyAddedPaymentId")
	@ResponseBody
	public int getRecentlyAddedPaymentId() {
		return shopService.getRecentlyAddedPaymentId();
	}
	
	@PostMapping(value="insertDealData")
	@ResponseBody
	public void insertDealData(@RequestParam Map<String, Object> map) {
		System.out.println("insertDealData: "+map);
		shopService.insertDealData(map);
	}
	
	@PostMapping(value="insertPaymentData")
	@ResponseBody
	public void insertPaymentData(@RequestParam Map<String, Object> map) {
		System.out.println("insertPaymentData: "+map);
		shopService.insertPaymentData(map);
	}
	
	@PostMapping(value="insertOrderData")
	@ResponseBody
	public void insertOrderData(@RequestParam Map<String, Object> map) {
		System.out.println("insertOrderData: "+map);
		shopService.insertOrderData(map);
	}
	
	@PostMapping(value="insertCheckData")
	@ResponseBody
	public void insertCheckData(@RequestParam Map<String, Object> map) {
		System.out.println("insertCheckData: "+map);
		shopService.insertCheckData(map);
	}
	
	@PostMapping(value="getRecentlyAddedCheckId")
	@ResponseBody
	public int getRecentlyAddedCheckId() {
		return shopService.getRecentlyAddedCheckId();
	}
	
	@PostMapping(value="updateSalesStatus")
	@ResponseBody
	public void updateSalesStatus(@RequestParam Map<String, Object> map) {
		shopService.updateSalesStatus(map);
	}
	
	@PostMapping(value="shopSalesNowView")
	public String shopSalesNowView(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String pg = "1";
		System.out.println(map);
		model.addAttribute("map", map);
		model.addAttribute("account", shopService.getMyAccount());
		
		int userId = (int) session.getAttribute("ssUserId");

		model.addAttribute("addressList", mypageService.getAddressList(pg, userId));
		model.addAttribute("paging", mypageService.paging(pg, "address_table", userId));
		model.addAttribute("pg", pg);
		model.addAttribute("pageName", "myAddress");
		model.addAttribute("display", "/WEB-INF/views/shop/shopSalesNowView.jsp");
		return "/index";
	}
	
	@PostMapping(value="getRecentlyAddedSalesId")
	@ResponseBody
	public int getRecentlyAddedSalesId() {
		return shopService.getRecentlyAddedSalesId();
	}
	
	@PostMapping(value="insertAdminPurchaseData")
	@ResponseBody
	public void insertAdminPurchaseData(@RequestParam Map<String, Object> map) {
		System.out.println("insertAdminPurchaseData: "+map);
		shopService.insertAdminPurchaseData(map);
	}
	
	@PostMapping(value="updatePurchaseStatus")
	@ResponseBody
	public void updatePurchaseStatus(@RequestParam Map<String, Object> map) {
		shopService.updatePurchaseStatus(map);
	}
	
}
