package order.service;

import java.util.List;
import java.util.Map;

import order.bean.OrderDTO;
import order.bean.OrderPaging;

public interface OrderService {

	public List<OrderDTO> getOrderList(String pg);
	
	public OrderDTO getOrder(String orderId);

	public OrderPaging orderPaging(String pg);
	
	public OrderPaging orderPaging(Map<String, String> map);	
	
	public List<OrderDTO> getOrderSearchList(Map<String, String> map);

	public OrderPaging getOrderSearchListPaging(Map<String, String> map);

	public OrderDTO getOrderView(String orderId);

	public OrderDTO updateOrderTracking();


}
