<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
	<title>缓存信息</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:panel id="cacheForm" withButtonBar="true" hasBorder="false" fit="true">
	<ta:fieldset key="缓存信息">
		<ta:text id="cacheName" key="缓存名称" readOnly="true" />
		<ta:text id="cacheKey" key="缓存键值" readOnly="true" />
		<ta:text id="cacheKeyType" display="false"/>
		<ta:textarea id="cacheValue" key="缓存值" readOnly="true" height="120"/>
	</ta:fieldset>
	<ta:panelButtonBar align="right">
		<ta:button key="关闭[X]" onClick="parent.Base.closeWindow('cacheWin')" icon="icon-close2" hotKey="X"/>
	</ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
        $("body").taLayout();
    });
</script>