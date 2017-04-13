<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default" ng-cloak>
	<div class="panel-heading">
		<div class="row">
			<div class="col-md-10">
				<div class="panel-title">작업 내역</div>
			</div>
			<div class="col-md-2 pull-right" ng-show="ctrl.isOwner()">
				<!-- button class="btn btn-default btn-sm" ng-click="ctrl.editTask()">수정</button-->
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<table class="table">
					<tr>
						<th width="200">제목</th><td>{{ctrl.task.title}}</td>
					</tr>
					<tr>
						<th>작성자</th><td>{{ctrl.task.userName}}</td>
					</tr>
					<tr>
						<th>담당자</th><td>{{ctrl.task.workerName}}</td>
					</tr>
					<tr>
						<th>작업기한</th><td>{{ctrl.task.endDate}}
					</tr>
					<tr>
						<th>중요도</th><td>{{ctrl.getPriority()}}</td>
					</tr>
					<tr>
						<th>공개여부</th><td>{{ctrl.getOpened()}}</td>
					</tr>
					<tr>
						<th>상태</th><td>{{ctrl.statusName}}</td>
					</tr>
					<tr>
						<th>작업내용</th><td><span ng-bind="ctrl.task.content"></span></td>
					</tr>
					<tr ng-show="ctrl.iamWorker">
						<th>진척율</th><td><rzslider rz-slider-model="ctrl.task.currentRate" rz-slider-options="{floor:0, ceil:100, onEnd:ctrl.changeRate}"></rzslider></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row" ng-show="ctrl.addAttach">
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-default" ng-controller="fileController as fc" uploader="uploader" filters="queueLimit, customFilter">
					<div class="panel-heading">
						<div class="panel-title">첨부파일<small class="pull-right">{{uploader.queue.length}} / 10</small></div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-10 col-md-offset-1">
								<table class="table">
									<thead>
										<tr>
											<th width="50%">Name</th>
											<th>Size</th>
											<th>Progress</th>
											<th>Status</th>
											<th class="text-center">Actions</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="item in uploader.queue">
											<td>{{item.file.name}}</td>
											<td>{{item.file.size/1024/1024|number:2}} MB</td>
											<td>
												<div class="progress" style="margin-bottom:0;">
													<div class="progress-bar" role="progressbar" ng-style="{'width' : item.progress + '%'}"></div>
												</div>
											</td>
											<td class="text-center">
												<span ng-show="item.isSuccess"><i class="glyphicon glyphicon-ok"></i></span>
												<span ng-show="item.isCancel"><i class="glyphicon glyphicon-ban-circle"></i></span>
												<span ng-show="item.isError"><i class="glyphicon glyphicon-remove"></i></span>
											</td>
											<td nowrap>
												<button type="button" class="btn btn-success btn-xs" ng-click="item.upload()" ng-disabled="item.isReady || item.isUploading || item.isSuccess">
													<span class="glyphicon glyphicon-upload"></span> Upload
												</button>
												<button  type="button" class="btn btn-warning btn-xs" ng-click="item.cancel()" ng-disabled="!item.isUploading">
													<span class="glyphicon glyphicon-ban-circle"></span> Cancel
												</button>
												<button type="button" class="btn btn-danger btn-xs" ng-click="fc.remove(item)">
													<span class="glyphicon glyphicon-trash"></span> Remove
												</button>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="row well">
									<label class="col-md-4 control-label" for="file">파일선택</label>
									<div class="col-md-6">
										<input type="file" class="form-control" id="file" uploader="uploader" nv-file-select="" multiple
											   data-placement="bottom" data-type="info" data-animation="am-fade-and-scale" data-title="여러 개의 파일을 선택하려면, Shift나 Ctrl키를 이용하십시오." bs-tooltip/>
									</div>
								</div>
								<div class="progress">
									<div class="progress-bar" role="progressbar" ng-style="{'width' : uploader.prodress + '%'}"></div>
								</div>
								<div>
									<button type="button" class="btn btn-success btn-sm" ng-click="uploader.uploadAll()" ng-disabled="!uploader.getNotUploadedItems().length">
										<span class="glyphicon glyphicon-upload"></span> Upload all
									</button>
									<button type="button" class="btn btn-warning btn-sm" ng-click="uploader.cancelAll()" ng-disabled="!uploader.isUploading">
										<span class="glyphicon glyphicon-ban-circle"></span> Cancel all
									</button>
									<button type="button" class="btn btn-danger btn-sm" ng-click="fc.clearQueue()">
										<span class="glyphicon glyphicon-trash"></span> Remove all
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">	<!-- 첨부 파일 목록 -->
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">첨부 파일 목록</div>
					</div>
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th style="width: 50%">파일명</th>
									<th>크기</th>
									<th>수정일자</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="attach in ctrl.attachFiles">
									<td>{{attach.originName}}</td>
									<td>{{attach.size / 1024 / 1024 | number:2}} MB</td>
									<td>{{attach.modified}}</td>
									<td><a href="{{'/bpms/file/download/' + attach.attachId}}"><span class="glyphicon glyphicon-download"></span></a></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="panel-footer">
						<button type="button" class="btn btn-default btn-sm" ng-show="ctrl.iamWorker" ng-click="ctrl.addAttach=!ctrl.addAttach;">
							<span class="glyphicon glyphicon-plus"></span> 파일 추가
						</button>
					</div>
				</div>
				<!-- 작업 이력 -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">작업 이력<span class="pull-right glyphicon glyphicon-plus small" style="cursor:pointer;" id="view_list">더보기</span></div>
					</div>
					<div class="panel-body" id="history_list" style="display:none;">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>작업내용</th>
									<th>작성자</th>
									<th>작업자</th>
									<th>이력일자</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="history in ctrl.taskHistory">
									<td>{{$index + 1}}</td>
									<td>{{history.action}}</td>
									<td>{{history.creatorName}}</td>
									<td>{{history.workerName}}</td>
									<td>{{history.created|date:'yyyy-MM-dd HH:mm:ss'}}</td>
									<td><button type="button" class="btn btn-default btn-xs" ng-click="ctrl.detailHistory(history.historyId)">
										<span class="glyphicon glyphicon-zoom-in"></span>
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 작업 이력 -->
			</div>
		</div>
	</div>
	<div class="panel-footer">
		<span ng-show="ctrl.iamWorker">
		<button type="submit" class="btn btn-primary btn-sm" ng-click="ctrl.update()">
			<span class="glyphicon glyphicon-ok"></span> 확인
		</button>
		<span ng-hide="(ctrl.task.status == 'P' || ctrl.task.status == 'L') && ctrl.task.currentRate > 0">
		<button type="button" class="btn btn-warning btn-sm" ng-show="!ctrl.isOwner()" ng-click="ctrl.reject()">
			<span class="glyphicon glyphicon-ban-circle" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="작업을 반려하여 작성자에게 되돌립니다. 반려의견을 입력하여야 합니다." bs-tooltip></span> 반려
		</button>
		<button type="button" class="btn btn-success btn-sm" ng-show="!ctrl.isOwner()" ng-click="ctrl.delegate()">
			<span class="glyphicon glyphicon-user" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="작업을 다른 사용자에게 위임합니다. 위임 의견을 입력하여야 합니다." bs-tooltip></span> 위임
		</button>
		<button type="button" class="btn btn-danger btn-sm" ng-click="ctrl.hold()">
			<span class="glyphicon glyphicon-remove-circle" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="작업의 진행을 보류합니다. 보류 사유를 입력해야합니다." bs-tooltip></span> 보류
		</button>
		</span>
		</span>
		<button type="button" class="btn btn-danger btn-sm" ng-click="ctrl.cancel()" ng-show="ctrl.isOwner() && ctrl.task.status != 'F' && ctrl.task.status != 'C'">
			<span class="glyphicon glyphicon-ban-circle" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="작업을 삭제합니다. 삭제 사유를 입력해야합니다." bs-tooltip></span> 삭제
		</button>
		<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.gotoList()">
			<span class="glyphicon glyphicon-list" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="사용자의 작업 목록화면으로 이동합니다." bs-tooltip></span> 목록
		</button>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#view_list').on('click', function() {
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