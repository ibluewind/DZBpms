'use strict';

App
.constant('approveStatus', {
	SAVED: 'S',
	FINISH: 'F',
	PROCESSING: 'P',
	DEFERRED: 'D',
	REJECT: 'R'
})
.constant('approveTrayType', {
	UNDECIDE: 'U',
	COMPLETED: 'C',
	DEFER: 'D',
	EXPECTED: 'E',
	REJECT: 'R'
});