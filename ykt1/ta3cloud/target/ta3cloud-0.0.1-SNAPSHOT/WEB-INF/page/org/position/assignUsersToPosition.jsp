<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>岗位</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body id="body1" class="no-scrollbar">
<ta:pageloading/>
<ta:panel id="condition" fit="true" cols="3" withButtonBar="true" hasBorder="false" bodyStyle="padding:10px;">

	<ta:box fit="true" cols="2" span="2">
		<ta:text id="positionid" display="false"/>
		<ta:text id="userids" display="false"/>
		<ta:text id="orgid" display="false"/>
		<ta:box  columnWidth="0.4" fit="true" cssClass="linecolor" cssStyle="padding:10px;background-color:white;overflow:auto">
			<ta:checkbox key="包含子组织" id="isChildren" checked="true" value="isChildren" onClick="fnOrgTreeClick1(this)"/>
			<ta:tree id="orgTree" asyncUrl="positionUserMgAction!webQueryAsyncOrgTree.do" fontCss="fnFontCss" beforeClick="fnBeforeClick" childKey="orgid" parentKey="porgid" nameKey="orgname" asyncParam="['orgid']"
					 async="true" onClick="fnOrgTreeClick" showLine="true"/>
		</ta:box>
		<ta:box columnWidth="0.6" fit="true" cssStyle="margin-left:10px;" cssClass="linecolor">
			<ta:datagrid forceFitColumns="true" fit="true" id="userGrid" haveSn="true" selectType="checkbox" columnFilter="true">
				<ta:datagridItem id="name" key="姓名" align="center" width="90"></ta:datagridItem>
				<ta:datagridItem id="orgnamepath" key="所属组织" align="center"  width="300" showDetailed="true"></ta:datagridItem>
				<ta:dataGridToolPaging url="positionUserMgAction!queryUsersByOrgId.do" submitIds="condition" showExcel="false" pageSize="20" />
			</ta:datagrid>
		</ta:box>
	</ta:box>
	<ta:box height="100%" cols="2">
		<ta:box  columnWidth="0.2" fit="true">
			<div style="width:100%;position: relative;top:50%;	" id="centerdiv">
				<ta:button key="新增" cssStyle="display:block;margin: 0 auto;" icon="icon-dbArrow_right" onClick="batchAddData()"/>
				<ta:button key="移除" cssStyle="display:block;margin: 0 auto;margin-top:10px" icon="icon-dbArrow_left" onClick="batchDelete()"/>
			</div>
		</ta:box >
		<ta:box columnWidth="0.8" fit="true">
			<ta:datagrid forceFitColumns="true" fit="true" id="userGridSelect"  haveSn="true" columnFilter="true" selectType="checkbox">
				<ta:datagridItem id="name" key="姓名" align="center" width="90"></ta:datagridItem>
				<ta:datagridItem id="orgnamepath" key="所属组织" align="center"  width="300" showDetailed="true"></ta:datagridItem>
			</ta:datagrid>
		</ta:box>
	</ta:box>
	<ta:panelButtonBar>
		<ta:button key="保存[S]" hotKey="s" onClick="fnAddPosition()" icon="icon-addTo"/>
		<ta:button id="remove"  key="关闭[X]" hotKey="x" icon="icon-close2" onClick="fnClose();"/>
	</ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        //默认以根节点进行查询
        Base.submit("positionid","positionUserMgAction!queryUsersByOrgId.do",
            {"dto['orgid']":Base.getValue("orgid"),"dto['userids']":Base.getValue("userids"),"dto['isChildren']":Base.getValue("isChildren")});
    });
    //右侧表格数据移除
    function batchDelete(){
        var gridHebing=[];//合并之后的数据
        var gridSelected = Base.getGridSelectedRows("userGridSelect");
        var gridExistData = Base.getGridData("userGrid");
        Base.deleteGridSelectedRows("userGridSelect");
        var repeatName="";
        if(gridSelected.length==0){
            return Base.alert("请先选择账户再进行操作","warn");
        }
        for(var i =0 ; i< gridSelected.length;i++){
            var exist=false;
            for(var j=0;j<gridExistData.length;j++){
                if(gridExistData[j].userid==gridSelected[i].userid){
                    exist=true;
                    repeatName=repeatName + gridSelected[i].name+",";
                    break;
                }
            }
            if(!exist){
                gridHebing.push(gridSelected[i]);
            }
        }
        //合并选择的数据
        if(gridHebing.length < gridSelected.length){
            repeatName = repeatName.substr(0,repeatName.length-1);
            Base.alert("["+repeatName+"]" +"账户已经勾选");
        }
        var result = gridExistData.concat(gridHebing);
        Base._setGridData("userGrid",result);
        // Base.deleteGridRowsByData("userGrid",gridHebing);
        Base._setGridData("userGridSelect",Base.getGridData("userGridSelect"));

    }
    //选择左侧表格数据到右侧
    function batchAddData(){
        var gridHebing=[];//合并之后的数据
        var gridSelected = Base.getGridSelectedRows("userGrid");
        var gridExistData = Base.getGridData("userGridSelect");
        Base.deleteGridSelectedRows("userGrid");
        var repeatName="";
        if(gridSelected.length==0){
            return Base.alert("请先选择账户再进行操作","warn");
        }
        for(var i =0 ; i< gridSelected.length;i++){
            var exist=false;
            for(var j=0;j<gridExistData.length;j++){
                if(gridExistData[j].userid==gridSelected[i].userid){
                    exist=true;
                    repeatName=repeatName + gridSelected[i].name+",";
                    break;
                }
            }
            if(!exist){
                gridHebing.push(gridSelected[i]);
            }
        }
        //合并选择的数据
        if(gridHebing.length < gridSelected.length){
            repeatName = repeatName.substr(0,repeatName.length-1);
            Base.alert("["+repeatName+"]" +"账户已经勾选");
        }
        console.log("1:"+gridExistData);
        var result = gridExistData.concat(gridHebing);
        Base._setGridData("userGridSelect",result);
		console.log("2:"+result);
       // Base.deleteGridRowsByData("userGrid",gridHebing);
        Base._setGridData("userGrid",Base.getGridData("userGrid"));
    }
    function fnOrgTreeClick(e, tree, treeNode){
        var userids = Base.getValue("userids");
        Base.setValue("orgid",treeNode.orgid);
        Base.submit("positionid","positionUserMgAction!queryUsersByOrgId.do",
            {"dto['orgid']":treeNode.orgid,"dto['userids']":userids,"dto['isChildren']":Base.getValue("isChildren")});
    }
    function fnOrgTreeClick1(obj){
        var orgTree = Base.getObj("orgTree");
        var selectedNodes = orgTree.getSelectedNodes();
        var treeNode;
        if(selectedNodes && selectedNodes.length == 1){
            treeNode = selectedNodes[0];
        }else{
            Base.alert("请选择部门后再进行子部门人员的查询","warn");
            $(obj).removeAttr("checked");
            return;
        }
        var userids = Base.getValue("userids");
        Base.setValue("orgid",treeNode.orgid);
        Base.submit("positionid","positionUserMgAction!queryUsersByOrgId.do",
            {"dto['orgid']":treeNode.orgid,"dto['userids']":userids,"dto['isChildren']":Base.getValue("isChildren")});
    }

    function fnAddPosition(){
        var data = Base.getGridData("userGridSelect");
        if(data && data.length > 0){
            Base.submit(null,"positionUserMgAction!saveAssignUsers.do",
                {
                    "dto['positionid']":Base.getValue('positionid'),
                    "dto['userGridSelect']":Ta.util.obj2string(data)
                },null,false,function(){
                    Base.deleteGridSelectedRows("userGrid");
                    var positionid = Base.getValue('positionid');
                    parent.Base.submit("","positionUserMgAction!queryPosMission.do",{"pos_positionid":positionid},null,null,function(data){
                    });
                    parent.Base.msgTopTip("添加成功!");
                    fnClose();
                });
        }else{
            Base.alert("请选择数据后再进行岗位的添加","warn");
        }
    }

    //组织树渲染
    function fnFontCss(treeId,treeNode){
        if(treeNode.effective == 0 && !treeNode.admin){
            return {'text-decoration':'line-through','color': 'red'};
        }else if(treeNode.effective == 0 && treeNode.admin){
            return {'text-decoration':'line-through'};
        }else if(treeNode.effective != 0 && !treeNode.admin){
            return {'color': 'red'};
        }else{
            return {};
        }
    }
    //权限判断
    function fnBeforeClick(treeId,treeNode){
        if(treeNode.effective == 0){
            parent.Base.msgTopTip("<div class='msgTopTip'>该组织无效，不能进行查询</div>");
            return false;
        }
        if(treeNode.admin != true){
            parent.Base.msgTopTip("你无权操作该组织");
            return false;
        }else{
            return true;
        }
    }

    /**关闭窗口*/
    function fnClose(){
        parent.Base.closeWindow("assignUser");
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>