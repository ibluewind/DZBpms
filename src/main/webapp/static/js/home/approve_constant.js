'use strict';

App
.constant('approveStatus', {
	CHECKED: 'C',
	SAVED: 'S',
	FINISH: 'F',
	PROCESSING: 'P',
	DEFERRED: 'D',
	REJECT: 'R'
})
.constant('approveTrayType', {
	UNDECIDE: 'U',		// 미결함
	COMPLETED: 'C',		// 완료함
	FINISHED: 'F',		// 기결함
	REJECT: 'R',		// 반려함
	DEFER: 'D',			// 보류함
	EXPECTED: 'E',		// 예정함
	REFER: 'S',			// 참조함
	AGREE: 'A'			// 합의함
}).
constant('approveLineType', {
	PROCESS: 'P',		// 처리부서
	REQUEST: 'R',		// 의뢰부서
	REFER: 'S',			// 참조
	AGREE: 'A'			// 합의
});