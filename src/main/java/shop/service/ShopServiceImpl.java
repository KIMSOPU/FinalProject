package shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import account.bean.AccountDTO;
import mypage.service.MypageService;
import shop.bean.ShopDTO;
import shop.bean.ShopPaging;
import shop.dao.ShopDAO;
import user.bean.UserDTO;
import user.dao.UserDAO;

@Service
public class ShopServiceImpl implements ShopService {
	//private int NUMBER_OF_ITEMS_PER_PG = 24;
	@Autowired
	private MypageService mypageService;
	@Autowired
	private ShopDAO shopDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private ShopPaging shopPaging;
	@Autowired
	private HttpSession session;
	
	
	@Override
	public Map<String, Object> getShopList(List<String> brand, List<String> size, Map<String, Object> map, String pg) {
		//파라미터 map의 필터, 정렬 조건에 맞춰 shopDTO List 뽑아오기
		
		// 기본화면 (필터 선택x)
		if(map.get("sort") == null) map.put("sort", "popular");
		
		// 브랜드, 사이즈 선택 시 map에 담기
		if(brand != null) map.put("brand", brand);
		if(size != null) map.put("size", size);
		
		// 가격 min-max
		if(map.get("price") != null) {
			String price = (String) map.get("price");
			if(price.equals("10만원 이하")) {
				map.put("priceMin", 0);
				map.put("priceMax", 100000);
			} else if(price.equals("10만원 - 30만원 이하")) {
				map.put("priceMin", 100000);
				map.put("priceMax", 300000);
			} else if(price.equals("30만원 - 50만원 이하")) {
				map.put("priceMin", 300000);
				map.put("priceMax", 500000);
			} else if(price.equals("50만원 이상")) {
				map.put("priceMin", 500000);
				map.put("priceMax", 50000000);
			}
		}
		//if(brand != null) System.out.println(brand.toString());
		//if(size != null) System.out.println(size.toString());
		//System.out.println(map.toString());
		List<ShopDTO> shopDTOList = shopDAO.getShopDTOList(map); //brandName, size, price, sort
		
		
		//뽑아온 List에 '관심상품 클릭여부', '관심상품 최저가' 추가로 세팅
		List<ShopDTO> productList = this.makeShopCardDTOList(shopDTOList);
		
		//상품별 위시로 등록된 횟수, 스타일에 태그된 횟수 list 가져오기
		List<ShopDTO> wishStyleCountList = shopDAO.getWishStyleCount();
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("productList", productList);
		returnMap.put("wishStyleCountList", wishStyleCountList);
		
		return returnMap;
	}
	
	
	
	private List<ShopDTO> makeShopCardDTOList(List<ShopDTO> shopDTOList) {
		for(ShopDTO shopDTO: shopDTOList) {
			// 관심상품 클릭 여부 (로그인 여부 확인 필요)
			if(session.getAttribute("ssUserId") != null) {
				int userId = (int) session.getAttribute("ssUserId");
				
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("productId", shopDTO.getProductId());
				map.put("userId", userId);
				
				if(shopDAO.getWishOnOff(map) == null) shopDTO.setWishOnOff("off");
				else shopDTO.setWishOnOff("on");
				
			} else shopDTO.setWishOnOff("off"); //비로그인 상태면 무조건 off
		}
		return shopDTOList;
	}



	@Override
	public Map<String, Object> getShop(String productId)  {
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("shopDTO", shopDAO.getShop(productId));
		UserDTO u;
		try {
			u = userDAO.getUserId((int)session.getAttribute("ssUserId"));
		} catch (Exception e) {
			u = null;
		}
		tempMap.put("userDTO", u);			
		
		return tempMap;
	}
	
