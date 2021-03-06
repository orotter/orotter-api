# How to launch orotter api for Windows

## 1. Install Hyper-V

[こちら](https://msdn.microsoft.com/ja-jp/virtualization/hyperv_on_windows/quick_start/walkthrough_install)を参考に、Hyper-Vをインストールする。要Windows10 Pro

## 2. Install Docker

[Docker](https://www.docker.com/)のサイトから、Docker for Windowsをダウンロードし、インストールする

Docker for Windowsをインストール後、設定からCドライブを共有設定にしておくのを忘れない（これをしないとローカルのファイル群とマッピングできない）

## 3. Launch

App, DBはdocker-composeで起動できる

```
# git clone https://github.com/orotter/orotter-api.git
# cd orotter-api
# docker-compose build
# docker-compose run -d app bash -c "bundle exec rake db:create"
# docker-compose run -d app bash -c "bundle exec rake db:migrate"
# docker-compose run -d app bash -c "bundle exec rake db:seed"
# docker-compose up
```

# Orotter API References
Orotter API References
簡易化のために、CSRF対応はOFFにしています
また、ログイン認証もOAuthなどは使用せず、パラメータを付与してリクエストするだけでできるようになっています


* [つぶやき](#つぶやき)
 * [GET /api/v1/t](#get-apiv1t)
 * [GET /api/v1/u/:id/t](#get-apiv1uidt)
 * [POST /api/v1/t/create](#post-apiv1tcreate)
 * [GET /api/v1/t/:id/favorite](#get-apiv1tidfavorite)
 * [GET /api/v1/t/:id/unfavorite](#get-apiv1tidunfavorite)
* [ユーザー](#ユーザー)
 * [GET /api/v1/u](#get-apiv1u)
 * [POST /api/v1/u/login](#post-apiv1ulogin)
 * [GET /api/v1/u/logout](#get-apiv1ulogout)
 * [GET /api/v1/u/current](#get-apiv1ucurrent)
 * [POST /api/v1/u/signup](#post-apiv1usignup)
 * [GET /api/v1/u/:id/follow](#get-apiv1uidfollow)
 * [GET /api/v1/u/:id/unfollow](#get-apiv1uidunfollow)
 * [GET /api/v1/u/follows](#get-apiv1ufollows)
 * [GET /api/v1/u/followers](#get-apiv1ufollowers)

## つぶやき


### Properties
* id
 * Example: `1`
 * Type: integer
* user_id
 * Example: `1`
 * Type: integer
* text
 * Example: `"オロなう"`
 * Type: string
 * Pattern: `/.*{1, 140}/`
* created_at
 * Example: `"2015-08-05T06:50:24.000Z"`
 * Type: string
* updated_at
 * Example: `"2015-08-05T06:50:24.000Z"`
 * Type: string
* favorites
 * Example: `100`
 * Type: integer
* user
 * Type: object

### GET /api/v1/t
ログイン中のユーザーとフォローしているユーザーのつぶやき一覧を返す

```
GET /api/v1/t HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "user_id": 1,
    "text": "オロなう",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "favorites": 100,
    "user": {
      "id": 1,
      "username": "balmychan",
      "name": "Ayumi Goto",
      "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
      "created_at": "2015-08-05T06:50:24.000Z",
      "updated_at": "2015-08-05T06:50:24.000Z",
      "follows_count": 20,
      "followers_count": 20,
      "tweets_count": 1200
    }
  }
]
```

### GET /api/v1/u/:id/t
指定のユーザーのつぶやき一覧を返す

```
GET /api/v1/u/1/t HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "user_id": 1,
    "text": "オロなう",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "favorites": 100,
    "user": {
      "id": 1,
      "username": "balmychan",
      "name": "Ayumi Goto",
      "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
      "created_at": "2015-08-05T06:50:24.000Z",
      "updated_at": "2015-08-05T06:50:24.000Z",
      "follows_count": 20,
      "followers_count": 20,
      "tweets_count": 1200
    }
  }
]
```

### POST /api/v1/t/create
つぶやきを投稿する

* text
 * Example: `"オロなう"`
 * Type: string

```
POST /api/v1/t/create HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 201 Created
Content-Type: application/json

[
  {
    "id": 1,
    "user_id": 1,
    "text": "オロなう",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "favorites": 100,
    "user": {
      "id": 1,
      "username": "balmychan",
      "name": "Ayumi Goto",
      "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
      "created_at": "2015-08-05T06:50:24.000Z",
      "updated_at": "2015-08-05T06:50:24.000Z",
      "follows_count": 20,
      "followers_count": 20,
      "tweets_count": 1200
    }
  }
]
```

### GET /api/v1/t/:id/favorite
つぶやきをお気に入りする

```
GET /api/v1/t/1/favorite HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "user_id": 1,
  "text": "オロなう",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "favorites": 100,
  "user": {
    "id": 1,
    "username": "balmychan",
    "name": "Ayumi Goto",
    "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "follows_count": 20,
    "followers_count": 20,
    "tweets_count": 1200
  }
}
```

### GET /api/v1/t/:id/unfavorite
つぶやきのお気に入りを解除する

```
GET /api/v1/t/1/unfavorite HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "user_id": 1,
  "text": "オロなう",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "favorites": 100,
  "user": {
    "id": 1,
    "username": "balmychan",
    "name": "Ayumi Goto",
    "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "follows_count": 20,
    "followers_count": 20,
    "tweets_count": 1200
  }
}
```

## ユーザー


### Properties
* id
 * Example: `1`
 * Type: integer
* username
 * Example: `"balmychan"`
 * Type: string
* name
 * Example: `"Ayumi Goto"`
 * Type: string
* image
 * Example: `"https://pbs.twimg.com/profile_images/1286698114/KM56TsK9"`
 * Type: string
* created_at
 * Example: `"2015-08-05T06:50:24.000Z"`
 * Type: string
* updated_at
 * Example: `"2015-08-05T06:50:24.000Z"`
 * Type: string
* follows_count
 * Example: `20`
 * Type: integer
* followers_count
 * Example: `20`
 * Type: integer
* tweets_count
 * Example: `1200`
 * Type: integer

### GET /api/v1/u
ユーザー検索

* keyword
 * Example: `"菊"`
 * Type: string

```
GET /api/v1/u?keyword=%E8%8F%8A HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "username": "balmychan",
    "name": "Ayumi Goto",
    "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "follows_count": 20,
    "followers_count": 20,
    "tweets_count": 1200
  }
]
```

### POST /api/v1/u/login
ログイン

* username
 * Example: `"balmychan"`
 * Type: string
* password
 * Example: `"hogehoge"`
 * Type: string

```
POST /api/v1/u/login HTTP/1.1
Content-Type: application/json
Host: orotter.com

{
  "username": "balmychan",
  "password": "hogehoge"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### GET /api/v1/u/logout
ログアウト

```
GET /api/v1/u/logout HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### GET /api/v1/u/current
現在ログイン中のユーザー情報を返す

```
GET /api/v1/u/current HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### POST /api/v1/u/signup
ユーザー作成

* username
 * Example: `"balmychan"`
 * Type: string
* name
 * Example: `"Ayumi Goto"`
 * Type: string
* password
 * Example: `"hogehoge"`
 * Type: string

```
POST /api/v1/u/signup HTTP/1.1
Content-Type: application/json
Host: orotter.com

{
  "username": "balmychan",
  "name": "Ayumi Goto",
  "password": "hogehoge"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### GET /api/v1/u/:id/follow
指定のユーザーをフォローする

```
GET /api/v1/u/1/follow HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### GET /api/v1/u/:id/unfollow
指定のユーザーのフォローを解除する

```
GET /api/v1/u/1/unfollow HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "username": "balmychan",
  "name": "Ayumi Goto",
  "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
  "created_at": "2015-08-05T06:50:24.000Z",
  "updated_at": "2015-08-05T06:50:24.000Z",
  "follows_count": 20,
  "followers_count": 20,
  "tweets_count": 1200
}
```

### GET /api/v1/u/follows
現在ログイン中のユーザーがフォローしているユーザーの一覧を返す

```
GET /api/v1/u/follows HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "username": "balmychan",
    "name": "Ayumi Goto",
    "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "follows_count": 20,
    "followers_count": 20,
    "tweets_count": 1200
  }
]
```

### GET /api/v1/u/followers
現在ログイン中のユーザーがフォローされているユーザーの一覧を返す

```
GET /api/v1/u/followers HTTP/1.1
Host: orotter.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "username": "balmychan",
    "name": "Ayumi Goto",
    "image": "https://pbs.twimg.com/profile_images/1286698114/KM56TsK9",
    "created_at": "2015-08-05T06:50:24.000Z",
    "updated_at": "2015-08-05T06:50:24.000Z",
    "follows_count": 20,
    "followers_count": 20,
    "tweets_count": 1200
  }
]
```

