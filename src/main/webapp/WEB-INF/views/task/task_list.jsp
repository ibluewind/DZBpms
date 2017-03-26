<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="row">
			<div class="col-md-10">
				<div class="panel-title">작업목록</div>
			</div>
			<div class="col-md-2">
				<select class="form-control" ng-model="ctrl.searchStatus">
					<option value="">--------- ALL ---------</option>
					<option value="N">신규</option>
					<option value="P">진행중</option>
					<option value="H">보류</option>
					<option value="R">반려</option>
					<option value="C">취소</option>
					<option value="D">위임</option>
					<option value="L">지연</option>
					<option value="F">완료</option>
				</select>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div class="table-responsive">
			<table class="table">
				<thead>
					<th>번호</th>
					<th>상태</th>
					<th>작업명</th>
					<th>작성자</th>
					<th>담당자</th>
					<th>작업기한</th>
					<th>작성일자</th>
					<th>완료율</th>
					<th></th>
				</thead>
				<tbody>
					<tr ng-repeat="task in ctrl.tasks | filter:ctrl.statusFilter" ng-class="{'bg-primary':task.status=='N', 'bg-info':task.status=='S', 'bg-success':task.status=='F', 'bg-warning':task.status=='R', 'bg-danger':task.status=='L' || task.status=='H' || task.status == 'C'}">
						<td>{{$index + 1}}</td>
						<td>{{ctrl.getStatusName(task.status)}}
						<td style="cursor:pointer" ng-click="ctrl.canEdit(task) ? ctrl.edit(task.taskId) : ctrl.view(task.taskId)">{{task.title}}</td>
						<td>{{task.userName}}</td>
						<td>{{task.workerName}}</td>
						<td>{{task.endDate}}</td>
						<td>{{task.createDate}}</td>
						<td>{{task.currentRate}} / {{task.targetRate}}</td>
						<td>
							<div class="btn-group" role="group" ng-hide="task.currentRate == 100 || !ctrl.isWorker(task)">
								<button type="button" tabindex=100 class="btn btn-default btn-xs" ng-click="ctrl.processRateDown(task)"><span class="caret"></span></button>
								<button type="button" tabindex=100 class="btn btn-default btn-xs dropup" ng-click="ctrl.processRateUp(task)"><span class="caret"></span></button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="panel-footer">
		작업 내용을 확인하거나 수정하시려면, 제목을 클릭하십시오.	
	</div>
</div>