package com.example.demo;

//import org.python.antlr.ast.Str;

import java.io.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;


//@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    public static ArrayList<String> list=new ArrayList<>();
    public void init() {
        message = "Hello World!";
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	
       String uri = request.getRequestURI();
       System.out.println(uri);
        if (uri.endsWith("/hello-servlet")) {

            response.sendRedirect("Xamin/index.html");

        }else if (uri.endsWith("/updata"))
        {

            Process proc;
            StringBuilder data_json = new StringBuilder();
            try {
                String exe = "python";
                String command = "E:\\updata.py";
                String num1 =  "000001.SZ";
                String[] cmdArr = new String[] {exe, command, num1};
                proc = Runtime.getRuntime().exec(cmdArr);
                //proc = Runtime.getRuntime().exec("python D:\\demo1.py");// 执行py文件
                //用输入输出流来截取结果
                BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
                String line = null;
                while ((line = in.readLine()) != null) {
                    data_json.append(line+"\n");
                    System.out.println(line);
                }
                in.close();
                proc.waitFor();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
        else if(uri.endsWith("/list"))
        {
            request.getRequestDispatcher("JSTable/sharelist.jsp").forward(request,response);
        }else if(uri.endsWith("/detail")){
            request.getRequestDispatcher("detail/hello2.jsp").forward(request,response);
        }else if(uri.endsWith("/prec")){
            request.getRequestDispatcher("detail/hello1.jsp").forward(request,response);
        }else if(uri.endsWith("/show")||uri.endsWith("/update")){
            request.getRequestDispatcher("webhqchart.demo/demo/myshare.jsp").forward(request,response);
        }else if(uri.endsWith("/minute"))
            request.getRequestDispatcher("webhqchart.demo/demo/minute.jsp").forward(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	try {
			doGet(request,response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    }

    public void destroy() {
    }
}