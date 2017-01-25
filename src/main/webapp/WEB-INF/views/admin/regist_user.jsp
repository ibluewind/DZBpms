<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">사용자 {{ctrl.edit ? "수정" : "등록"}}</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" name="form">
			<input type="hidden" name="id" ng-model="ctrl.user.id"/>
			<div class="form-group">
				<label class="col-md-4 control-label" for="userid">User Id</label>
				<div class="col-md-6">
					<input type="email" class="form-control" id="userid" name="userid" ng-model="ctrl.user.userId" {{ctrl.edit ? "readonly" : ""}} required placeholder="Email 주소"/>
				</div>
				<div class="col-md-2">
					<span class="glyphicon glyphicon-search" ng-click="ctrl.searchUser()"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="firstName">First Name</label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="firstName" name="firstName" ng-model="ctrl.user.firstName" required placeholder="이름"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="lastName">Last Name</label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="lastName" name="lastName" ng-model="ctrl.user.lastName" required placeholder="성"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">Password</label>
				<div class="col-md-6">
					<input type="password" id="password" name="password" class="form-control" ng-model="ctrl.user.password" {{ctrl.edit ? "readonly" : ""}} required placeholder="비밀번호" {{ctrl.edit ? "readonly}}/>
				</div>
				<div ng-if="ctrl.edit" class="col-md-2">
					<button type="button" class="btn btn-default" ng-click="ctrl.resetPassword()">Reset</button>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="panel-title">부서/직급 정보</div>
				</div>
				<div class="panel-body">
					<div class="row" ng-repeat="depos in ctrl.user.deptPositions">
						<div class="col-md-5">
							<div class="form-group">
								<label class="col-md-4 control-label">부서명</label>
								<div class="col-md-8">
									<input type="text" class="form-control" name="deptName" ng-model="depos.deptName" ng-click="ctrl.selectDepartment(depos.deptId)" readonly required/>
									<input type="hidden" name="deptId" ng-model="depos.deptId"/>
								</div>
							</div>
						</div>
						<div class="col-md-5">
							<div class="form-group">
								<label class="col-md-4 control-label">{{depos.positionType == 'P' ? '직급' : (depos.positionType == 'R' ? '직책' : '직급/직책')}}</label>
								<div class="col-md-8">
									<input type="text" class="form-control" name="positionName" ng-model="depos.positionName" ng-click="ctrl.selectPosition(depos.positionId)" readonly required/>
									<input type="hidden" name="positionId" ng-model="depos.positionId"/>
								</div>
							</div>
						</div>
						<div class="col-md-2">
							<button ng-if="$index > 0" type="button" ng-click="ctrl.removeDepartPosition(depos.deptId, depos.positionId)" class="btn btn-danger btn-sm">삭제</button>
						</div>
					</div>
				</div>
				<div class="panel-footer">
					<button type="button" class="btn btn-default" ng-click="ctrl.addDepartPosition()">부서/직급 추가</button>
				</div>
			</div>
			<!-- 사용자 권한 정보 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="panel-title">사용자 권한 정보</div>
				</div>
				<div class="panel-body">
					<div class="row">
						<select multiple name="authorities" class="form-control"
							ng-options="option.comment for option in ctrl.authorities track by option.authId"
							ng-model="ctrl.selectedAuthorities" required>
						</select>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="panel-footer">
		<button type="button" class="btn btn-primary" ng-click="ctrl.submit()" ng-disabled="form.$invalid">{{ctrl.edit ? "수정" : "확인"}}</button>
		<button type="button" class="btn btn-default" ng-click="ctrl.cancel()">취소</button>
	</div>
</div>