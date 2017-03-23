<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<table class="table table-condensed table-hover">
	<tr ng-repeat="s in list">
		<th>{{timeFilter(s)}}</th><td schedule-popover ng-click="showPopover($event)" data-schedule='{{s.id}}' style="cursor:pointer;">{{s.title}}</td>
	</tr>
</table>