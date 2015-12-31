var app = angular.module("users",[]);
	
app.controller("UsersController", ["$scope", "$http", "$window", function($scope, $http, $window){
	this.checkAndRedirect = function(name){
		$http.post("/users/can_create?name=" + name).success(function(data){
			if (data.success == true){
				$window.location.href = data.url;
			}
			else{
				$scope.nameForm.nameInput.$setValidity('required', false);
			}
		});
	};
}]);