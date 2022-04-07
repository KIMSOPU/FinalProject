package product.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import product.bean.ProductDTO;
import product.bean.ProductPaging;
import product.dao.ProductDAO;


@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ProductPaging productPaging;

	// 상품목록
	@Override
	public List<ProductDTO> getproductList(String pg) {
		int endNum = Integer.parseInt(pg) * 10;
		int startNum = endNum - 9;
		
		Map<String, Integer> map = new HashedMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return productDAO.getproductList(map);
	}
	
	
	// 상품목록 페이징
	@Override
	public ProductPaging productPaging(String pg) {
		int total = productDAO.getTotalProduct();

		productPaging.setCurrentPage(Integer.parseInt(pg));
		productPaging.setPageBlock(5);
		productPaging.setPageSize(10);
		productPaging.setTotalA(total);
		productPaging.makePagingHTML();
		
		return productPaging;
	}

	// 상품목록 검색
	@Override
	public List<ProductDTO> searchProduct(Map<String, Object> map) {
		int endNum = Integer.parseInt((String) map.get("searchPg")) * 10;
		int startNum = endNum - 9;
		
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return productDAO.searchProduct(map);
	}

	// 상품목록 검색 페이징
	@Override
	public ProductPaging searchProductPaging(Map<String, Object> map) {
		int total = productDAO.getSearchTotalProduct(map);

		productPaging.setCurrentPage(Integer.parseInt((String) map.get("searchPg")));
		productPaging.setPageBlock(5);
		productPaging.setPageSize(10);
		productPaging.setTotalA(total);
		productPaging.makePagingHTML();
		
		return productPaging;
	}

	// 상품등록
	@Override
	public void getProductWrite(Map<String, Object> map) {
		productDAO.getProductWrite(map);
	}
	
	// 상품 재고
	@Override
	public List<Object> getProductStock(Map<String, Object> map) {
		return productDAO.getProductStock(map);
	}
	
	// 재고 수정
	@Override
	public void updateStock(Map<String, String> map) {		
		List<String> list = new ArrayList<>();
		List<String> list2 = new ArrayList<>();
		List<String> list3 = new ArrayList<>();
		
		List<Map<String, String>> end = new ArrayList<>();
		map.forEach((k, v) -> list.add(v));
		
		String modelId = list.get(14);
		String productId = list.get(15);
		
		for(int i=0; i<14; i++) {
			list2.add(list.get(i));
		}
		
		for(int i=16; i<30; i++) {
			list3.add(list.get(i));
		}
		
		for(int i=0; i < 14; i++) {
			Integer i2 = Integer.parseInt(list2.get(i)) - Integer.parseInt(list3.get(i));
				if(i2 >= 1 && i2 != 0) {		
						Map<String, String> map2 = new HashedMap<String, String>();
						map2.put("productSize", i*5+225+"");
						map2.put("count", i2+"");
						System.out.println(map2);
						
						end.add(map2);
				}else if(i2 <= 1 && i2 != 0){
						Map<String, String> map2 = new HashedMap<String, String>();
						map2.put("productSize", i*5+225+"");
						map2.put("count", i2+"");
						System.out.println(map2);
						
						end.add(map2);
				}
		}
		productDAO.updateStock(end, modelId, productId);
	}
	
	// 삼풍삭제
	@Override
	public void deleteProduct(String modelId) {
		productDAO.deleteProduct(modelId);		
	}
	
	// 상품수정을 위한 상품정보
	@Override
	public List<ProductDTO> getProductInfo(String modelId) {
		return productDAO.getProductInfo(modelId);
	}
	
	// 상품수정
	@Override
	public void productUpdate(Map<String, Object> map) {
		productDAO.productUpdate(map);
	}
	
	@Override
	public List<ProductDTO> getProductListForIndex(String pg) {
		int endNum = Integer.parseInt(pg) * 4;
		int startNum = endNum - 3;
		
		Map<String, Integer> map = new HashedMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return productDAO.getProductListForIndex(map);
	}

	@Override
	public Map<String, Object> getProductListForSearch() {
		Map<String, Object> map = new HashedMap<String, Object>();
		map.put("searchList", productDAO.getProductListForSearch());
		map.put("RealNameList", productDAO.getProductListForSearch2());
		return map;
	}
		
}
