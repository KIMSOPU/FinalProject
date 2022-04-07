package stock.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import stock.bean.StockDTO;

@Repository
@Transactional
public class StockDAOMybatis implements StockDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<StockDTO> getStockForm(Map<String, Integer> map) {
		return sqlSession.selectList("stockSQL.getStockForm", map);
	}
	
	@Override
	public List<StockDTO> getStockListBySize(Map<String, String> map) {
		return sqlSession.selectList("stockSQL.getStockListBySize", map);
	}

}
