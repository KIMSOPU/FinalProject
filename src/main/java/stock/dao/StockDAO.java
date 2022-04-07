package stock.dao;

import java.util.List;
import java.util.Map;

import stock.bean.StockDTO;

public interface StockDAO {

	public List<StockDTO> getStockForm(Map<String, Integer> map);

	public List<StockDTO> getStockListBySize(Map<String, String> map);

}
