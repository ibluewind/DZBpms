<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>부서 선택</h4>
			</div>
			<div class="modal-body">
				<div id='jstree' js-tree="treeConfig" ng-model="treeData" tree-events="select_node:selectDept"></div>				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm" ng-click="answer('ok')">Ok</button>
				<button type="button" class="btn btn-warning btn-sm" ng-click="answer('no')">Cancel</button>
			</div>
		</div>
	</div>
</div>