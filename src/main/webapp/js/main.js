

/*
window.addEventListener('DOMContentLoaded', (event) => {
	var w = window.innerWidth;
	if(w < 1200) {
		document.getElementById('sidebar').classList.remove('active');
	}
});
window.addEventListener('resize', (event) => {
	var w = window.innerWidth;
	if(w < 1200) {
		document.getElementById('sidebar').classList.remove('active');
		document.getElementById('wraper').classList.remove('margin3');
	}else{
		document.getElementById('sidebar').classList.add('active');
		document.getElementById('wraper').classList.add('margin3');
	}
});

document.querySelector('.burger-btn').addEventListener('click', () => {
	document.getElementById('sidebar').classList.toggle('active');
})
document.querySelector('.sidebar-hide').addEventListener('click', () => {
	document.getElementById('sidebar').classList.toggle('active');

})
*/

// Perfect Scrollbar Init
if (typeof PerfectScrollbar == 'function') {
	const container = document.querySelector(".sidebar-wrapper");
	const ps = new PerfectScrollbar(container, {
		wheelPropagation: false
	});
}

// Scroll into active sidebar
// document.querySelector('.sidebar-item.active').scrollIntoView(false)