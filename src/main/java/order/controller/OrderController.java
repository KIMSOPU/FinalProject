package order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import deal.bean.DealDTO;
import order.bean.OrderDTO;
import order.bean.OrderPaging;
import order.service.OrderService;

@Controller
@RequestMapping(value="/adminViews/order")
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	@GetMapping(value="orderList")
	public String orderList(@RequestParam(required=false, defaultValue="1") String pg,
		      				Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/order/orderList.jsp");
		return "/admin/adminIndex";
	}
	
	@PostMapping(value="getOrderList")
	@ResponseBody
	public Map<String, Object> getOrderList(@RequestParam(required=false, defaultValue="1") String pg) {
		List<OrderDTO> list = orderService.getOrderList(pg);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("orderPaging", orderService.orderPaging(pg));
		
		return map;
	}
	
	@PostMapping(value="getOrder")
	@ResponseBody
	public OrderDTO getOrder(@RequestParam String orderId) {
		return orderService.getOrder(orderId);
	}
	
	@PostMapping(value="getOrderSearchList")
	@ResponseBody
	public Map<String, Object> getOrderSearchList(@RequestParam Map<String, String> map, Model model) { //searchOption, keyword, pg(id=searchPg)
		System.out.println(map.get("searchOption")+", "+map.get("keyword")+", "+map.get("pg"));
		OrderPaging orderPaging = orderService.getOrderSearchListPaging(map);
		List<OrderDTO> list = orderService.getOrderSearchList(map);

		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("list", list);
		tempMap.put("orderPaging", orderPaging );
		
		return tempMap;
	}
	
	
	@GetMapping(value="orderView")
	public String orderView(@RequestParam String orderId, Model model) {
		model.addAttribute("orderId", orderId);
		model.addAttribute("display", "/WEB-INF/adminViews/order/orderView.jsp");
		return "/admin/adminIndex";
	}
	
	@PostMapping(value="getOrderView")
	@ResponseBody
	public OrderDTO getOrderView(@RequestParam String orderId) {
		return orderService.getOrderView(orderId);
	}

	
	@PostMapping(value="updateOrderTracking")
	@ResponseBody
	public OrderDTO updateOrderTracking() {
		return orderService.updateOrderTracking();
	}
	
	
}	
