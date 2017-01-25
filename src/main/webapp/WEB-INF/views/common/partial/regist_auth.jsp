<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>권한 코드 설정</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="form">
					<div class="form-group">
						<label class="col-md-4 control-label" for="roleName">Role Name</label>
						<div class="col-md-8">
							<input type="hidden" ng-model="auth.authId"/>
							<input type="text" id="roleName" ng-model="auth.roleName" class="form-control" placeholder="Enter Role name (required)" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="comment">Comment</label>
						<div class="col-md-8">
							<input type="text" id="comment" ng-model="auth.comment" class="form-control" placeholder="Enter Comment (required)" required>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" ng-click="answer('ok')" ng-disabled="form.$invalid">확인</button>
				<button type="button" class="btn btn-default" ng-click="answer('no')">취소</button>
			</div>
		</div>
	</div>
</div>