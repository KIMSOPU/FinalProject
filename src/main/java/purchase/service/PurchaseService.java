package purchase.service;

import java.util.List;
import java.util.Map;

import purchase.bean.PurchaseDTO;

public interface PurchaseService {

	public List<PurchaseDTO> getPurchaseList(String pg);

	public Object purchasePaging(String pg);

	public List<PurchaseDTO> getPurchaseSearchList(Map<String, String> map);

}
