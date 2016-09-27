+++
date = "2016-09-27T23:09:27+09:00"
draft = false
title = "Rails5で爆速チャットアプリを作ってみた"
slug = "rails5 chat app"
author = "nabeen"
categories = ["rails"]
tags = ["rails","ruby","action cable"]

+++

どうも僕([@nabeen](https://github.com/nabeen))です。

Rails5では、コアを構成するライブラリにAction Cableが追加されました。これを使うと、Web Socketを使ったリアルタイムなチャットアプリケーションが簡単に作れるらしい、、！？

※本記事は[WEB+DB PRESS Vol.93](http://gihyo.jp/magazine/wdpress/archive/2016/vol93)の内容を一部改変したものになります。

## 前準備
まずはローカルにプロジェクト用のディレクトリを掘る。

```bash
$ mkdir trailen
$ cd trailen
```

んでgit管理下にして、`README.md`を追加しておきます。

```bash
$ git init
$ touch README.md
$ echo "trailen" >> README.md
```

`.gitignore`は`gibo`で作るのがトレンドだと信じているので、giboを使って生成しようそうしよう。

```bash
$ touch .gitignore
$ gibo OSX Ruby Rails Vagrant JetBrains >> .gitignore
```

## 開発環境構築
僕は[rails-dev-box](https://github.com/rails/rails-dev-box#whats-in-the-box)をベースにちょこっとカスタマイズして使いました。基本、cloneして来るだけで使えるのでここでは詳細は割愛。

後は簡単ですね。

```bash
$ vagrant up
$ vagrant ssh
```

## Railsのインストール
グローバルに`rails`をインストールします。

```bash
$ sudo gem install rails
$ rails -v
Rails 5.0.0.1
```

最新版ｷﾀ━━━━(ﾟ∀ﾟ)━━━━!!

## 新規アプリの作成
テストなし、DBをmysqlで作成します。完全に僕の好みです。テストはRspec使いたいんでね（この記事では書きません）。

```bash
$ rails new trailen -T -d mysql
```

DBは作ってくれないので、ここは手動で。

```sql
mysql> create database trailen_development;
Query OK, 1 row affected (0.00 sec)
```

ここまで来ればサーバー起動でデフォルト画面が表示されます（DBのパスワードとかはちゃんと設定してね）。rails5になってデフォルト画面変わっていることに少しの感動を覚える僕。

```bash
$ rails s -b 0.0.0.0 -p 8888
```

## コントローラーの作成
長い前準備が終わり、ようやく本命のチャットアプリに着手します。ジェネレータでチャット表示用のコントローラーを作成します。

```bash
$ ./bin/rails g controller rooms show
```

## モデルの作成
次は当然モデルですね。メッセージ保存用。

```bash
$ ./bin/rails g model message content:text
$ ./bin/rails db:migrate
```

## ビューの作成
本体と、

```haml
<h1>Chat room</h1>

<div id="messages">
  <%= render @messages %>
</div>
```

パーシャル。

```haml
<div class="message">
  <p><%= message.content%></p>
</div>
```

## チャネルの作成
んで、これまたジェネレータでチャンネルを作っていきます。

```bash
$ ./bin/rails g channel room speak
Running via Spring preloader in process 11323
      create  app/channels/room_channel.rb
   identical  app/assets/javascripts/cable.js
      create  app/assets/javascripts/channels/room.coffee
```

`app/channels/room_channel.rb`と`app/assets/javascripts/channels/room.coffee`が作成されました（ナニコレ）。前者がサーバーサイドの処理、後者がフロント側の処理を担当するっぽい。

んで、ここまでくればWebSocketのコネクションが貼れるはずだったんだけど、ここでエラーが発生します。どうやら許可されていないホストらしい。わざわざ許可せないかんのか。

```bash
Started GET "/cable" for 192.168.33.1 at 2016-09-27 12:40:45 +0000
Cannot render console from 192.168.33.1! Allowed networks: 127.0.0.1, ::1, 127.0.0.0/127.255.255.255
Started GET "/cable/" [WebSocket] for 192.168.33.1 at 2016-09-27 12:40:45 +0000
Request origin not allowed: http://192.168.33.33:8888
Failed to upgrade to WebSocket (REQUEST_METHOD: GET, HTTP_CONNECTION: Upgrade, HTTP_UPGRADE: websocket)
Finished "/cable/" [WebSocket] for 192.168.33.1 at 2016-09-27 12:40:45 +0000
```

先人によると、設定を追加してあげないといけないようで、

参考：[Action CableのREADMEを読んでみた！](http://morizyun.github.io/blog/action-cable-introduction-reading/)

僕の環境だと、以下の設定を`config/environments/development.rb`に追記してあげました。ここは人それぞれだと思うので、自信の環境に合うように設定してください。

```ruby
config.action_cable.allowed_request_origins = ['http://localhost:8888']
```

追記して再起動したらOKになりました。うん、いいね順調順調。

```bash
Finished "/cable/" [WebSocket] for 10.0.2.2 at 2016-09-27 12:43:43 +0000
Started GET "/cable" for 10.0.2.2 at 2016-09-27 12:43:43 +0000
Cannot render console from 10.0.2.2! Allowed networks: 127.0.0.1, ::1, 127.0.0.0/127.255.255.255
Started GET "/cable/" [WebSocket] for 10.0.2.2 at 2016-09-27 12:43:43 +0000
Successfully upgraded to WebSocket (REQUEST_METHOD: GET, HTTP_CONNECTION: Upgrade, HTTP_UPGRADE: websocket)
RoomChannel is transmitting the subscription confirmation
```

あとはもうガーッとコーディングしていけば完成！DBに突っ込んだりイベント発火させたりわちゃわちゃわちゃわちゃ必要だもんね。ガーッと書きましょう。ガーッと。

で、この時点のコードを見たい方は[Github](https://github.com/nabeen/trailen/tree/chat-app-base)に乗せていますので、そちらをご参照あれ（書く気力がなくなった）。
もちろん本番で運用する場合はもっと設定が必要ですが、とりあえずサクッと作れそうだなという感触は得られましたね。

## おわりに
今回はサクッと作るところまでで終わったけど、最終的にはあれやこれやしてメインのWEBアプリのサブ機能的な位置づけでひっそり存在するくらいにはしていきたいという願望。

ぼくはれいるずとおともだちになるんだ！

