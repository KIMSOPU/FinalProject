package purchase.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import purchase.bean.PurchaseDTO;


@Repository
@Transactional
public class PurchaseDAOMybatis implements PurchaseDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PurchaseDTO> getPurchaseList(Map<String, Integer> map) {
		return sqlSession.selectList("purchaseSQL.getPurchaseList", map);
	} 

	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("purchaseSQL.getTotalCount");
	}
	
	@Override
	public List<PurchaseDTO> getPurchaseSearchList(Map<String, String> map) {
		return sqlSession.selectList("purchaseSQL.getPurchaseSearchList");
	}
	
}
