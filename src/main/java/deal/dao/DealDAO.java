package deal.dao;

import java.util.List;
import java.util.Map;

import deal.bean.DealDTO;

public interface DealDAO {

	public List<DealDTO> getDealList(Map<String, Integer> map);

	public DealDTO getDeal(String dealId);

	public int getTotalCount();

	public List<DealDTO> getDealSearchList(Map<String, String> map);

	public int getTotalCountForSearch();

	public void insertDelivery(Map<String, String> map);

	public int getRecentlyAddedDeliveryId();

	public void updateDelivery(Map<String, String> map);


}
