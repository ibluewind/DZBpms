<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form name="form" class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-md-4 control-label">제목</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="title" ng-model="title" placeholder="제목" required/>
		</div>
	</div>
	<div class="form-group">
		<label for="start" class="col-md-4 control-label">시작일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="start" ng-model="startDate" data-autoclose="1" bs-datepicker/>
			<input type="text" class="form-control" id="startHours" ng-model="startDate" ng-show="hasHours" data-time-format="HH:mm" data-autoclose="1" bs-timepicker/>
		</div>
	</div>
	<div class="form-group">
		<label for="end" class="col-md-4 control-label">종료일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="end" ng-model="endDate" data-autoclose="1" bs-datepicker/>
			<input type="text" class="form-control" id="endHours" ng-model="endDate" ng-show="hasHours" data-time-format="HH:mm" data-autoclose="1" bs-timepicker/>
		</div>
	</div>
	<div class="form-group">
		<label for="content" class="col-md-4 control-label">내용</label>
		<div class="col-md-8">
			<textarea class="form-control" rows="3" id="content" ng-model="content"></textarea>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button type="button" class="btn btn-primary btn-sm" ng-click="saveSchedule()" ng-disabled="form.$invalid">저장</button>
			<button type="button" class="btn bnt-defulat btn-sm" ng-click="closePopover()">취소</button>
		</div>
	</div>
</form>