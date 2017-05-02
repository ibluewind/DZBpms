<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">프로젝트 생성</div>
	</div>
	<div class="panel-body">
		<form name="regist_project" class="form-horizontal">
			<div class="form-group">
				<label class="col-md-4 control-label" for="project_name">프로젝트명</label>
				<div class="col-md-6">
					<input type="text" id="project_name" class="form-control" ng-model="ctrl.project.title" required placeholder="프로젝트 명"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="manager">프로젝트 담당자</label>
				<div class="col-md-6">
					<input type="text" id="manager" class="form-control" ng-model="ctrl.project.manager" ng-click="ctrl.selectManager()" readonly required/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="startDate"><i class="fa fa-calendar"></i>시작일자</label>
				<div class="col-md-6">
					<input type="text" id="startDate" class="form-control" ng-model="ctrl.project.startDate" data-autoclose="true" data-start-week="0" bs-datepicker requried/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="endDate"><i class="fa fa-calendar"></i>종료일자</label>
				<div class="col-md-6">
					<input type="text" id="endDate" class="form-control" ng-model="ctrl.project.endDate" data-min-date="startDate" data-autoclose="true" data-start-week="0" bs-datepicker placeholder="종료일자는 작업이 추가되면서 변경될 수 있습니다." required/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="period">프로젝트 기간</label>
				<div class="col-md-6">
					<input type="text" id="period" class="form-control" ng-model="ctrl.project.period" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="comment">프로젝트 개요</label>
				<div class="col-md-6">
					<textarea rows="6" class="form-control" ng-model="ctrl.project.comment" style="width:100%"></textarea>
				</div>
			</div>
		</form>
	</div>
	<div class="panel-footer"></div>
</div>
