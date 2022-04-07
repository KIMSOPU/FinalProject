package purchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import purchase.bean.PurchaseDTO;
import purchase.bean.PurchasePaging;
import purchase.dao.PurchaseDAO;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	private PurchaseDAO purchaseDAO;	
	@Autowired
	private PurchasePaging purchasePaging;

	@Override
	public List<PurchaseDTO> getPurchaseList(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("endNum", Integer.parseInt(pg) * 10);
		map.put("startNum", (Integer.parseInt(pg) * 10) - 9);
		
		List<PurchaseDTO> list = purchaseDAO.getPurchaseList(map);
		return list;
	}

	@Override
	public Object purchasePaging(String pg) {
		purchasePaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		purchasePaging.setPageBlock(6);
		purchasePaging.setPageSize(10);
		purchasePaging.setTotalA(purchaseDAO.getTotalCount());
		purchasePaging.makePagingHTML();
		
		return purchasePaging;
	}
	
	@Override
	public List<PurchaseDTO> getPurchaseSearchList(Map<String, String> map) {
		return purchaseDAO.getPurchaseSearchList(map);
	}

}
