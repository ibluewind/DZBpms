package com.dizzo.bpms.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

public class HttpDownload {

	public static void main(String[] args) throws IOException {
		String urlStr = "https://ntrl.ntis.gov/NTRL/dashboard/searchResults/titleDetail/PB2017100084.xhtml";
		
		URL		url = new URL(urlStr);
		URLConnection connection = url.openConnection();
		
		HttpsURLConnection	httpConnection = (HttpsURLConnection)connection;
		
		httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		//httpConnection.setRequestProperty("Origin", "https://ntrl.ntis.gov");
		//httpConnection.setRequestProperty("Upgrade-Insecure-Requests", "1");
		//httpConnection.setRequestProperty("Referer", "https://ntrl.ntis.gov/NTRL/dashboard/searchResults/titleDetail/PB2017100084.xhtml");
		httpConnection.setRequestProperty("Cookie", "JSESSIONID=aa7fc34996708363b9c133d4e51c");
		
		httpConnection.setRequestMethod("POST");
		httpConnection.setDoOutput(true);
		
		String params = "detailsTBarForm=detailsTBarForm&javax.faces.ViewState=2514167295696878415%3A-395283885016059419&detailsTBarForm%3Aj_idt34=detailsTBarForm%3Aj_idt34";
		OutputStream	os = httpConnection.getOutputStream();
		
		os.write(params.getBytes("UTF-8"));
		os.flush();
		os.close();
		
		System.out.println("ResponseCode: " + httpConnection.getResponseCode());
		Map <String, List<String>> fields = httpConnection.getHeaderFields();
		Iterator<String> keys = fields.keySet().iterator();
		
		while (keys.hasNext()) {
			String key = keys.next();
			System.out.println(key + " : " + fields.get(key));
		}
		
		if (httpConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
			String	fileName = "d:/test.pdf";
			System.out.println("Saving : " + fileName);
			FileOutputStream	out = new FileOutputStream(fileName);
			InputStream			in = httpConnection.getInputStream();
			
			byte	b[] = new byte[4096];
			
			for (int nread = 0; ((nread = in.read(b)) > 0);) {
				out.write(b, 0, nread);
			}
			
			in.close();
			out.flush();
			out.close();
			System.out.println("DONE");
		}

	}

}
