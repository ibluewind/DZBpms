<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-md-4 control-label">제목</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="title" ng-model="title" placeholder="제목"/>
		</div>
	</div>
	<div class="form-group">
		<label for="start" class="col-md-4 control-label">시작일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="start" ng-model="startDate" bs-datepicker/>
		</div>
	</div>
	<div class="form-group">
		<label for="end" class="col-md-4 control-label">종료일</label>
		<div class="col-md-8">
			<input type="text" class="form-control" id="end" ng-model="endDate" bs-datepicker/>
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
			<button type="button" class="btn btn-primary btn-sm" ng-click="saveSchedule()">저장</button>
			<button type="button" class="btn bnt-defulat btn-sm" ng-click="closePopover()">취소</button>
		</div>
	</div>
</div>