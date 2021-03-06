+++
author = "nabeen"
categories = ["Swift", "Xcode"]
date = "2016-09-29T20:55:14+09:00"
draft = false
slug = "hello-swift"
tags = ["Swift", "Xcode", "delegate", "Optional"]
title = "LAMPエンジニアがSwiftを始めた時に必ずぶち当たるであろう壁について簡単に説明する"

+++

どうも僕([@nabeen](https://github.com/nabeen))です。

ペーペーエンジニアの僕ですが、今までは基本的にPHPでお仕事してきました。でもとあるプロジェクトでいきなりSwiftで書かれたプロダクトを引き継ぐことに、、、！今日はそんな僕が最初に躓いた（今でも躓いている）ことについてお話させていただきます。

## 大前提
チュートリアルから始めて新規開発とかだとまた違うんでしょうけど、「既存のプロダクト」を「SwiftのSも知らないLAMPエンジニア」が引き継いだ、というちょっと変わった状況であることを念頭に置いておいてください。

ちなみに、Objective-Cも書いたことはありません。

## Viewの作り方がわからんよ
現時点の結論：Storyboardで全体の画面遷移を定義して、細かい部品をxibで作る

我々LAMPエンジニアは、Viewと言えばHTMLです。CSSです。JSです。**でもSwift（というかネイティブ）は違うんだってね！**

基本的にはGUIで作り込んでいくことになります。GUIでなんとかコンポーネントをドラッグ&ドロップして、GUIでサイズ指定して、GUIで位置指定して、GUIでごにょごにょ。この辺はコード的にはXMLで定義されてるんですけど、なんだか「見えない部分でやってる感」がすごい。

なんか昔Dreamweaverのビジュアルエディタで位置調整してた時を少し思い出したよ。

## View作ってたらConstraintsがーーって怒られるよ
現時点の結論：きちんと制約をつけましょう

Xcodeは結構頭がいいので、「なんかこれどこに配置するのかあやふやじゃね？」って時に、ちゃんと僕を怒ってくれます。赤で怒られるから、結構強めに怒ってるのかな。

でも悪いのはConstraintsをきちんと設定していない僕なので、今ではむしろ感謝しています！Xcodeありがとう！

## xib表示しただけでなんかdiff出るんだけど？
現時点の結論：自分が「意図的に変更した」部分以外はrevertする

なんかXMLにOXのシステムバージョンを持っていて、更新されてるとdiffが出てしまう。これはマジでうざい。システム情報なんて持たないで欲しい。ファック！ファック！！ファック！！！

社内のメンターに聞いたところ、「そういうもん」らしい。まじかよ。マゾかよ。

## ?とか!とかあるけど、あれなんなん?
現時点の結論：とりあえず[ここ](http://qiita.com/maiki055/items/b24378a3707bd35a31a8)読んどけばいい

オプショナル型っていうらしい。いわゆるヌルポ（この前覚えた言葉）を防いでくれるために使われるやつで、世界各国のSwiftエンジニアが便利便利と阿吽絶叫しているようだけど、他の言語にはない概念なので( ﾟдﾟ)ﾎﾟｶｰﾝとしていた。

でも上記の記事を読んでおけば、( ﾟдﾟ)ﾎﾟｶｰﾝから(*´﹃｀*)ﾀﾞﾗｰくらいにはなると思う。

## delegateってなんだよファックかよ
現時点の結論：自分で使える気がしない

delegateはprotcolとセットで出てきて、「何かの処理を依頼する」時に使われるもの、らしい。という概念自体は[このへん](http://qiita.com/mochizukikotaro/items/a5bc60d92aa2d6fe52ca)とか読めばわかるんだけど、なんか現実的なユースケースがよくわからない。

ごめん。

## ViewのviewDidloadとかっていつ呼ばれんの？
現時点の結論：ライフサイクルはわかったけどいつ何の処理を書けばいいのやら

例えば僕がやっているプロジェクトだと、ViewControllerでこういうのが結構呼ばれている。

```swift
override func viewDidLoad() {
    super.viewDidLoad()
	
	//ごにょごにょ
}
```

上記から察するに、「親クラスのアクションを上書きしてるんだな」「親クラスのアクションも呼び出すんだな」ってことはわかるんだけど、じゃあこれいつ呼ばれんの、と。調べてみると[ライフサイクル](http://qiita.com/mo_to_44/items/0ca628b4cc74c8c5599d)がちゃんとあって、呼び出し順があるようだ（当然か）。jQueryの`$(document).ready`みたいなもんね。

でもこのライフサイクルがあるのはいいけど、どこになんの処理を書くのがベストプラクティスなんですか？

## デフォルトで組み込まれているクラス群、関数群がわからない
現時点の結論：覚えるしか無い

Javaもそうなんだけど、「やたらと長い名前の標準関数」みたいなのが、Swiftにもあります。んで、そもそもどんなクラス、関数があるのかってのは、もう覚えるしかない。覚える以外の方法があったら教えて欲しい。

## ObserverにObservable
現時点の結論：僕にはまだ早かった

いわゆるReactiveプログラミングの概念。監視対象を決めて、それが変わったらあれもこれもそれも自動で変えてねっていうような感じの仕組み？かな？

わかってる人風に言うと、**Reactiveを使えば簡単に状態管理を制御できます。**

Swiftうんぬんというよりも、Reactiveプログラミングに触れたことがない僕はまだまだ理解に及んでいません。

ううっ。

## おまけ：感想
基本的にはViewを作るだけなのに、なんでこんなに知らない技術が出てくるんだ！

プロダクトの特性上、ネイティブでロジックをガリガリ書くってことはなく、APIのレスポンスで何をどう表示するかってのがメインになります。要はViewをいい感じにするだけ、処理はAPI。でもでもでもでもなんだか難しい！

そもそもコンパイラ型言語っぽい書き方にまだ慣れてない。

## おわりに
とりあえず今日からiOSエンジニアって名乗っておきますね(*´﹃｀*)
