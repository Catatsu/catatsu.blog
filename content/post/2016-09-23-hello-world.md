+++
date = "2016-09-23T20:22:41+09:00"
draft = false
title = "Catatsuの技術ブログ始めました！"
slug = "initial commit"
author = "nabeen"
categories = ["information"]
tags = ["Hugo","Wercker","Github Pages"]

+++

どうも僕([@nabeen](https://github.com/nabeen))です。

有志でやってる[Catatsu](https://github.com/Catatsu)というプロジェクトがあるんですが、せっかくなのでってことでプロジェクト用のブログを立ち上げることにしました！エンジニア的にはアウトプットした方がいいしね？？

## どこで書くかを決める
金無し職無しスキル無しの僕らはそんなに高望みはしません。**無料で使えるものを最大限に活用します。**Tech Blogってこともあり、以下の点に重きを置いて選定しました。

- Markdownで書けること
- 一生涯無料で利用できること
- ギークな感じのするもの ← これ重要

もうここまでくれば決まったようなもの。Hugoを使って、Werckerでbuild、deployするのがベストプラクティスだと信じ、この構成で作りました。

## 構成
- [catatsu.github.io](https://github.com/Catatsu/catatsu.github.io)：Github Pagesホスティング用
- [catatsu.blog](https://github.com/Catatsu/catatsu.blog)：Hugo管理用

同じリポジトリだとなんだか面倒くさそうな匂いがプンプンしたので、サクッと作れて単純明快ということでホスティング用リポジトリと管理用リポジトリで分けています。

## 記事作成手順
デフォルトだとちょっと扱いづらいので、shellを叩いて記事を作成するようにしてあります。

```
$ sh create.sh hello-world
```

参考：['hugo new'を便利にするスクリプト](http://blog.sgr-ksmt.org/2016/02/05/hugo_new_post/)

あとは記事を書いてpushするだけで公開されます。楽ちん。

## Werckerの設定
Werckerでハマったので、そこだけ記載しておきます。全て公式が古いのが悪いです。僕は悪くありません。ハマった時間を返して(ry

`wercker.yml`はこんな感じで設定しましょう。

```yml
box: debian
build:
  steps:
    - arjen/hugo-build@1.12.0:
      flags: --buildDrafts=false
      theme: startbootstrap-clean-blog
deploy:
  steps:
    - install-packages:
        packages: git ssh-client
    - leipert/git-push:
        gh_oauth: $GIT_TOKEN
        basedir: public
        repo: Catatsu/catatsu.github.io
        branch: master
```

## おわりに
GithubPages × Hugo × Werckerでサクッとブログを立ち上げられるってのは非常に便利ですね。日本中全ての会社でサクッとツルッとブログを立ち上げるといいですよ。

さて、次は[@matumotto](https://github.com/matumotto)がいい感じにデザインを整えてくれるはずなので、次回も乞うご期待！
