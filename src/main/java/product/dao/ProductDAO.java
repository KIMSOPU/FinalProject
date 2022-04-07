package product.dao;

import java.util.List;
import java.util.Map;

import product.bean.ProductDTO;

public interface ProductDAO {

	public List<ProductDTO> getproductList(Map<String, Integer> map);

	public int getTotalProduct();

	public List<ProductDTO> searchProduct(Map<String, Object> map);

	public int getSearchTotalProduct(Map<String, Object> map);

	public List<Object> getProductStock(Map<String, Object> map);
	
	public void updateStock(List<Map<String, String>> end, String modelId, String productId);

	public void getProductWrite(Map<String, Object> map);

	public void deleteProduct(String modelId);

	public List<ProductDTO> getProductInfo(String modelId);

	public void productUpdate(Map<String, Object> map);

	public ProductDTO getProductById(int productId);
	
	public List<ProductDTO> getProductListForIndex(Map<String, Integer> map);

	public List<ProductDTO> getSearchResult(String keyword);

	public List<ProductDTO> getProductListForSearch();
	
	public List<ProductDTO> getProductListForSearch2();

}
