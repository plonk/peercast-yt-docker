# peercast-yt-docker

PeerCast YT の Docker コンテナを作ってみました。`plonk/peercast-yt` の
名前で
[Docker hub に上がっています](https://hub.docker.com/r/plonk/peercast-yt/)
。

起動してみましょう。初回起動時は Docker イメージのダウンロードが行われ
ます。終了は `Ctrl+C` でできます。

    $ docker run -it --net=host plonk/peercast-yt:0.3.0
    (...)
    Running with default configuration

ホストの 7144 番ポートをブラウザで開いて HTML UI にアクセスできます。
この時点ではパスワードが設定されていないのでリモートから HTML UI にア
クセスすることはできません。(JSON-RPCも使えません)

設定ページでパスワードなどが変更できますが、設定ファイルがコンテナの
外に保存できない状態ですのでコンテナが終了したら設定が消えてしまいま
す。

設定ファイルをコンテナの外に保存するには、まず設定ファイルを保存するディ
レクトリを作ります。ここでは、ユーザー名が `user` で、
`/home/user/config` ディレクトリを作ったとします。

    $ mkdir /home/user/config

peercast-yt のコンテナを以下のように起動します。これで
`/home/user/config` とコンテナ内の `/root/config` がリンクされた状態に
なります。

    $ docker run -it --net=host -v /home/user/config:/root/config plonk/peercast-yt:0.3.0
    Running with default configuration
    ^C

`Ctrl+C` を押してコンテナを終了すると、
`/home/user/config/peercast.ini` の名前で設定ファイルができているはず
です。パスワードを設定する場合は`Privacy`セクションの`password`キーに
平文で設定してください。

次回からは `/home/user/config/peercast.ini` から設定が読み込まれるよう
になります。

    $ docker run -it --net=host -v /home/plonk/config:/root/config plonk/peercast-yt:0.3.0
    Running with user configuration: /root/config/peercast.ini
    ^CSaving configuration: /root/config/peercast.ini
