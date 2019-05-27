<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="inc-path.jsp" %>
<head>
    <title>异常界面</title>
    <link id="linkskin" type="text/css" rel="stylesheet">
    <script src="<%=facePath%>support/jquery/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script>
        webFaceSkin.apply(linkskin,"<%=basePath%>indexSRC/errorpage/css/");
        $(document).ready(function () {
            $("#bgImg").attr("src","<%=basePath %>indexSRC/errorpage/img/"+webFaceSkin.getSkin()+"/401.png");
        })
    </script>

</head>
<body class="no-scrollbar">
<div class="content">
    <div class="content-con">
        <div class="con-center">
            <img id="bgImg" alt="pic"/>
        </div>
        <div class="con-desc">
            异常代码：401
        </div>
    </div>

</div>
</body>
</html>
<%@ include file="/ta/incfooterTopEvent.jsp"%>
