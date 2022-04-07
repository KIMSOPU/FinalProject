package sales.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sales.bean.SalesDTO;
import sales.bean.SalesPaging;
import sales.dao.SalesDAO;

@Service
public class SalesServiceImpl implements SalesService {
	@Autowired
	private SalesDAO salesDAO;
	@Autowired
	private SalesPaging salesPaging;
	
	@Override
	public List<SalesDTO> getSalesHis() {
		return salesDAO.getSalesHis();
	}

	@Override
	public List<SalesDTO> getBrandHis() {
		List<SalesDTO> list = salesDAO.getBrandHis();
		return list;

	}

	@Override
	public SalesDTO getLowestPriceSalesDTO(String productId) {
		return salesDAO.getLowestPriceSalesDTO(productId);
	}
	
	@Override
	public List<SalesDTO> getSalesListBySize(Map<String, String> map) {
		return salesDAO.getSalesListBySize(map);
	}

	@Override
	public List<SalesDTO> getSalesList(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("endNum", Integer.parseInt(pg) * 10);
		map.put("startNum", (Integer.parseInt(pg) * 10) - 9);
		
		List<SalesDTO> list = salesDAO.getSalesList(map);
		return list;
	}

	@Override
	public Object salesPaging(String pg) {
		salesPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		salesPaging.setPageBlock(6);
		salesPaging.setPageSize(10);
		salesPaging.setTotalA(salesDAO.getTotalCount());
		salesPaging.makePagingHTML();
		
		return salesPaging;
	}
	
	@Override
	public List<SalesDTO> getPurchaseHis() {
		return salesDAO.getPurchaseHis();
	}

	


}
