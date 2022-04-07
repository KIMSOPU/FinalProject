package event.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import event.bean.EventDTO;
import event.bean.EventPaging;
import event.service.EventService;

@Controller
@RequestMapping(value="/*/event")
public class EventController {
	@Autowired
	private EventService eventService;
	
	// 이벤트 기본 폼
	@GetMapping(value = "eventList")
	public String eventList(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/event/eventList.jsp");
		return "/admin/adminIndex";
	}
	
	// 이벤트 리스트 / 페이징 처리
	@PostMapping(value = "getEventList")
	@ResponseBody
	public Map<String, Object> getEventList(@RequestParam(required = false, defaultValue = "1") String pg, @RequestParam String option) {
		Map<String, Object> map = new HashedMap<String, Object>();		
			
		// 리스트 뽑아오기
		List<EventDTO> list = eventService.getEventList(pg, option);
		// 페이징 처리하기
		EventPaging eventPaging = eventService.eventPaging(pg, option);
					
		map.put("eventPaging", eventPaging);
		map.put("list", list);
		return map;
	}
	
	// 이벤트 검색결과
	@PostMapping(value = "searchEvent")
	@ResponseBody
	public Map<String, Object> searchEvent(@RequestParam Map<String, Object> map){		
		//페이징처리
		EventPaging eventPaging = eventService.searchEventPaging(map);
		// 검색 결과 리스트
		List<EventDTO> list = eventService.searchEvent(map);
			
		// data로 보낼 결과물
		Map<String, Object> map2 = new HashMap<String, Object>();
		// 검색 결과 리스트
		map2.put("list", list);
		// 페이징처리의 결과 값
		map2.put("eventPaging", eventPaging);
		return map2;
		}
	
	// 이벤트 작성 폼
	@GetMapping(value = "eventWrite")
	public String eventWrite(Model model, @RequestParam(required = false, defaultValue = "1") String pg) {
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/event/eventWrite.jsp");
		return "/admin/adminIndex";
	}
	
	// 이벤트 등록
	@PostMapping(value = "writeEvent")
	@ResponseBody
	public void writeEvent(@RequestParam Map<String, Object> map, @RequestParam("img[]") List<MultipartFile> list, HttpSession session) {
		// 실제폴더에 업로드
		String filePath = session.getServletContext().getRealPath("/storage");
		String fileName; // 실제이름
		File file; // 파일 생성
		
		System.out.println(list);
		int count=0;
		for (MultipartFile img : list) {
			fileName = img.getOriginalFilename();
			file = new File(filePath, fileName);
			
			// 파일 이동
			try {
				if(!file.exists()) {
					img.transferTo(file);					
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			count++;
			map.put("img" + count, fileName);

		} // end for

		eventService.writeEvent(map);		
	}
	
	// 이벤트 수정 폼
	@GetMapping(value = "updateEventForm")
	public String UpdateEvent(Model model, @RequestParam(required = false, defaultValue = "1") String pg, @RequestParam String eventId) {
		model.addAttribute("eventId", eventId);
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/WEB-INF/adminViews/event/eventUpdate.jsp");
		return "/admin/adminIndex";
	}
	
	// 이벤트 수정을 위한 정보
	@PostMapping(value = "getEventInfo")
	@ResponseBody
	public Map<String, Object> getEventInfo(@RequestParam String eventId){	
		EventDTO eventDTO = eventService.getEventInfo(eventId);
		List<String> list2 = new ArrayList<String>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		list2.add(eventDTO.getImg1());
		list2.add(eventDTO.getImg2());
		list2.add(eventDTO.getImg3());
			
		map.put("eventDTO", eventDTO);
		map.put("list", list2);
		
		return map;
	}
	
	// 이벤트수정
	@PostMapping(value = "eventUpdate")
	@ResponseBody
	public void eventUpdate(@RequestParam Map<String, Object> map, @RequestParam(name="img2[]", required = false) List<String> img2, @RequestParam("img[]") List<MultipartFile> list, HttpSession session){			
		System.out.println(map);
		String filePath = "C:\\shoeCream_images\\images\\logo"; 
		String fileName; // 실제이름
		File file; // 파일 생성
		
		// 실 파일 입력
		if(img2 != null) {
			int count=0;
			
			for(int i=0; i< img2.size(); i++) {			
				String img3 = img2.get(i);			
				System.out.println("String 입력될 애들" + img3);
			
				count++;
				map.put("img" + count, img3);
				
			}
			
			for(int i=0; i<list.size(); i++) {
				System.out.println(list);
				MultipartFile img = list.get(i);
				
				fileName = img.getOriginalFilename();
				file = new File(filePath, fileName);
				
				// 파일 이동
				try {
					if(!file.exists()) {
						img.transferTo(file);					
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				count++;
				map.put("img" + count, fileName);
				
			}
			
		}else {	
			    int count=0;
				for(int i=0; i<list.size(); i++) {
				
				MultipartFile img = list.get(i);
				
				fileName = img.getOriginalFilename();
				file = new File(filePath, fileName);
	
				// 파일 이동
				try {
					if(!file.exists()) {
						img.transferTo(file);					
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				count++;
				map.put("img" + count, fileName);
				
			}
		}
			eventService.eventUpdate(map);		
		}
		
	// 이벤트 삭제
	@GetMapping(value = "deleteEvent")
	public String deleteEvent(@RequestParam String eventId, Model model, HttpSession session) {
		
		String filePath = session.getServletContext().getRealPath("/storage");
		String fileName; // 실제이름
		File file; // 파일 생성

		Map<String, Object> map = this.getEventInfo(eventId);	
		List<String> list = (List<String>) map.get("list");
		System.out.println("삭제" + list);

			
		// 원 사진 파일 삭제	
		for (int i=0; i<list.size() ;i++) {
			if(list.get(i) != null) {
				fileName = list.get(i);
				file = new File(filePath, fileName);			
					if(file.exists()){ 
						file.delete();
					}
			}
			
		}
					
		eventService.deleteEvent(eventId);
		
		model.addAttribute("display", "/WEB-INF/adminViews/event/eventList.jsp");
		return "/admin/adminIndex";
	}
	
	// 체크박스 이벤트 삭제
	@PostMapping(value = "deletEventList")
	@ResponseBody
	public String deletEventList(@RequestParam(value="checkBoxArr[]") String[] checkBoxArr, Model model, HttpSession session) {
		
		String filePath = session.getServletContext().getRealPath("/storage");
		String fileName; // 실제이름
		File file; // 파일 생성

		for(String eventId: checkBoxArr) {
			Map<String, Object> map = this.getEventInfo(eventId);	
			List<String> list = (List<String>) map.get("list");
			System.out.println("삭제" + list);
			
			// 원 사진 파일 삭제	
			for (int i=0; i<list.size() ;i++) {
				if(list.get(i) != null) {
					fileName = list.get(i);
					file = new File(filePath, fileName);			
						if(file.exists()){ 
							file.delete();
						}
				}
				
			}
			
			eventService.deletEventList(eventId);
		}
				
		model.addAttribute("display", "/WEB-INF/adminViews/product/productList.jsp");
		return "/admin/adminIndex";
	}
}	
