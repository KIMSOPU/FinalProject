package sales.service;

import java.util.List;
import java.util.Map;

import sales.bean.SalesDTO;

public interface SalesService {

	public List<SalesDTO> getSalesHis();

	public List<SalesDTO> getBrandHis(); 

	public SalesDTO getLowestPriceSalesDTO(String productId);

	public List<SalesDTO> getSalesListBySize(Map<String, String> map); 
	
	public List<SalesDTO> getSalesList(String pg);

	public Object salesPaging(String pg); 

	public List<SalesDTO> getPurchaseHis(); 


}
