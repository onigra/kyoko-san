# setup

```sh
install MySQL

git clone
bundle install
rake db:create
rake db:migrate
rails s
```

# usage

```sh
# index
$ curl -v -X GET "http://0.0.0.0:3000/books" -d ''

# show
$ curl -v -X GET "http://0.0.0.0:3000/books/1" -d ''

# create
$ curl -v -H 'Content-Type: application/json; charset=UTF-8' -X POST "http://0.0.0.0:3000/books/" -d '{"book": {"name": "パーフェクトRuby", "isbn": "978-4774158792"}}'

# udpate
$ curl -v -H 'Content-Type: application/json; charset=UTF-8' -X PATCH "http://0.0.0.0:3000/books/" -d '{"book": {"name": "Perfect Ruby"}}'

# destroy
$ curl -v -X DELETE "http://0.0.0.0:3000/books/1" -d ''
```
