<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">결재문서 이력 <span class="pull-right glyphicon glyphicon-plus small" style="cursor:pointer;" id="view_list">더보기</span></div>
	</div>
	<div class="panel-body" id="history_list" style="display:none;">
		<table class="table table-stripe">
			<thead>
				<tr>
					<th style="text-align:center;">담당자</th><th style="text-align:center;">이력일시</th><th style="text-align:center;">상태</th><th style="text-align:center;">비고</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="history in ctrl.histories">
					<td width="20%" style="text-align:center;">{{history.userName}}</td>
					<td width="20%" style="text-align:center;">{{history.created|date:'yyyy-MM-dd HH:mm:ss'}}</td>
					<td width="20%" style="text-align:center;">{{ctrl.statusName(history)}}</td>
					<td width="40%">{{history.comment}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#view_list').on('click', function(e) {
			if ($('#history_list').is(':visible')) {
				$('#history_list').slideUp("slow");
				$(this).removeClass('glyphicon-minus');
				$(this).addClass('glyphicon-plus');
				$(this).text("더보기");
			} else {
				$('#history_list').slideDown("slow");
				$(this).removeClass('glyphicon-plus');
				$(this).addClass('glyphicon-minus');
				$(this).text("감추기");
			}
		});
	});
</script>