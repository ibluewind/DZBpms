<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>직급/직위 선택</h4>
			</div>
			<div class="modal-body">
				<div ng-repeat="pos in positions" class="radio">
					<label class="control-label">
						<input type="radio" name="position" ng-model="position" value="pos.id" ng-click="selectPosition(pos.id, pos.name)">{{pos.name}}
					</label>
				</div>			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm" ng-click="answer('ok')">Ok</button>
				<button type="button" class="btn btn-warning btn-sm" ng-click="answer('no')">Cancel</button>
			</div>
		</div>
	</div>
</div>