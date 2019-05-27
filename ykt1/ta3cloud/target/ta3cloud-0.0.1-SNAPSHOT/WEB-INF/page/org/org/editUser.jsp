<%@page import="com.yinhai.modules.org.ta3.domain.po.IOrg"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<%
	String orgType_org = IOrgConstants.ORG_TYPE_ORG;
	String orgType_depart = IOrgConstants.ORG_TYPE_DEPART;
	String orgType_team = IOrgConstants.ORG_TYPE_TEAM;
%>
<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%">
<head>
	<title>人员修改</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:pageloading/>
<ta:form id="userForm" fit="true">
	<ta:panel id="userInfo" hasBorder="false" expanded="false" fit="true" bodyStyle="padding:10px 20px 10px 10px;" withButtonBar="true">
		<ta:text id="userid" key="用户编号" readOnly="true" span="2" display="false"/>
		<ta:text id="loginid" key="登录帐号" required="true" readOnly="true" span="2"  validType='[{type:"maxLength",param:[10],msg:"最大长度为10"}]' labelWidth="120"  bpopTipPosition="bottom"/>
		<ta:text id="name" key="姓名" required="true" labelWidth="120"/>
		<%--<ta:radiogroup key="性别" collection="SEX" id="sex" cols="2"/>--%>
		<ta:selectInput key="性别" collection="SEX" id="sex" filterOrg="false" labelWidth="120"/>
		<ta:text id="tel" key="移动电话"  validType='[{type:"maxLength",param:[11],msg:"最大长度为11"},{type:"mobile"}]' labelWidth="120"/>
		<ta:selectInput id="isdeveloper" key="是否是超级管理员" collection="YESORNO" value="0" textHelp="设置当前人员是否是超级管理员,设置是之后，不需要在系统授权，用用最高权限" labelWidth="120"></ta:selectInput>
		<ta:panelButtonBar align="right">
			<ta:button type="submit" icon="icon-addTo" id="updateUserBtn" key="保存[S]" hotKey="S" submitIds="userInfo" url="orgUserMgAction!editUser.do" successCallBack="function(){parent.Base.msgTopTip('修改用户成功');parent.Base.closeWindow('win');}"/>
			<ta:button icon="icon-close2" id="closeWinBtn" key="关闭[X]"  hotKey="X" onClick="parent.Base.closeWindow('win');" />
		</ta:panelButtonBar>
	</ta:panel>
</ta:form>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        Base.focus("name");
    })
    /*添加org*/
    function fnAddOrgToOrgList() {
        var data = Base.getGridData("orgidList");
        var node = $.fn.zTree.getZTreeObj("w_orgTree").getNodeByParam("id", Base.getValue("w_orgid"), null);
        if (node != null && node.id != null) {
            for (var i = 0; i < data.length; i ++) {
                if (node.id == data[i].orgid) {Base.msgTopTip("<div style='width: 200px;margin: auto 0;text-align: center;line-height: 100px;font-size: 20px;'>已添加</div>", 2200, 200, 100);return;}
            }
            var org = {};
            org.orgname = node.name;
            org.orgid = node.id;
            org.orgtype = node.orgtype;
            org.orgnamepath = node.orgnamepath;
            data.push(org);
            Base._setGridData("orgidList", data);
            var json = Ta.util.obj2string(data);
            $("#orgs").val(json);
        }
    }
    function fnDelOrgFromOrgList() {
        Base.deleteGridSelectedRows("orgidList");
        var data = Base.getGridData("orgidList");
        var json = Ta.util.obj2string(data);
        $("#orgs").val(json);
    }
    function fnSaveSuccCb() {
        if (confirm("保存成功，是否继续新增人员？")) {
            Base.resetData("userForm");
            Base.focus("name");
        } else {
            Base.closeWindow('win');
        }
    }
    function fnselecttree(treeId, treeNode) {
        //是否有效
        if (treeNode.effective == 0) return false;
        //是否有管理权限
        if (!treeNode.admin) return false;
        //直属组织必须是部门或者机构
        if (treeNode.orgtype != "<%=orgType_org%>" && treeNode.orgtype != "<%=orgType_depart%>"){
            Base.alert("直属组织只能是部门或者机构，不能为组","warn");
            return false;
        }
        return true;
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>