<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex=-1 role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>직급/직책 코드 설정</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="form">
					<div class="form-group">
						<label class="col-md-4 control-label" for="name">Name</label>
						<div class="col-md-8">
							<input type="text" class="form-control" id="name" ng-model="position.name" placeholder="Enter Name" required/>
							<input type="hidden" ng-model="position.id"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="type">Type</label>
						<div class="col-md-8">
							<select class="form-control" ng-model="position.type" required>
								<option value="P">직급</option>
								<option value="R">직책</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="seq">Seq.</label>
						<div class="col-md-8">
							<input type="seq" class="form-control" id="seq" ng-model="position.seq" placeholder="Enter Seq. number" required/>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" ng-click="answer('yes')" ng-disabled="form.$invalid">확인</button>
				<button type="button" class="btn btn-default" ng-click="answer('no')">취소</button>
			</div>
		</div>
	</div>
</div>