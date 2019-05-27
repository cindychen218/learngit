<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>日志分析</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar">
<script type="text/javascript" src="<%=facePath%>lib/echart/echarts-all.js"></script>
<ta:pageloading/>
<ta:tabs fit="true" id="qktj" onSelect="fnTaTabSelect">
	<ta:tab key="用户在线时点分析" id="zxqk">
		<%@include file="logAanalysis_ol.jsp" %>
	</ta:tab>
	<ta:tab key="用户登录时点分析" id="login">
		<%@include file="logAanalysis_login.jsp" %>
	</ta:tab>
	<ta:tab key="用户登录环境分析" id="dlqk" cssStyle="overflow:auto;">
		<%@include file="logAanalysis_re.jsp" %>
	</ta:tab>
</ta:tabs>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
		taStatLogin();
        //在线人数统计
		taStatOnline();
		taLogAanalysisRun_ol();
        //客户端系统版本统计
        taStatClientSys();
        //客户端屏幕分辨率统计
        taStatClientScreen();
        //客户端浏览器统计
        taStatClientBrowser();

    });
    function fnTaTabSelect(tab){
        if(tab == 'zxqk' && window.taLogAanalysisRun_ol){
            //绘制用户时点在线统计图
            taLogAanalysisRun_ol();
        }
        if(tab == 'login' && window.taLogAanalysisRun_login){
			taLogAanalysisRun_login();
		}
        if(tab == 'dlqk'){
            if(window.taLogAanalysisRun_cs){
                //绘制用户客户端系统版本统计图
                taLogAanalysisRun_cs();
            }
            if(window.taLogAanalysisRun_css){
                //绘制用户客户端分辨率统计图
                taLogAanalysisRun_css();
            }
            if(window.taLogAanalysisRun_cb){
                //绘制用户客户端浏览器版本统计图
                taLogAanalysisRun_cb();
            }
        }
    }

</script>
<%@ include file="/ta/incfooter.jsp"%>