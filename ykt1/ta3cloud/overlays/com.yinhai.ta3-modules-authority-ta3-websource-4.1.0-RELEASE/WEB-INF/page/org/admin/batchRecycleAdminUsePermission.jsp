<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
	<title>批量回收权限</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:pageloading />
<ta:fieldset cssStyle="margin:10px;">
	<div style="color:red;">你在表格中所勾选的岗位将“失去”这些被勾选的资源的使用权限.</div>
</ta:fieldset>
<ta:panel id="adminPanel" hasBorder="false" expanded="false" fit="true"  bodyStyle="margin:0px 10px;" bodyClass="linecolor" withButtonBar="true">
	<ta:tree id="opTree" checkable="true" chkboxType="{'Y':'s','N':''}" onCheck="fnTreeChg1" beforeCheck="fnBfChk" fontCss="fnSetFont"/>
	<ta:text id="recyclePermissionsPositionids" display="false"/>
	<ta:text id="positionType" display="false"/>
	<ta:panelButtonBar align="right">
		<ta:button id="personalrecyclePermissionsOpBtn" key="保存[S]" hotKey="S" icon="icon-addTo"  onClick="fnRecyclePermissionsOp()"/>
		<ta:button id="closeOpBtn" key="关闭[X]" hotKey="X" icon="icon-close2" onClick="parent.Base.closeWindow('opWin');"/>
	</ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script>
    $(document).ready(function() {
        $("body").taLayout();
    })
    function fnTreeChg1(event, treeId, treeNode) {
        var opTree = Base.getObj("opTree");
        var ptreeNode = opTree.getNodeByParam("id", treeNode.pId);
        if(ptreeNode){
            var pcheckbox = $("#" + ptreeNode.tId  + "_check");
            if (!treeNode.checked && ptreeNode.checked)
                pcheckbox.click();
        }
    }
    function fnSetFont(treeId, treeNode) {
        if(treeNode.policy == 4 || treeNode.policy == 3)
            return {color:"red"};
    }
    function fnBfChk(treeId, treeNode) {
        if(treeNode.policy == 4 || treeNode.policy == 3)
            return Base.alert("该功能无需安全认证，所有用户都有权限，即便修改也无效。"), false;
        return true;
    }

    function fnRecyclePermissionsOp(url){
        var obj = Base.getObj("opTree");
        var nodes = obj.getChangeCheckedNodes();
        var len = nodes.length;
        if (len == 0) {
            return Base.alert("没有任何改变，不需要保存。"), false;
        }
        var checkedNodes = obj.getCheckedNodes(true);
        var str = "";
        for (var i = 0; i < len; i++) {
            nodes[i].checkedOld = nodes[i].checked;
        }
        for(var i = 0 ; i < checkedNodes.length; i++){
            var node = checkedNodes[i];
            if(node.isyab003 != null){
                var pnode = node.getParentNode();
                str += "{\"id\":\"" + node.id + "\",\"isyab003\":\""+node.isyab003+"\",\"menuid\":\""+pnode.id+"\"},";
            }else{
                str += "{\"id\":\"" + node.id + "\"},";
            }
        }
		var positionids = Base.getValue("recyclePermissionsPositionids").split(",");
		var positionDto = "";
		for (var i = 0; i < positionids.length; i++) {
			positionDto += "{'positionid':'" + positionids[i] + "'},";
		}
		positionDto = "[" + positionDto.substring(0, positionDto.length - 1) + "]";

		if (str != "") {
            str = "[" + str.substr(0, str.length - 1) + "]";
            Base.submit("adminPanel", "adminUserMgAction!recycleAdminUsePermissions.do", {"ids":str,"positionids":positionDto},null,null,function(){
                parent.Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>批量回收使用权限成功</div>");
                parent.Base.closeWindow('opWin');
            });
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>