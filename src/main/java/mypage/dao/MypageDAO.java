package mypage.dao;

import java.util.List;
import java.util.Map;

import mypage.bean.WishListDTO;
import purchase.bean.PurchaseDTO;
import sales.bean.SalesDTO;

public interface MypageDAO {

	public List<WishListDTO> getWishList(Map<String, Integer> map);

	public int getTotalDB(Map<String, Object> map);

	public void deleteWish(int wishListId);

	public void addWish(Map<String, Integer> map);
	
	public WishListDTO getWishOnOff(Map<String, Integer> map);
	
	// 구매
	public List<PurchaseDTO> getBuyList(Map<String, Integer> map);

	public int getTotalBuyPaging(Map<String, Integer> map);
	
	public SalesDTO getPrice(int productId);

	public List<PurchaseDTO> getIngBuyingList(Map<String, Integer> map);

	public int getTotalIngBuying(int userId);
	
	public List<PurchaseDTO> getMonthBuyingList(Map<String, Object> map);

	public  List<PurchaseDTO> getEndBuyingList(Map<String, Integer> map);

	public int getEndBuying(int userId);

	public int getTotalMonthBuying(Map<String, Object> map);

	public List<PurchaseDTO> getMonthEndBuyingList(Map<String, Object> map);

	public int getTotalEndMonth(Map<String, Object> map);
		
	// 판매
	public List<SalesDTO> getSellingList(Map<String, Object> map);

	public int sellpaging(Map<String, Object> map);

	public List<SalesDTO> getEndSellingList(Map<String, Object> map);

	public List<SalesDTO> getIngSellingList(Map<String, Object> map);

	public int endSellpaging(Map<String, Object> map);

	public List<SalesDTO> getMonthEndSellingList(Map<String, Object> map);

	public int ingSellpaging(Map<String, Object> map);

	public int endSellpaging2(Map<String, Object> map);

	public List<SalesDTO> getMonthSellingList(Map<String, Object> map);

	public int getMonthSellingPaging(Map<String, Object> map);

	// 구매 상세
	public Map<String, Object> getByingInfo(Map<String, Object> map);

	// 판매상세
	public Map<String, Object> getSellingInfo(Map<String, Object> map);
	



}
