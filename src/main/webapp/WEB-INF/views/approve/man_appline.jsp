<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">결재라인 목록</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>제목</th><th>양식명</th><th>수정일자</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="s in ctrl.summaries">
							<td ng-click="ctrl.editSummaryInfo(s.lineId)" style="cursor:pointer;">{{s.title}}</td>
							<td>{{s.formTitle}}</td>
							<td>{{s.modified|date:'yyyy-MM-dd HH:mm:ss'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- div class="panel-footer command-line">
				<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.addCustomApproveLine()"><span class="glyphicon glyphicon-plus">&nbsp;추가</span></button>
			</div-->
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">결재 라인 상세 정보</div>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" name="summary_form">
					<div class="form-group">
						<input type="hidden" ng-model="ctrl.summary.lineId">
						<label class="col-md-4 control-label" for="title">결재라인제목</label>
						<div class="col-md-8">
							<input type="text" id="title" class="form-control" ng-model="ctrl.summary.title">
						</div>
					</div>
					<div class="form-group">
						<input type="hidden" ng-model="ctrl.summary.formId">
						<label class="col-md-4 control-label" for="formTitle">결재양식</label>
						<div class="col-md-8">
							<input type="text" id="formTitle" class="form-control" ng-model="ctrl.summary.formTitle" disabled required ng-click="ctrl.selectForm()" placeholder="양식을 선택하세요.">
						</div>
					</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>순번</th><th>결재자</th><th>직책</th><th colspan=2></th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="l in ctrl.customAppLines">
								<td>{{l.seq}}</td>
								<td>{{l.approvalName}}</td>
								<td>{{l.approvalPosition}}</td>
								<td>
									<button type="button" class="btn btn-default btn-xs" ng-click="ctrl.moveUp()" ng-disabled="$first"><span class="glyphicon glyphicon-chevron-up small"></span></button>
									<button type="button" class="btn btn-default btn-xs" ng-click="ctrl.moveDown()" ng-disabled="$last"><span class="glyphicon glyphicon-chevron-down small"></span></button>
								</td>
								<td>
									<button type="button" class="btn btn-default btn-xs" ng-click="ctrl.addTo(l.seq)"><span class="glyphicon glyphicon-plus small"></span></button>
									<button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.remove(l.seq)"><span class="glyphicon glyphicon-trash small"></span></button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="panel-footer command-line"></div>
		</div>
	</div>
</div>