package com.dizzo.bpms.model;

import java.util.Date;
import java.util.List;

public class FormContent {

	private String	formId;
	private String	title;		// 제목이 없을 수 있다. 이런 경우에는 양식명을 제목으로 사용한다.
	private Date	created;	// 작성일자
	private Date	modified;	// 수정일자.	-- 작성 후 결재하지 않고 저장하는 경우도 있다.
	private String	userId;		// 작성자 아이디
	private List<FormCategory>	categories;		// form field 값.
	
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public Date getModified() {
		return modified;
	}
	public void setModified(Date modified) {
		this.modified = modified;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public List<FormCategory> getCategories() {
		return categories;
	}
	public void setCategories(List<FormCategory> categories) {
		this.categories = categories;
	}
}
