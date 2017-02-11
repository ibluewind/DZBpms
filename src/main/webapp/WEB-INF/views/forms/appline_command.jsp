<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-primary">
	<div class="panel-heading">
		<div class="panel-title">결재라인</div>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-6"><!-- 의뢰부서 결재라인 -->
				<table class="table table-bordered approve_line">
					<thead>
						<tr>
							<th ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
								{{$index == 0 ? "담당" : appLine.approvalPosition}}
								<ul class="sub-menu" ng-if="$index > 0 && ctrl.edit">
									<li><button type="button" class="btn btn-default btn-xs" ng-click="ctrl.addApproveLine($index, 'R')"><span class="glyphicon glyphicon-plus">&nbsp;추가</span></button>
									<li><button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.deleteApproveLine($index, 'R')"><span class="glyphicon glyphicon-trash">&nbsp;삭제</span></button>
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
								{{appLine.approvalName}}
							</td>
						</tr>
						<tr>
							<td ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyRequestApproveLine">
								<small ng-if="appLine.modified">{{appLine.modified|date:'yyyy-MM-dd HH:mm:dd'}}</small>
								<span ng-if="!appLine.modified">&nbsp;</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-md-6"><!-- 처리부서 결재라인 -->
				<table class="table table-bordered approve_line">
					<thead>
						<tr>
							<th ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
								{{$index == 0 ? "담당" : appLine.approvalPosition}}
								<ul class="sub-menu" ng-if="$index > 0 && ctrl.canEditLine">
									<li><button type="button" class="btn btn-default btn-xs" ng-click="ctrl.addApproveLine($index, 'P')"><span class="glyphicon glyphicon-plus">&nbsp;추가</span></button>
									<li><button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.deleteApproveLine($index, 'P')"><span class="glyphicon glyphicon-trash">&nbsp;삭제</span></button>
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
								{{appLine.approvalName}}
							</td>
						</tr>
						<tr>
							<td ng-repeat="appLine in ctrl.approveLine|filter:ctrl.onlyProcessingApproveLine">
								<small ng-if="appLine.modified">{{appLine.modified|date:'yyyy-MM-dd HH:mm:dd'}}</small>
								<span ng-if="!appLine.modified">&nbsp;</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		// 결재라인 관리 메뉴 처리
		$('.approve_line th').hover(
			function() {
				var $subMenu = $(this).find('.sub-menu');
				$subMenu.css("left", $subMenu.offset().left);
				$subMenu.show();
			},
			function() {
				var $subMenu = $(this).find('.sub-menu');
				$subMenu.hide();
			}
		);
	});
</script>