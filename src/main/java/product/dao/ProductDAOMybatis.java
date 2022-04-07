package product.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import product.bean.ProductDTO;
import stock.bean.StockDTO;

@Repository
public class ProductDAOMybatis implements ProductDAO {
	@Autowired
	private SqlSession sqlSession;
	
	// 상품목록
	@Override
	public List<ProductDTO> getproductList(Map<String, Integer> map) {
		return sqlSession.selectList("productSQL.getproductList", map);
	}

	// 상품목록 페이징
	@Override
	public int getTotalProduct() {
		return sqlSession.selectOne("productSQL.getTotalProduct");
	}

	// 상품목록 검색
	@Override
	public List<ProductDTO> searchProduct(Map<String, Object> map) {
		return sqlSession.selectList("productSQL.searchProduct", map);
	}

	// 상품 목록 페이징
	@Override
	public int getSearchTotalProduct(Map<String, Object> map) {
		return sqlSession.selectOne("productSQL.getSearchTotalProduct", map);
	}
	
	// 상품등록
	@Override
	public void getProductWrite(Map<String, Object> map) {
		sqlSession.insert("productSQL.getProductWrite", map);
		
		sqlSession.insert("productSQL.priceWrite", sqlSession.selectOne("productSQL.getProductM", map.get("modelId")));
	}

	// 상품재고량
	@Override
	public List<Object> getProductStock(Map<String, Object> map) {
		List<Integer> sizeList = new ArrayList<>();
		List<Object> list=new ArrayList<>();
		
		for(int i = 0; i < 14; i++) {
			sizeList.add(Integer.parseInt((String) map.get(i*5+225+"")));
		}
		
		map.put("sizeList", sizeList);
		List<StockDTO> stockList = sqlSession.selectList("productSQL.getProductStock", (String) map.get("modelId"));
		
		int count = 0;
		for(StockDTO stockDTO : stockList) {
			for(int i = 0; i < sizeList.size(); i++) {
				if(sizeList.get(i) == stockDTO.getProductSize()) {
					count++;		
					Map<String, String> map3 = new HashMap<String, String>();
					map3.put("productSize", stockDTO.getProductSize()+""); 
					map3.put("count", count+"");
					list.add(map3);
				}				
			}	
			count = 0;
		}
		
		return list;
	}
	
	// 재고등록
	@Override
	public void updateStock(List<Map<String, String>> end, String modelId, String productId) {	
		// 상품테이블 등록
		ProductDTO product  = sqlSession.selectOne("productSQL.getProductById", Integer.parseInt(productId));
		
		// 재고테이블 등록
		for(Map<String, String> map: end) {
			map.put("productId", productId);
			if(!map.get("count").contains("-")) {
				for(int i=0; i < Integer.parseInt((String) map.get("count")); i++) {
					// 재고
					sqlSession.insert("stockSQL.insertStock", map);
					// 상품
					sqlSession.insert("productSQL.getProductWrite2", product);
				}
			}else if(map.get("count").contains("-")) {				
				map.put("productId", productId);
				List<StockDTO> stockList = sqlSession.selectList("stockSQL.selectStock", map);

				for(int i=0; i < Integer.parseInt((String) map.get("count").replace("-", "")); i++) {					
					// 재고 삭제
					sqlSession.delete("stockSQL.deleteStock", stockList.get(i).getStockId());
					// 상품 상품아이디중에 재고번호가 일치하는 수 만큼 삭제
					sqlSession.delete("productSQL.deleteStock2", stockList.get(i).getStockId());
				}
			}
				
		}
		
	}
	
	// 상품삭제
	@Override
	public void deleteProduct(String modelId) {
		sqlSession.delete("productSQL.deleteProduct", modelId);
	}
	
	// 상품수정을 위한 특정 상품의 정보
	@Override
	public List<ProductDTO> getProductInfo(String modelId) {
		return sqlSession.selectList("productSQL.getProductInfo", modelId);
	}
	
	// 상품수정
	@Override
	public void productUpdate(Map<String, Object> map) {
		System.out.println(map);
		sqlSession.update("productSQL.productUpdate", map);
	}
	
	@Override
	public ProductDTO getProductById(int productId) {
		return sqlSession.selectOne("productSQL.getProductById", productId);
	}
	
	@Override
	public List<ProductDTO> getProductListForIndex(Map<String, Integer> map) {
		return sqlSession.selectList("productSQL.getProductListForIndex", map);
	}

	@Override
	public List<ProductDTO> getSearchResult(String keyword) {
		return sqlSession.selectList("productSQL.getSearchResult", keyword);
	}

	@Override
	public List<ProductDTO> getProductListForSearch() {
		return sqlSession.selectList("productSQL.getProductListForSearch");
	}
	
	@Override
	public List<ProductDTO> getProductListForSearch2() {
		return sqlSession.selectList("productSQL.getProductListForSearch2");
	}
	
}
