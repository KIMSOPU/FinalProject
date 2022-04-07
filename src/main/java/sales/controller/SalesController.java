package sales.controller;

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

import sales.bean.SalesDTO;
import sales.service.SalesService;

@Controller
@RequestMapping(value = "/*/sales")
public class SalesController {
	
	@Autowired
	private SalesService salesService;
	
	@PostMapping(value = "getSalesHis")
	@ResponseBody
	public List<SalesDTO> getSalesHis() {
		return salesService.getSalesHis();
	}
	
	@PostMapping(value = "getBrandHis")
	@ResponseBody
	public  List<SalesDTO> getBrandHis() {
		
		List<SalesDTO> list = salesService.getBrandHis();
		System.out.println("list: "+list);
		
		return list;
	}
	
	@PostMapping(value = "getLowestPriceSalesDTO")
	@ResponseBody
	public SalesDTO getLowestPriceSalesDTO(@RequestParam String productId) {
		System.out.println("getLowestPriceSalesDTO: " + productId);
		return salesService.getLowestPriceSalesDTO(productId);
	}
	
	@PostMapping(value = "getSalesListBySize")
	@ResponseBody
	public List<SalesDTO> getSalesListBySize(@RequestParam Map<String, String> map) {
		System.out.println("getSalesListBySize: " + map);
		return salesService.getSalesListBySize(map);
	}
	
	
	@GetMapping(value="salesList")
	public String salesList(@RequestParam(required=false, defaultValue="1") String pg,
		      				Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/order/salesList.jsp");
		return "/admin/adminIndex";
	}
	
	// 전체 리스트 가져오기
	@PostMapping(value="getSalesList")
	@ResponseBody
	public Map<String, Object> getSalesList(@RequestParam(required=false, defaultValue="1") String pg) {
		List<SalesDTO> list = salesService.getSalesList(pg);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("salesPaging", salesService.salesPaging(pg));
		
		return map;
	}
	
	@PostMapping(value = "getPurchaseHis")
	@ResponseBody
	public List<SalesDTO> getPurchaseHis() {
		return salesService.getPurchaseHis();
	}
}
