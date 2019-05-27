<%@ page language="java" pageEncoding="UTF-8" errorPage="true"%>
<%
String isajax = request.getHeader("x-requested-with");
if("XMLHttpRequest".equals(isajax)){
	response.setContentType("text/json; charset=UTF-8");
	response.addHeader("__exception","1");
	out.print(session.getAttribute("_exceptionmsg"));
}else{
	out.print("抱歉，出现未知错误！");
	//这个地方输出未知异常的界面
	out.print(session.getAttribute("_exceptionmsg"));
}
session.removeAttribute("_exceptionmsg");
%>
