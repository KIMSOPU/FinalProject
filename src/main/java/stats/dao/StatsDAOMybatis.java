package stats.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import stats.bean.StatsDTO;

@Repository
public class StatsDAOMybatis implements StatsDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<StatsDTO> getPriceDataForShop(int productId) {
		return sqlSession.selectList("statsSQL.getPriceDataForShop", productId);
	}

}
