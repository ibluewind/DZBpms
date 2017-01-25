<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">양식 {{ctrl.edit ? "수정" : "등록"}}</div>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-horizontal" name="form">
						<div class="form-group">
							<label class="col-md-2 control-label">양식명</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-sm" ng-model="ctrl.form.title" required/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">설명</label>
							<div class="col-md-9">
								<textarea class="form-control" rows="10" ng-model="ctrl.form.comment"></textarea>
							</div>
						</div>
					</form>
					<!-- file Uploader -->
					<div class="col-md-offset-2 col-md-9" ng-controller="fileController as fc" uploader="uploader" filters="queueLimit" ng-hide="ctrl.edit && ctrl.hasFormFile">
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
						<div class="row" ng-hide="fc.readyToUpload">
							<label class="col-md-4 control-label" for="file">파일선택</label>
							<div class="col-md-6">
								<input type="file" id="formFile" uploader="uploader" nv-file-select/>
							</div>
						</div>
					</div>
					<!-- form file -->
					<div class="row" ng-show="ctrl.edit && ctrl.hasFormFile">
						<div class="col-md-offset-2 col-md-9">
							<div class="panel panel-default">
								<div class="panel-heading"><div class="panel-title">양식 파일</div></div>
								<div class="panel-body">
									<table class="table">
										<thead>
											<tr>
												<th>파일명</th>
												<th>크기</th>
												<th>수정일자</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr ng-repeat="file in ctrl.formFile">
												<td>{{file.originName}}</td>
												<td>{{file.size/1024/1024|number:2}} MB</td>
												<td>{{file.modified|date:'yyyy-MM-dd HH:mm:ss'}}</td>
												<td>
													<a type="button" class="btn btn-default btn-xs" href="{{'/bpms/file/download/' + file.attachId}}"><span class="glyphicon glyphicon-download-alt"></span></a>
													<button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.deleteFormFile()"><span class="glyphicon glyphicon-trash"></span></button>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-offset-2 col-md-9">
							<div class="panel panel-default">
								<div class="panel-heading">
									<div class="panel-title">결재 처리 부서</div>
								</div>
								<div class="panel-body">
									<div class="form-group">
										<label class="col-md-4 control-label">처리부서 선택</label>
										<div class="col-md-5">
											<input type="text" class="form-control input-sm" ng-model="ctrl.form.procDeptName" readonly>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-default btn-sm" ng-click="ctrl.selectProcessDepartment()">선택</button>
											<button type="button" class="btn btn-danger btn-sm" ng-click="ctrl.deleteProcessDepartment()"><span class="glyphicon glyphicon-trash"></span></button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-footer">
		<button type="button" class="btn btn-primary btn-sm" ng-click="ctrl.submit()" ng-disabled="form.$invalid">{{ctrl.edit ? "저장" : "등록"}}</button>
	</div>
</div>