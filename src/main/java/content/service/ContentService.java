package content.service;

import java.util.List;
import java.util.Map;

import content.bean.AnnounceDTO;
import content.bean.ContentPaging;

public interface ContentService {

	public List<AnnounceDTO> getAnnounceList(String pg);

	public ContentPaging announcePaging(String pg);

	public void writeAnnounce(AnnounceDTO announceDTO);

	public List<AnnounceDTO> searchAnnounce(Map<String, Object> map);

	public ContentPaging serachAnnouncePaging(Map<String, Object> map);

	public void deleteAnnounce(String announcementId);

	public void deleteAllAnnounce(String[] checkBoxArr);

	public AnnounceDTO getUpdateView(String announcementId);

	public void updateAnnounce(AnnounceDTO announceDTO);


}
