package purchase.controller;

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

import purchase.bean.PurchaseDTO;
import purchase.service.PurchaseService;

@Controller
@RequestMapping(value="/adminViews/order")
public class PurchaseController {

	@Autowired
	private PurchaseService purchaseService;
	
	@GetMapping(value="purchaseList")
	public String purchaseList(@RequestParam(required=false, defaultValue="1") String pg,
		      				Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/order/purchaseList.jsp");
		return "/admin/adminIndex";
	}
	
	// 전체 리스트 가져오기
	@PostMapping(value="getPurchaseList")
	@ResponseBody
	public Map<String, Object> getPurchaseList(@RequestParam(required=false, defaultValue="1") String pg) {
		List<PurchaseDTO> list = purchaseService.getPurchaseList(pg);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("purchasePaging", purchaseService.purchasePaging(pg));
		
		return map;
	}
	
	@PostMapping(value="getPurchaseSearchList")
	@ResponseBody
	public List<PurchaseDTO> getPurchaseSearchList(@RequestParam Map<String, String> map) {
		System.out.println("getPurchaseSearchList: "+map);
		return purchaseService.getPurchaseSearchList(map);
	}
}
