<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="appline_command.jsp"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">제증명신청서</div>
	</div>
	<div class="panel-body">
		<form class="form-inline" name="form">
			<table class="table table-bordered">
				<tr>
					<td ng-show="ctrl.edit">
						<label class="radio-inline"><input type="radio" id="korWorkCert" ng-model="ctrl.form.fields['workCert']" value="한글">한글</label>
						<label class="radio-inline"><input type="radio" id="engWorkCert" ng-model="ctrl.form.fields['workCert']" value="영문">영문 재직증명서</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['workCert']}} 재직증명서
					</td>
					<td ng-show="ctrl.edit">
						<label><input type="number" class="form-control input-sm" ng-model="ctrl.form.fields['numWorkCert']" min="0" max="10"> 부</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['numWorkCert']}} 부
					</td>
				</tr>
				<tr>
					<td ng-show="ctrl.edit">
						<label class="radio-inline"><input type="radio" ng-model="ctrl.form.fields['careerCert']" value="한글">한글</label>
						<label class="radio-inline"><input type="radio" ng-model="ctrl.form.fields['careerCert']" value="영문">영문 경력증명서</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['careerCert']}} 경력증명서
					</td>
					<td ng-show="ctrl.edit">
						<label><input type="number" class="form-control input-sm" ng-model="ctrl.form.fields['numCareerCert']" min="0" max="10"> 부</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['numCareerCert']}} 부
					</td>
				</tr>
				<tr>
					<td>갑근세증명원</td>
					<td ng-show="ctrl.edit">
						<label><input type="number" class="form-control input-sm" ng-model="ctrl.form.fields['numIncomeTax']" min="0" max="10"> 부</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['numIncomeTax']}} 부
					</td>
				</tr>
				<tr>
					<td>근로자원천징수영수증(사본)</td>
					<td ng-show="ctrl.edit">
						<label><input type="number" class="form-control input-sm" ng-model="ctrl.form.fields['numWithHolding']" min="0" max="10"> 부</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['numWithHolding']}} 부
					</td>
				</tr>
				<tr>
					<td>기타</td>
					<td ng-show="ctrl.edit">
						<label><input type="number" class="form-control input-sm" ng-model="ctrl.form.fields['numEtc']" min="0" max="10"> 부</label>
					</td>
					<td ng-show="!ctrl.edit">
						{{ctrl.form.fields['numEtc']}} 부
					</td>
				</tr>
			</table>
		</form>
		<form class="form-horizontal">
			<div class="form-group">
				<label class="col-md-4" for="userName">성명</label>
				<div class="col-md-6 well well-sm">
					{{ctrl.form.fields['userName']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4" for="deptName">소속 및 직위</label>
				<div class="col-md-6" ng-show="ctrl.edit">
					<input type="text" id="deptName" class="form-control input-sm" ng-model="ctrl.form.fields['deptName']">
					<input type="text" id="positionName" class="form-control input-sm" ng-model="ctrl.form.fields['positionName']">
				</div>
				<div class="col-md-6 well well-sm" ng-show="!ctrl.edit">
					{{ctrl.form.fields['deptName']}} {{ctrl.form.fields['positionName']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4" for="employeeDate">입사일</label>
				<div class="col-md-6" ng-show="ctrl.edit">
					<input type="text" id="employeeDate" class="form-control input-sm" ng-model="ctrl.form.fields['employeeDate']">
				</div>
				<div class="col-md-6 well well-sm" ng-show="!ctrl.edit">
					{{ctrl.form.fields['employeeDate']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4" for="quitDate">퇴사일</label>
				<div class="col-md-6" ng-show="ctrl.edit">
					<input type="text" id="quitDate" class="form-control input-sm" ng-model="ctrl.form.fields['quitDate']">
				</div>
				<div class="col-md-6 well well-sm" ng-show="!ctrl.edit">
					{{ctrl.form.fields['quitDate']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4" for="purpose">용도</label>
				<div class="col-md-6" ng-show="ctrl.edit">
					<input type="text" id="purpose" class="form-control input-sm" ng-model="ctrl.form.fields['purpose']">
				</div>
				<div class="col-md-6 well well-sm" ng-show="!ctrl.edit">
					{{ctrl.form.fields['purpose']}}
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4" for="present">제출처</label>
				<div class="col-md-6" ng-show="ctrl.edit">
					<input type="text" id="present" class="form-control input-sm" ng-model="ctrl.form.fields['present']">
				</div>
				<div class="col-md-6 well well-sm" ng-show="!ctrl.edit">
					{{ctrl.form.fields['present']}}
				</div>
			</div>
		</form>
	</div>
	<div class="panel-footer">
		<%@ include file="approve_command.jsp" %>
	</div>
</div>
<%@ include file="approve_history.jsp"%>