package stock.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import stock.bean.StockDTO;
import stock.dao.StockDAO;

@Service
public class StockServiceImpl implements StockService {

	@Autowired
	private StockDAO stockDAO;
	
	
	@Override
	public List<StockDTO> getStockForm(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("pg", Integer.parseInt(pg));
		
		List<StockDTO> list = stockDAO.getStockForm(map);
		return list;
	}
	
	@Override
	public List<StockDTO> getStockListBySize(Map<String, String> map) {
		return stockDAO.getStockListBySize(map);
	}

}
