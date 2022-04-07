package stock.controller;

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

import stock.bean.StockDTO;
import stock.service.StockService;

@Controller
@RequestMapping(value = "/*/stock")
public class StockController {
	
	@Autowired
	private StockService stockService;
	
	@GetMapping(value = "stockForm")
	public String stockForm(@RequestParam Map<String, String> map, Model model) {
		model.addAttribute("map", map);
		model.addAttribute("display", "/WEB-INF/adminViews/stock/stockForm.jsp");
		return "/admin/adminIndex";
	}
	
	
	@GetMapping(value = "stockView")
	public String stockView(@RequestParam Map<String, String> map, Model model) {
		model.addAttribute("map", map);
		model.addAttribute("display", "/WEB-INF/adminViews/stock/stockView.jsp");
		return "/admin/adminIndex";
	}
	
	
	@GetMapping(value = "inspectionView")
	public String inspectionView(@RequestParam Map<String, String> map, Model model) {
		model.addAttribute("map", map);
		model.addAttribute("display", "/WEB-INF/adminViews/stock/inspectionView.jsp");
		return "/admin/adminIndex";
	}
	
	
	@PostMapping(value="getStockForm")
	@ResponseBody
	public List<StockDTO> getStockForm(@RequestParam(required=false, defaultValue="1") String pg) {
		List<StockDTO> list = stockService.getStockForm(pg);
		System.out.println("list: "+list);
		return list;
	}
	
	@PostMapping(value = "getStockListBySize")
	@ResponseBody
	public List<StockDTO> getStockListBySize(@RequestParam Map<String, String> map) {
		System.out.println(map);
		return stockService.getStockListBySize(map);
	}
	

}
