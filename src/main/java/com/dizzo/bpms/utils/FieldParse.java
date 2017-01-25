package com.dizzo.bpms.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import com.dizzo.bpms.model.FormField;

public class FieldParse {
	
	public static void main(String[] args) throws Exception {
		System.out.println(new File(".").getAbsolutePath());
		BufferedReader	reader = new BufferedReader(new FileReader(new File("form.jsp")));
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
		
		
		System.out.println(fields);
	}
	
	private static String setClauseField(String line) {
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
	
	private static String getClauseFieldName(String clauseField, String line) {
		String	field = null;
		String	arr[] = line.split(" ");
		int i;
		
		for (i = 0; i < arr.length; i++) {
			if (arr[i].contains("ng-model"))	break;
		}
		
		field = arr[i].substring(arr[i].indexOf(".") + 1, arr[i].lastIndexOf("\""));
		return field;
	}
	
	private static String getSingleFieldName(String line) {
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

}

