package stats.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import stats.bean.StatsDTO;
import stats.dao.StatsDAO;

@Service
public class StatsServiceImpl implements StatsService {
	@Autowired
	private StatsDAO statsDAO;
	
	@Override
	public List<StatsDTO> getPriceDataForShop(int productId) {
		return statsDAO.getPriceDataForShop(productId);
	}

}
