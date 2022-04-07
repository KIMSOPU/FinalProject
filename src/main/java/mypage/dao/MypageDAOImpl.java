package mypage.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mypage.bean.WishListDTO;
import purchase.bean.PurchaseDTO;
import sales.bean.SalesDTO;

@Repository
public class MypageDAOImpl implements MypageDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<WishListDTO> getWishList(Map<String, Integer> map) {
		return sqlSession.selectList("mypageSQL.getWishList", map);
	}
	
	@Override
	public int getTotalDB(Map<String, Object> map) {
		return sqlSession.selectOne("mypageSQL.getTotalDB", map);
	}
	
	@Override
	public void deleteWish(int wishListId) {
		sqlSession.delete("mypageSQL.deleteWish", wishListId);
	}
	
	@Override
	public void addWish(Map<String, Integer> map) {
		sqlSession.insert("mypageSQL.addWish", map);
	}
	
	@Override
	public WishListDTO getWishOnOff(Map<String, Integer> map) {
		return sqlSession.selectOne("mypageSQL.getWishOnOff", map); //userId, productId
	}

	@Override
	public List<PurchaseDTO> getBuyList(Map<String, Integer> map) {	
		List<Integer> list = sqlSession.selectList("mypageSQL.getPurchase", map.get("userId"));
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getBuyList", map.get("userId"));		
		List<PurchaseDTO> PurchaseList = new ArrayList<>();
		
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getPurchaseId() == list.get(j)) {
					count++;				
					if( count >= startNum && count <= endNum ) {
						PurchaseList.add(list2.get(i));
					}
				}						
			}			
		}

		return PurchaseList;
	} 
	
	
	@Override
	public int getTotalBuyPaging(Map<String, Integer> map) {
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getBuyList", map);			
		List<Integer> list = sqlSession.selectList("mypageSQL.getPurchase", map.get("userId"));
		
		int count = 0;	
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getPurchaseId() == list.get(j)) {	
					count++;				
				}						
			}			
		}	
		return count;
	}
	
	@Override
	public SalesDTO getPrice(int productId) {
		List<SalesDTO> list = sqlSession.selectList("mypageSQL.getPrice", productId);
		Map<String, SalesDTO> map = new HashMap<String, SalesDTO>();
		for(SalesDTO s : list) {
			map.put("SalesDTO", s);			
		}		
		return map.get("SalesDTO");
	}
		
	@Override
	public List<PurchaseDTO> getMonthBuyingList(Map<String, Object> map) {		
		List<Integer> list = sqlSession.selectList("mypageSQL.getPurchase", map.get("userId"));
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getMonthBuyingList", map);	
		List<PurchaseDTO> PurchaseList = new ArrayList<>();
		
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());
		
	
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getPurchaseId() == list.get(j)) {
					count++;				
					if( count >= startNum && count <= endNum ) {
						PurchaseList.add(list2.get(i));
					}
				}						
			}			
		}
		return PurchaseList;
	}
	
	@Override
	public int getTotalMonthBuying(Map<String, Object> map) {
		List<Integer> list = sqlSession.selectList("mypageSQL.getPurchase", map.get("userId"));
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getMonthBuyingList", map);	
		
		int count = 0;
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getPurchaseId() == list.get(j)) {
					count++;				

				}						
			}			
		}
		return count;
	}
	
	@Override
	public List<PurchaseDTO> getIngBuyingList(Map<String, Integer> map) {
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> purchaseList2 = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getIngBuyingList", map);
		System.out.println(list);
		for(PurchaseDTO p : list) {purchaseList.add(p);}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getIngBuyingList2", map);
		System.out.println(list2);
			for(PurchaseDTO p2 : list2) {
				purchaseList.add(p2);
			}
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		for(PurchaseDTO p3 : purchaseList) {
			count++;
			if( count >= startNum && count <= endNum ) {			
				purchaseList2.add(p3);
			}		
		}
		return purchaseList2;
	}
	
	@Override
	public int getTotalIngBuying(int userId) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("userId", userId);
		
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> purchaseList2 = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getIngBuyingList", map);
			for(PurchaseDTO p : list) {
				purchaseList.add(p);
			}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getIngBuyingList2", map);
			for(PurchaseDTO p : list2) {
				purchaseList.add(p);
			}
			
		int count = 0;
		for(PurchaseDTO p : purchaseList) {
			count++;
			purchaseList2.add(p);
			
		}
		return count;
	}

	@Override
	public List<PurchaseDTO> getEndBuyingList(Map<String, Integer> map) {			
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> purchaseList2 = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getEndBuyingList", map);
		for(PurchaseDTO p : list) {purchaseList.add(p);}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getEndBuyingList2", map);
			for(PurchaseDTO p2 : list2) {
				purchaseList.add(p2);
			}
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		for(PurchaseDTO p3 : purchaseList) {
			count++;
			if( count >= startNum && count <= endNum ) {
				purchaseList2.add(p3);
			}		
		}
		return purchaseList2;
	}
	
	@Override
	public int getEndBuying(int userId) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("userId", userId);
		
		int count = 0;	
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getEndBuyingList", map);
		for(PurchaseDTO p : list) {count++; purchaseList.add(p);}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getEndBuyingList2", map);
			for(PurchaseDTO p2 : list2) {
				count++;
				purchaseList.add(p2);
			}
		return count;
	}
	
	@Override
	public List<PurchaseDTO> getMonthEndBuyingList(Map<String, Object> map) {
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> purchaseList2 = new ArrayList<PurchaseDTO>();
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getMonthEndBuyingList", map);
		for(PurchaseDTO p : list) {purchaseList.add(p);}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getMonthEndBuyingList2", map);
			for(PurchaseDTO p2 : list2) {
				purchaseList.add(p2);
			}
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		for(PurchaseDTO p3 : purchaseList) {
			count++;
			if( count >= startNum && count <= endNum ) {
				purchaseList2.add(p3);
			}		
		}
		return purchaseList2;
	}

	
	@Override
	public int getTotalEndMonth(Map<String, Object> map) {
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		int count = 0;
		List<PurchaseDTO> list = sqlSession.selectList("mypageSQL.getMonthEndBuyingList", map);
		for(PurchaseDTO p : list) {count++; purchaseList.add(p);}
		List<PurchaseDTO> list2 = sqlSession.selectList("mypageSQL.getMonthEndBuyingList2", map);
			for(PurchaseDTO p2 : list2) {
				count++;
				purchaseList.add(p2);
			}
		return count;
	}
	
	// 판매
	@Override
	public List<SalesDTO> getSellingList(Map<String, Object> map) {
		List<SalesDTO> list2 = sqlSession.selectList("mypageSQL.getSellingList", map);		
		List<Integer> list = sqlSession.selectList("mypageSQL.getTotalSelling", map.get("userId"));
		List<SalesDTO> list3 = new ArrayList<SalesDTO>();
		
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getSalesId() == list.get(j)) {	
					count++;				
					if( count >= startNum && count <= endNum ) {
						list3.add(list2.get(i));
					}
				}						
			}			
		}
		return list3;
	}

	@Override
	public int sellpaging(Map<String, Object> map) {
		List<SalesDTO> list2 = sqlSession.selectList("mypageSQL.getSellingList", map);		
		List<Integer> list = sqlSession.selectList("mypageSQL.getTotalSelling", map.get("userId"));
		List<SalesDTO> list3 = new ArrayList<SalesDTO>();
		
		int count =0;
		for(int i=0; i< list2.size(); i++) {;
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getSalesId() == list.get(j)) {
					count++;
					list3.add(list2.get(i));
				}				
			}			
		}
		return count;
	}
	
	@Override
	public List<SalesDTO> getMonthSellingList(Map<String, Object> map) {
		List<SalesDTO> list2 = sqlSession.selectList("mypageSQL.getMonthSellingList", map);		
		System.out.println(map);
		List<Integer> list = sqlSession.selectList("mypageSQL.getTotalSelling", map.get("userId"));
		List<SalesDTO> list3 = new ArrayList<SalesDTO>();
		
		int count = 0;
		int startNum = Integer.parseInt(map.get("startNum").toString());		
		int endNum = Integer.parseInt(map.get("endNum").toString());	
		for(int i=0; i< list2.size(); i++) {
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getSalesId() == list.get(j)) {	
					count++;				
					if( count >= startNum && count <= endNum ) {
						list3.add(list2.get(i));
					}
				}						
			}			
		}
		return list3;
	}
	
	@Override
	public int getMonthSellingPaging(Map<String, Object> map) {
		List<SalesDTO> list2 = sqlSession.selectList("mypageSQL.getMonthSellingList", map);		
		List<Integer> list = sqlSession.selectList("mypageSQL.getTotalSelling", map.get("userId"));
		List<SalesDTO> list3 = new ArrayList<SalesDTO>();
		
		int count =0;
		for(int i=0; i< list2.size(); i++) {;
			for(int j=0; j< list.size(); j++) {
				if(list2.get(i).getSalesId() == list.get(j)) {
					count++;
					list3.add(list2.get(i));
				}				
			}			
		}
		return count;
	}

	@Override
	public List<SalesDTO> getEndSellingList(Map<String, Object> map) {
		return sqlSession.selectList("mypageSQL.getEndSellingList", map);
	}
	
	@Override
	public List<SalesDTO> getIngSellingList(Map<String, Object> map) {
		return sqlSession.selectList("mypageSQL.getIngSellingList", map);
	}
	
	@Override
	public int ingSellpaging(Map<String, Object> map) {
		return sqlSession.selectOne("mypageSQL.ingSellpaging", map);
	}

	@Override
	public int endSellpaging(Map<String, Object> map) {
		return sqlSession.selectOne("mypageSQL.endSellpaging", map);
	}
	
	@Override
	public List<SalesDTO> getMonthEndSellingList(Map<String, Object> map) {
		return sqlSession.selectList("mypageSQL.getMonthEndSellingList", map);
	}
	
	@Override
	public int endSellpaging2(Map<String, Object> map) {
		return sqlSession.selectOne("mypageSQL.endSellpaging2", map);
	}
	
	// 구매상세
	@Override
	public Map<String, Object> getByingInfo(Map<String, Object> map) {
		if(Integer.parseInt(map.get("orderId").toString()) != 0) {
			return sqlSession.selectOne("mypageSQL.getByingInfo2", map);
		}else if(Integer.parseInt(map.get("dealId").toString()) != 0){
			return sqlSession.selectOne("mypageSQL.getByingInfo3", map);		
		}else {
			return sqlSession.selectOne("mypageSQL.getByingInfo", map);			
		}
	}
	
	// 판매상세
	@Override
	public Map<String, Object> getSellingInfo(Map<String, Object> map) {	
		if(Integer.parseInt(map.get("dealId").toString()) != 0) {
			return sqlSession.selectOne("mypageSQL.getSellingInfo2", map);
		}else {
			return sqlSession.selectOne("mypageSQL.getSellingInfo", map);			
		}
	}
}
