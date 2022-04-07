package deal.service;

import java.util.List;
import java.util.Map;

import deal.bean.DealDTO;
import deal.bean.DealPaging;

public interface DealService {

	public List<DealDTO> getDealList(String pg);

	public DealDTO getDeal(String dealId);

	public DealPaging dealPaging(String pg);
	public DealPaging dealPaging(Map<String, String> map);

	public List<DealDTO> getDealSearchList(Map<String, String> map);

	public void insertDelivery(Map<String, String> map);

	public int getRecentlyAddedDeliveryId();

	public void updateDelivery(Map<String, String> map);

}
