package content.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import content.bean.AnnounceDTO;
import content.bean.ContentPaging;
import content.dao.ContentDAO;

@Service
public class ContentServiceImpl implements ContentService {
	@Autowired
	private ContentDAO contentDAO;
	@Autowired
	private ContentPaging contentPaging;
	
	// 리스트 목록 뽑아오기(글 갯수를 위한 startNum / endNum)
	@Override
	public List<AnnounceDTO> getAnnounceList(String pg) {		
		int endNum = Integer.parseInt(pg) * 10;
		int startNum = endNum - 9;
		
		Map<String, Integer> map = new HashedMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return contentDAO.getAnnounceList(map);
	}

	// paging 처리
	@Override
	public ContentPaging announcePaging(String pg) {
		int total = contentDAO.getTotalAnnounce();

		contentPaging.setCurrentPage(Integer.parseInt(pg));
		contentPaging.setPageBlock(5);
		contentPaging.setPageSize(10);
		contentPaging.setTotalA(total);
		contentPaging.makePagingHTML();
		
		return contentPaging;
	}

	// 공지사항 작성
	@Override
	public void writeAnnounce(AnnounceDTO announceDTO) {		
		contentDAO.writeAnnounce(announceDTO);
	}
	
	// 공지사항 검색 결과
	@Override
	public List<AnnounceDTO> searchAnnounce(Map<String, Object> map) {
		int endNum = Integer.parseInt((String) map.get("searchPg")) * 10;
		int startNum = endNum - 9;
		
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return contentDAO.searchAnnounce(map);
	}
	
	// 공지사항 검색 결과 페이징처리
	@Override
	public ContentPaging serachAnnouncePaging(Map<String, Object> map) {
		
		int total = contentDAO.searchTotalAnnounce(map);

		contentPaging.setCurrentPage(Integer.parseInt((String) map.get("searchPg")));
		contentPaging.setPageBlock(5);
		contentPaging.setPageSize(10);
		contentPaging.setTotalA(total);
		contentPaging.makePagingHTML();
		
		return contentPaging;
	}

	// 공지사항 삭제
	@Override
	public void deleteAnnounce(String announcementId) {
		contentDAO.deleteAnnounce(announcementId);
	}
	
	// 체크표된 모든 공지사항 삭제
	@Override
	public void deleteAllAnnounce(String[] checkBoxArr) {
		contentDAO.deleteAnnounce(checkBoxArr);
	}
	
	// 수정시 기본 글 가져오기
	@Override
	public AnnounceDTO getUpdateView(String announcementId) {
		return contentDAO.getUpdateView(announcementId);
	}
	
	// 공지사항 수정
	@Override
	public void updateAnnounce(AnnounceDTO announceDTO) {
		contentDAO.updateAnnounce(announceDTO);
	}
}
