<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4 class="modal-title">작업 이력 상세</h4>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<th>작성일</th><td>{{history.created | date:'yyyy-MM-dd HH:mm:ss'}}</td>
					</tr>
					<tr>
						<th>작성자</th><td>{{history.creatorName}}</td>
					</tr>
					<tr>
						<th>작업자</th><td>{{history.workerName}}</td>
					</tr>
					<tr>
						<th>작업내용</th><td>{{history.action}}</td>
					</tr>
					<tr>
						<th>의견</th><td>{{history.comment}}</td>
					</tr>
					<tr>
						<th>진척율</th><td>{{history.procRate}}</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm" ng-click="$hide()">확인</button>
			</div>
		</div>
	</div>
</div>