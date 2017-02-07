<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ui-route를 사용해서 페이지를 다시 목록과 보기 두개의 화면으로 나눈다. -->
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="panel-title">미결함 문서 목록</div>
			</div>
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th></th><th>문서명</th><th>작성자</th><th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="doc in ctrl.documents">
							<td></td><td><a href="#/edit_app/{{doc.appId}}?action=proc">{{doc.appTitle}}</a></td><td>{{doc.creatorName}}</td><td>{{doc.created|date:'yyyy-MM-dd HH:mm:ss'}}
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-6">
	</div>
</div>