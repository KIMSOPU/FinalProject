package order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import deal.bean.DealDTO;
import order.bean.OrderDTO;

@Repository
@Transactional
public class OrderDAOMybatis implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> getOrderList(Map<String, Integer> map) {
		return sqlSession.selectList("orderSQL.getOrderList", map);
	}
	
	@Override
	public OrderDTO getOrder(String orderId) {
		return sqlSession.selectOne("orderSQL.getOrder", Integer.parseInt(orderId));
	}
	
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("orderSQL.getTotalCount");
	}
	
	@Override
	public List<OrderDTO> getOrderSearchList(Map<String, String> map) {
		return sqlSession.selectList("orderSQL.getOrderSearchList", map);
	}

	

	@Override
	public int OrderSearchListPaging(Map<String, String> map) {
		return sqlSession.selectOne("orderSQL.OrderSearchListPaging", map);

	}

	@Override
	public OrderDTO getOrderView(String orderId) {
		return sqlSession.selectOne("orderSQL.getOrderView", Integer.parseInt(orderId));

	}

	@Override
	public OrderDTO updateOrderTracking() {
		return sqlSession.selectOne("orderSQL.updateOrderTracking");
	}

	
	
//	@Override
//	public List<OrderDTO2> convertOrderDTO(OrderDTO o) {
//		return sqlSession.selectList("orderSQL.converyOrderDTO", o);
//	}
}
