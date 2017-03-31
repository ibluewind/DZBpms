<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">부서 정보 {{ctrl.edit ? "수정" : "등록"}}</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" name="form">
		<input type="hidden" name="pId" ng-model="ctrl.dept.pId"/>
		<input type="hidden" name="deptId" ng-model="ctrl.dept.deptId"/>
		<input type="hidden" name="useYN" ng-model="ctrl.dept.userYN"/>
		<input type="hidden" name="companyId" ng-model="ctrl.dept.companyId"/>
		
		<div class="form-group">
			<label class="col-md-3 control-label" for="parentName">상위부서</label>
			<div class="col-md-7">
				<input type="text" id="parentName" class="form-control" ng-model="ctrl.dept.parentName" ng-click="ctrl.selectParent()" readonly/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label" for="name">부서명</label>
			<div class="col-md-7">
				<input type="text" id="name" name="deptName" class="form-control" ng-model="ctrl.dept.name" required/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label" for="companyName">소속회사</label>
			<div class="col-md-7">
				<input type="text" id="companyName" class="form-control" ng-model="ctrl.dept.companyName" readonly/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label" for="docManagerM">문서관리자(정)</label>
			<div class="col-md-7">
				<input type="text" id="docManagerM" class="form-control" ng-model="ctrl.masterManager.userName" ng-click="ctrl.selectDocumentManager('M')" readonly/>
			</div>
			<div class="col-md-2" ng-show="ctrl.edit">
				<button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.clearDocumentManager('M')"><span class="glyphicon glyphicon-trash"></span></button>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label" for="docManagerS">문서관리자(부)</label>
			<div class="col-md-7">
				<input type="text" id="docManagerS" class="form-control" ng-model="ctrl.secondManager.userName" ng-click="ctrl.selectDocumentManager('S')" readonly/>
			</div>
			<div class="col-md-2" ng-show="ctrl.edit">
				<button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.clearDocumentManager('S')"><span class="glyphicon glyphicon-trash"></span></button>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label" for="seq">순번</label>
			<div class="col-md-7">
				<input type="text" id="seq" class="form-control" ng-model="ctrl.dept.seq">
			</div>
		</div>
		</form>
	</div>
	<div class="panel-footer">
		<button type="button" class="btn btn-primary" ng-click="ctrl.submit()" ng-disabled="form.$invalid">{{ctrl.edit ? '수정' : '확인'}}</button>
		<button ng-if="ctrl.edit" type="button"  class="btn btn-danger" ng-click="ctrl.delete(ctrl.dept.deptId)">Delete</button>
		<button type="button" class="btn btn-default pull-right" ng-click="ctrl.add()"><span class="glyphicon glyphicon-plus"></span>부서추가</button>
	</div>
</div>