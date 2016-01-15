Lottery
---------------
  公司年会抽奖程序

#### ps: 你们这些坏人fork项目一个star都不给(T_T)

## 基本

本程序基于浏览器．本程序基于nodejs. 数据库基于sqllite3． 分辨率1440 * 900．实际运行的屏幕是 15米*9米

本程序基于linux编写，一般情况下，window也可以跑起来，但是不排除存在一些错误

## 环境要求

1. nodejs 环境
2. 基本npm包依赖

```
npm install node-dev -g
npm install coffee-script -g
```

## 安装
clone 本仓库到本地后，进去根目录．

```
cd lottery
npm install
```

## 运行demo

### 启动

```
npm start
```
demo效果:
![alt tag](https://cloud.githubusercontent.com/assets/3005433/6016636/e36c86b4-abbf-11e4-9847-98d9315c477a.gif)

图有点大 所以github上看起来会有点卡,但实际没有卡顿

### 使用

启动应用后，打开浏览器(chrome或者firefox) 打开浏览器,输入 localhost:3000/index.html 可以看到抽奖界面．
按回车键 进行抽奖和下一轮抽奖．

由于抽奖的数目由数据的以产生的数据来决定，因此在抽完配置的数量后，再抽只会抽取一个，可以通过运行

```
node-dev server/src/reset-winner-list.coffee
```
重置中奖数据库．
注意所有命令必须在项目根目录下运行．

注意：由于本程序依赖数据库，而本源代码仅包括测试数据库，实际运行中需要添加数据才能使用．

## 正式使用

### 删除测试数据库

找到db.sqlite删除．（如需回复测试数据库,可以运行npm test进行初始化测试数据库）

### 正式数据添加说明

找到文件```server/src/configure.coffee```

1. 修改测试环境变量
```
exports.isTestEnviroment = true
```
为 (运行demo请设置为true):
```
exports.isTestEnviroment = false
```

２.修改抽奖人员头像位置

```
exports.conver =
  sourceDir: "/home/ec/dumps/photos"
  distDir: "/home/ec/dumps/dist"
```
第一个是照片原文件夹，把公司人员的大头贴 最好是300 * 300 px（请利用ps或者其他工具先批量处理完成）
放到```sourceDir```文件夹内,照片的文件名为人员姓名或者编号（这个将存到数据库里面）．
第二个```distDir```是数据关联的照片文件夹，指定它，并且使该文件夹为空．
注意这里的文件夹必须为绝对路径！
然后在根目录```lottery```下运行
```
node-dev server/src/convert.coffee
```
就会自动扫描文件夹，并处理人员名单到数据库．这样数据库就初始化完成了．（数据库因为使用的是sqllite3文本数据库,因此不需要额外安装）
可以下载SQLliteStudio数据库管理器，打开根目录下的db.sqlite文件，即可浏览数据．

3.在项目目录下运行
```
npm start
```
访问localhost:3000/index.html即可看到抽奖界面

打开localhost:3000/controller.html　可以看到抽奖的中奖名单


## 相关图片资源
1. 相关图片放在了client/image目录下，其中奖品图片为product-1到product-６, product-tv.

2.每轮中奖的数量在```server/src/configure.coffee```配置．

3.抽奖时的背景音乐放在了```client/audio```目录底下．
其中bg.mp3是背景乐，stop.mp3是中奖音效.如需更改请确保文件名和文件类型一致.即mp3格式．


## 关于头像出现的频率
在```client/js/run．js```中找到 ```winnerDisplayTimeInterval```进行更改
默认是50毫秒飘出一个(因为公司人多，所以比较快速)，可以自行调试设置

## 背景气球的出现频率
在```client/js/background-animation．js```中找到```backgroundDisplayTimeInterval``
进行更改

##其他
1. 如果抽奖集中在一个时段,不会出现任何问题.
2. 如果抽奖阶段分开, 而且间隔时间比较长，那么每次抽奖后，可能需要关闭浏览器，到抽奖时在打开．
（主要是怕出现显卡过热,导致操作系统假死，因为笔记本在投影扩展到一个大屏幕后，独立显卡的发热量
明显增多．当然，如果你笔记本比较好，而且测试过不过出现显卡过热导致系统黑屏现象，那么可以无视这个问题）
3. 因为是针对一定数量的奖品和中间数量，可能存在一些其他设置写死，如果你在使用过程中不明白可以提issue或者发邮件我.
鉴于国内网络环境邮箱地址(ec.huyinghuan@gmail.com 或 xiacijian@163.com). 但是issue是最佳选择．
4. 如果你觉得能使用并且好用,欢迎捐赠到支付宝 646344359@qq.com (仅需0.1元鼓励)．谢谢
5. 请使用代码master分支．

## License
MIT

