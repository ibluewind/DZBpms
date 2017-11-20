'use strict';
App.controller('PageController', ['PageService', function(PageService) {
	
	var self = this;
	var _items = [];
	self.pager = {};
	self.items = [];
	
	initContoller();
	
	function initController() {
		self.setPage(1);
	}
	
	self.setItems = function(items) {
		_items = items;
	};
	
	self.setPage = function(page) {
		if (page < 1 || page > self.pager.totalPages)	return;
		
		self.pager = PageService.GetPager(self.items.length, page);
		self.items = _items.slice(self.pager.startIndex, self.pager.endIdex + 1);
	};
}]);