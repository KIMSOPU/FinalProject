package purchase.dao;

import java.util.List;
import java.util.Map;

import purchase.bean.PurchaseDTO;

public interface PurchaseDAO {

	public List<PurchaseDTO> getPurchaseList(Map<String, Integer> map);

	public int getTotalCount();

	public List<PurchaseDTO> getPurchaseSearchList(Map<String, String> map);

}
