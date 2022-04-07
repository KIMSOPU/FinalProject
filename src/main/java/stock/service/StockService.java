package stock.service;

import java.util.List;
import java.util.Map;

import stock.bean.StockDTO;

public interface StockService {

	public List<StockDTO> getStockForm(String pg);

	public List<StockDTO> getStockListBySize(Map<String, String> map);

}
