package com.dizzo.bpms.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;
import com.dizzo.bpms.service.FileAttachService;
import com.dizzo.bpms.service.FormService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/form")
public class FormRestController {
	
	@Autowired
	FormService		formService;
	
	@Autowired
	FileAttachService	fileService;

	/**
	 * angular에서 호출된 결과를 plain text로 전달해야하므로, produces="text/plain"을 설정한다.
	 * @param name
	 * @return
	 */
	@RequestMapping(value="/file/{name}", method=RequestMethod.DELETE)
	public FileAttach deleteFormFile(@PathVariable String name) {
		FileAttach	file = fileService.deleteByFileName(name);
		return file;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Form saveForm(@RequestBody Form form) {
		form.setCreator(getPrincipal());
		form = formService.save(form);
		System.out.println("Save Form: " + form);
		
		return form;
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public List<Form> list() {
		return formService.list();
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public Form getById(@PathVariable String id) {
		System.out.println("get form information: id = " + id);
		return formService.getById(id);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Form update(@RequestBody Form form) {
		return formService.update(form);
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public Form delete(@PathVariable String id) {
		return formService.delete(id);
	}
	
	/**
	 * 관리자가 등록한 양식 파일을 parsing해서 form_field table을 등록한다.
	 * form_field table은 양식 파일에 있는 field 정보를 저장하고, 사용자가 결재 양식을 등록할 때 양식의 초기화를 위해서 사용된다.
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/field", method=RequestMethod.POST)
	public List<FormField> saveFormField(@RequestBody String id) throws Exception {
		System.out.println("saving form fields: " + id);
		List<FileAttach> files = fileService.listByMainId(id);
		System.out.println("files: " + files);
		FileAttach	file = files.get(0);
		List<FormField>	fields = parsingFormField(new File(file.getPath() + file.getName()));
		
		formService.saveFormField(id, fields);
		return fields;
	}
	
	@RequestMapping(value="/field/{id}", method=RequestMethod.GET)
	public List<FormField> getFormField(@PathVariable String id) {
		return formService.getFormField(id);
	}
	
	private List<FormField> parsingFormField(File file) throws Exception {
		System.out.println("parsing Form Field: " + file.getAbsolutePath());
		BufferedReader	reader = new BufferedReader(new FileReader(file));
		String	line = null;
		String	clauseField = null;
		int		category = 0;
		int		clause = 0;
		String	fieldName = null;
		List<FormField> fields = new ArrayList<FormField>();
		
		while ((line = reader.readLine()) != null) {
			if (line.contains("ng-model")) {
				// ng-model이 나왔다는 것은 처음 단일 필드를 정의한 것이거나, ng-repeat가 종료되고 새로운 단일 필드가
				// 나타난 것으로 가정할 수 있음. 즉, ng-repeat가 종료되었다는 의미로 해석해도 될 것임.
				// 단, clauseField가 null이 아닌 경우에는 같은 카테고리에 필드들을 등록하도록 함.
				// 문제는 역시 ng-repeat가 끝났다는 것을 어떻게 알 수 있는가 이다.
				// 아래에 getSingleFieldName()에서 null 리턴된다면 ng-repeat에 해당하는 필드이므로 null이 리턴되지 않은 경우 ng-repeat는 종료...
				fieldName = getSingleFieldName(line);
				if (fieldName != null) {
					if (clauseField != null)		clauseField = null;		// ng-repeat가 종료되고 새로운 단일 필드이므로 초기화.
					fields.add(new FormField(category, clause, fieldName, ""));
					category++;
				} else if (clauseField != null) {
					// ng-repeat에 해당하는 필드를 처리한다.
					// 만일 ng-repeat가 연속해서 등장하는 경우에는 어떻게 되나?
					// clauseField != null 인 상태에서 clauseField 값이 변경되었다면, 새로운 카테고리이다.
					// 아래의 조건문에서 ng-repeat가 처음이 아니라면, 다른 카테고리로 간주하도록 처리하였다.
					fieldName = getClauseFieldName(clauseField, line);
					fields.add(new FormField(category, clause, fieldName, ""));
				}
			} else if (line.contains("ng-repeat")) {
				// 특정 카테고리의 clause 시작을 알림.
				// inner ng-repeat 처리는 하지 않음. 그런 양식이 존재할지 모르겠음.
				// 만일, ng-repeat가 처음 나타난 것이 아니라면, 다른 카테고리의 필드라고 간주해야 함.
				// ng-repeat와 ng-model이 같은 라인에 나타나지 않는다. (그래야 한다.)
				if (clauseField != null) {
					category++;
					clauseField = null;
				}
				clauseField = setClauseField(line);
			} else {
				// ng-repeat가 시작되었고, ng-model을 찾음.
				// ng-repeat가 끝난 것도 처리해야 함. 안그러면 계속해서 같은 category field를 처리하려고 할꺼임.
				// ng-model을 만나거나, ng-repeat를 다시 만나면 기존의 ng-repeat는 종료된 것으로 간주하고 처리해야 함.
			}
		}
		
		reader.close();
		
		System.out.println("parsed fields: " + fields);
		return fields;
	}
	
	private String setClauseField(String line) {
		String field = null;
		
		String buff[] = line.split("=");
		int i = 0;
		for (i = 0; i < buff.length; i++) {
			if (buff[i].contains("ng-repeat")) {
				i++;
				break;
			}
		}
		
		field = buff[i].substring(1, buff[i].indexOf(" in"));
		System.out.println("clause filed : " + field);
		return field;
	}
	
	private String getClauseFieldName(String clauseField, String line) {
		String	field = null;
		String	arr[] = line.split(" ");
		int i;
		
		for (i = 0; i < arr.length; i++) {
			if (arr[i].contains("ng-model"))	break;
		}
		
		field = arr[i].substring(arr[i].indexOf(".") + 1, arr[i].lastIndexOf("\""));
		return field;
	}
	
	private String getSingleFieldName(String line) {
		String	field = null;
		String	buff[] = line.split(" ");
		
		for (int i = 0; i < buff.length; i++) {
			if (buff[i].contains("ng-model")) {
				if (buff[i].contains("[")) {
					// 단일 필드
					field = buff[i].substring(buff[i].indexOf('[') + 2, buff[i].indexOf(']')-1);
				}
				break;
			}
		}
		
		return field;
	}
	
	private String getPrincipal() {
		return IndexController.getPrincipal();
	}
}
