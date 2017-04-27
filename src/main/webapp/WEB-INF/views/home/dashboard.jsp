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
	<div class="col-md-4">
		<!-- 미결함 -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">미결함</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>문서명</th><th>작성자</th><th>수신일자</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="tray in ctrl.trays|filter:ctrl.undecideTrays">
							<td><a href="#/edit_app/{{tray.appId}}?action=proc">{{tray.appTitle}}</a></td>
							<td>{{tray.creatorName}}</td>
							<td>{{tray.modified|date:'yyyy-MM-dd HH:mm:ss'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<!-- 보류함 -->
		<div class="panel panel-warning">
			<div class="panel-heading">
				<div class="panel-title">보류함</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>문서명</th><th>작성자</th><th>보류일자</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="tray in ctrl.trays|filter:ctrl.deferredTrays">
							<td><a href="#/edit_app/{{tray.appId}}?action=proc">{{tray.appTitle}}</a></td>
							<td>{{tray.creatorName}}</td>
							<td>{{tray.modified|date:'yyyy-MM-dd HH:mm:ss'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<!-- 예결함 -->
		<div class="panel panel-info">
			<div class="panel-heading">
				<div class="panel-title">예정함</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover table-condensed">
					<thead>
						<tr>
							<thead>
								<th>문서명</th>
								<th>작성자</th>
								<th>작성일자</th>
							</thead>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="tray in ctrl.trays|filter:ctrl.expectedTrays">
							<td><a href="#/view_app/{{tray.appId}}?action=proc">{{tray.appTitle}}</a></td>
							<td>{{tray.creatorName}}</td>
							<td>{{tray.created|date:'yyyy-MM-dd HH:mm:ss'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="row hidden-xs hidden-sm" ng-show="ctrl.chief">
	<div class="col-md-12" ng-controller="chartController as chart">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">작업 현황</div>
			</div>
			<div class="panel-body">
				<canvas id="bar" class="chart chart-bar" style="width:100%;height:250px;" chart-data="chart.chartData" chart-labels="chart.chartLabels" chart-series="chart.chartSeries" chart-colors="chart.chartColors" chart-click="chart.onClick"></canvas>
			</div>
		 </div>
	</div>
</div>