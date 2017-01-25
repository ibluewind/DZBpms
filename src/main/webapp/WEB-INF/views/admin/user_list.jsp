<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">{{ctrl.dept.name}} 사용자 목록</div>
	</div>
	<div class="tablecontainer">
		<table class="table table-hover table-split">
			<thead>
				<tr>
					<th>USERID</th>
					<th>FIRSTNAME</th>
					<th>LASTNAME</th>
					<th>POSITIONNAME</th>
					<th width="200"></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="u in ctrl.users">
					<td><span ng-bind="u.userId"></span></td>
					<td><span ng-bind="u.firstName"></span></td>
					<td><span ng-bind="u.lastName"></span></td>
					<td>
						<span ng-repeat="pos in u.deptPositions">
							{{pos.positionName}}
						</span>
					</td>
					<td>
						<button type="button" ng-click="ctrl.edit(u.userId)" class="btn btn-success custom-width">Edit</button>
						<button type="button" ng-click="ctrl.remove(u.userId)" class="btn btn-danger custom-width">Remove</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="panel-footer">
			<button type="button" class="btn btn-default" ng-click="ctrl.add()"><span class="glyphicon glyphicon-plus"></span> Add New User</button>
	</div>
</div>