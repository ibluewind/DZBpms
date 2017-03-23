<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form name="form" class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-md-4 control-label">제목</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="title" ng-model="schedule.title" placeholder="제목" ng-show="edit" required/>
			<div ng-hide="edit">{{schedule.title}}</div>
		</div>
	</div>
	<div class="form-group">
		<label for="start" class="col-md-4 control-label">시작일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="start" ng-model="schedule.startDate" data-autoclose="1" ng-show="edit" bs-datepicker/>
			<input type="text" class="form-control" id="startHours" ng-model="schedule.startDate" data-minute-step="10" data-arrow-behavior="picker" data-time-format="HH:mm a" data-autoclose="1" ng-disabled="schedule.wholeDay" ng-show="edit" bs-timepicker/>
			<div ng-hide="edit">{{schedule.startDate|date:'yyyy-MM-dd HH:mm'}}</div>
		</div>
	</div>
	<div class="form-group">
		<label for="end" class="col-md-4 control-label">종료일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="end" ng-model="schedule.endDate" data-autoclose="1" ng-show="edit" bs-datepicker/>
			<input type="text" class="form-control" id="endHours" ng-model="schedule.endDate" data-minute-step="10" data-arrow-behavior="picker" data-time-format="HH:mm a" data-autoclose="1" ng-disabled="schedule.wholeDay" ng-show="edit" bs-timepicker/>
			<div ng-hide="edit">{{schedule.endDate|date:'yyyy-MM-dd HH:mm'}}</div>
		</div>
	</div>
	<div class="form-group">
		<label for="wholeDay" class="col-md-4 control-label">하루종일</label>
		<div class="col-md-8">
			<input type="checkbox" ng-model="schedule.wholeDay" id="wholeDay" ng-disabled="!edit">
		</div>
	</div>
	<div class="form-group">
		<label for="content" class="col-md-4 control-label">내용</label>
		<div class="col-md-8">
			<textarea class="form-control" rows="3" id="content" ng-model="schedule.content" ng-show="edit"></textarea>
			<div ng-hide="edit">{{schedule.content}}</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button type="button" class="btn btn-primary btn-sm" ng-click="saveSchedule()" ng-disabled="form.$invalid" ng-show="edit">저장</button>
			<button type="button" class="btn btn-primary btn-sm" ng-click="updateSchedule()" ng-disabled="form.$invalid" ng-hide="edit || schedule.type != 'P'">수정</button>
			<button type="button" class="btn bnt-defulat btn-sm" ng-click="closePopover()">취소</button>
			<button type="button" class="btn btn-danger btn-sm" ng-click="deleteSchedule()" ng-hide="edit || schedule.type != 'P'">삭제</button>
		</div>
	</div>
</form>