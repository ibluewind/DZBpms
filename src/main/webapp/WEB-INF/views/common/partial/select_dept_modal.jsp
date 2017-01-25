<div class="modal upload_modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" style="width: 50%;">
		<div class="modal-content">
			<div class="modal-header">
				Select Department
			</div>
			<div class="modal-body">
				<div id='jstree' js-tree="ctrl.treeConfig" ng-model="ctrl.treeData" tree-events="select_node:ctrl.selectDept"></div>				
				<button type="button" class="btn btn-primary btn-sm" ng-click="ctrl.saveChanged()">Ok</button>
				<button type="button" class="btn btn-warning btn-sm" ng-click="ctrl.cancelChanged()">Cancel</button>
			</div>
		</div>
	</div>
</div>