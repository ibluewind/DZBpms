<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">작업 {{ctrl.edit ? "수정" : "생성"}}</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" name="form">
			<div class="form-group">
				<label class="col-md-4 control-label" for="title">제목</label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="title" ng-model="ctrl.task.title" placeholder="제목을 입력하세요." required/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="userName">작성자</label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="userName" ng-model="ctrl.task.userName" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="workerName">담당자</label>
				<div class="col-md-6">
					<input type="text" class="form-control" id="workerName" ng-model="ctrl.task.workerName" ng-click="ctrl.selectWorker()" readonly required
					data-placement="bottom" data-type="info" data-animation="am-fade-and-scale" data-title="담당자를 지정하려면 클릭하십시오." bs-tooltip/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="endDate"><i class="fa fa-calendar"></i>작업기한</label>
				<div class="col-md-6">
					<input type="text" class="form-control input-sm" id="endDate" ng-model="ctrl.task.endDate" data-min-date="today" data-autoclose="true" data-start-week="0" bs-datepicker required/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="priority">중요도</label>
				<div class="col-md-6">
					<select class="form-control" id="priority" ng-model="ctrl.task.priority" required>
						<option value='H'>상</option>
						<option value='M'>중</option>
						<option value='L'>하</option>
						<option value='E'>긴급</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="opened">공개</label>
				<div class="col-md-6">
					<div class="radio">
						<label data-placement="right" data-type="info" data-animation="am-fade-and-scale" data-title="팀 내부 사용자에게만 작업을 공개합니다." bs-tooltip>
							<input type="radio" name="opened" value="T" ng-model="ctrl.task.opened">팀내 공개
						</label>
					</div>
					<div class="radio">
						<label data-placement="right" data-type="info" data-animation="am-fade-and-scale" data-title="부서내 사용자에게 작업을 공개합니다." bs-tooltip>
							<input type="radio" name="opened" value="D" ng-model="ctrl.task.opened">부서 공개
						</label>
					</div>
					<div class="radio">
						<label data-placement="right" data-type="info" data-animation="am-fade-and-scale" data-title="작성자와 담당자외에 공개하지 않습니다." bs-tooltip>
							<input type="radio" name="opened" value="N" ng-model="ctrl.task.opened" checked>공개 안함
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="content">작업내용</label>
				<div class="col-md-6">
					<textarea id="content" class="form-control" rows="5" ng-model="ctrl.task.content" required></textarea>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
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
		<div class="row" ng-show="ctrl.edit">
			<div class="col-md-10 col-md-offset-1">
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
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="attach in ctrl.attachFiles">
									<td>{{attach.originName}}</td>
									<td>{{attach.size / 1024 / 1024 | number:2}} MB</td>
									<td>{{attach.modified}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="panel-footer">
						
					</div>
				</div>
				<!-- 작업 이력 -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">작업 이력</div>
					</div>
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>작업내용</th>
									<th>작성자</th>
									<th>작업자</th>
									<th>작성일</th>
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
					<div class="panel-footer">
					</div>
				</div>
				<!-- 작업 이력 -->
			</div>
		</div>
		
	</div>
	<div class="panel-footer">
		<button type="submit" class="btn btn-primary btn-sm" ng-disabled="form.$invalid" ng-click="ctrl.submit()">
			<span class="glyphicon glyphicon-ok"></span> 확인
		</button>
		<button type="button" class="btn btn-danger btn-sm" ng-click="ctrl.cancel()" ng-hide="ctrl.task.taskId==''">
			<span class="glyphicon glyphicon-ban-circle" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="작업을 삭제합니다." bs-tooltip></span> 삭제
		</button>
		<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.gotoList()">
			<span class="glyphicon glyphicon-list" data-placement="top" data-type="info" data-animation="am-fade-and-scale" data-title="사용자의 작업 목록화면으로 이동합니다." bs-tooltip></span> 목록
		</button>
	</div>
</div>