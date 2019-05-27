<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*"%>
<%@ page import="com.yinhai.core.common.api.config.impl.SysConfig"%>
<%@ include file="inc-path.jsp" %>

<script type="text/javascript">
    var jsonMsg ="";
    <%if ("true".equals(SysConfig.getSysConfig("developMode"))) {%>
        jsonMsg = "<%=session.getAttribute("exceptionJsonMsg")%>";
    <%} else { %>
        jsonMsg = "<%=request.getParameter("exceptionJsonMsg")%>";
    <%} %>

    function ready(fn){
        if(document.addEventListener){  //标准浏览器
            document.addEventListener('DOMContentLoaded',function(){
                //注销事件，避免反复触发
                document.removeEventListener('DOMContentLoaded',arguments.callee,false);
                fn();
            },false)
        }
        else if(document.attachEvent){    //IE，两个条件
            document.attachEvent('onreadystatechange',function(){
                if(document.readyState=='complete'){
                    //注销事件，避免反复触发
                    document.detachEvent('onreadystatechange',arguments.callee);
                    fn();
                }
            });
        }
    }
    ready(function(){
        $("#bgImg").attr("src","<%=basePath %>indexSRC/errorpage/img/"+webFaceSkin.getSkin()+"/418.png");
        document.getElementById("errorMsg").innerText = (typeof jsonMsg == "undefined" || jsonMsg == null || jsonMsg == "null")?"":jsonMsg;
    });
</script>
<head>
    <title>异常界面</title>
    <link id="linkskin" type="text/css" rel="stylesheet">
    <script src="<%=facePath%>support/jquery/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script>
        webFaceSkin.apply(linkskin,"<%=basePath%>indexSRC/errorpage/css/");
    </script>
</head>
<body class="no-scrollbar">
<div class="content">
    <div class="content-con">
        <div class="con-center">
            <img id="bgImg" alt="pic"/>
        </div>
        <div class="con-desc">
            异常代码：418
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
