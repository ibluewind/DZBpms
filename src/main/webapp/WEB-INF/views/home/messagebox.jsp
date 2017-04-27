<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">메시지 목록</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th><input type="checkbox" id='checkedAll' ng-click="ctrl.selectAllMessages($event)"></th>
							<th>내용</th>
							<th>일시</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="msg in ctrl.messages">
							<td><input type="checkbox" ng-model="msg.selected"/></td>
							<td>{{msg.message}}</td>
							<td>{{msg.created|date:"yyyy-MM-dd HH:mm:ss"}}</td>
							<td>{{msg.readYn == 'Y' ? "읽음" : ""}}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="panel-footer" ng-init="ctrl.setReadAllMessages()">
				<button type="button" class="btn btn-xs btn-danger" ng-click="ctrl.deleteMessage()" ng-disabled="!ctrl.checkAtLeastOne()">
				<span class="glyphicon glyphicon-trash"></span>삭제
				</button>
			</div>
		</div>
	</div>
</div>