<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
    <title>组织人员管理</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" id="hintbody" style="padding:0px;margin:0px">
<ta:pageloading/>
<ta:box cols="2" fit="true">
    <ta:box fit="true" columnWidth="0.3" id="orgTreeBox">
        <ta:text id="searchbox" cssClass="searchbox" value="输入后回车检索" clickIcon="icon-search"
                 clickIconFn="fnQuery()"></ta:text>
        <ta:box fit="true" cssStyle="overflow:auto;">
            <ta:tree id="orgTree" childKey="orgid" nameKey="orgname" parentKey="porgid" fontCss="treeEffective"
                     showLine="true" async="false"
                     editable="false" onClick="fnClk"
                     keepLeaf="true" showAddBtn="false"
                     beforeDrop="fnBeforeDrop" onDrop="fnOnDrop"/>
        </ta:box>
    </ta:box>
    <ta:box fit="true" id="userGridBox" cssStyle="padding:10px;" columnWidth="0.7">
        <ta:box>
            <ta:fieldset cols="12" id="userQuery">
                <ta:text id="dept" key="组织" labelWidth="60" span="4" readOnly="true" clickIcon="icon-close"
                         clickIconTitle="点击还原为所有组织" clickIconFn="fnClear()"/>
                <ta:checkboxgroup id="isShowSubOrg" cssStyle="width:100px">
                    <ta:checkbox key="子组织" value="1" checked="false" display="false" onClick="fnOnClick()"/>
                </ta:checkboxgroup>
                <ta:text id="nameKey" span="3" cssStyle="margin-right:20px" labelWidth="70"
                         keys="[{name:'name',key:'姓名'},{name:'loginid',key:'账号'}]"
                         textHelp="姓名支持模糊查询;账户不支持模糊查询，但支持多个账户查询，以逗号隔开"></ta:text>
                <ta:buttonGroup span="4">
                    <ta:button key="查询" icon="icon-search" onClick="fnQueryUsers()"></ta:button>
                    <ta:button key="重置" icon="icon-refresh" onClick="fnReset()"></ta:button>
                    <ta:button key="↓" id="showmore" onClick="showMore(this,'more')"/>
                </ta:buttonGroup>
                <ta:box span="12" cols="3" id="more" cssStyle="display:none">
                    <ta:radiogroup key="性别" id="sex" cols="3" labelWidth="60">
                        <ta:radio key="男" value="1"/>
                        <ta:radio key="女" value="2"/>
                        <ta:radio key="不限" value="-1" checked="checked"/>
                    </ta:radiogroup>
                    <ta:radiogroup key="锁定标志" id="islock" cols="3" labelWidth="90">
                        <ta:radio key="锁定" cssStyle="color:gray;text-decoration: line-through;" value="1"/>
                        <ta:radio key="未锁" value="0"/>
                        <ta:radio key="不限" value="-1" checked="checked"/>
                    </ta:radiogroup>
                </ta:box>
                <ta:text id="deptId" key="树的orgId" display="false" value="1"/>
                <ta:text id="flag" display="false" value="1"/>
                <ta:text id="operationFlag" display="false" value="addPrincipal"/>
                <ta:text id="effective" display="false" value="-1"/>
            </ta:fieldset>
        </ta:box>
        <ta:box fit="true">
            <ta:panel fit="true" key="人员列表" cssStyle="">
                <ta:datagrid enableColumnMove="true" onSelectChange="fnSlctChg" id="userGd" fit="true"
                             selectType="checkbox" haveSn="true" forceFitColumns="true">
                    <ta:datagridItem id="userid" asKey="true" key="userid" hiddenColumn="true"/>
                    <ta:datagridItem id="orgid" asKey="true" key="orgid" hiddenColumn="true"/>
                    <ta:datagridItem id="orgidpath" asKey="true" key="orgidpath" hiddenColumn="true"/>
                    <ta:datagridItem id="positionid" asKey="true" key="positionid" hiddenColumn="true"/>
                    <ta:datagridItem id="name" key="姓名" showDetailed="true" align="center" dataAlign="center"
                                     formatter="fnNameFormatter"/>
                    <ta:datagridItem id="loginid" sortable="true" key="登录账号" width="80" align="center"
                                     dataAlign="center" showDetailed="true"/>
                    <ta:datagridItem id="orgnamepath" key="所属组织" showDetailed="true" width="400"/>
                    <ta:datagridItem id="sex" key="性别" align="center" dataAlign="center" collection="SEX"/>
                    <ta:datagridItem id="tel" key="移动电话" align="center" width="150" showDetailed="true"
                                     dataAlign="center"/>
                    <ta:datagridItem id="effective" key="可用标志" width="150px" hiddenColumn="true" asKey="true"/>
                    <ta:datagridItem id="islock" key="锁定标志" width="150px" hiddenColumn="true" asKey="true"/>
                    <ta:datagridItem id="authmode" collection="authmode" key="权限认证方式" width="100px"
                                     showDetailed="true"></ta:datagridItem>
                    <ta:dataGridToolPaging url="positionMgAction!queryAddUser.do" selectExpButtons="1,2"
                                           showExcel="true" submitIds="userQuery" pageSize="10"/>
                </ta:datagrid>
                <ta:panelButtonBar>
                    <ta:button id="addBtn" key="保存[S]" hotKey="S" disabled="true" icon="icon-addTo"
                               onClick="addPrincipal()"/>
                    <ta:button id="close" icon="icon-close2" key="关闭[C]" hotKey="C" onClick="fnClose()"/>
                </ta:panelButtonBar>
            </ta:panel>
        </ta:box>
    </ta:box>
