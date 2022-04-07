package serviceCenter.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.CookieValue;

import serviceCenter.bean.AnnouncementBoardDTO;
import serviceCenter.bean.BoardPaging;
import serviceCenter.bean.QnaTableDTO;

public interface ServiceCenterService {
	public BoardPaging boardPaging(String pg, String tableName);

	public List<AnnouncementBoardDTO> getAnnouncementList(String pg);
	public AnnouncementBoardDTO getAnnouncementDetail(String announcementId, @CookieValue(name = "view", required=false) String cookie);

	public List<QnaTableDTO> getQnaList(String pg);
	public String checkPwd(String qnaId, String qnaPwd);
	public QnaTableDTO getQnaDetail(String qnaId);
	public QnaTableDTO getQnaReply(String qnaId);
	public void qnaRegister(Map<String, Object> map);
	public void qnaDelete(String qnaId);
	public void qnaUpdate(Map<String, Object> map);
	
}
