<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.yinhai.core.common.api.config.impl.SysConfig"%>
<%@ include file="inc-path.jsp" %>
<head>
<title>异常界面</title>
<link id="linkskin" type="text/css" rel="stylesheet">
<script src="<%=facePath%>support/jquery/jquery-1.11.0.min.js" type="text/javascript"></script>
<script>
    var jsonMsg ="";
    <%if ("true".equals(SysConfig.getSysConfig("developMode"))) {%>
    jsonMsg = "<%=session.getAttribute("exceptionJsonMsg")%>";
    <%} else { %>
    jsonMsg = "<%=request.getParameter("exceptionJsonMsg")%>";
    <%} %>

    if(jsonMsg == "" || jsonMsg == "null"){
        <%
        String detail = "";
        if(exception != null){
            //此处输出异常信息
            exception.printStackTrace();
            detail += exception.getMessage();
            StackTraceElement[] trace = exception.getStackTrace();
            for (StackTraceElement s : trace) {
                detail += " " + s + " ";
            }
        }
    	%>
        jsonMsg = "<%=detail%>";
    }

    webFaceSkin.apply(linkskin,"<%=basePath%>indexSRC/errorpage/css/");
    $(document).ready(function () {
        $("#bgImg").attr("src","<%=basePath %>indexSRC/errorpage/img/"+webFaceSkin.getSkin()+"/500.png");
        document.getElementById("errorMsg").innerText = (typeof jsonMsg == "undefined" || jsonMsg == null || jsonMsg == "null")?document.getElementById("errorMsg").innerText:jsonMsg;
    })

    var errorMessage ="<%=request.getParameter("errorMessage")%>";
    function getErrorMsg(){
        document.getElementById("errorCode").innerText = errorMessage;
    }

</script>

</head>
<body class="no-scrollbar">
<div class="content">
    <div class="content-con">
        <div class="con-center">
            <img id="bgImg" alt="pic"/>
        </div>
        <div class="con-desc">
            异常代码：500
        </div>
            <div>
                <div class="con-detail con-detail-center">
                    <a href="javascript:getErrorMsg()">错误编码</a>
                </div>
                <%--前台错误信息（JSP 编译错误）--%>
                <p class="con-info con-info-center" id="errorCode"></p>
            </div>
             <div>
                <div class="con-detail">
                    错误详情：
                </div>
                <%--前台错误信息（JSP 编译错误）--%>
                <p class="con-info" id="errorMsg">
                </p>
            </div>
        </div>

</div>
</body>
</html>
<%@ include file="/ta/incfooterTopEvent.jsp"%>
