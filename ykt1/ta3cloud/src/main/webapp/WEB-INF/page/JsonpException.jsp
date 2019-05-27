<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.yinhai.core.app.api.util.JSonFactory"%>
<%
	response.setContentType("application/javascript; charset=UTF-8"); //解决从服务器返回中文乱码问题
	Object restr =   request.getAttribute("jsonMsg");
	if(request.getParameter("callbackparam")!=null && "jsonpCallback".equals(request.getParameter("callbackparam"))){
		out.print(request.getParameter("callbackparam")+"("+restr+")");
	}
	out.flush();
%>