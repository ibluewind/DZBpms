<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header alert alert-warning">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4 class="modal-title">{{title}}</h4>
			</div>
			<div class="modal-body">{{content}}</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm" ng-click="answer('yes')">확인</button>
			</div>
		</div>
	</div>
</div>