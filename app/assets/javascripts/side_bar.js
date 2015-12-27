
var app = angular.module("sideBar",[]);
	
app.controller("TestsJsonController", ["$http", function($http){
	var testJasonCntr = this;
	this.filterBy = '-updated';
	this.filterSwitch = function(){
		this.filterBy = (this.filterBy[0] == '-'? this.filterBy.substr(1) : ('-' + this.filterBy));
	}

	this.testsJson = [];
	this.getTests = function(){
		$http.get("/side_bar/test_json").success(function(data){
			testJasonCntr.testsJson = data;
		});
	};
	this.getTests();

	this.getDate = function(dateTime){
		var monthThree = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
		var dateString = new Date(dateTime);
		var dateStringDay = dateString.getDate().toString();
		return (monthThree[dateString.getMonth()] + " " + (dateStringDay[1]?dateStringDay:"0"+dateStringDay[0]));
	};

	this.getTime = function(dateTime){
		var dateString = new Date(dateTime);
		var dateStringHours = dateString.getHours();
		return (dateStringHours.toString() + ":" + dateString.getMinutes().toString() + " " + ((dateStringHours >= 12) ? "PM" : "AM"));
	};

}]);


function hideSideBar(){
	$("#side-bar-circle").slideDown();
	$("#side-bar-container").slideUp();
}

function showSideBar(){
	$("#side-bar-container").slideDown();
	$("#side-bar-circle").slideUp();
}

// scrollBar
(function($){
    $(window).load(function(){
        $("#ul-tests-wrapper").mCustomScrollbar({
		    theme:"scroll-bar-theme"
		});
	});
})(jQuery);