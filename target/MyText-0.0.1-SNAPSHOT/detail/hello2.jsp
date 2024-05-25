<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"> 
	<title>股票详细信息展示</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
  <script src="detail/JS/echarts.js"></script>
  <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
  <script src="https://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  
	<style>
    .fakeimg {
        height: 200px;
         background: #aaa;
    }
  </style>
</head>
<body>

<%Process proc;
    StringBuilder data_json1 = new StringBuilder();
    StringBuilder data_json2 = new StringBuilder();
    StringBuilder data_json3 = new StringBuilder();
    StringBuilder data_json4 = new StringBuilder();
    try {
    	String exe = "python";
        String command = request.getServletContext().getRealPath("/")+"readd.py";
        //String command = "updata.py";
        String[] cmdArr=null;
        String num1 =  request.getParameter("code");
        String num2 =  request.getParameter("name");
        String start=request.getParameter("start");
        String end=request.getParameter("end");
        if(num1==""||num1==null){
        	num1="000001.SZ";
        }
        if(num2==""||num2==null){
        	num2="平安银行";
        }
        if(start==""||start==null||start=="null"){
        	//System.out.print(start);
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	start="2021 03 22" ;
        }
        if(end==""||end==null||end=="null"){
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	end="2022 03 22" ;
        }
        //System.out.print(start.length());
        if(start.length()<10){
        	start="2021 03 22" ;
        }
        if(end.length()<10){
        	end="2022 03 22" ;
        }
        //System.out.print(start.length());
        //System.out.print(start);
        String startYear = start.substring(0,4);
        String startMonth = start.substring(5,7);
        String startDate = start.substring(8,10);
        String start1=startYear+startMonth+startDate;
        //System.out.println(start);
        String endYear = end.substring(0,4);
        String endMonth = end.substring(5,7);
        String endDate = end.substring(8,10);
        String end1=endYear+endMonth+endDate;
        //System.out.println(end);
        
        int s=Integer.parseInt(start1);
        int e=Integer.parseInt(end1);
        if(s>e)
        	cmdArr= new String[] {exe, command, num1,num2,end1,start1};
        else{
        	cmdArr= new String[] {exe, command, num1,num2,start1,end1};
        }

        proc = Runtime.getRuntime().exec(cmdArr);
        //proc = Runtime.getRuntime().exec("python D:\\demo1.py");// 执行py文件
        //用输入输出流来截取结果
        BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
        data_json1.append(in.readLine());  //日期
        data_json2.append(in.readLine());  //量比
        data_json3.append(in.readLine());  //成交量
        data_json4.append(in.readLine());  //成交额
        //String line = null;
        //System.out.print("aaa");
        //while ((line = in.readLine()) != null) {
        	//System.out.print("ok");
            //data_json.append(line+"*");
        //}
        in.close();
        proc.waitFor();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    //System.out.print(data_json);
    String dataa = data_json1.toString();
    String numm = data_json2.toString().replaceAll(" ","").replaceAll("nan", "0");
    String numm2 = data_json3.toString().replaceAll(" ","").replaceAll("nan", "0");
    String numm3 = data_json4.toString().replaceAll(" ","").replaceAll("nan", "0");
	//out.print("<script>var dataa="+data_json.toString()+"</script>");
    //out.print("<script>var dataa="+data_json1.toString()+";var numm="+data_json2.toString()+"</script>");
    
    try {
        String exe = "python";
        String command = request.getServletContext().getRealPath("/")+"ht.py";
        //String command = "updata.py";
        String[] cmdArr=null;
        //String num1 = "000001.SZ";
        //String num2 = "名字";
        //String start="2019 01 01";
        //String end="2020 01 01";
        String num1 =  request.getParameter("code");
        String num2 =  request.getParameter("name");
        String start=request.getParameter("start");
        String end=request.getParameter("end");
        
        if(num1==""||num1==null){ 
        	System.out.print(num1);
        	//request.setAttribute("code","000001.SZ");
        	num1="000001.SZ";
        	System.out.print(num1);
        }
        if(num2==""||num2==null){
        	//request.setAttribute("name","平安银行");
        	num2="平安银行";
        }
        if(start==""||start==null){
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	start="2021 03 22" ;
        	//System.out.print(start);
        }
        if(end==""||end==null){   //null
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	end="2022 03 22" ;
        }
        String startYear = start.substring(0,4);
        String startMonth = start.substring(5,7);
        String startDate = start.substring(8,10);
        String start1=startYear+startMonth+startDate;
        //System.out.println(start);
        String endYear = end.substring(0,4);
        String endMonth = end.substring(5,7);
        String endDate = end.substring(8,10);
        String end1=endYear+endMonth+endDate;
        //System.out.println(end);
        
        int s=Integer.parseInt(start1);
        int e=Integer.parseInt(end1);
        if(s>e)
        	cmdArr= new String[] {exe, command, num1,num2,end1,start1};
        else{
        	cmdArr= new String[] {exe, command, num1,num2,start1,end1};
        }
        //cmdArr= new String[] {exe, command, num1, num2,start,end};
        proc = Runtime.getRuntime().exec(cmdArr);
        //proc = Runtime.getRuntime().exec("python D:\\demo1.py");// 执行py文件
        //用输入输出流来截取结果
        proc.waitFor();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    //if(request.getParameter("start")==""||request.getParameter("start")==null){
    //	request.getParameter("start")=2021-03-22;
    //}
    //if(request.getParameter("end")==""||request.getParameter("end")==null){
    //	request.getParameter("end")=2022-03-22;
    //}
    String code1 =  request.getParameter("code");
    String code2 =  request.getParameter("name");
    String startdate=request.getParameter("start");
    String enddate=request.getParameter("end");
    if(code1==""||code1==null){
    	code1="000001.SZ";
    }
    if(code2==""||code2==null){
    	code2="平安银行";
    }
    if(startdate==""||startdate==null){
    	startdate="2021-03-22" ;
    }
    if(enddate==""||enddate==null){
    	enddate="2022-03-22" ;
    }
    
    
%>

<div style="background:url(detail/IMG/bg-gupiao.jpeg);background-size: 100%;background-repeat:no-repeat;">
<div class="jumbotron text-center" style="margin-bottom:0; background-color:rgba(13, 70, 83, 0.78);background-size: 100%;background-repeat:no-repeat;">
  
  <h1 style="color:#fff">股票详细信息展示</h1>
  <p><a href="https://github.com/jones2000/HQChart/tree/master/webhqchart.demo" style="color:#fff">如果你想要得到更多相关的信息，请点击这里</a></p>
  <form action="/MyText/detail" method="get" class="form-inline" role="form">
    <div class="form-group" style="color:#fff">
    	股票代码:<input class="form-control" type="text" name="code"
                value=<%=code1%> readonly="readonly" />
    	股票票名：<input class="form-control" type="text" name="name"
                value=<%=code2%> readonly="readonly" />
    	start: <input class="form-control" type="date" name="start" id="ss"/>
    	end: <input class="form-control" type="date" name="end" id="ee"/>
    </div>
    <button type="submit" class="btn btn-default">提交</button>
  </form>
  </div>
</div>
<nav class="navbar navbar-inverse" style="background-color:#fff;border:0px">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="javascript:;" onclick="javascrtpt:jump()">股票</a>
    </div>
    <div>
      <ul id="myTab" class="nav navbar-nav">
        <li class="active"><a href="#page1" data-toggle="tab">量比</a></li>
        <li><a href="#page2" data-toggle="tab">平均线</a></li>
        <li><a href="#page3" data-toggle="tab">成交量/额</a></li>
        <li><a href="#page4" data-toggle="tab">换手率</a></li>
        <!--  <li><a href="#page5" data-toggle="tab">signal</a></li>-->
    </ul>
    </div>
  </div>
</nav>

<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="page1">
     	<div class="panel" id="one"></div>  
	</div>
	<div class="tab-pane fade" id="page2">
	 <div class="container">
	   <div class="row">
		<div class="panel" id="four" style="width:1200px ;height: 700px">
    		<iframe src="/MyText/mutiple_pie.html" width="100%" height="100%"></iframe>
    	</div>
      </div>
     </div>	
	</div>
	<div class="tab-pane fade" id="page3">
		<div class="panel" id="two"></div>
	</div>
	<div class="tab-pane fade" id="page4">
		<div class="container">
      		<div class="row">
				<div class="panel" id="three" style="width:1200px ;height: 700px">
    				<iframe src="/MyText/huanshoulv.html" width="100%" height="100%"></iframe>
    			</div>
    		</div>
    	</div>
	</div>
	<!--
	<div class="tab-pane fade" id="page5">
		<div class="container">
      		<div class="row">
				<div class="panel" id="three" style="width:1200px ;height: 700px">
    				<iframe src="/MyText/ceshi.html" width="100%" height="100%"></iframe>
    			</div>
			</div>
		</div>
    </div>
    -->
</div>



<div class="jumbotron text-center" style="margin-bottom:0"></div>


<script type="text/javascript">
function jump(){
	var test = window.location.search; 
	window.location.href="http://localhost:8080/MyText/update"+test;
}
</script>
<script type="text/javascript">
var dateControl = document.getElementById("ss");
var dodate = "<%=startdate%>";
dateControl.value = dodate;
</script>
<script type="text/javascript">
var dateControl = document.getElementById("ee");
var dodate = "<%=enddate%>";
dateControl.value = dodate;
</script>
<script type="text/javascript">
var dd = <%=dataa%>;
var nn = <%=numm%>;
var mainContainer = document.getElementById('one');
//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
var resizeMainContainer = function () {
	mainContainer.style.width = window.innerWidth+'px';
	mainContainer.style.height = window.innerHeight*0.8+'px';
};
//设置div容器高宽
resizeMainContainer();
// 初始化图表
var bar_Chart = echarts.init(mainContainer);
$(window).on('resize',function(){//
//屏幕大小自适应，重置容器高宽
resizeMainContainer();
    bar_Chart.resize();
});

/*var bar=function(){
        $.ajax({
            url:"/bar",
            success:function (data) {
                bar_Chart_option.xAxis.data=data.name;
                bar_Chart_option.series[0].data=data.value;
                bar_Chart.setOption(bar_Chart_option);
            },
            error:function(xhr,type,errorThrown) {
            }
        })
}*/
var bar_Chart_option = {
    title: {
        text: '股票量比分布',
        left: 'center',
    },
    tooltip : {
        trigger: 'item',
        //formatter: "{c}"
        
        formatter: function (params) {
        	//console.log(params)
            var i=params.data;
            var j;
            if(i>10) j="极端放量，趋势已经到默契，可以考虑反向操作";
            else if(i>5) j="放巨量表现，趋势已到末期";
            else if(i>2.5) j="明显放量，可以采取相应行动了";
            else if(i>1.5) j="温和放量，将会延续原有趋势";
            else if(i>0.8) j="成交量处于正常水平";
            else if(j==0.5) j="成交量萎缩到极致，变盘随时发生";
            else j="";
            return '日期:'+params.name+'</br>'+'量比:'+params.data+'</br>'+j
        }
    },
    toolbox: {
        show : true, 
        x: 1200, 
        feature: {
            dataZoom: {
                yAxisIndex: 'none'
            },
        }
    },
    dataZoom: [{
		type: 'inside',
    }],
    xAxis: {
        type: 'category',
        name:'日期',
        nameLocation: 'center',
        nameGap:25,
        data:dd
    },
    yAxis: {
        type: 'value',
        name:'量比'
    },
    series: [{
        data:nn,
        type:'bar',
        dataZoom: [{
            type: 'inside',//x轴
        }],
        itemStyle:{
            normal: {
                    color: 'rgba(13, 70, 83, 0.91)'
                }
        },
        markLine: {
            silent: true,
            lineStyle: {
              normal: {
                color: 'red'                   // 这儿设置安全基线颜色
              }
            },
            data: [{
                yAxis: 1.5
            },
            {
            	yAxis: 0.8
            }],
        },

    }]
};
bar_Chart.setOption(bar_Chart_option);

//bar();


</script>

<script type="text/javascript">
var nn2 = <%=numm2%>;
var nn3 = <%=numm3%>;
  var mainContainer = document.getElementById('two');
  //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
  var resizeMainContainer = function () {
    mainContainer.style.width = window.innerWidth+'px';
    mainContainer.style.height = window.innerHeight*0.8+'px';
  };
  //设置div容器高宽
  resizeMainContainer();
  // 初始化图表
  var line_Chart = echarts.init(mainContainer);
  $(window).on('resize',function(){//
  //屏幕大小自适应，重置容器高宽
  resizeMainContainer();
      line_Chart.resize();
  });
  var line_Chart_option = {
      title: {
          text: '股票成交量及成交额分布',
          left: 'center',
      },
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'cross',
          animation: false,
          label: {
            backgroundColor: '#505765'
          }
        }
      },
      legend: {
        data: ['成交额', '成交量'],
        left: 10
      },
      toolbox: {
          show : true, 
          x: 1200, 
          feature: {
              dataZoom: {
                  yAxisIndex: 'none'
              },
          }
      },
      dataZoom: [{
      	type: 'inside',
      }],
      xAxis: {
          type: 'category',
          name:'日期',
          nameLocation: 'center',
          nameGap:25,
          boundaryGap: false,
          data:dd
      },
      yAxis: [{
          type: 'value',
          name:'成交额'
      },{
          name: '成交量',
          nameLocation: 'start',
          alignTicks: true,
          type: 'value',
          inverse: true
      }],
      series: [{
          name: '成交额',
          data:nn3,
          type:'line',
          itemStyle:{
              normal: {
                      color: 'rgba(13, 70, 83, 1)'
                  }
          },
          areaStyle: {},
          lineStyle: {
            width: 1
          },
          emphasis: {
            focus: 'series'
          },
      },
      {
          name: '成交量',
          type: 'line',
          data:nn2,
          yAxisIndex: 1,
          itemStyle:{
              normal: {
                      color: 'rgba(12, 184, 182, 0.91)'
                  }
          },
          areaStyle: {},
          lineStyle: {
            width: 1
          },
          emphasis: {
            focus: 'series'
          },
      }]
  };
  line_Chart.setOption(line_Chart_option);

  
  
  </script>
</body>
</html>