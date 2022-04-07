package content.dao;

import java.util.List;
import java.util.Map;

import content.bean.AnnounceDTO;

public interface ContentDAO {

	public List<AnnounceDTO> getAnnounceList(Map<String, Integer> map);

	public int getTotalAnnounce();

	public void writeAnnounce(AnnounceDTO announceDTO);

	public List<AnnounceDTO> searchAnnounce(Map<String, Object> map);

	public int searchTotalAnnounce(Map<String, Object> map);

	public void deleteAnnounce(String announcementId);

	public void deleteAnnounce(String[] checkBoxArr);

	public AnnounceDTO getUpdateView(String announcementId);

	public void updateAnnounce(AnnounceDTO announceDTO);

}
