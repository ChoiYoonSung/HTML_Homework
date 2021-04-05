/**
 * 
 */
var pop;
function proc() {
	pop = window.open("http://google.com");
}
function proc2() {
	pop.close();
}

function showMsg() {
// 		window.setTimeout();
// 		setTimeout(alertMsg, 3000);
setTimeout(function () {
	alert("타이머 썼어유");
}, 3000);

window.setTimeout(function (){
	alert("왜 이래유~");
	}, 5000);
	
}
// 	function alertMsg() {
// 		alert("타이머 썼어유");
// 	}

function changeBgColor(){
	setInterval(changeColr, 3000);
}
function changeColr(){
	//랜덤으로 색을 만들어서 p태그의 배경을 넣어주기
	//1.랜덤 색 뽑기
	var r = 0, g = 0, b = 0; //0~255
	r = Math.floor(Math.random() * 256);
	g = Math.floor(Math.random() * 256);
	b = Math.floor(Math.random() * 256);
	
	//2.p태그에 배경색 주기
	document.getElementById("pInterval").style.backgroundColor
	= "rgb(" + r + ", " + g + ", " + b + ")";
	// "red", "#ff0055", "rgb(255,0,255)"
}






