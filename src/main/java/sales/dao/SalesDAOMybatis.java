package sales.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import sales.bean.SalesDTO;

@Repository
@Transactional
public class SalesDAOMybatis implements SalesDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SalesDTO> getSalesHis() {
		return sqlSession.selectList("salesSQL.getSalesHis");
	}

	@Override
	public List<SalesDTO> getBrandHis() {
		return sqlSession.selectList("salesSQL.getBrandHis");

	}
	
	@Override
	public SalesDTO getLowestPriceSalesDTO(String productId) {
		return sqlSession.selectOne("salesSQL.getLowestPriceSalesDTO", Integer.parseInt(productId));
	}
	
	@Override
	public List<SalesDTO> getSalesListBySize(Map<String, String> map) {
		return sqlSession.selectList("salesSQL.getSalesListBySize", map);
	}
	
	@Override
	public List<SalesDTO> getSalesList(Map<String, Integer> map) {
		return sqlSession.selectList("salesSQL.getSalesList", map);
	}

	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("salesSQL.getTotalCount");
	}
	
	@Override
	public List<SalesDTO> getPurchaseHis() {
		return sqlSession.selectList("salesSQL.getPurchaseHis");
	}

}
