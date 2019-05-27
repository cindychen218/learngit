<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@page import="com.yinhai.core.app.api.util.TagUtil"%>
<%@page import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%
	IResultBean rb = TagUtil.getResultBean();

	if(rb!=null){
		String restr = JSonFactory.bean2json(rb);
		if(request.getParameter("callbackparam")!=null && "jsonpCallback".equals(request.getParameter("callbackparam"))){
			response.setContentType("application/javascript; charset=UTF-8");
		    out.print(request.getParameter("callbackparam")+"("+restr+")");
		}
		else{
		    //IE 默认不识别 application/json ； text/json
			response.setContentType("text/html; charset=UTF-8"); //解决从服务器返回中文乱码问题
			out.print(restr);
		}
	}
	out.flush();
%>