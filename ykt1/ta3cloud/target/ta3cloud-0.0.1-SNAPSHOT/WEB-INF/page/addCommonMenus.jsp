<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>常用菜单</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar">
<ta:pageloading />
<ta:box fit="true" cssStyle="width:500px;min-width:300px;">
	<ta:buttonGroup align="right">
		<ta:button id="saveScopeOpBtn" key="保存" onClick="fnSaveOp('commonMenuAction!saveCommonMenus.do')" />
	</ta:buttonGroup>
	<ta:box cssStyle="overflow:auto;" fit="true" heightDiff="40">
		<ta:tree id="commonMenuTree" checkable="true" nameKey="menuname"
				 childKey="menuid" parentKey="pmenuid"
				 chkboxType="{'Y':'s', 'N':'ps'}" />
	</ta:box>
</ta:box>
</body>
</html>
<script>
    $(document).ready(function() {
        $("body").taLayout();
    });

    function sendMsgToFrame(type, msg, args) {
        try {
            var o = {};
            o.type = type;
            o.msg = msg;
            o.args = args;
            o = Ta.util.obj2string(o);
            window.top.postMessage(o, "*");
        } catch (e) {
        }
    }

    function fnSaveOp(url) {
        var obj = Base.getObj("commonMenuTree");
        var nodes = obj.getChangeCheckedNodes();
        var len = nodes.length;
        if (len == 0) {
            return Base.alert("没有任何改变，不需要保存。"), false;
        }
        var str = "";
        for (var i = 0; i < len; i++) {
            var node = nodes[i];
            str += "{\"menuid\":\"" + node.menuid + "\",\"checked\":\""
                + node.checked + "\"},";
            node.checkedOld = node.checked;
        }
        if (str != "") {
            str = "[" + str.substr(0, str.length - 1) + "]";
            $.ajax({
                "data" : "{ \"list\" : " + str + "}",
                "url" : Base.globvar.basePath + url,
                contentType: "application/json",
                "success" : function(data) {
                    Base.msgTopTip("<div style='width:140px;margin:0 auto;font-size:16px;margin-top:8px;text-align:center;'>更新常用菜单成功!</div>");
                    Base.closeWindow("addWin");
                    sendMsgToFrame("function", "menuCommon.getMenuCommonList");
                },
                "type" : "POST",
                "dataType" : "json"
            });
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>