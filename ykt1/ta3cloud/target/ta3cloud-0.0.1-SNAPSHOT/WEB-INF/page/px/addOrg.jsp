<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>


<html>
<head>
	<title>新增组织</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" style="padding:0px;margin:0px">
<ta:pageloading/>

<ta:button key="baoc"/>

</body>
</html>
<script  type="text/javascript">
	$(document).ready(function () {
		$("body").taLayout();
	})
</script>
<%@ include file="/ta/incfooter.jsp"%>