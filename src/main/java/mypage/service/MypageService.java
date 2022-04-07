package mypage.service;

import java.util.List;
import java.util.Map;

import account.bean.AccountDTO;
import address.bean.AddressDTO;
import mypage.bean.MypagePaging;
import user.bean.UserDTO;

public interface MypageService {

	public MypagePaging paging(String pg, String tableName, int userId);

	public List<Map<String, Object>> getWishList(String pg, int userId);

	public void deleteWish(int wishListId);

	public String switchWish(int productId);

	// 구매
	public List<Map<String, Object>> getBuyList(String pg, int userId);
	
	public MypagePaging buyPaging(String pg, int userId);

	public int getTotalBuying(int userId);

	public List<Map<String, Object>> getMonthBuyingList(Map<String, Object> map);

	public MypagePaging monthPaging(Map<String, Object> map);

	public int getEndBuying(int userId);

	public List<Map<String, Object>> getIngBuyingList(String pg, int userId);

	public MypagePaging ingPaging(String pg, int userId);

	public List<Map<String, Object>> getEndBuyingList(String pg, int userId);

	public MypagePaging endPaging(String pg, int userId);

	public int getTotalIngBuying(int userId);

	public List<Map<String, Object>> getMonthEndBuyingList(Map<String, Object> map);

	public MypagePaging endMonthPaging(Map<String, Object> map);

	// 판매
	public int getSellingCount(int userId);

	public List<Map<String, Object>> getSellingList(String pg, int userId, String option);

	public MypagePaging sellpaging(String pg, int userId, String option);

	public List<Map<String, Object>> getMonthSellingList(String pg, Map<String, Object> map);

	public MypagePaging getMonthSellingPaging(String pg, Map<String, Object> map);

	public int getIngCount(int userId);

	public List<Map<String, Object>> getIngSellingList(String pg, int userId, String option);

	public MypagePaging ingSellpaging(String pg, int userId, String option);

	public int getEndCount(int userId);

	public List<Map<String, Object>> getEndSellingList(String pg, int userId);

	public MypagePaging endSellpaging(String pg, int userId);

	public List<Map<String, Object>> getMonthEndSellingList(String pg, Map<String, Object> map);

	public MypagePaging endSellpaging2(String pg, Map<String, Object> map);

	// 마이페이지
	public UserDTO getUser(int userId);

	public void updateUsername(String username);

	public void updateEmail(String email);

	public String updatePwd(Map<String, String> map);

	public void updateFullName(String fullName);

	public void updatePhoneNum(String phoneNum);

	public AccountDTO getAccount(int userId);

	public void registerAccount(AccountDTO accountDTO);

	public void updateAccount(AccountDTO accountDTO);

	public List<AddressDTO> getAddressList(String pg, int userId);

	public void registerAddress(AddressDTO addressDTO);

	public void updateAddress(AddressDTO addressDTO);

	public void deleteAddress(int addressId);

	public void setDefaultAddr(int addressId);

	public void updateProfileImg(String fileName);

	public void deleteProfileImg();

	public void withdrawal();

	public void updateIntroMsg(String introMsg);

	public AccountDTO getMyAccount();
	
	public AddressDTO getMyAddress();

	// 구매 상세페이지
	public Map<String, Object> getByingInfo(Map <String, Object> map);

	// 판매 상세페이지
	public Map<String, Object> getSellingInfo(Map <String, Object> map);

	public String checkWish(int productId);


}
