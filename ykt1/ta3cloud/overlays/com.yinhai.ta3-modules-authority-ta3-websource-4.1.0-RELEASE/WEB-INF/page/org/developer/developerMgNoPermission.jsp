<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
	<title>超级管理员管理为开启</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" layout="border" layoutCfg="{leftWidth:270}" id="hintbody" style="padding:0px;margin:0px">
<ta:pageloading/>
<ta:box id="unopen" cssStyle="font-size:20px;color:red;">多超级管理员为开启，联系管理开启config.properties里面isOpenMultipleDeveloper参数设置成true</ta:box>
<ta:box id="nopermit" cssStyle="font-size:20px;color:red;">没有访问此功能的权限，此权限只有超级管理员可以访问!!</ta:box>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
    })
</script>
<%@ include file="/ta/incfooter.jsp"%>