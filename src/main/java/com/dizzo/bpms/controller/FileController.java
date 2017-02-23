package com.dizzo.bpms.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.service.FileAttachService;

/**
 * 첨부파일 관리
 * 첨부 파일은 자체 생성되는 아이디로 파일 이름을 변경하여 저장하고, 실제 이름은 별도로 DB에 저장한다.
 * taskId와 매핑도 이루어져야 한다.
 * @author andrew
 *
 */
@Controller
@RequestMapping("/file")
public class FileController {

	public static String	UPLOAD_LOCATION = "e:/upload/";
	public static String	FORMFILE_LOCATION = "e:/workspace/DZBpms/src/main/webapp/WEB-INF/views/forms/";
	
	@Autowired
	FileAttachService	service;
	
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	@ResponseBody
	public List<String> uplaodFile(MultipartHttpServletRequest request) throws IOException {
		Iterator<String>	iterator = request.getFileNames();
		MultipartFile	file = null;
		List<String>	fileNames = new ArrayList<String>();
		while (iterator.hasNext()) {
			file = request.getFile(iterator.next());
			String	uuid = UUID.randomUUID().toString();
			String	ext = getFileExtension(file.getOriginalFilename());
			File	sf =  new File(UPLOAD_LOCATION + uuid + ext);
			FileCopyUtils.copy(file.getBytes(), sf);
			fileNames.add(replaceFileSeparator(sf.getPath()));
		}
		return fileNames;
	}
	
	@RequestMapping(value="/form/upload", method=RequestMethod.POST)
	@ResponseBody
	public List<String> uploadFormFile(MultipartHttpServletRequest request) throws IOException {
		Iterator<String>	iterator = request.getFileNames();
		MultipartFile		file = null;
		List<String>		fileNames = new ArrayList<String>();
		
		System.out.println("Path: " + request.getServletContext().getRealPath("/WEB-INF"));
		while (iterator.hasNext()) {
			file = request.getFile(iterator.next());
			String	uuid = UUID.randomUUID().toString();
			File	sf = new File(FORMFILE_LOCATION + uuid + ".jsp");
			FileCopyUtils.copy(file.getBytes(), new FileOutputStream(sf));
			fileNames.add(replaceFileSeparator(sf.getPath()));
		}
		
		return fileNames;
	}
	
	/**
	 * 양식 파일의 내용을 전송한다.
	 * 양식 파일의 내용은 결재 작성 화면에서 사용되는데, utf-8로 인코딩이 되어야 한다.
	 * @param formId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/form/{formId}", method=RequestMethod.GET, produces="text/html; charset=utf-8")
	@ResponseBody
	public String getFormFileContent(@PathVariable String formId) throws IOException {
		String	content = null;
		
		//양식 파일은 하나만 존재한다.
		FileAttach	formFile = service.listByMainId(formId).get(0);
		File	form = new File(formFile.getPath() + formFile.getName());
		
		content = FileCopyUtils.copyToString(new FileReader(form));
		System.out.println("form Content: " + new String(content.getBytes("UTF-8")));
		return content;
	}
	
	/**
	 * task에 첨부된 파일을 다운로드 한다.
	 * FileController인데 너무 task에만 특화되어있는거 아닌가 싶다.
	 * 범용 적인 FileController를 만들기 위해서는 서버에 저장되는 메카니즘을 정의하고, 정의된 메카니즘에 의해 파일 명과 타입을 전송할 수 있게 설계해야 한다.
	 * @param attachId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/download/{attachId}", method=RequestMethod.GET)
	public void downloadFile(@PathVariable String attachId, HttpServletResponse response) throws IOException {
		FileAttach	attach = service.getByAttachId(attachId);
		File	file = new File(attach.getPath() + attach.getName());
		
		if (!file.exists()) {
			String errorMessage = "파일이 서버에 존재하지 않습니다.";
			System.out.println(errorMessage);
			OutputStream	os = response.getOutputStream();
			os.write(errorMessage.getBytes(Charset.forName("UTF-8")));
			os.close();
			return;
		}
		
		String	mimeType = URLConnection.guessContentTypeFromName(file.getName());		// taskAttach의 type을 사용할 수 있는지 확인할 것. type은  angularFileUploader에서 처리한 결과이다.
		if (mimeType == null) {
			mimeType = "application/octet-stream";
		}
		
		System.out.println("Attach : " + attach);
		mimeType = attach.getType();
		
		System.out.println("mimeType : " + mimeType);
		
		response.setContentType(mimeType);
		response.setHeader("Content-Disposition", String.format("attachment; filename=\"" + attach.getOriginName() + "\""));
		response.setContentLength((int)file.length());	// or attach.getSize()
		
		InputStream	is = new BufferedInputStream(new FileInputStream(file));
		
		FileCopyUtils.copy(is, response.getOutputStream());
	}
	
	private String getFileExtension(String fileName) {
		String	ext = null;
		ext = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		return ext;
	}
	
	private String replaceFileSeparator(String filePath) {
		return filePath.replaceAll(Matcher.quoteReplacement(File.separator), "/");
	}
}
