<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"> 
	<title>股票预测信息展示</title>
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
        	start="1995 01 01" ;
        	//System.out.print(start);
        }
        if(end==""||end==null){   //null
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	end="2022 01 01" ;
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
    /*
    //为了减少运行时间，这里就用已经跑好的图展示了
    try {
        String exe = "python";
        String command = request.getServletContext().getRealPath("/")+"pre.py";
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
        	start="1995 01 01" ;
        	//System.out.print(start);
        }
        if(end==""||end==null){   //null
            //cmdArr= new String[] {exe, command,"show", num1,num2};//out.print(num1);
        	end="2022 01 01" ;
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
        proc.waitFor();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }*/
    
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
    	startdate="1995-01-01" ;
    }
    if(enddate==""||enddate==null){
    	enddate="2022-01-01" ;
    }
    
    
%>

<div style="background:url(detail/IMG/bg-gupiao.jpeg);background-size: 100%;background-repeat:no-repeat;">
    <div class="jumbotron text-center" style="margin-bottom:0; background-color:rgba(13, 70, 83, 0.78);background-size: 100%;background-repeat:no-repeat;">
      
      <h1 style="color:#fff">股票预测信息展示</h1>
      <p><a href="https://github.com/jones2000/HQChart/tree/master/webhqchart.demo" style="color:#fff">如果你想要得到更多相关的信息，请点击这里</a></p>
      <form action="/MyText/prec" method="get" class="form-inline" role="form">
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
    <br>
    <div class="container">
      <div class="row" width="80%" height="50%">
        <div class="col-md-3 col-sm-4 col-xs-12" style="text-align: center;">
          <br><br><br>
          <h2 class="ser-title">买入卖出信号预测</h2>
          <hr class="botm-line">
          <p>通过统计日线上穿下穿获得买入卖出信号，signal=1为买入信号，signal=-1为卖出信号</p>
        </div>
        <div class="col-md-9 col-sm-8 col-xs-12">
          <div style="visibility: visible;" class="col-sm-9 more-features-box">
            <div class="panel" id="sig1" style="width:900px ;height: 500px">
				<iframe src="/MyText/ceshi.html" width="100%" height="100%"></iframe>
            </div>
          </div>
        </div>
      </div>

      <div class="row" width="80%" height="50%">
        <div class="col-md-3 col-sm-4 col-xs-12" style="text-align: center;">
          <br><br><br>
          <h2 class="ser-title">涨幅趋势预测</h2>
          <hr class="botm-line">
          <p>通过LSTM预测股票成交价格涨幅趋势</p>
        </div>
        <div class="col-md-9 col-sm-8 col-xs-12">
          <div style="visibility: visible;" class="col-sm-9 more-features-box">
            <div class="panel" id="sig2" style="width:900px ;height: 500px;background-color:rgb(207, 226, 222)">
				<img src="/MyText/000001SZ.png" width="100%" height="100%">
            </div>
          </div>
        </div>
      </div>


    </div>
    
    
    
    
    <div class="jumbotron text-center" style="margin-bottom:0"></div>


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

</body>
</html>