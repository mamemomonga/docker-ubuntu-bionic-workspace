# Debian Bionic(18.04)のシンプルな作業環境

シンプルな作業環境をDockerで準備します。

## 日本向けの調整

* ローカルのカレントユーザと同じUID, GIDのユーザがコンテナ起動時にappユーザとして作成されます
* aptリポジトリとして日本のミラーを使用します
* ローカルタイムがJST(Asia/Tokyo)となります

# 構築

	$ git clone ...
	$ ./ctrl.sh build

# 単発起動

終了時にコンテナを削除

rootユーザでログイン

	$ ./ctrl.sh run-root

appユーザでログイン

	$ ./ctrl.sh run-app

# サーバ起動

バックグラウンドで無限sleepするサーバを起動します。また、rsyslogdがバックグラウンドで動作します。

## 起動

	$ ./ctrl.sh up

## 終了

	$ ./ctrl.sh down

rootユーザでログイン

	$ ./ctrl.sh login-root

appユーザでログイン

	$ ./ctrl.sh login-app

# TIPS

## docker exec コマンドを使用する

docker-compose exec だと -it オプションがデフォルトになっているため、標準入出力をつかったやりとりに問題がでる場合があるが、docker exec を使えば解決する。

### /home/app の内容を app.tar.gz で取得する

	$ docker exec $(docker ps -q --filter 'name=app') tar zcvC /home/app . > app.tar.gz

### カレントディレクトリの内容を/home/appにコピーする

	$ tar c . | docker exec -i $(docker ps -q --filter 'name=app') tar xvC /home/app

