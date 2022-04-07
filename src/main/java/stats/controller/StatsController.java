package stats.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import stats.bean.StatsDTO;
import stats.service.StatsService;

@Controller
@RequestMapping(value="/*/stats")
public class StatsController {
	@Autowired
	private StatsService statsService;
	
	
	@GetMapping(value="statsView")
	public String statsView(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/stats/statsView.jsp");
//		return "/WEB-INF/adminViews/stats/statsView";
		return "/admin/adminIndex";
	}
	
//	@GetMapping(value="statsView")
//	public Map<String, String> statsView() {
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("display", "/WEB-INF/adminViews/stats/statsView.jsp");
//		return map;
//	}
	
	@PostMapping(value="getStatsData")
	@ResponseBody
	public void getStatsData() {
		
	}
	
	@PostMapping(value="getPriceDataForShop")
	@ResponseBody
	public List<StatsDTO> getPriceDataForShop(@RequestParam int productId) {
		System.out.println(productId);
		return statsService.getPriceDataForShop(productId);
	}
}
