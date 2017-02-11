package com.dizzo.bpms.utils;

import java.net.Inet4Address;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;

public class MacAddress {

	public static void main(String[] args) throws SocketException, UnknownHostException {
		Inet4Address	ip = (Inet4Address) Inet4Address.getLocalHost();
		System.out.println("IP: " + ip.getHostAddress());
		
		NetworkInterface	nif = NetworkInterface.getByName("eth2");
		System.out.println(nif.getDisplayName());
		byte[] mac = nif.getHardwareAddress();
		
		for (byte b: mac) {
			System.out.printf("%02x : ", b);
		}
	}
		
}
