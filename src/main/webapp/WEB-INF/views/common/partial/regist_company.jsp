<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex=-1 role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>회사 정보 설정</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="form">
					<div class="form-group">
						<label class="col-md-4 control-label" for="name">Name</label>
						<div class="col-md-8">
							<input type="text" id="name" class="form-control" ng-model="company.name" placeholder="Enter Company Name" required/>
							<input type="hidden" ng-model="company.id"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="ceo">CEO</label>
						<div class="col-md-8">
							<input type="text" id="ceo" class="form-control" ng-model="company.ceo" placeholder="Enter CEO's Name" required/>
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