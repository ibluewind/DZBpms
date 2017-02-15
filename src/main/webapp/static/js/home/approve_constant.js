'use strict';

App
.constant('approveStatus', {
	SAVED: 'S',
	FINISH: 'F',
	PROCESSING: 'P',
	DEFERRED: 'D',
	REJECT: 'R',
	CHECKED: 'C'
})
.constant('approveTrayType', {
	UNDECIDE: 'U',		// 미결함
	COMPLETED: 'C',		// 기결함
	FINISHED: 'F',		// 완료함
	DEFER: 'D',			// 보류함
	EXPECTED: 'E',		// 예정함
	REJECT: 'R'			// 반려함
});