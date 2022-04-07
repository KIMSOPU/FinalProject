package product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import product.bean.ProductDTO;
import product.bean.ProductPaging;

@Controller
@Component
@RequestMapping(value="/*/product")
public class ProductController {
	@Autowired
	private product.service.ProductService productService;
	
	// 상품목록 기본 폼
	@GetMapping(value = "productList")
	public String productList(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/product/productList.jsp");
		return "/admin/adminIndex";
	}
	
	// 상품목록 리스트
	@PostMapping(value = "getproductList")
	@ResponseBody
	public Map<String, Object> getproductList(@RequestParam(required = false, defaultValue = "1") String pg) {
		Map<String, Object> map = new HashedMap<String, Object>();		
		
		// 리스트 뽑아오기
		List<ProductDTO> list = productService.getproductList(pg);
		// 페이징 처리하기
		ProductPaging productPaging = productService.productPaging(pg);

		map.put("productPaging", productPaging);
		map.put("list", list);
		return map;
	}
	
	// 상품등록 기본 폼
	@GetMapping(value = "productWrite")
	public String productWrite(Model model) {
		model.addAttribute("display", "/WEB-INF/adminViews/product/productWrite.jsp");
		return "/admin/adminIndex";
	}
	
	// 상품등록
	@PostMapping(value = "getProductWrite")
	@ResponseBody
	public void getProductWrite(@RequestParam Map<String, Object> map, @RequestParam("img[]") List<MultipartFile> list) {
		// 실제폴더에 업로드
		String filePath = "C:\\shoeCream_images\\images\\productImg";  
		String fileName; // 실제이름
		File file; // 파일 생성
		
		int count=0;
		for (MultipartFile img : list) {
			fileName = img.getOriginalFilename();
			file = new File(filePath, fileName);
			
			// 파일 이동
			try {
				if(!file.exists()) {
					img.transferTo(file);
				}				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			count++;
			map.put("img" + count, fileName);

		} // end for
		System.out.println(map);
		productService.getProductWrite(map);	
	}
	
	// 재고량 확인 기본 폼
	@GetMapping(value = "stockView")
	public String stockView(Model model, @RequestParam(required = false, defaultValue = "1") String pg, @RequestParam String modelId, @RequestParam String productId) {
		model.addAttribute("productId", productId);
		model.addAttribute("modelId", modelId);
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/stock/adminStockView.jsp");
		return "/admin/adminIndex";
	}

	// 상품재고 불러오기
	@PostMapping(value = "getProductStock")
	@ResponseBody
	public List<Object> getProductStock(@RequestParam Map<String, Object> map) {
		List<Object> list =  productService.getProductStock(map);	
		return list;
	}
	
	// 재고 등록
	@PostMapping(value = "updateStock")
	@ResponseBody
	public void updateStock(@RequestParam Map<String, String> map) {
		productService.updateStock(map);
	}
	
	// 상품 검색
	@PostMapping(value = "searchProduct")
	@ResponseBody
	public Map<String, Object> searchProduct(@RequestParam Map<String, Object> map){		
		//페이징처리
		ProductPaging productPaging = productService.searchProductPaging(map);
		// 검색 결과 리스트
		List<ProductDTO> list = productService.searchProduct(map);

		// data로 보낼 결과물
		Map<String, Object> map2 = new HashMap<String, Object>();
		// 검색 결과 리스트
		map2.put("list", list);
		// 페이징처리의 결과 값
		map2.put("productPaging", productPaging);
		return map2;
	}
	
	// 상품수정 폼
	@GetMapping(value = "updateProduct")
	public String updateProduct(@RequestParam String modelId,@RequestParam String pg, Model model) {		
		
		model.addAttribute("pg", pg);
		model.addAttribute("modelId", modelId);
		model.addAttribute("display", "/WEB-INF/adminViews/product/productUpdate.jsp");
		return "/admin/adminIndex";
	}
	
	// 상품수정/삭제을 위한 상품정보
	@PostMapping(value = "getProductInfo")
	@ResponseBody
	public Map<String, Object> getProductInfo(@RequestParam String modelId){	
		List<ProductDTO> list = productService.getProductInfo(modelId);
		List<String> list2 = new ArrayList<String>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		list2.add(list.get(0).getImg1());
		list2.add(list.get(0).getImg2());
		list2.add(list.get(0).getImg3());
		
		for(ProductDTO productDTO : list) {
			map.put("productDTO", productDTO);
		}
				
		map.put("list", list2);
		
		return map;
	}
	
	// 상품수정
	@PostMapping(value = "productUpdate")
	@ResponseBody
	public void productUpdate(@RequestParam Map<String, Object> map, @RequestParam(name="img2[]", required = false) List<String> img2, @RequestParam("img[]") List<MultipartFile> list){			
		System.out.println(map);
		String filePath = "C:\\shoeCream_images\\images\\productImg";  
		String fileName; // 실제이름
		File file; // 파일 생성

		// 실 파일 입력
		if(img2 != null) {
			int count=0;
			
			for(int i=0; i< img2.size(); i++) {					
				String img3 = img2.get(i);					
				fileName = img3;
				
				count++;
				map.put("img" + count, img3);				
			}
		
			if(list != null) {
				
				for(int i=0; i<list.size(); i++) {
					MultipartFile img = list.get(i);
					
					fileName = img.getOriginalFilename();
					file = new File(filePath, fileName);
					
					// 파일 이동
					try {
						if(!file.exists()) {
							img.transferTo(file);
						}						
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					count++;
					map.put("img" + count, fileName);
					
				}
			}						
		}else {	
			    int count=0;
				for(int i=0; i<list.size(); i++) {
				
				MultipartFile img = list.get(i);
				
				fileName = img.getOriginalFilename();
				file = new File(filePath, fileName);
	
				// 파일 이동
				try {
					if(!file.exists()) {
						img.transferTo(file);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				count++;
				map.put("img" + count, fileName);
				
			}
		}
			productService.productUpdate(map);
		}
	
	// 상품삭제
	@GetMapping(value = "deleteProduct")
	public String deleteProduct(@RequestParam String modelId, Model model) {
		
		String filePath = "C:\\shoeCream_images\\images\\productImg";  
		String fileName; // 실제이름
		File file; // 파일 생성

		Map<String, Object> map = this.getProductInfo(modelId);
		List<String> list = (List<String>) map.get("list");
		System.out.println("삭제" + list);

			
		// 원 사진 파일 삭제	
		for (int i=0; i<list.size() ;i++) {
			if(list.get(i) != null) {
				fileName = list.get(i);
				file = new File(filePath, fileName);			
					if(file.exists()){ 
						file.delete();
					}
			}
			
		}
					
		productService.deleteProduct(modelId);
		
		model.addAttribute("display", "/WEB-INF/adminViews/product/productList.jsp");
		return "/admin/adminIndex";
	}
	
	// 체크박스 상품 삭제
	@PostMapping(value = "deleteProductList")
	@ResponseBody
	public String deleteProductList(@RequestParam(value="checkBoxArr[]") String[] checkBoxArr, Model model) {
		
		String filePath = "C:\\shoeCream_images\\images\\productImg"; 
		String fileName; // 실제이름
		File file; // 파일 생성

		for(String modelId: checkBoxArr) {
			Map<String, Object> map = this.getProductInfo(modelId);
			List<String> list = (List<String>) map.get("list");
			
			// 원 사진 파일 삭제	
			for (int i=0; i<list.size() ;i++) {
				if(list.get(i) != null) {
					fileName = list.get(i);
					file = new File(filePath, fileName);			
						if(file.exists()){ 
							file.delete();
						}
				}
				
			}
			
			productService.deleteProduct(modelId);
		}
				
		model.addAttribute("display", "/WEB-INF/adminViews/product/productList.jsp");
		return "/admin/adminIndex";
	}

	@PostMapping(value = "getProductListForIndex")
	@ResponseBody
	public List<ProductDTO> getProductListForIndex(@RequestParam(required = false, defaultValue = "1") String pg) {
		return productService.getProductListForIndex(pg);
	}
	
	@PostMapping(value = "getProductListForSearch")
	@ResponseBody
	public Map<String, Object> getProductListForSearch() {
		return productService.getProductListForSearch();
	}
}
