<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="appline_command.jsp" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">{{ctrl.form.title}}</div>
	</div>
	<div class="panel-body">
		<form name="form" class="form-horizontal">
			<div class="form-group">
				<label class="col-md-1 control-label">부서</label>
				<div class="col-md-11">
					<input type="text" class="form-control input-sm" ng-model="ctrl.form.fields['deptName']" readonly ng-disabled="!ctrl.edit">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 control-label">직위/직책</label>
				<div class="col-md-11">
					<input type="text" class="form-control input-sm" ng-model="ctrl.form.fields['positionName']" readonly ng-disabled="!ctrl.edit">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 control-label">성명</label>
				<div class="col-md-11">
					<input type="text" class="form-control input-sm" ng-model="ctrl.form.fields['userName']" ng-disabled="!ctrl.edit">
				</div>
			</div>
			<div class="row">
				<div class="col-md-offset-1 col-md-11">
					<div class="well">상기 본인은 다음과 같이 휴가를 가고자 하오니 결재 바랍니다.</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-offset-1 col-md-11">
					<table class="table table-condensed">
						<thead>
							<tr>
								<th>구분</th>
								<th width="300">기간</th>
								<th>일수</th>
								<th>사유</th>
								<th>비고</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="field in ctrl.form.fields['fieldRows'][0] track by $index">
								<td>
									<select class="form-control input-sm" ng-model="field.type" ng-disabled="!ctrl.edit">
										<option value='1'>연차 휴가</option>
										<option value='2'>경조 휴가</option>
										<option value='3'>생리 휴가</option>
										<option value='4'>산천후휴가</option>
										<option value='5'>특별 휴가</option>
										<option value='6'>공가</option>
										<option value='7'>대휴</option>
										<option value='8'>공상</option>
										<option value='9'>기타</option>
									</select>
										
								</td>
								<td>
									<div class="form-group">
										<div class="col-md-6">
											<input type="text" class="form-control input-sm" ng-model="field.startDate" data-max-date="{{field.endDate}}" bs-datepicker ng-disabled="!ctrl.edit"/>
										</div>
										<div class="col-md-6">
											<input type="text" class="form-control input-sm" ng-model="field.endDate" data-min-date="{{field.startDate}}" bs-datepicker ng-disabled="!ctrl.edit"/>
										</div>
									</div>
								</td>
								<td>
									<span >{{ctrl.dateDiff(field.startDate, field.endDate)}}</span>
								</td>
								<td>
									<input type="text" class="form-control input-sm" ng-model="field.comment" ng-disabled="!ctrl.edit"/>
								</td>
								<td>
									<input type="text" class="form-control input-sm" ng-model="field.remark" ng-disabled="!ctrl.edit"/>
								</td>
								<td ng-show="$index > 0 && ctrl.edit">
									<button type="button" class="btn btn-default btn-xs" ng-click="ctrl.removeField(0, $index)"><span class="glyphicon glyphicon-minus"></span></button>
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.addField(0)" ng-hide="!ctrl.edit">항목추가</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
	<div class="panel-footer">
		<%@ include file="approve_command.jsp" %>
	</div>
</div>
<%@ include file="approve_history.jsp" %>