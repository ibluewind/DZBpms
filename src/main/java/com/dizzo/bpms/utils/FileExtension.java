package com.dizzo.bpms.utils;

import java.io.File;
import java.util.regex.Matcher;

public class FileExtension {

	public static void main(String[] args) {
		String fileName = "test_1243.10.txt";
		String ext = null;
		
		ext = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		
		System.out.println("fileName = " + fileName + ", ext = " + ext);
		
		File	file = new File("d:/upload/template/test.txt");
		System.out.println("fileName: " + file.getPath().replaceAll(Matcher.quoteReplacement(File.separator), "/"));
		
		String filePath = file.getPath().substring(0, file.getPath().lastIndexOf(File.separator)+1);
		fileName = file.getPath().substring(filePath.length(), file.getPath().length());
		System.out.println("indexOf .txt: " + fileName.indexOf(".txt"));
		System.out.println("filePath: " + filePath + ", name: " + fileName.substring(0, fileName.indexOf(".txt")));
		System.out.println("name: " + fileName);
	}

}