</ta:box>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function (data) {
        $("body").taLayout();
        var orgid = Base.getValue("deptId");
        var obj = Base.getObj("orgTree");
        var node = obj.getNodeByParam("orgid",orgid);
        obj.selectNode(node);
        var str=node.orgnamepath;
        var strs=str.split("/");
        var newStr="";
        for(var i=0;i<strs.length;i++){
            if(i!=strs.length-1){
                newStr+=strs[i]+"->";
            }else{
                newStr+=strs[i];
            }
        }
        Base.setValue("dept",newStr);
        if("success"==Base.getValue("flag")){
            let orgTreeDiv = document.getElementById("orgTreeBox").parentElement;
            let userGridDiv = document.getElementById("userGridBox").parentElement;
            orgTreeDiv.remove();
            userGridDiv.style.width = "100%";
            $("#userGd").trigger("_resize");
        }
        //调整“组织”样式
        var $dept = $("#dept");
        $dept.removeClass("readonly");
        $dept.parent().removeClass("readonly");
        $dept.parent().css({"borderTop":"0px","borderLeft":"0px","borderRight":"0px","borderRadius":0});
        $("#searchbox").css('color','#CCC');
        //进入页面后再进行查询，以免数据多导致加载缓慢
        // 	fnQueryUsers();
        //树判断
        $("#searchbox").focus(function(e){
            if(this.value.trim()=='输入后回车检索'){
                $(this).css('color','#000000');
                this.value="";
                e.stopPropagation();
            }
        }).blur(function(e){
            if(this.value.trim()==''){
                $(this).css('color','#CCC');
                this.value="输入后回车检索";
                e.stopPropagation();
            }
        }).keydown(function(e){
            if(e.keyCode==13){
                fnQuery();
            }
        });
        //fnPageGuide(parent.currentBuinessId);

    })

    function fnPageGuide(currentBuinessId){
        var data = [
            {id:$("#hintbody"),
                message:"此功能可对组织与人员进行管理，增删查改组织或者人员。"
            },
            {id:$("#orgTree"),
                message:"1.鼠标移到组织树上的每一个节点，在该节点右边将产生一排可操作该组织的按钮；<br/>2.单击节点还可查询人员；<br/>3.右键单击可弹出右键菜单"
            },
            {id:$("#dept").parent(),
                message:"可将该查询条件重置为“所有组织”"
            },
            {id:$("#nameKey").parent().siblings("label"),
                message:"可在姓名和账号间切换查询条件"
            },
            {id:$("#showmore"),
                message:"单击可在下面展示更多查询条件"
            },
            {id:$("#btngrp"),
                message:"针对人员的操作，可根据表格中的勾选状况，变化可操作状态"
            }
        ];
        new TaHelpTip($("body")).helpTip({
            replay : false,
            show : true,
            cookname : currentBuinessId,
            data : data
        });
    }

    //点击显示子组织触发事件
    function fnOnClick(){
        fnQueryUsers();
    }

    //树的搜索按钮点击事件
    function fnQuery(){
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        treeObj.cancelSelectedNode();
        if ($("#searchbox").val().trim() != "") {
            var menuTree = Ta.core.TaUIManager.getCmp('orgTree');
            var nodes = menuTree.getNodesByParamFuzzy("py", $("#searchbox").val());
            if(nodes.length == 0)
                nodes = menuTree.getNodesByParamFuzzy("orgname", $("#searchbox").val());
            if(nodes.length == 0){
                Base.setValue("dept","所有组织");
                Base.setValue("deptId","");
                Base.clearGridData("userGd");
                treeObj.cancelSelectedNode();
                return;
            }
            if (nodes.length>0) {
                if(nodes.length==1){
                    menuTree.selectNode(nodes[0]);
                }else{
// 				var target=Base.getObj("searchbox");
                    var target=$("#searchbox")[0];
                    Base.showBoxComponent("b2",target)
                    var data=[];
                    for(var i=0;i<nodes.length;i++){
                        var row={};
                        row.orgname=nodes[i].orgname;
                        row.orgnamepath=nodes[i].orgnamepath;
                        row.orgid=nodes[i].orgid;
                        data.push(row);
                    }
                    Base._setGridData("find",data);
                }
            }
        }else{
            fnClear();
        }
        var sn=treeObj.getSelectedNodes();
        if(sn!=null||sn!=undefined){
            fnClk(event,"orgTree",sn[0]);
        }
    }
    //清除组织信息
    function fnClear(){
        Base.setValue("dept","所有组织");
        Base.setValue("deptId","");
        fnQueryUsers();
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        treeObj.cancelSelectedNode();
    }


    <%-- 新增正职人员 --%>
    function addPrincipal() {
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        var nodes = treeObj.getSelectedNodes();
        if(null == nodes || nodes.length == 0){
            Base.msgTopTip("请选中需要添加正职的组织！",4000);return;
        }
        var node,param,porgname;
        if(nodes.length > 0) {
            node = nodes[0];
            /*param = {"dto['selectOrgId']":node.orgid,"dto['orgnamepath']":node.orgnamepath};*/
            if(node.getParentNode()){
                porgname=node.getParentNode().orgname;
            }
            param={"dto['orgid']":node.orgid,"dto['porgname']":porgname};
            if(node.effective == "0" && !node.admin){
                Base.msgTopTip("无权在该组织下操作，请选择有权限的组织进行操作",4000);return;
            }else if(node.effective == "0" && node.admin){
                Base.msgTopTip("该组织无效，请选择有效的组织进行操作",4000);return;
            }else if(node.effective != "0" && !node.admin){
                Base.msgTopTip("无权在该组织下操作，请选择有权限的组织进行操作",4000);return;
            }
        }
        Base.confirm("确定要新增该人员为正职吗？", function(yes){
            if(yes){
                Base.submit("userGd", "positionMgAction!addPrincipal.do", null, false, false, function(data){
                    Base.msgTopTip("<div class='msgTopTip'>人员正职信息新增成功!</div>");
                    fnClose();
                });
            }
        });

    }

    //表格选中行改变事件，控制页面按钮
    function fnSlctChg(o) {
        var data=Base.getGridSelectedRows("userGd");
        if(data.length != 1){
            Base.setDisabled("addBtn");
        }else{
            Base.setEnable("addBtn");
        }
        if(data.length>1){
           // Base.msgTopTip("",4000);return;
        }
    }
    function deputyFnSlctChg(o){
        var data=Base.getGridSelectedRows("deputyGd");
        if(data!=null&&data!=""&&data!=undefined){
            Base.setEnable("deputyDeleteBtn");
        }else{
            Base.setDisabled("deputyDeleteBtn");
        }
    }
    <%-- 组织样式 --%>
    function treeEffective(treeId, treeNode){
        if(treeNode.effective == "0" && !treeNode.admin){
            return {'text-decoration':'line-through','color': 'red'};
        }else if(treeNode.effective == "0" && treeNode.admin){
            return {'text-decoration':'line-through'};
        }else if(treeNode.effective != "0" && !treeNode.admin){
            return {'color': 'red'};
        }else{
            return {'text-decoration':'none'};
        }
    }
    <%-- 表格formatter 用于区别 effective，islock，positiontype 显示不同的颜色 --%>
    function fnNameFormatter(row, cell, value, columnDef, dataContext) {
        if (dataContext.effective == 0) {
            return "<span style='color:red;text-decoration:line-through;';>" + value + "</span>";
        }
        if (dataContext.islock == 1) {
            return "<span style='color:brown;text-decoration:line-through;'>" + value + "</span>";
        }
        if (dataContext.positiontype == 0) {
            return "<span style='color:red'>" + value + "</span>";
        }
        return value;
    }

    //点击重置按钮触发
    function fnReset(){
        Base.setValue("dept","所有组织");
        Base.setValue("deptId",null);
        Base.setValue("sex","-1");
        Base.setValue("islock","-1");
        Base.setValue("isShowSubOrg","1");
        Base.setValue("name","");
        Base.setValue("loginid","");
        Base.getObj("nameKey").reset();
    }
    //点击查询按钮触发
    function fnQueryUsers(){
        Base.clearGridDirty("userGd");
        var isShow=false;
        if($("#more").css("display")=="block"){
            isShow=true;
        }else{
            isShow=false;
        }
        Base.submit("userQuery", "positionMgAction!queryAddUser.do",{"dto['isShow']":isShow});
    }
    // 单击查询人员数据
    function fnClk(e, treeId, treeNode) {
        if(treeNode!=undefined&&treeNode!=null){
            var str=treeNode.orgnamepath;
            var strs=str.split("/");
            var newStr="";
            for(var i=0;i<strs.length;i++){
                if(i!=strs.length-1){
                    newStr+=strs[i]+"->";
                }else{
                    newStr+=strs[i];
                }
            }
            Base.setValue("dept",newStr);
            Base.setValue("deptId",treeNode.orgid);
            fnQueryUsers();
        }
    }
    // 判断和提示能否拖拽调整组织排序
    function fnBeforeDrop(treeId, treeNodes, targetNode, moveType) {
        var treeNode = treeNodes[0];
        if (treeNode.porgid != targetNode.porgid) {
            return Base.alert("非同级组织间不支持排序！"), false;
        } else if (moveType == "inner") {
            return Base.alert("不支持改变组织级次！"), false;
        }
        return confirm("是否保存对组织排序的修改？");
    }
    // 拖拽调整组织排序
    function fnOnDrop(event, treeId, treeNodes, targetNode, moveType) {
        Base.setDisabled("update,save");
        var pNode = treeNodes[0].getParentNode();
        var sortid = [];
        for (var i = 0; i < pNode.children.length; i ++) {
            sortid.push({orgid: pNode.children[i].orgid});
        }
        Base.submit(null, "orgUserMgAction!sortOrg.do", {sortorgids:Ta.util.obj2string(sortid)} , false, false);
    }
    function showMore(o,id){
        var $con = $('#'+id);
        if($con.is(':visible')){
            $con.hide();
            $(o).find('span').text('↓');
        }else{
            $con.show();
            $(o).find('span').text('↑');

        }
        $(window).resize();
    }

    function fnClose(){
        parent.Base.closeWindow("newWin");
    }



    function fnBeforeUpdateOrg(){
        return true;
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>