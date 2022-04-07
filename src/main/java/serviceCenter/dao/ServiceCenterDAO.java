package serviceCenter.dao;

import java.util.List;
import java.util.Map;

import serviceCenter.bean.AnnouncementBoardDTO;
import serviceCenter.bean.QnaTableDTO;

public interface ServiceCenterDAO {

	public int getTotalDB(String tableName);

	public List<AnnouncementBoardDTO> getAnnouncementList(Map<String, Integer> map);
	public AnnouncementBoardDTO getAnnouncementDetail(String announcementId);
	public void hit(String announcementId);

	public List<QnaTableDTO> getQnaList(Map<String, Integer> map);
	public QnaTableDTO checkPwd(Map<String, Object> map);
	public QnaTableDTO getQnaDetail(String qnaId);
	public QnaTableDTO getQnaReply(String qnaId);
	public void qnaRegister(Map<String, Object> map);
	public void qnaDelete(String qnaId);
	public void qnaUpdate(Map<String, Object> map);

}
