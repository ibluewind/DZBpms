<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal" tabindex=-1 role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4>작업 담당자 선택</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5" ng-hide="workerList.length > 0">
						<div id="jstree" js-tree="treeConfig" ng-model="treeData" tree-events="select_node:selectDept"></div>
					</div>
					<div ng-class="workerList.length > 0 ? 'col-md-12' : 'col-md-7'">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="panel-title">사용자 목록</div>
							</div>
							<div class="panel-body">
								<form class="form-inline">
									<table class="table table-hover">
										<thead>
											<th>이름</th>
										</thead>
										<tbody>
											<tr ng-repeat="worker in workerList">
												<td>
													<div class="radio">
														<label>
															<input type="radio" name="worker" value="{{worker.userId}}" ng-click="selectUser(worker)">
															{{worker.lastName}}{{worker.firstName}}
														</label>
													</div>
												<td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm" ng-click="answer('ok')">Ok</button>
				<button type="button" class="btn btn-default btn-sm" ng-click="answer('no')">Cancel</button>
			</div>
		</div>
	</div>
</div>