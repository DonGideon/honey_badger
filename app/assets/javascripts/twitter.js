var app = angular.module("twitter",[]);
	
app.controller("TwitterController", ["$http", function($http){
	this.tab = 0;
	this.tweets = []
	var twitterCtrl = this;
	this.filterBy = '-updated';
	this.filterSwitch = function(){
		this.filterBy = (this.filterBy[0] == '-'? this.filterBy.substr(1) : ('-' + this.filterBy));
	}

	this.searchTweets = function(){
		$http.get("/twitter/search_tweets").success(function(data){
			twitterCtrl.tweets = data;
		});
	};

	this.getHistory = function(){
		$http.get("/twitter/history").success(function(data){
			testJasonCntr.testsJson = data;
		});
	};

	this.setTab = function(tab){
		this.tab = tab;
	};

	this.isTab = function(tab){
		return (this.tab === tab);
	};
}]);