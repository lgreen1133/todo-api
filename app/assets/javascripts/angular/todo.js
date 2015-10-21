angular.module('todoApp', [])
  .controller('TodoListController', ['$scope','$http', function($scope,$http) {
    var todoList = this;
    var current_user_id = $('#user_id').val();

    $http({
      method: 'GET',
      url: '/api/lists'
    }).then(function successCallback(response) {
      console.log(response);
      todoList.todos = response.data.lists;
      // this callback will be called asynchronously
      // when the response is available
    }, function errorCallback(response) {
      console.log(response);
      // called asynchronously if an error occurs
      // or server returns response with an error status.
    });
 
    todoList.addTodo = function() {
      $http({
        method: 'POST',
        url: '/api/users/' + current_user_id + '/lists',
        data: {
          list: {name: todoList.todoText,
                permissions: todoList.permissions }
        }
      }).then(function successCallback(response) {
        console.log(response);
        todoList.todos.push(response.data.list);
        todoList.todoText = ''; 
      }, function errorCallback(response) {
        console.log(response);
      });
    };

    todoList.addItem = function(todo) {
      $http({
        method: 'POST', 
        url: '/api/lists/' + todo.id + '/items',
        data: {
          item: {name: todo.newItem,
            complete: 'false' }
        }

      }).then(function successCallback(response) {
        todo.items.push(response.data.item);
        todo.newItem = ''; 

      }, function errorCallback(response) {
        console.log(response);

      });
    };

    todoList.remaining = function() {
      var count = 0;
      angular.forEach(todoList.todos, function(todo) {
        count += todo.done ? 0 : 1;
      });
      return count;
    };
 
    todoList.remove = function() {
      // var oldTodos = todoList.todos;
      // todoList.todos = [];
      angular.forEach(todoList.todos, function(todo) {
        if(todo.complete) {
          // hit list API and destroy list
          $http({
            method: 'DELETE',
            url: '/api/users/' + current_user_id + '/lists/' + todo.id 
          }).then(function successCallback(response) {
            console.log(response);
            todoList.todos.filter(function(t,index) {
              if(t.id == todo.id) {
                todoList.todos.splice(index,1);
              };
            });
          }, function errorCallback(response) {
            console.log(response);
          }); 
        } else {
          angular.forEach(todo.items, function(item) {
            if(item.complete) {
              $http({
                method: 'DELETE', 
                url: '/api/items/' + item.id                

              }).then(function successCallback(response) {
                console.log(response);
                // todo.items.push(response.data.item);
                // todo.newItem = ''; 
                  todo.items.filter(function(i,index) {
                  if(i.id == item.id) {
                    todo.items.splice(index,1);
                  };
                });
              }, function errorCallback(response) {
                console.log(response);
              });
            };          
          })
        };
      });
    };
  }]);