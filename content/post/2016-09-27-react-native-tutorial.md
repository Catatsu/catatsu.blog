+++
categories = ["React-Native"]
date = "2016-09-27T23:35:00+09:00"
description = "環境構築〜そしてHelloWorld"
draft = false
slug = "react-native-tutorial"
image = "/img/about-bg.jpg"
author = "matumotto"
tags = ["ReactNative", "development"]
title = "ReactNativeの開発環境構築"

+++

どうも僕([@matumotto](https://github.com/matumotto))です。
ReactNativeを久しぶりに覗いたらバージョンがめっちゃあがってたので、1からやりなおしていきます。

※OS X環境想定

 ----

## ReactNativeでHelloWorldまでやってみる

 ----

### 環境準備
 - まずnode.jsとwatchmanをインストール

```bash
brew install node
brew install watchman
```

※watchmanは推奨。Facebook製のファイル監視ツール。

- npmでReactNativeのコマンドツールをインストール

```bash
npm install -g react-native-cli
```

 ----


### プロジェクト作成〜ビルド
- まずはプロジェクトを作成する 

```bash
react-native init TestProject
```

 - 移動

 ```bash
 cd TestProject
 ```

 - Android用にビルドして実行 
 ※事前にエミュレータを立ち上げておいてください(もしくは実機接続)

 ```
 #実機でやる場合のみ必須
 adb reverse tcp:8081 tcp:8081
 react-native run-android
 ```

 ----

### アプリが立ち上がった！
 すこし文言を替えてみます！
 起動したままで、プロジェクト内にある''index.android.js''を変更してみましょう！
 
 - 文言を変更する

 ```bash
 sed -i '' 's/Welcome to React Native!/Hello React!/g' index.android.js
 ``` 

 - アプリに反映
 アプリのメニューからReloadを選択するとテキストが更新されます。
 Hello React! やったね！


 おしまい。

 つぎは何かモノを作っていきます。

