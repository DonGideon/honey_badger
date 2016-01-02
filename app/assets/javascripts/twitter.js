var app = angular.module("twitter",[]);
	
app.controller("TwitterController", ["$http", "$window", function($http, $window){
	this.tab = 0;
	this.loadAjax = false;
	this.tweets = []
	this.search_history = []
	var twitterCtrl = this;
	this.filterSwitch = function(){
		this.filterBy = (this.filterBy[0] == '-'? this.filterBy.substr(1) : ('-' + this.filterBy));
	}

	this.getAjax = function(url, dataArr){
		twitterCtrl.loadAjax = true;
		$http.get(url).success(function(data){
			if (data.error){
				$window.location.href = data.url;
			}
			else{
				twitterCtrl[dataArr] = data;
			}
				twitterCtrl.loadAjax = false;
		});
	};

	this.searchTweets = function(){
		this.getAjax("/twitter/search_tweets", "tweets");
	};

	this.getHistory = function(){
		this.getAjax("/twitter/history", "search_history");
	};

	this.setTab = function(tab){
		this.tab = tab;
	};

	this.isTab = function(tab){
		return (this.tab === tab);
	};

	this.getDate = function(s){
		return (new Date(s))
	};
}]);

app.directive("imageLoadingAjax", function() {
  return {
    restrict: "E",
    replace: true,
    template: "<img class='img-ajax' src='/images/ajax-loader.gif' ng-show='twitterCtrl.loadAjax'/>"
  };
});