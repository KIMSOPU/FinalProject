package shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import mypage.bean.WishListDTO;
import shop.bean.ShopDTO;

@Repository
@Transactional
public class ShopDAOMybatis implements ShopDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ShopDTO> getShopList(Map<String, Integer> map) {
		return sqlSession.selectList("shopSQL.getShopList", map);
	}
	
	@Override
	public List<ShopDTO> getWishStyleCount() {
		return sqlSession.selectList("shopSQL.getWishStyleCount");
	}
	
	@Override
	public ShopDTO getShop(String productId) {
		return sqlSession.selectOne("shopSQL.getShop", Integer.parseInt(productId));
	}
	
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("shopSQL.getTotalCount");
	}
	
	@Override
	public List<ShopDTO> getShopSearchList(Map<String, String> map) {
		return sqlSession.selectList("shopSQL.getShopSearchList", map);
	}

	@Override
	public List<String> getBrandList() {
		return sqlSession.selectList("shopSQL.getBrandList");
	}

	@Override
	public List<Object> getShopPopularityFiter(Map<String, Object> map) {
		return sqlSession.selectList("shopSQL.getShopPopularityFiter", map);

	}

	@Override
	public Object getPurchaseLowPriceFiter(Map<String, Integer> map) {
		return sqlSession.selectList("shopSQL.getPurchaseLowPriceFiter", map);

	}

	@Override
	public Object getPurchaseHighPriceFiter(Map<String, Integer> map) {
		return sqlSession.selectList("shopSQL.getPurchaseHighPriceFiter", map);

	}

	@Override
	public Object getReleaseFiter(Map<String, Integer> map) {
		return sqlSession.selectList("shopSQL.getReleaseFiter", map);

	}
	
	// 이 아래부터는 새로 만든 메소드
	@Override
	public WishListDTO getWishOnOff(Map<String, Integer> map) {
		return sqlSession.selectOne("shopSQL.getWishOnOff", map); //userId, productId
	}
	
	@Override
	public Integer getLowestPriceByProductId(int productId) {
		return sqlSession.selectOne("shopSQL.getLowestPriceByProductId", productId);
	}
	
	@Override
	public List<ShopDTO> getShopDTOList(Map<String, Object> map) {
		return sqlSession.selectList("shopSQL.getShopDTOList", map);
	}
	
	
	@Override
	public void insertSalesData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertSalesData", map);
	}
	
	@Override
	public void insertPurchaseData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertPurchaseData", map);
	}
	
	@Override
	public int getRecentlyAddedPurchaseId() {
		return sqlSession.selectOne("shopSQL.getRecentlyAddedPurchaseId");
	}
	
	@Override
	public int getRecentlyAddedPaymentId() {
		return sqlSession.selectOne("shopSQL.getRecentlyAddedPaymentId");
	}
	
	@Override
	public void insertDealData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertDealData", map);
	}
	
	@Override
	public void insertPaymentData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertPaymentData", map);
	}
	
	@Override
	public void insertOrderData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertOrderData", map);
	}
	
	@Override
	public void insertCheckData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertCheckData", map);
	}
	
	@Override
	public int getRecentlyAddedCheckId() {
		return sqlSession.selectOne("shopSQL.getRecentlyAddedCheckId");
	}
	
	@Override
	public void updateSalesStatus(Map<String, Object> map) {
		sqlSession.update("shopSQL.updateSalesStatus", map);
	}
	
	@Override
	public int getRecentlyAddedSalesId() {
		return sqlSession.selectOne("shopSQL.getRecentlyAddedSalesId");
	}
	
	@Override
	public void insertAdminPurchaseData(Map<String, Object> map) {
		sqlSession.insert("shopSQL.insertAdminPurchaseData", map);
	}
	
	@Override
	public void updatePurchaseStatus(Map<String, Object> map) {
		sqlSession.update("shopSQL.updatePurchaseStatus", map);
	}
	
}
