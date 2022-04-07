package event.service;

import java.util.List;
import java.util.Map;

import event.bean.EventDTO;
import event.bean.EventPaging;

public interface EventService {

	public List<EventDTO> searchEvent(Map<String, Object> map);

	public EventPaging searchEventPaging(Map<String, Object> map);

	public List<EventDTO> getEventList(String pg, String option);

	public EventPaging eventPaging(String pg, String option);
	
	public EventPaging eventPaging(String pg);

	public void writeEvent(Map<String, Object> map);

	public EventDTO getEventInfo(String eventId);

	public void eventUpdate(Map<String, Object> map);

	public void deleteEvent(String eventId);

	public void deletEventList(String eventId);
}
