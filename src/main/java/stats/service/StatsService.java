package stats.service;

import java.util.List;

import stats.bean.StatsDTO;

public interface StatsService {

	public List<StatsDTO> getPriceDataForShop(int productId);

}
