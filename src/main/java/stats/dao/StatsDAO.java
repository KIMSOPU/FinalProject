package stats.dao;

import java.util.List;

import stats.bean.StatsDTO;

public interface StatsDAO {

	public List<StatsDTO> getPriceDataForShop(int productId);

}
