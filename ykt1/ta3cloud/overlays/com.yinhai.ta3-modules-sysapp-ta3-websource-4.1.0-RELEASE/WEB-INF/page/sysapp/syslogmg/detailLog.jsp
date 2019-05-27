<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>系统异常详细信息</title>
    <%@ include file="/ta/inc.jsp"%>
    <style>
        .textarea-layout-Container .textarea-input-Container.readonly { pointer-events: auto; }
    </style>

</head>
<body class="no-scrollbar" >
<ta:pageloading/>
<ta:panel id="pnlMain" hasBorder="false">
    <ta:text id="type" key="异常类型" readOnly="true"></ta:text>
    <ta:textarea  key="详细信息" id="exceptionDetail" height="400" readOnly="true"></ta:textarea>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
		var obj = Base.getObj("exceptionDetail").getValue().replaceAll("<br/>","\n");
		Base.getObj("exceptionDetail").setValue(obj);
    });
</script>
<%@ include file="/ta/incfooter.jsp"%>