package order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import deal.bean.DealDTO;
import order.bean.OrderDTO;
import order.bean.OrderPaging;
import order.dao.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	private OrderDAO orderDAO;	
	@Autowired
	private OrderPaging orderPaging;
	
	@Override
	public List<OrderDTO> getOrderList(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("endNum", Integer.parseInt(pg) * 10);
		map.put("startNum", (Integer.parseInt(pg) * 10) - 9);
		
		List<OrderDTO> list = orderDAO.getOrderList(map);
		return list;
	}
	
	@Override
	public OrderDTO getOrder(String orderId) {
		return orderDAO.getOrder(orderId);
	}
	
	@Override
	public OrderPaging orderPaging(String pg) {
		orderPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		orderPaging.setPageBlock(5);
		orderPaging.setPageSize(10);
		orderPaging.setTotalA(orderDAO.getTotalCount());
		orderPaging.makePagingHTML();
		
		return orderPaging;
	}
	
	@Override
	public OrderPaging orderPaging(Map<String, String> map) {
		return null;
	}
	
	@Override
	public List<OrderDTO> getOrderSearchList(Map<String, String> map) {
		int endNum = Integer.parseInt(map.get("pg")) * 10;
		int startNum = endNum - 9;
		
		map.put("startNum", Integer.toString(startNum));
		map.put("endNum", Integer.toString(endNum));
		
		return orderDAO.getOrderSearchList(map);
	}

	@Override
	public OrderPaging getOrderSearchListPaging(Map<String, String> map) {
		System.out.println("map 확인: " + map);
		int total = orderDAO.OrderSearchListPaging(map);

		orderPaging.setCurrentPage(Integer.parseInt((String) map.get("pg")));
		orderPaging.setPageBlock(6);
		orderPaging.setPageSize(10);
		orderPaging.setTotalA(total);
		orderPaging.makePagingHTML();
		
		return orderPaging;
	}

	@Override
	public OrderDTO getOrderView(String orderId) {
		return orderDAO.getOrderView(orderId);
	}

	@Override
	public OrderDTO updateOrderTracking() {
		return orderDAO.updateOrderTracking();
	}
}
