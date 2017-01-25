<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-md-4">
		<!-- 진행중인 업무 -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">진행중인 업무</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>작업명</th><th>작업기한</th><th>진척율</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="task in ctrl.tasks | filter:ctrl.filterProcess" style="cursor:pointer" ng-click="ctrl.canEdit(task) ? ctrl.edit(task.taskId) : ctrl.view(task.taskId)">
							<td>{{task.title}}</td>
							<td>{{task.endDate|date:'yyyy-MM-dd'}}</td>
							<td>{{task.currentRate}}/{{task.targetRate}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<!-- 지연된 업무 -->
		<div class="panel panel-danger">
			<div class="panel-heading">
				<div class="panel-title">지연된 업무</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>작업명</th><th>작업기한</th><th>진척율</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="task in ctrl.tasks | filter:ctrl.filterLate" style="cursor:pointer" ng-click="ctrl.canEdit(task) ? ctrl.edit(task.taskId) : ctrl.view(task.taskId)">
							<td>{{task.title}}</td>
							<td>{{task.endDate|date:'yyyy-MM-dd'}}</td>
							<td>{{task.currentRate}}/{{task.targetRate}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<!-- 내가 생성한 업무 -->
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="panel-title">신규 업무</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>작업명</th><th>작업기한</th><th>진척율</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="task in ctrl.tasks | filter:ctrl.filterNewTask" style="cursor:pointer" ng-click="ctrl.canEdit(task) ? ctrl.edit(task.taskId) : ctrl.view(task.taskId)">
							<td>{{task.title}}</td>
							<td>{{task.endDate|date:'yyyy-MM-dd'}}</td>
							<td>{{task.currentRate}}/{{task.targetRate}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<h4>결재 관련 영역</h4>
</div>