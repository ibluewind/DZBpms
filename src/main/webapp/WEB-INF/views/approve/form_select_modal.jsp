<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex=-1 role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>결재 양식 선택</h4>
			</div>
			<div class="modal-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>결재 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="f in formList">
							<td>
								<div class="radio">
									<label>
										<input type="radio" name="form" ng-click="selectForm(f)" ng-required="true">
										{{f.title}}
									</label>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" ng-click="answer('yes')" ng-disabled="form.$invalid">확인</button>
				<button type="button" class="btn btn-default" ng-click="answer('no')">취소</button>
			</div>
		</div>
	</div>
</div>