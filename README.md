# Open Todo API

The purpose of this project is to build an externally usable API for a basic todo list application. This API will allow users to modify user accounts and todo items from the command line.

This project was completed as part of my [Bloc](https://www.bloc.io) Rails Web Development course. 

#### Notes

* http basic auth was implemented for API authentication
* Front-end was also built and devise was incorporated 
* Users, lists and items were serialized by implementing [Active Model Serializers](https://github.com/rails-api/active_model_serializers)

#### Using Curl Commands

*Create User*

```
$ curl -u username:password -d "user[username]=Sterling" -d "user[password]=Archer" http://localhost:3000/api/users/
```

*Create List*

```
$ curl -u username:password -d "list[name]=Things to do today" -d "list[permissions]=private" http://localhost:3000/api/users/1/lists
```

*Create Item*

```
$ curl -u username:password -d "item[name]=Dance if you want to" http://localhost:3000/api/lists/1/items
```


