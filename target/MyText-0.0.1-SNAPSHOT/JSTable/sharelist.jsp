
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>股票列表</title>

    <link rel="stylesheet" href="JSTable/assets/bootstrap.min.css">
    <link rel="stylesheet" href="JSTable/assets/jstable.css" />
    <style>
        body {
            background-color: #fafafa;
        }

        .container {
            margin: 150px auto;
            max-width: 960px;
        }
    </style>
</head>

<body>
     <div class="container">
    
        
         <table id="basic" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>股票代码</th>
                    <th>symbol</th>
                    <th>股票名称</th>
                    <th>涨跌额</th>
                    <th>涨跌幅（未复权)</th>
                </tr>
            </thead>
            <tbody>
            <%
                String command = request.getServletContext().getRealPath("/");
                System.out.println(command);
                String[] s={"python",command+"sharelist.py"};
                Process p= Runtime.getRuntime().exec(s);
                BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream(),"UTF-8"));
                //p.waitFor();
                String temp=in.readLine();
                String[] ts=temp.split(" ");
                for (int i = 0; i < ts.length/5; i++) {
                    out.print("<tr><th><a href=\"/MyText/show?code="+ts[i*5+0]+"&name="+ts[i*5+2]+"\">");
                    //out.print("<a href = "javascript:location.href=encodeURI('/MyText/show?code="+ts[i*5+0]+"&name="+ts[i*5+2]')">")
                    out.print(ts[i*5+0]);
                    out.print("</a></th> <th>");
                    out.print(ts[i*5+1]);
                    out.print("</th> <th>");
                    out.print(ts[i*5+2]);
                    out.print("</th> <th>");
                    out.print(ts[i*5+3]);
                    out.print("</th> <th>");
                    out.print(ts[i*5+4]);
                    out.print("</th>");
                }
                in.close();
                p.waitFor();
            %>

            </tbody>
        </table>
    </div>
 	<script>
 	function linkClick(linkObject) {

 	    var formObject = document.createElement('form');
 	    document.body.appendChild(formObject);
 	     formObject.setAttribute('method', 'post');
 	     var url = linkObject.href;
 	     var uri = '';
 	     var i = url.indexOf('?');

 	     if(i == -1) {
 	        formObject.action = url;
 	     } else {
 	        formObject.action = url.substring(0, i);
 	     }

 	     if( i >= 0 && url.length >= i + 1) {
 	        uri = url.substring(i + 1, url.length);
 	     }

 	     var sa = uri.split('&');

 	     for(var i = 0; i < sa.length; i++) {
 	       var isa = sa[i].split('=');
 	       var inputObject = document.createElement('input');
 	       inputObject.setAttribute('type', 'hidden');
 	       inputObject.setAttribute('name', isa[0]);
 	       inputObject.setAttribute('value', isa[1]);
 	       formObject.appendChild(inputObject);
 	     }

 	     formObject.submit();

 	     return false;
 	}
 	</script>
    <script src="JSTable/assets/jstable.min.js"></script>
    <script>
        new JSTable("#basic");
    </script>
   
</body>
</html>
