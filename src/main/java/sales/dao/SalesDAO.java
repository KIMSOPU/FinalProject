package sales.dao;

import java.util.List;
import java.util.Map;

import sales.bean.SalesDTO;

public interface SalesDAO {
	
	public List<SalesDTO> getSalesHis();

	public List<SalesDTO> getBrandHis();

	public SalesDTO getLowestPriceSalesDTO(String productId);

	public List<SalesDTO> getSalesListBySize(Map<String, String> map);
	
	public List<SalesDTO> getSalesList(Map<String, Integer> map);

	public int getTotalCount();

	public List<SalesDTO> getPurchaseHis();

}
