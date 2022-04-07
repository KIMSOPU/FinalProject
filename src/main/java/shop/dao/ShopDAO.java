package shop.dao;

import java.util.List;
import java.util.Map;

import mypage.bean.WishListDTO;
import shop.bean.ShopDTO;

public interface ShopDAO {

	public List<ShopDTO> getShopList(Map<String, Integer> map);

	public ShopDTO getShop(String productId);

	public int getTotalCount();

	public List<ShopDTO> getShopSearchList(Map<String, String> map);

	public List<ShopDTO> getWishStyleCount();
	
	public List<String> getBrandList();

	public List<Object> getShopPopularityFiter(Map<String, Object> map);

	public Object getPurchaseLowPriceFiter(Map<String, Integer> map);

	public Object getPurchaseHighPriceFiter(Map<String, Integer> map);

	public Object getReleaseFiter(Map<String, Integer> map);
	// 아래부터는 신규생성 메소드
	public WishListDTO getWishOnOff(Map<String, Integer> map);

	public Integer getLowestPriceByProductId(int productId);

	public List<ShopDTO> getShopDTOList(Map<String, Object> map);
	
	
	public void insertSalesData(Map<String, Object> map);

	public void insertPurchaseData(Map<String, Object> map);

	public int getRecentlyAddedPurchaseId();

	public void insertDealData(Map<String, Object> map);

	public void insertPaymentData(Map<String, Object> map);

	public int getRecentlyAddedPaymentId();

	public void insertOrderData(Map<String, Object> map);

	public void insertCheckData(Map<String, Object> map);

	public int getRecentlyAddedCheckId();

	public void updateSalesStatus(Map<String, Object> map);

	public int getRecentlyAddedSalesId();

	public void insertAdminPurchaseData(Map<String, Object> map);

	public void updatePurchaseStatus(Map<String, Object> map);
}
