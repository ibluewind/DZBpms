<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<div class="container">
	<div class="row" id="calendar">
		<div class="col-md-3 hidden-xs hidden-sm" style="border-right:1px solid #ccc;">
			<div class="row nav_bar">
				<div class="col-md-2 text-left"><i class="glyphicon glyphicon-chevron-left"></i></div>
				<div class="col-md-8 text-center calendar-header">2017년 2월</div>
				<div class="col-md-2 text-right"><i class="glyphicon glyphicon-chevron-right"></i></div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="mini-calendar">
						<div class="calendar-row">
							<span class="calendar-header">일</span>
							<span class="calendar-header">월</span>
							<span class="calendar-header">화</span>
							<span class="calendar-header">수</span>
							<span class="calendar-header">목</span>
							<span class="calendar-header">금</span>
							<span class="calendar-header">토</span>
						</div>
						<!-- div class="calendar-row" ng-repeat="cell in calendar">
							<span class="calendar-cell" ng-repeat="d in cell track by $index">{{d}}</span>
						</div-->
						<div class="calendar-row">
							<span class="calendar-cell">29</span>
							<span class="calendar-cell">30</span>
							<span class="calendar-cell">31</span>
							<span class="calendar-cell">1</span>
							<span class="calendar-cell">2</span>
							<span class="calendar-cell">3</span>
							<span class="calendar-cell">4</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-9">
			<div class="row nav_bar">
				<div class="col-md-6 col-xs-6">
					<div class="row">
						<div class="col-md-1 col-xs-1 text-center">
							<h4><i class="glyphicon glyphicon-chevron-left"></i></h4>
						</div>
						<div class="col-md-1 col-xs-1 text-center">
							<h4><i class="glyphicon glyphicon-chevron-right"></i></h4>
						</div>
						<div class="col-md-5 col-xs-4 text-center calendar-header">
							<h4>2017년 2월</h4>
						</div>
						<div class="col-md-1 col-xs-1 text-center">
							<h4><i class="glyphicon glyphicon-chevron-down"></i></h4>
						</div>
					</div>
				</div>
				<div class="col-md-6 hidden-xs hidden-sm">
					<div class="pull-right">
						<button class="btn btn-default">일</button>
						<button class="btn btn-default">주</button>
						<button class="btn btn-default">월</button>
					</div>
					<div class="pull-left">
						<button class="btn btn-info">오늘</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>