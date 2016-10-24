+++
author = "nabeen"
categories = ["bot"]
date = "2016-10-24T11:45:17+09:00"
draft = false
slug = "line-notify"
tags = ["LINE Notify"]
title = "LINE Notifyが楽しそうだったので試してみた"

+++

どうも僕([@nabeen](https://github.com/nabeen))です。

皆さん、LINE使ってますか？使ってますね？

イマドキ、連絡は絶対メールで！なんて古風なやり方を続けている方はIT界隈にはいないと思いますが、色んな通知を色んなサービスで受けるのはちょっとつらたん。。そこで、通知関連をLINEにまとめられると色々便利ですよね（多分）。

ただし、用法用量は守ってご利用ください（個人的に業務連絡をLINEでやるのは反対派です）。

## 手順
- アクセストークンの発行
- `Authorization: Bearer`に発行したトークンを入れてmessageをPOST

これだけ。簡単。

## なにわともあれトークン発行
まずは登録してアクセストークンを発行しましょう。

https://notify-bot.line.me/ja/

ポチポチするだけです。

## curlでPOSTしてみる
```
curl -X POST -H 'Authorization: Bearer <token>' -F 'message=<message>' https://notify-api.line.me/api/notify
```

通知が届きましたね。

こちらからは以上です。

参考：
[LINE Notifyをとりあえず使ってみる](http://qiita.com/okunoryo/items/88c002d74ab173706c93)

