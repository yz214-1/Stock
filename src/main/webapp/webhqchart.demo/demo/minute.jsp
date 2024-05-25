<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.concurrent.ScheduledExecutorService" %>
<%@ page import="java.util.concurrent.Executors" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="com.example.demo.HelloServlet" %>

<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="refresh" content="10">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>页面行情(K线图)</title>
    <link rel="stylesheet" href="webhqchart.demo/jscommon/umychart.resource/css/tools.css" />
    <link rel="stylesheet" href="webhqchart.demo/jscommon/umychart.resource/font/iconfont.css" />
    <!-- 使用阿里云图片 -->
    <!--<link rel="stylesheet" href="https://at.alicdn.com/t/font_1040563_1d1tgaoqofpi.css" />-->
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_1196214_ny3l0dbclr.css" />

</head>
<body>
<div id="kline" style="width: 900px;height:400px;position: relative;"></div>


<script src="webhqchart.demo/demo/content/js/jquery.min.js"></script>
<script src="webhqchart.demo/demo/content/js/webfont.js"></script>

<script src="webhqchart.demo/jscommon/umychart.network.js"></script>
<script src="webhqchart.demo/jscommon/umychart.js"></script>
<script src="webhqchart.demo/jscommon/umychart.complier.js"></script>
<script src="webhqchart.demo/jscommon/umychart.index.data.js"></script>
<script src="webhqchart.demo/jscommon/umychart.style.js"></script>


<%Process proc;
    out.print("<script>poue={\"data\":[");
    if(HelloServlet.list.size()>0)
        out.print(HelloServlet.list.get(0));
    for (int i = 1; i < HelloServlet.list.size(); i++) {
        out.print(","+HelloServlet.list.get(i));
    }
    out.print("],\"symbol\":\"002422.SZ\",\"name\":\"科伦药业\",\"start\":-1,\"end\":0,\"count\":4686,\"ticket\":422,\"version\":\"2.0\",\"message\":null,\"code\":0}"+"</script>;");
%>

