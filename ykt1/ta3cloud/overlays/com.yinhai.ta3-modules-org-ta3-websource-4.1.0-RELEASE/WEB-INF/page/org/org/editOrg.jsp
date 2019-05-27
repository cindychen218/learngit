<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<%@page import="com.yinhai.core.common.api.config.impl.SysConfig"%>
<%@page import="com.yinhai.modules.org.api.util.IOrgConstants"%>
<%
	String orgType_org = IOrgConstants.ORG_TYPE_ORG;
	String orgType_depart = IOrgConstants.ORG_TYPE_DEPART;
	String orgType_team = IOrgConstants.ORG_TYPE_TEAM;
%>
<html>
<head>
	<title>编辑组织</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:pageloading/>
<ta:text id="t_orgid" display="false" />
<ta:text id="t_porgname"  display="false" />
<ta:form id="orgForm" fit="true">
	<ta:panel id="orgInfo" hasBorder="false" expanded="false" scalable="false" fit="true"
			  bodyStyle="padding:10px;overflow:auto;" withButtonBar="true">
		<ta:box id="departPanel" cssStyle="padding:10px;" columnWidth="0.9" fit="true">
			<ta:text id="porgid" key="父级组织id" display="false" />
			<ta:text id="orgid" key="组织id" display="false" />
			<ta:text id="orglevel" key="父组织层级" display="false" />
			<ta:text id="isleaf" key="父组织是否为叶子" display="false" />
			<ta:text id="porgname" key="父组织名称" readOnly="true" columnWidth="0.6" span="2" labelWidth="125" />
			<ta:text id="orgnamepath" key="组织路径" readOnly="true" columnWidth="0.6" span="2" disabled="true" labelWidth="125"/>
			<ta:text id="orgname" key="组织名称"  validType='[{type:"maxLength",param:[60],msg:"最大长度为60"}]'  required="true" columnWidth="0.6" span="2"  labelWidth="125" onChange="fnChange(this)"/>
			<ta:box span="2" id="yab003TreeView">
				<ta:selectTree  url="orgUserMgAction!getYab003List.do" required="true" asyncParam="['id']"
								key="经办机构" nameKey="name" idKey="id" parentKey="pid"
								treeId="w_yab003Tree" targetId="yab003Tree"  targetDESC="w_yab003Desc" labelWidth="125" />
			</ta:box>
			<ta:box span="2" columnWidth="0.6" >
				<ta:text id="costomno" key="自定义编码" columnWidth="1" validType='[{type:"maxLength",param:[20],msg:"最大长度为20"},{type:"compare",param:[">","maxUdi"]}]' labelWidth="125"/>
				<ta:text id="maxUdi" key="已使用最大编号" columnWidth="0.5" readOnly="true" validType='[{type:"maxLength",param:[20],msg:"最大长度为20"}]' labelWidth="110" display="false"/>
			</ta:box>
			<ta:selectInput id="orgtype" key="组织类型"  span="2" columnWidth="0.6"  collection="ORGTYPE" required="true" labelWidth="125" onSelect="fnOrgTypeSelect"/>
			<%--<ta:selectData labelWidth="125" placeholder="输入姓名后查询" hiddenValue="positionid" id="positionnamelike"  name="orgmanager" submitIds="orgid" displayValue="positionname" key="组织负责人(正职)" columnWidth="0.6" span="2" url="orgUserMgAction!queryLikeZhengzhi.do" inputQueryNum="1" titleValue="orgnamepath"></ta:selectData>
			<ta:selectData labelWidth="125" placeholder="输入姓名后查询" hiddenValue="positionid" id="positionnamelike1" name="orgmanager_deputy" submitIds="orgid" displayValue="positionname" key="组织负责人(副职)" columnWidth="0.6" span="2" url="orgUserMgAction!queryLikeZhengzhi.do" multiple="true" inputQueryNum="1" titleValue="orgnamepath"/>
			--%><ta:selectInput id="yab003" collection="yab003" key="经办机构" required="true" span="2" labelWidth="125" columnWidth="0.6" filterOrg="false"  />
			<ta:radiogroup id="effective" labelWidth="125" key="禁用标志"  cols="2" required="true" span="2" columnWidth="0.6">
				<ta:radio name="dto['effective']" key="禁用" value="0" />
				<ta:radio name="dto['effective']" key="启用" value="1" onClick="fnCheckParent(event)"/>
			</ta:radiogroup>
			<%-- 新增组织扩展jsp --%>
			<%@include file="../../org/orgextend/orgMgExtend.jsp" %>
		</ta:box>
		<ta:panelButtonBar>
			<ta:button type="submit" icon="icon-addTo" url="orgUserMgAction!editOrg.do" id="update"  key="保存[S]" onSubmit="fnBeforeUpdateOrg" submitIds="departPanel" hotKey="S" successCallBack="fnRefleshTree" />
			<ta:button id="close" icon="icon-close2" key="关闭[C]" hotKey="C" onClick="fnClose()"/>
		</ta:panelButtonBar>
	</ta:panel>
