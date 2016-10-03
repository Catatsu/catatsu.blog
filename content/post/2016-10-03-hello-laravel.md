+++
author = "nabeen"
categories = ["php", "Laravel"]
date = "2016-10-03T20:51:42+09:00"
draft = false
slug = "hello-laravel"
tags = ["php", "laravel", "homestead", "artisan"]
title = "PHP界隈で一番ナウい（けど遅い）という噂のLaravelをサクッと触ってなんとなく理解する"

+++

どうも僕([@nabeen](https://github.com/nabeen))です。

RubyにはRailsというRubyのフレームワークといえばコレ！みたいなものがあるんですが、残念ながらPHP界隈にはRailsに該当するようなフレームワークはありません。

そんな中、個人的に一番ナウいと思っているPHPフレームワークLaravelに触れるべく、サンプルアプリを通してその使いやすさを実感してみようと思います！

## 開発環境構築
ナウいフレームワークだけあって、Laravelは`composer`で入れる、また、`vagrant`も標準で準備されています。最高！最高！ふぅうううーーーーーー！！

```bash
$ composer require laravel/homestead
```

```bash
$ php vendor/bin/homestead make
```

ここまでやれば`vagrant up`までたどり着きます。マジかよ楽かよ。

```bash
$ vagrant up
```

```bash
$ vagrant ssh
```

あとはアプリをサクッと作るぜ！

```bash
$ composer create-project laravel/laravel --prefer-dist laravel-apps
```

とここまで来て気づいたんですが、プロジェクト配下でアプリを作ってしまったので階層がちょっと気持ち悪い感じになってしまいました。

のでちょっと変えて、こんな感じに。`vagrant`関連はvagrant配下に押しやっています。ちょっとスッキリ。

```bash
$ tree -L 1 ./
./
├── app
├── artisan
├── bootstrap
├── composer.json
├── composer.lock
├── config
├── database
├── gulpfile.js
├── package.json
├── phpunit.xml
├── public
├── readme.md
├── resources
├── routes
├── server.php
├── storage
├── tests
├── vagrant
└── vendor
```

あとはブラウザから`http://192.168.10.10/`を叩けば、デフォルトページが出ていますね！ね？え？出るよね？

## チュートリアル
公式にはチュートリアル的なものがなかったので、[こちら](http://qiita.com/fumiyasac@github/items/78a335880f7abb1de8bf)のチュートリアル的なのを参考に、Laravelっていきます。

やることはリンク先にある通りなので爆、ポイントをかいつまんで説明します。

マイグレーションファイルを作るコマンドは以下。中身は完全Skeletonなので、自分でガリガリ書いていきましょう。書くべし書くべし！

```bash
$ php artisan make:migration create_topics_table
```

マイグレーションの適用もちゃんとコマンドで。

```bash
$ php artisan migrate
```

戻したければロールバックもできる。ロールバックは、「前回適用したもの」がロールバックされるようだ（※一気に幾つかマイグレーションしたら一気にいくつかロールバックされる）。

```bash
$ php artisan migrate:rollback
```

モデルもジェネレータで生成できる。

```
$ php artisan make:model Topic
```


ときたら当然コントローラーもジェネレータで生成できます。

```
$ php artisan make:controller TopicsController
```

でもこれ、ホント単一ファイル(テストもないしViewもない)しか生成してくれないので、そんなに使い勝手は良くないかも。。コレくらいだったら`cp`でコピーしちゃった方がいいかもしんない。

まぁそれは置いといて、`rails c`的なあれもあります。

```
$ php artisan tinker
```

ルーティングは前のバージョンとは変わっていて、`routes/web.php`で定義されてるっぽい。設定されているルーティングを見るにはこのコマンド。`resource`でRESTfulなURIも生成できる！Railsライクですね。

```bash
$ php artisan route:list
+--------+----------+--------------------+------+----------------------------------------------+--------------+
| Domain | Method   | URI                | Name | Action                                       | Middleware   |
+--------+----------+--------------------+------+----------------------------------------------+--------------+
|        | GET|HEAD | /                  |      | App\Http\Controllers\TopicsController@index  | web          |
|        | GET|HEAD | api/user           |      | Closure                                      | api,auth:api |
|        | GET|HEAD | topics/add         |      | App\Http\Controllers\TopicsController@add    | web          |
|        | POST     | topics/create      |      | App\Http\Controllers\TopicsController@create | web          |
|        | POST     | topics/delete      |      | App\Http\Controllers\TopicsController@delete | web          |
|        | GET|HEAD | topics/edit/{id}   |      | App\Http\Controllers\TopicsController@edit   | web          |
|        | POST     | topics/update/{id} |      | App\Http\Controllers\TopicsController@update | web          |
|        | GET|HEAD | topics/{id}        |      | App\Http\Controllers\TopicsController@show   | web          |
+--------+----------+--------------------+------+----------------------------------------------+--------------+
```

とまぁこんな感じで←え、なんとなくざっくり理解できました。

ここまでのソースは[Github](https://github.com/nabeen/laravel_apps/tree/hello-laravel)にあげているので、ご自由にどうぞ。

## ちょっと気に食わないところ
箇条書きでいきます。

- ControllerがHttp配下にあるのが慣れない
- ModelがApp直下にあるのはどうなの？
- ルーティングファイルの名前が`web.php`だと？

まだ殆どLaravelのメリットは感じられていませんが、とりあえず慣れ親しんだ感じのフォルダ構成から結構逸脱してるなぁという印象。まぁこういうのは慣れだし、そこまで障害にはならないんですが（自分好みの定義にも変えられるんだろうけど、なるべくデフォルトから逸脱したくはない）。

## おわりに
なんか全然Laravelの機能が把握できなかった気がするけど、触りとしてはこんなもんでいいですかね？

次回はソーシャルログイン辺りを実装していきます。
