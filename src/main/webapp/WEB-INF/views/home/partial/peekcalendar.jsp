<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
	<div class="text-center">
		<i class="glyphicon glyphicon-chevron-left" ng-click="prevYear()"></i>
		<span style="font-size:1.2em; color:#888;font-weight:bold;">{{currentYear}}</span>
		<i class="glyphicon glyphicon-chevron-right" ng-click="nextYear()"></i>
	</div>
	<table style="width:200px; height: 150px; border-spacing:10px; border-collapse:separate;">
		<tr>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(0)">1월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(1)">2월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(2)">3월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(3)">4월</td>
		</tr>
		<tr>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(4)">5월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(5)">6월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(6)">7월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(7)">8월</td>
		</tr>
		<tr>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(8)">9월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(9)">10월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(10)">11월</td>
			<td style="text-align:center;width:20px;background-color:#f5f5f5;cursor:pointer;" ng-click="selectMonth(11)">12월</td>
		</tr>
	</table>
