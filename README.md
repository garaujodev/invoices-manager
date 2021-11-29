# README

## Invoice Manager

 This application is a RESTful API written in Ruby on Rails to manage Invoices (CRUD) using [Use-cases](https://github.com/serradura/u-case).

### Description

It runs on **Ruby** `2.6.5` using **Rails** `6.1.4`. You can use your version manager to install it (We have `.tool-versions` and `.ruby-version` files)

```console
$ asdf install // if you are using asdf
```

### Configuration

Run the following steps:

```console
$ bundle install
$ bin/rails db:create db:schema:load
$ bin/rails server
```

To run the test suite:

```console
$ bin/rails test
```

### Collection

You can import the collection in Postman using [this link](https://www.getpostman.com/collections/d2d194331af7280df167).

To use the endpoints you will need to create your token:

- Send a `POST` request to `/users/registrations` with the following content:

  ```json
  {
      "user": {
          "email": "youremail@example.com"
      }
  }
  ```

- If your email is valid, it will return the token. The will can be sent to your email address, but you need to configure your STMP, or just follow the next step.

  - To got the email in `dev` environment, you can use the `mailcatcher`:

    ```console
    $ mailcatcher
    ```

  - Later, just access your localhost in port `1080` (eg.: http://127.0.0.1:1080/)

Now, with your token in hands, just put it on request `HEADERS`:

```console
curl --location --request GET 'http://localhost:3000/invoices/:id' \
--header 'Authorization: Bearer token="5037a84f-e842-4ac9-b2c2-fdf2a28a8430"'
```
