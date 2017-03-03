package com.dizzo.bpms.utils;

import java.util.Scanner;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncodingGenerator {

	public static void main(String[] args) {
		String password = args[0];
		System.out.println(password + " : " + new BCryptPasswordEncoder().encode(password));

	}

}
