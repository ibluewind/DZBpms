<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="appline_command.jsp"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">제증명신청서</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" name="form">
			<table class="table table-stripe" width="50%">
				<tr>
					<td>
						<input type="radio" class="form-control input-sm" ng-model="ctrl.form.fields['workCert']" value="ENG">영문
						<input type="radio" class="form-control input-sm" ng-model="ctrl.form.fields.['workCert']" value="KOR">한글
						재직증명서
					</td>
					<td>
						<input type="text" class="form-control input-sm" ng-model="ctrl.form.fields.['numWorkCert']">부
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" class="form-control input-sm" ng-model="ctrl.form.fields.['careerCert']" value="ENG">영문
						<input type="radio" class="form-control input-sm" ng-model="ctrl.form.fields.['careerCert']" value="KOR">한글
						경력증명서
					</td>
					<td>
						<input type="text" class="form-control input-sm" ng-model="ctrl.form.fields.['numCareerCert']">부
					</td>
				</tr>
				<tr>
					<td>갑근세증명원</td>
					<td><input type="text" class="form-control input-sm" ng-model="ctrl.form.fields.['numIncomeTax']">부
				</tr>
				<tr>
					<td>근로자원천징수영수증(사본)</td>
					<td><input type="text" class="form-control input-sm" ng-model="ctrl.form.fields.['numWithHolding']">부
				</tr>
				<tr>
					<td>기타</td>
					<td><input type="text" class="form-control input-sm" ng-model="ctrl.form.fields.['numEtc']">부
				</tr>
			</table>
			<div class="form-group">
				<label class="col-md-4 control-label" for="userName">성명</label>
				<div class="col-md-8">
					{{ctrl.form.fields['userName']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="deptName">소속 및 직위</label>
				<div class="col-md-8">
					<input type="text" id="deptName" class="form-control input-sm" ng-model="ctrl.form.fields['deptName']">
					<input type="text" id="positionName" class="form-control input-sm" ng-model="ctrl.form.fields['positionName']">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="employeeDate">입사일</label>
				<input type="text" id="employeeDate" class="form-control input-sm" ng-model="ctrl.form.fields['employeeDate']">
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="quitDate">퇴사일</label>
				<input type="text" id="quitDate" class="form-control input-sm" ng-model="ctrl.form.fields['quitDate']">
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="purpose">용도</label>
				<input type="text" id="purpose" class="form-control input-sm" ng-model="ctrl.form.fields['purpose']">
			</div>
			<div class="form-group">
				<lable class="col-md-4 control-label" for="present">제출처</lable>
				<input type="text" id="present" class="form-control input-sm" ng-model="ctrl.form.fields['present']">
			</div>
		</form>
	</div>
	<div class="panel-footer">
		<%@ include file="approve_command.jsp" %>
	</div>
</div>
<%@ include file="approve_history.jsp"%>