<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row">
	<div class="col-md-4">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">양식목록</div>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th>양식명</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="form in ctrl.forms">
							<td><a href="#/regist_app/{{form.id}}">{{form.title}}</a></td>
							<td>{{form.comment}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<div class="panel panel-info">
			<div class="panel-heading">
				<div class="panel-title">작성중인 결재 문서</div>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th width="70%">문서명</th>
							<th>작성일자</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="summary in ctrl.summaries | filter:ctrl.filterSaved">
							<td><a href="#/edit_app/{{summary.appId}}">{{summary.title}}</a></td>
							<td>{{summary.created|date:'yyyy-MM-dd'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="panel-title">진행중인 결재 문서</div>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th width="70%">문서명</th>
							<th>작성일자</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="summary in ctrl.summaries |filter:ctrl.filterProcessing">
							<td><a href="#/edit_app/{{summary.appId}}">{{summary.title}}</a></td>
							<td>{{summary.created|date:'yyyy-MM-dd'}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>