<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<button type="button" class="btn btn-primary btn-sm" ng-click="ctrl.saveApprove('S')" ng-show="ctrl.owner && ctrl.edit">
	<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;저장
</button>
<button type="button" class="btn btn-success btn-sm" ng-click="ctrl.submitApprove()" ng-hide="!ctrl.edit && ctrl.owner">
	<span class="glyphicon glyphicon-ok"></span>&nbsp;{{!ctrl.owner ? '결재' : '상신'}}
</button>
<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.cancelApprove()"><span class="glyphicon glyphicon-repeat"></span>&nbsp;취소</button>
<button type="button" class="btn btn-danger btn-sm" ng-click="ctrl.removeApprove()" ng-show="ctrl.edit && ctrl.owner">
	<span class="glyphicon glyphicon-remove"></span>&nbsp;삭제
</button>
<button type="button" class="btn btn-warning btn-sm" ng-click="ctrl.rejectApprove()" ng-hide="!ctrl.edit && ctrl.owner">
	<span class="glyphicon glyphicon-repeat"></span>&nbsp;반려
</button>
<button type="button" class="btn btn-info btn-sm" ng-click="ctrl.deferApprove()" ng-hide="!ctrl.edit && ctrl.owner">
	<span class="glyphicon glyphicon-briefcase"></span>&nbsp;보류
</button>