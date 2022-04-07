package shop.service;

import java.util.List;
import java.util.Map;

import account.bean.AccountDTO;
import shop.bean.ShopDTO;
import shop.bean.ShopPaging;

public interface ShopService {
	public Map<String, Object> getShopList(List<String> brand, List<String> size, Map<String, Object> map, String pg);

	public Map<String, Object> getShop(String productId);

	public ShopPaging shopPaging(String pg);
	public ShopPaging shopPaging(Map<String, String> map);

	public List<ShopDTO> getShopSearchList(Map<String, String> map);

	public Map<String, Object> getShopSalesView(Map<String, String> map);

	public AccountDTO getMyAccount();

	public Map<String, Object> getBrandList();

	public void insertSalesData(Map<String, Object> map);

	public Map<String, Object> getShopPurchaseBidView(Map<String, String> map);

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
