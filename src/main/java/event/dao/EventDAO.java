package event.dao;

import java.util.List;
import java.util.Map;

import event.bean.EventDTO;

public interface EventDAO {

	public List<EventDTO> getEventList(Map<String, Object> map);

	public int getTotalEvent(Map<String, Object> map);

	public List<EventDTO> searchEvent(Map<String, Object> map);

	public int searchEventPaging(Map<String, Object> map);
	
	public void writeEvent(Map<String, Object> map);
	
	public EventDTO getEventInfo(String eventId);

	public void eventUpdate(Map<String, Object> map);

	public void deleteEvent(String eventId);

}
