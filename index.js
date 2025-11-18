//モジュールのインポート
const http = require('http');
const express = require('express');

//expressオブジェクトの生成
const app = express();

//getでリクエスト時に処理するコールバック関数指定
app.get("/", function(req, res){
    res.sendFile(__dirname + '/index.html');
});

//getでリクエスト時に処理するコールバック関数指定
app.get("/mypage", function(req, res){
    res.sendFile(__dirname + '/mypage.html');
});

//サーバの設定
const server = http.createServer(app);
server.listen(3000);