<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="panel panel-default" ng-controller="ctrl" uploader="uploader" filters="queueLimit, customFilter">
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
								<button type="button" class="btn btn-danger btn-xs" ng-click="ctrl.remove(item)">
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