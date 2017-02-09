<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-primary">
	<div class="panel-heading">
		<div class="panel-title">결재라인</div>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-6"><!-- 의뢰부서 결재라인 -->
				<ul class="appline">
					<li class="title" style="width: {{100 / ctrl.approveLine.length}}%"  ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
						{{$index == 0 ? "담당" : appLine.approvalPosition}}
						<ul class="sub-menu" ng-if="$index > 0 && ctrl.edit">
							<li><button type="button" class="btn btn-default btn-xs" ng-click="ctrl.addApproveLine($index)"><span class="glyphicon glyphicon-plus">&nbsp;추가</span></button>
							<li><button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.deleteApproveLine($index)"><span class="glyphicon glyphicon-trash">&nbsp;삭제</span></button>
						</ul>
					</li>
				</ul>
				<ul class="appline">
					<li style="width: {{100 / ctrl.approveLine.length}}%"  ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
						{{appLine.approvalName}}
					</li>
				</ul>
				<ul class="appline" ng-if="!ctrl.edit">
					<li style="width: {{100 /ctrl.approveLine.length}}%" ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
						<small>{{appLine.modified|date:'yyyy-MM-dd HH:mm:dd'}}</small>
					</li>
				</ul>
			</div>
			<div class="col-md-6"><!-- 의뢰부서 결재라인 -->
				<ul class="appline">
					<li class="title" style="width: {{100 / ctrl.approveLine.length}}%"  ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
						{{$index == 0 ? "담당" : appLine.approvalPosition}}
						<ul class="sub-menu" ng-if="$index > 0 && ctrl.edit">
							<li><button type="button" class="btn btn-default btn-xs" ng-click="ctrl.addApproveLine($index)"><span class="glyphicon glyphicon-plus">&nbsp;추가</span></button>
							<li><button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.deleteApproveLine($index)"><span class="glyphicon glyphicon-trash">&nbsp;삭제</span></button>
						</ul>
					</li>
				</ul>
				<ul class="appline">
					<li style="width: {{100 / ctrl.approveLine.length}}%"  ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
						{{appLine.approvalName}}
					</li>
				</ul>
				<ul class="appline" ng-if="!ctrl.edit">
					<li style="width: {{100 /ctrl.approveLine.length}}%" ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
						<small>{{appLine.modified|date:'yyyy-MM-dd HH:mm:dd'}}</small>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>