</ta:form>
</body>
</html>
<script  type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        Base.submit("t_orgid,t_porgname","orgUserMgAction!queryEditOrg.do",{},null,null,function(data){
            Base.setSelectDataValue("positionnamelike",{
                positionid:data.fieldData.orgmanager,
				positionname:data.fieldData.orgmanager_name
			});
            Base.setSelectDataValue("positionnamelike1",{
                positionid:data.fieldData.orgmanager_deputy,
                positionname:data.fieldData.orgmanager_deputy_name
            });
        });
    })
    //组织名称改变触发事件
    function fnChange(){
        var orgname=Base.getValue("orgname");
        var orgnamepath=Base.getValue("orgnamepath");
        var index=orgnamepath.lastIndexOf("/");
        var str=orgnamepath.substring(0,index+1)+orgname;
        Base.setValue("orgnamepath",str);
    }
    //重构树节点的数据
    function  fnRefleshTree(){
        var orgtype=Base.getValue("orgtype");
        var treeObj=parent.$.fn.zTree.getZTreeObj("orgTree");
        var node=treeObj.getNodeByParam("orgid",Base.getValue("orgid"));
        node.orgname=Base.getValue("orgname");
        node.orgtype=Base.getValue("orgtype");
        node.costomno=Base.getValue("costomno");
        node.yab003=Base.getValue("yab003");
        node.orgnamepath=Base.getValue("orgnamepath");
        var effective=Base.getValue("effective");
        node.effective=effective;

        if(effective=="0"){
            var nodes=treeObj.getNodesByFilter(filter,false,node,"");
            for(var i=0;i<nodes.length;i++){
                nodes[i].effective=effective;
                treeObj.updateNode(nodes[i],false);
            }
        }
        if(orgtype=="01"){
            node.iconSkin="tree-depart-area";
        }else{
            node.iconSkin="tree-depart-labor";
        }
        treeObj.updateNode(node,false);
        parent.Base.msgTopTip("修改组织成功");
        parent.Base.closeWindow("newWin");
    }
    //过滤函数
    function filter(node){
        if(node.orgnamepath.indexOf(Base.getValue("orgnamepath"))==-1){
            return false;
        }else{
            return true;
        }
    }
    //关闭窗口
    function fnClose(){
        parent.Base.closeWindow("newWin");
    }
    //检测effect为禁用时，提醒用户确认
    function fnBeforeUpdateOrg(){
        if(Base.getValue("orgid")=="1"&&Base.getValue("effective")=="0"){
            Base.msgTopTip("顶层组织不能禁用");
            return false;
        }
        if (Base.getValue("effective") == "0") {
            return confirm("禁用组织将禁用子组织，及这些组织下的所有岗位，是否继续");
        }else
            return true;
    }
    //选择组织类型
    function fnOrgTypeSelect(value,key){
        var treeObj =parent.$.fn.zTree.getZTreeObj("orgTree");
        var pnode = treeObj.getNodeByParam(treeObj.setting.data.simpleData.idKey, Base.getValue("porgid"));
        var node = treeObj.getNodeByParam(treeObj.setting.data.simpleData.idKey, Base.getValue("orgid"));
        if(node !=null && node !=undefined &&  node.children){
            var cnodes = node.children;
            for(var i = 0 ; i < cnodes.length; i++){
                if(cnodes[i].orgtype ==  '<%=orgType_org%>'){
                    if(key != "<%=orgType_org%>"){
                        Base.setValue("orgtype","");
                        Base.alert("该组织下有机构，因此该组织只能是机构","error",function(){Base.focus("orgtype")});
                        break;
                    }
                }else if(cnodes[i].orgtype == "<%=orgType_depart%>"){
                    if(key == "<%=orgType_team%>"){
                        Base.setValue("orgtype","");
                        Base.alert("该组织下有部门，因此该组织只能是机构或者部门","error",function(){Base.focus("orgtype")});
                        break;
                    }
                }
            }
        }
        if(pnode != null && pnode != undefined){
            if(pnode.orgtype == "<%=orgType_org%>"){
            }else if(pnode.orgtype == "<%=orgType_depart%>"){
                if(key == "<%=orgType_org%>"){
                    Base.setValue("orgtype","");
                    Base.alert("部门下只能建部门或者组","error",function(){Base.focus("orgtype")});
                }
            }else if(pnode.orgtype == "<%=orgType_team%>"){
                if(key != "<%=orgType_team%>") {
                    Base.setValue("orgtype", "");
                    Base.alert("组下只能建组", "error", function() {
                        Base.focus("orgtype")
                    });
                }
            } else {
                Base.setValue("orgtype", "");
                Base.alert("组织机构类型出错，请联系管理员", "error", function() {
                    Base.focus("orgtype")
                });
            }
        }
    }
    //判断父节点是否禁用
    function fnCheckParent(e){
        var treeObj=parent.$.fn.zTree.getZTreeObj("orgTree");
        var node = treeObj.getNodeByParam(treeObj.setting.data.simpleData.idKey, Base.getValue("porgid"));
        if (node && node != null && node != undefined &&  node.effective == 0){
            Base.alert("该组织的上级组织已经禁用，请先启用上级组织","warn");
            Base.setValue("effective", "0");
            e.keyCode = 0;
            e.cancelBubble = true;
            e.returnValue = false;
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>