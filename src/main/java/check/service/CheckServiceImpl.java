package check.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import check.bean.CheckDTO;
import check.bean.CheckPaging;
import check.dao.CheckDAO;


@Service
public class CheckServiceImpl implements CheckService{
	@Autowired
	private CheckDAO checkDAO;

	
	@Autowired
	private CheckPaging checkPaging;
	
	@Override
	public List<CheckDTO> getCheckForm(String pg) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		//map.put("pg", Integer.parseInt(pg));
		
		int endNum = Integer.parseInt(pg) * 10;
		int startNum = endNum - 9;
		
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		List<CheckDTO> list = checkDAO.getCheckForm(map);
		System.out.println("checkService list: "+list);
		return list;
	}

	@Override
	public List<Object> searchBtnForm(Map<String, Object> map) {
		 return checkDAO.searchBtnForm(map);

	}

	@Override
	public CheckPaging checkPaging(String pg) {
		int total = checkDAO.getTotalCheck();

		checkPaging.setCurrentPage(Integer.parseInt(pg));
		checkPaging.setPageBlock(5);
		checkPaging.setPageSize(10);
		checkPaging.setTotalA(total);
		checkPaging.makePagingHTML();
		
		return checkPaging;
	}

	@Override
	public CheckDTO getCheckChgForm(String checkId) {
		return checkDAO.getCheckChgForm(checkId);

	}

	@Override
	public void situationChg(Map<String, Object> map) {
		checkDAO.situationChg(map);
		
	}

	@Override
	public void resultChg(Map<String, Object> map) {
		checkDAO.resultChg(map);
		
	}

}
