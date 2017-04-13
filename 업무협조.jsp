<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="appline_command.jsp" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">업무협조</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" name="form">
			<div class="form-group">
				<label class="col-md-4 control-label" for="receiverName">수신</label>
				<div class="col-md-7">
					<input type="text" id="receiverName" class="form-control input-sm" ng-model="ctrl.form.fields['receiverName']" readonly/>
					<input type="hidden" id="receiverId" data-role="approve_line" ng-model="ctrl.form.fields['receiverId']"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="referName">참조</label>
				<div class="col-md-7">
					<input type="text" id="referName" class="form-control input-sm" ng-model="ctrl.form.fields['referName']" readonly/>
					<input type="hidden" ng-model="ctrl.form.formfields['referId']"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="content">내용</label>
				<div class="col-md-7">
					<textarea id="content" class="form-control" rows="10" ng-model="ctrl.form.fields['content']" ng-required="true"></textarea>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col-md-offset-1 col-md-10 well">
				{{ctrl.form.fields['deptName']}}&nbsp;{{ctrl.form.fields['positionName']}}&nbsp;{{ctrl.form.fields['userName']}}
			</div>
		</div>
	</div>
	<div class="panel-footer">
		<%@ include file="approve_command.jsp" %>
	</div> 
</div>
<%@ include file="approve_history.jsp" %>