<script>

    //预加载下阿里云图片
    WebFont.load({ custom: { families: ['iconfont'] } });
    WebFont.load({ custom: { families: ['js-iconfont'] } });

    function getURLParams(name)
    {
        return null;
    }


    $(window).resize(resizeCanvas);

    function resizeCanvas()
    {
        var height= $(window).height();
        var width = $(window).width();
        var divKline=document.getElementById('kline');
        //divKline.style.top=20+'px';
        //divKline.style.left=20+'px';
        //divKline.style.width=(width-20)+'px';
        //divKline.style.height=(height-20)+'px';
        divKline.style.top=0+'px';
        divKline.style.left=0+'px';
        divKline.style.width=(width)+'px';
        divKline.style.height=(height)+'px';
        divKline.JSChart.OnSize();
    }

    function NetworkFilter(data, callback)
    {
        console.log('[NetworkFilter] data', data);
        data.PreventDefault=true;
        callback(poue);

    }


    $(function ()
    {

        JSComplier.AddIcon({ID:1, Text:'\ue611', Color:'rgb(35,55,55)', Family:'js-iconfont'});    //添加一个obj={ID:, Text:, Color, Family: }

        var debug=getURLParams('debug');
        if (debug==1)
        {
            var vConsole = new VConsole();
            console.log('create VConsole');
        }

        var symbol=getURLParams('symbol');
        if (symbol==null) symbol='000001.sz';

        var index=getURLParams('index');        //指标1
        if (index==null) index='MA';

        var index2=getURLParams('index2');      //指标2
        if (index2==null) index2='VOL';

        var index3=getURLParams('index3');      //指标3
        if (index3==null) index3='MACD';

        var language=getURLParams('language');
        if (!language) language='CN';

        var aryIndex=new Array();
        aryIndex.push({Index:index,Modify:true,Change:true});
        aryIndex.push({Index:index2,Modify:true,Change:true});
        if (index3) aryIndex.push({Index:index3,Modify:true,Change:true});

        //黑色风格设置, 默认是白色风格
        var blackStyle=HQChartStyle.GetStyleConfig(STYLE_TYPE_ID.BLACK_ID);
        JSChart.SetStyle(blackStyle);
        document.getElementById('kline').style.backgroundColor=blackStyle.BGColor;

        // 创建股票K线图
        console.log('create JSChart');
        var chart=JSChart.Init(document.getElementById('kline'));

        var height= $(window).height();
        var width = $(window).width();
        var divKline=document.getElementById('kline');
        divKline.style.width=width+'px';
        divKline.style.height=height+'px';
        chart.OnSize();

        LoadCustomIndex();

        var option=
            {
                Type:'历史K线图',
                Windows:aryIndex, //窗口指标

                Windows:
                    [
                        {
                            //Index:'自定义图标'//"Zealink-操盘BS点",
                            Index:'MA'
                            //API: {Name:'Zealink-操盘BS点',Script:null, Args:null, Url:'http://127.0.0.1:18080/api/jsindex' }
                        },
                        {
                            Index:"MACD",
                            //API: {Name:'MACD',Script:null, Args:null, Url:'http://127.0.0.1:18080/api/jsindex' } ,
                            Lock:
                                {
                                    IsLocked: false,
                                    Callback: unlockIndex,
                                    BG: 'rgba(220,220,220,0.5)',
                                    TextColor: 'rgb(255,215,0)',
                                    Text: '\ue611',
                                    Font: '50px js-iconfont',
                                    //Count: 10  //锁主右边几条数据
                                }
                        },
                        //{Index:"RSI"},

                    ], //窗口指标

                Symbol:symbol,
                IsAutoUpdate:true,          //是自动更新数据
                AutoUpdateFrequency:3000,   //数据更新频率
                //TradeIndex: {Index:'交易系统-BIAS'},    //交易系统
                NetworkFilter:NetworkFilter,

                IsShowRightMenu:true,          //右键菜单
                IsShowCorssCursorInfo:true,    //是否显示十字光标的刻度信息
                CorssCursorInfo:{ Left:1, Right:1, Bottom:1, IsShowCorss:true, PressTime:300 },  //十字光标刻度设置

                KLine:
                    {
                        DragMode:1,                 //拖拽模式 0 禁止拖拽 1 数据拖拽 2 区间选择
                        Right:1,                    //复权 0 不复权 1 前复权 2 后复权
                        Period:0,                   //周期 0 日线 1 周线 2 月线 3 年线
                        MaxReqeustDataCount:1000,   //数据个数
                        PageSize:150,               //一屏显示多少数据
                        IndexTreeApiUrl:"https://opensourcecache.zealink.com/cache/hqh5/index/commonindextree.json",        //指标树下载地址
                        //Info:["互动易","大宗交易",'龙虎榜',"调研","业绩预告","公告"],       //信息地雷
                        //Info:["公告","互动易","调研"],           //信息地雷
                        InfoPosition:1,                         //显示位置
                        KLineDoubleClick:true,              //双击分钟走势图
                        IsShowTooltip:true,                 //是否显示K线提示信息
                        //FirstShowDate:20180401,             //首屏显示的起始日期
                        DrawType:0,
                    },

                KLineTitle: //标题设置
                    {
                        IsShowName:true,       //不显示股票名称
                        IsShowSettingInfo:true //不显示周期/复权
                    },

                Border: //边框
                    {
                        Left:5,           //左边间距
                        Right:60,       //右边间距
                        Bottom:25,
                        Top:25
                    },

                Language:language,  //英文 'EN' 中文:'CN'

                ExtendChart:    //扩展图形
                    [
                        {Name:'画图工具',Top:25}
                    ],

                Frame:  //子框架设置 (Height 窗口高度比例值)
                    [
                        {   SplitCount:5,
                            //Height:4,
                            IsShowLeftText:false,
                            IsShowRightText:true
                        },
                        {
                            SplitCount:3,
                            //Height:2,
                            IsShowLeftText:false,
                            IsShowRightText:true
                        },
                        {
                            SplitCount:2,
                            //Height:2,
                            IsShowLeftText:false,
                            IsShowRightText:true
                        }
                    ],

                Overlay:
                    [
                        //{Symbol:'000001.sh', DrawType:0},
                        //{Symbol:'002415.sz', DrawType:0}
                    ],


            }

        var windowHeight= $(window).height();
        var windowWidth = $(window).width();

        /*
        option.Windows[1].Lock= {
            IsLocked: true, Callback: unlockIndex,
            BG: 'rgb(200,0,40)', TextColor: 'rgb(255,255,255)',
            //Text: '上锁了',
            Font: '12px 微软雅黑', Count: 10,  //锁主右边几条数据
            MinWidth:150,
        };
        */


        chart.SetOption(option);
        //jsChart.LockIndex('飞龙四式',unlockIndex);

        //注册监听事件
        //chart.AddEventCallback({event:JSCHART_EVENT_ID.RECV_INDEX_DATA, callback:testcallback})

        resizeCanvas();

        //setTimeout(() => { chart.SetFirstShowDate({Date:20170501,PageSize:600});}, 20000);
        //setTimeout(() => { chart.SetLanguage('EN');}, 5000);

        var template=
            {
                Windows:
                    [
                        {Index:"MA", Args:[ { Name:'M1', Value:10}, { Name:'M2', Value:15 }, { Name:'M3', Value:20} ]},
                        {Index:"MACD"},
                        {Index:"MTM"},
                        {Index:"CCI"},

                    ], //窗口指标
            }


    })

    function unlockIndex(data)
    {
        console.log('[unlockIndex]' , data);
        var chart=data.HQChart;
        chart.LockIndex({IndexName:data.Data.IndexName, IsLocked:false});
    }

    function testcallback(event,data,obj)
    {
        console.log('[testcallback]', data);
    }

    LoadCustomIndex=function()
    {
        var index=
            [
                {
                    ID:"自定义图标",                    //指标ID
                    Name:'自定义图标',                  //指标名称
                    Description:'自定义图标',           //描述信息
                    IsMainIndex:true,                  //是否是主图指标
                    Args:[],                           //指标参数
                    Script:                 //脚本
                        'DRAWICON(CLOSE>OPEN,LOW,1);'
                },
            ];

        JSIndexScript.AddIndex(index);  //添加到系统指标中
    }


</script>

<form action="/demo_war_exploded/update" method="get">

    股票代码:<input type="text" name="code"
                value=<%
        out.print(request.getParameter("code"));
    %> readonly="readonly" />
    股票票名：<input type="text" name="name"
                value=<%
        out.print(request.getParameter("name"));
    %> readonly="readonly" />
    start: <input type="text" name="start" />
    end: <input type="text" name="end" />
    <input type="submit" value="Submit" />
</form>
</body>
</html>