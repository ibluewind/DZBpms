<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" ng-click="$hide()">&times;</button>
				<h4 class="modal-title">{{title}}</h4>
			</div>
			<div class="modal-body">
				<div>{{content}}</div>
				<form name="form">
				<textarea class="form-control" rows="2" ng-model="comment" placeholder="의견을 입력하십시오." required></textarea>
				</form>
			</div>
			<div class="modal-footer">
				<!-- 의견이 입력되지 않으면, 확인 버튼은 활성화 되지 않는다. -->
				<button type="button" class="btn btn-danger btn-sm" ng-click="answer(comment)" ng-disabled='form.$invalid'>확인</button>
			</div>
		</div>
	</div>
</div>