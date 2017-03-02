<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<div class="container">
	<div class="row" id="calendar">
		<div class="col-md-3 hidden-xs hidden-sm" style="border-right:1px solid #ccc;" ng-controller="miniCalendarController as ctrl">
			<div class="row nav_bar">
				<div class="col-md-2 text-left"><i class="glyphicon glyphicon-chevron-left" ng-click="ctrl.gotoPrevMonth()"></i></div>
				<div class="col-md-8 text-center calendar-header">{{ctrl.currentDate.getFullYear()}}년 {{ctrl.currentDate.getMonth()+1}}월</div>
				<div class="col-md-2 text-right"><i class="glyphicon glyphicon-chevron-right" ng-click="ctrl.gotoNextMonth()"></i></div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="mini-calendar">
						<div class="calendar-row">
							<span class="calendar-week">일</span>
							<span class="calendar-week">월</span>
							<span class="calendar-week">화</span>
							<span class="calendar-week">수</span>
							<span class="calendar-week">목</span>
							<span class="calendar-week">금</span>
							<span class="calendar-week">토</span>
						</div>
						<div class="calendar-row" ng-repeat="cell in ctrl.calendar">
							<span class="calendar-cell" ng-repeat="d in cell track by $index" ng-class="[{'current-month':ctrl.isCurrentMonth(d)}, {'not-current-month':!ctrl.isCurrentMonth(d)}]"> {{d.getDate()}}</span>
						</div>
						<!-- div class="calendar-row">
							<span class="calendar-cell">29</span>
							<span class="calendar-cell">30</span>
							<span class="calendar-cell">31</span>
							<span class="calendar-cell">1</span>
							<span class="calendar-cell">2</span>
							<span class="calendar-cell">3</span>
							<span class="calendar-cell">4</span>
						</div-->
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-9" ng-controller="calendarController as ctrl">
			<div class="row nav_bar">
				<div class="col-md-6 col-xs-12">
					<div class="row">
						<div class="col-md-1 col-xs-1 text-center">
							<h4><i class="glyphicon glyphicon-chevron-left"></i></h4>
						</div>
						<div class="col-md-1 col-xs-1 text-center">
							<h4><i class="glyphicon glyphicon-chevron-right"></i></h4>
						</div>
						<div class="col-md-5 col-xs-8 text-center calendar-header">
							<h4>{{ctrl.currentDate.getFullYear()}}년 {{ctrl.currentDate.getMonth() + 1}}월</h4>
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
			<div class="row">
				<div class="col-md-12">
					<div class="calendar-row">
						<span class="calendar-week">일요일</span>
						<span class="calendar-week">월요일</span>
						<span class="calendar-week">화요일</span>
						<span class="calendar-week">수요일</span>
						<span class="calendar-week">목요일</span>
						<span class="calendar-week">금요일</span>
						<span class="calendar-week">토요일</span>
					</div>
					<div class="calendar-row top-border" ng-repeat="cell in ctrl.calendar">
						<span class="calendar-cell" style="height:140px;" ng-repeat="d in cell track by $index" ng-class="[{'not-current-month':!ctrl.isCurrentMonth(d)}, {'today':ctrl.isToday(d)}]"> {{d.getDate()}}</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>