	@Override
	public ShopPaging shopPaging(String pg) {
		shopPaging.setCurrentPage(Integer.parseInt(pg)); //�쁽�옱 �럹�씠吏�
		shopPaging.setPageBlock(6);
		shopPaging.setPageSize(5);
		shopPaging.setTotalA(shopDAO.getTotalCount());
		shopPaging.makePagingHTML();
		
		return shopPaging;
	}
	
	@Override
	public ShopPaging shopPaging(Map<String, String> map) {
		return null;
	}
	
	@Override
	public List<ShopDTO> getShopSearchList(Map<String, String> map) {
		int endNum = Integer.parseInt(map.get("pg")) * 5;
		int startNum = endNum - 4;
		
		map.put("startNum", Integer.toString(startNum));
		map.put("endNum", Integer.toString(endNum));
		
		return shopDAO.getShopSearchList(map);
	}

	@Override
	public Map<String, Object> getShopSalesView(Map<String, String> map) {	
		//productId, userInputPrice, userProductSize
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("shopDTO", shopDAO.getShop(map.get("productId")));
		tempMap.put("userDTO", userDAO.getUserId((int)session.getAttribute("ssUserId")));
		tempMap.put("userInputPrice", map.get("userInputPrice"));
		tempMap.put("userProductSize", map.get("userProductSize"));
		
		return tempMap;
	}
	
	@Override
	public Map<String, Object> getShopPurchaseBidView(Map<String, String> map) {
		//productId, userInputPrice, userProductSize
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("shopDTO", shopDAO.getShop(map.get("productId")));
		tempMap.put("userDTO", userDAO.getUserId((int)session.getAttribute("ssUserId")));
		tempMap.put("price", map.get("price"));
		tempMap.put("userProductSize", map.get("userProductSize"));
		
		return tempMap;
	}

	@Override
	public AccountDTO getMyAccount() {
		return mypageService.getMyAccount();
	}
	
	@Override
	public Map<String, Object> getBrandList() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandList", shopDAO.getBrandList());
		return map;
	}
	
	@Override
	public void insertSalesData(Map<String, Object> map) {
		map.put("userId", session.getAttribute("ssUserId"));
		shopDAO.insertSalesData(map);
	}
	
	@Override
	public void insertPurchaseData(Map<String, Object> map) {
		map.put("userId", session.getAttribute("ssUserId"));
		shopDAO.insertPurchaseData(map);
	}
	
	@Override
	public int getRecentlyAddedPurchaseId() {
		return shopDAO.getRecentlyAddedPurchaseId();
	}
	
	@Override
	public int getRecentlyAddedPaymentId() {
		return shopDAO.getRecentlyAddedPaymentId();
	}
	
	@Override
	public void insertDealData(Map<String, Object> map) {
		shopDAO.insertDealData(map);
	}
	
	@Override
	public void insertPaymentData(Map<String, Object> map) {
		shopDAO.insertPaymentData(map);
	}
	
	@Override
	public void insertOrderData(Map<String, Object> map) {
		UserDTO u = userDAO.getUserId((int)session.getAttribute("ssUserId"));
		map.put("userId", u.getUserId());
		map.put("phoneNum", u.getPhoneNum());
		shopDAO.insertOrderData(map);
	}
	
	@Override
	public void insertCheckData(Map<String, Object> map) {
		shopDAO.insertCheckData(map);
	}
	
	@Override
	public int getRecentlyAddedCheckId() {
		return shopDAO.getRecentlyAddedCheckId();
	}
	
	@Override
	public void updateSalesStatus(Map<String, Object> map) {
		shopDAO.updateSalesStatus(map);
	}
	
	@Override
	public int getRecentlyAddedSalesId() {
		return shopDAO.getRecentlyAddedSalesId();
	}
	
	@Override
	public void insertAdminPurchaseData(Map<String, Object> map) {
		shopDAO.insertAdminPurchaseData(map);
	}
	
	@Override
	public void updatePurchaseStatus(Map<String, Object> map) {
		shopDAO.updatePurchaseStatus(map);
	}
	
	
}
