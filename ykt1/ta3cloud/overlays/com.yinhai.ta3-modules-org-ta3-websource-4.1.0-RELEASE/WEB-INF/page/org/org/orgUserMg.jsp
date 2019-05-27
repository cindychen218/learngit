<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
	<title>组织人员管理</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" layout="border" layoutCfg="{leftWidth:375}"  id="hintbody" style="padding:0px;margin:0px">
<ta:pageloading/>
<ta:box position="left" key="组织维护">
	<ta:box cssStyle="padding:10px;" fit="true">
		<ta:text id="searchbox" cssClass="searchbox" value="输入后回车检索" clickIcon="icon-search" clickIconFn="fnQuery()"></ta:text>
		<ta:box fit="true" cssStyle="overflow:auto;">
			<ta:tree id="orgTree" childKey="orgid" nameKey="orgname" parentKey="porgid" fontCss="treeEffective" showLine="true" async="false"
					 editable="true" onClick="fnClk" beforeEdit="fnToEdit" beforeRemove="fnBfRemove" onRemove="fnDelDept" onRightClick="fnOnRightClick"
					 keepLeaf="true" editTitle="编辑当前组织" removeTitle="删除当前组织" addTitle="添加子组织" showAddBtn="true" onAdd="fnAddDept"
					 beforeDrop="fnBeforeDrop" onDrop="fnOnDrop" />
		</ta:box>
		<div id="rm" style="width:150px;font-size:12px;">
			<div id="rm_add" class="btn-app">添加子组织</div>
			<div id="rm_modify">编辑当前组织</div>
			<div id="rm_del">删除当前组织</div>
		</div>
	</ta:box>
</ta:box>
<ta:box position="center" cssStyle="padding:10px;">
	<ta:fieldset cols="12" id="userQuery">
		<ta:text id="dept" key="组织"  labelWidth="60"  span="4" readOnly="true" clickIcon="icon-close" clickIconTitle="点击还原为所有组织" clickIconFn="fnClear()" />
		<ta:checkboxgroup id="isShowSubOrg" cssStyle="width:100px">
			<ta:checkbox key="子组织" value="1" checked="true" onClick="fnOnClick()"/>
		</ta:checkboxgroup>
		<ta:text id="nameKey" span="3" cssStyle="margin-right:20px" labelWidth="80" keys="[{name:'name',key:'姓名'},{name:'loginid',key:'账号'}]" textHelp="姓名支持模糊查询;账户不支持模糊查询，但支持多个账户查询，以逗号隔开"></ta:text>
		<ta:buttonGroup span="4">
			<ta:button key="查询" icon="icon-search" onClick="fnQueryUsers()"></ta:button>
			<ta:button key="重置" icon="icon-refresh" onClick="fnReset()"></ta:button>
			<ta:button key="↓" id="showmore" onClick="showMore(this,'more')"/>
		</ta:buttonGroup>
		<ta:box span="12" cols="3" id="more" cssStyle="display:none">
			<ta:radiogroup key="性别" id="sex" cols="3" labelWidth="60">
				<ta:radio key="男" value="1" />
				<ta:radio key="女" value="2" />
				<ta:radio key="不限" value="-1" checked="checked" />
			</ta:radiogroup>
			<ta:radiogroup key="锁定标志" id="islock" cols="3" labelWidth="90">
				<ta:radio key="锁定" cssStyle="color:gray;text-decoration: line-through;" value="1" />
				<ta:radio key="未锁" value="0" />
				<ta:radio key="不限" value="-1" checked="checked" />
			</ta:radiogroup>
		</ta:box>
		<ta:text id="deptId" key="树的orgId" display="false" value="1"/>
		<ta:text id="effective" display="false" value="-1"/>
	</ta:fieldset>
	<ta:buttonGroup align="left" cssStyle="margin-left:0px;margin-top:10px;" id="btngrp">
		<ta:button id="addBtn" key="新增[A]" hotKey="A" icon="icon-addTo" onClick="addUser()" />
		<ta:button id="deleteBtn" key="删除[R]" hotKey="R" icon="icon-delete" onClick="delUser()" disabled="true"/>
		<ta:button id="seteffective" key="启用[D]" hotKey="D" icon="icon-correct" disabled="true" onClick="fnReUser()" />
		<ta:button id="uneffective" key="禁用[E]" hotKey="E" icon="icon-close" disabled="true" onClick="fnDisUser()" />
		<ta:button id="lockBtn" key="解锁[L]" hotKey="L" icon="icon-lock" disabled="true" onClick="fnUnLock()" />
		<ta:button disabled="true" id="changeOrgBtn" key="更改组织" hotKey="C" icon="icon-refresh" onClick="fnBatchPositionSet()" />
		<ta:button id="resetPassBtn" key="密码重置[P]" hotKey="P" icon="icon-headPortrait" disabled="true" onClick="fnResetPass()" />
	</ta:buttonGroup>
	<ta:panel fit="true" key="人员列表" cssStyle="margin-top:10px;">
		<ta:datagrid enableColumnMove="true" onSelectChange="fnSlctChg" id="userGd" fit="true"  selectType="checkbox" haveSn="true" forceFitColumns="true">
			<ta:datagridItem id="userid" asKey="true" key="userid" hiddenColumn="true" />
			<ta:datagridItem id="name" key="姓名" showDetailed="true" align="center" dataAlign="center" formatter="fnNameFormatter"/>
			<ta:datagridItem id="loginid" sortable="true" key="登录账号" width="80" align="center" dataAlign="center" showDetailed="true" />
			<ta:datagridItem id="icon1" icon="icon-edit"  align="center" dataAlign="center" click="fnEdit" key="编辑" />
			<ta:datagridItem id="icon2" icon="icon-headPortrait" align="center" dataAlign="center" click="fnPermission" key="权限" />
			<ta:datagridItem id="icon3" icon="icon-search" align="center" dataAlign="center"  key="岗位"  click="fnShowPossition"/>
			<ta:datagridItem id="orgnamepath" key="所属组织" showDetailed="true" width="400" />
			<ta:datagridItem id="sex" key="性别" align="center" dataAlign="center"  collection="SEX"/>
			<ta:datagridItem id="tel" key="移动电话"  align="center" width="150" showDetailed="true" dataAlign="center"/>
			<ta:datagridItem id="effective" key="可用标志" width="150px" hiddenColumn="true" asKey="true" />
			<ta:datagridItem id="islock" key="锁定标志" width="150px" hiddenColumn="true" asKey="true" />
			<ta:datagridItem id="authmode" collection="authmode" 	key="权限认证方式"  width="100px" showDetailed="true"></ta:datagridItem>
			<ta:dataGridToolPaging url="orgUserMgAction!queryUsers.do" selectExpButtons="1,2" showExcel="true" submitIds="userQuery" pageSize="50" />
		</ta:datagrid>
	</ta:panel>
</ta:box>
<ta:boxComponent height="200px" width="500px" id="b2" arrowPosition="vertical">
	<ta:datagrid id="find" fit="true" haveSn="true" forceFitColumns="true" onRowClick="fnRowClick" >
		<ta:datagridItem id="orgid" key="组织id" hiddenColumn="false"/>
		<ta:datagridItem id="orgname" key="组织名称"  showDetailed="true" width="100"/>
		<ta:datagridItem id="orgnamepath" key="组织路径" showDetailed="true" width="300"/>
	</ta:datagrid>
</ta:boxComponent>
<ta:boxComponent height="200px" width="400px" id="b1" arrowPosition="vertical">
	<ta:datagrid id="positions" fit="true" haveSn="true" border="true">
		<ta:datagridItem id="positionname" key="岗位名称" formatter="fnNameFormatter" showDetailed="true" width="70"/>
		<ta:datagridItem id="orgnamepath" key="组织路径" showDetailed="true" width="200"/>
		<ta:datagridItem id="positiontype" key="岗位类型" width="80"  showDetailed="true"  collection="positiontype" />
	</ta:datagrid>
</ta:boxComponent>
<ta:boxComponent id="editUser" height="230px" width="300px" arrowPosition="vertical">
	<ta:fieldset id="editfield">
		<ta:text id="p_userid" key="用户编号" readOnly="true" display="false"/>
		<ta:text id="p_loginid" readOnly="true" required="true" key="登录号"></ta:text>
		<ta:text id="p_name" required="true" key="姓名"></ta:text>
		<ta:selectInput id="p_sex" key="性别"  collection="Sex"></ta:selectInput>
		<ta:text id="p_tel" key="移动电话" validType='[{type:"mobile"}]'></ta:text>
		<ta:selectInput id="p_authmode" key="认证方式" disabled="true" collection="authmode"></ta:selectInput>
	</ta:fieldset>
	<ta:buttonGroup align="right" cssStyle="padding-right:0px;">
		<ta:button key="保存" onClick="fnEditUser()"></ta:button>
		<ta:button key="取消" onClick="fnCancleEditUser()"></ta:button>
	</ta:buttonGroup>
</ta:boxComponent>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        //调整“组织”样式
        var $dept = $("#dept");
        $dept.removeClass("readonly");
        $dept.parent().removeClass("readonly");
        $dept.parent().css({"borderTop":"0px","borderLeft":"0px","borderRight":"0px","borderRadius":0});
        $("#searchbox").css('color','#CCC');

        //进入页面后再进行查询，以免数据多导致加载缓慢
// 	fnQueryUsers();
        $("#rm").menu(); // 构建右键菜单
        // 在树上绑定右键事件
        $("#orgTree").bind('contextmenu', function(e){
            $('#rm').menu('show', {left: e.pageX, top: e.pageY});
            return false;
        });
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
        fnPageGuide(parent.currentBuinessId);
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
    function fnEditUser(){
        Base.submit("editUser","orgUserMgAction!editUser.do",{},null,null,function(){
            Base.msgTopTip('修改用户成功');
            $("#editUser").hide();
            fnQueryUsers();
        })
    }
    function fnCancleEditUser(){
        $("#editUser").hide();
    }
    //点击显示子组织触发事件
    function fnOnClick(){
        fnQueryUsers();
    }
    //查询表格行点击事件
    function fnRowClick(e,data){
        var treeObj=$.fn.zTree.getZTreeObj("orgTree");
        var node=treeObj.getNodeByParam("orgid",data.orgid,null);
        treeObj.selectNode(node,false);
        $("#b2").hide();
        fnClk(e, "orgTree", node);
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
                Base.setValue("deptId","1");
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
        Base.setValue("deptId","1");
        fnQueryUsers();
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        treeObj.selectNode(treeObj.getNodes()[0]);
        //alert(treeObj.getNodes()[0]);
        //treeObj.cancelSelectedNode();
    }
    //删除人员
    function delUser() {
        var o = Base.getGridSelectedRows("userGd");
        if(o && o.length > 0){
            Base.confirm("确定要删除这些人员吗？", function(yes){
                if(yes){
                    Base.submit("userGd", "orgUserMgAction!deleteUsers.do", null, false, false, function(){
                        Base.deleteGridSelectedRows('userGd');
                        Base.msgTopTip("<div class='msgTopTip'>删除人员成功</div>");
                    });
                }
            });
        }else{
            Base.alert("请先选择人员后再进行删除","warn");
        }
    }
    <%-- 新增人员 --%>
    function addUser() {
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        var nodes = treeObj.getSelectedNodes();
        var node,param;
        if(nodes.length > 0) {
            node = nodes[0];
            param = {"dto['selectOrgId']":node.orgid,"dto['orgnamepath']":node.orgnamepath};
            if(node.effective == "0" && !node.admin){
                Base.msgTopTip("无权在该组织下新增人员，请选择有权限的组织进行操作",4000);return;
            }else if(node.effective == "0" && node.admin){
                Base.msgTopTip("该组织无效，请选择有效的组织进行操作",4000);return;
            }else if(node.effective != "0" && !node.admin){
                Base.msgTopTip("无权在该组织下新增人员，请选择有权限的组织进行操作",4000);return;
            }
        }else{
            param = {};
		}
        Base.openWindow("win", "人员新增", "orgUserMgAction!toAddUser.do", param, 450, 440,null,fnQueryUsers,true);
    }
    //单人组织修改
    function fnBatchPositionSet() {
        var selectRows = Base.getGridSelectedRows("userGd");
        if(selectRows && selectRows.length == 1){
            Base.openWindow("win", "更改组织", "orgUserMgAction!toUpdateOrg.do", {"dto['userid']":selectRows[0].userid}, 400, 400,null,function(){
                fnQueryUsers();
            },true);
        }
    }
    //解锁单个用户
    function fnUnLock(){
        var d = Base.getGridSelectedRows("userGd");
        if(d && d.length == 1){
            Base.submit("", "orgUserMgAction!unLockUser.do", {"dto['userid']":d[0].userid},null,null, fnQueryUsers);
        }
    }
    //批量禁用用户
    function fnDisUser(){
        var o = Base.getGridSelectedRows("userGd");

        Base.confirm(o.length > 1 ? "确定要禁用这些人员吗？" : "确定要禁用这个人员吗？",function(yes){
            if(yes){
                Base.submit("userGd", "orgUserMgAction!unEffectiveUsers.do", null,null,null, function(){
                    fnQueryUsers();
                    Base.msgTopTip("禁用成功");
                });
            }
        });
    }
    //批量启用用户
    function fnReUser(){
        Base.submit("userGd", "orgUserMgAction!effectiveUsers.do", null,null,null, function(){
            fnQueryUsers();
            Base.msgTopTip("启用成功");
        });
    }
    //密码重置
    function fnResetPass() {
        var o = Base.getGridSelectedRows("userGd");
        Base.openWindow("passWin", "密码重置", "orgUserMgAction!toRestPass.do", {"userid":o[0].userid}, 280, 175);
    }
    //表格选中行改变事件，控制页面按钮
    function fnSlctChg(o) {
        var data=Base.getGridSelectedRows("userGd");
        if(data!=null&&data!=""&&data!=undefined){
            Base.setEnable("deleteBtn");
        }else{
            Base.setDisabled("deleteBtn");
        }
        //如果批量选择中有被禁用的用户，则不能 密码重置，修改和禁用
        for (var i = 0; i < o.length; i ++) {
            if (o[i].effective == 0)
                Base.setDisabled(["changeOrgBtn"]);
        }
        if (o.length == 1) {
            if (o[0].effective == 0) {
                Base.setEnable("seteffective");
                Base.setDisabled("uneffective");
            } else {
                Base.setDisabled("seteffective");
                Base.setEnable("uneffective");
            }
            if(o[0].islock == 1){
                Base.setEnable("lockBtn");
            }else{
                Base.setDisabled("lockBtn");
            }
            Base.setEnable(["editBtn","delBtn","resetPassBtn","changeOrgBtn"]);
        } else if (o.length > 1) {
            Base.setEnable(["delBtn","resetPassBtn"]);
            Base.setDisabled(["editBtn","changeOrgBtn","resetPassBtn"]);
        } else {
            Base.setDisabled(["changeOrgBtn","resetPassBtn","seteffective","uneffective","resetPassBtn","changeOrgBtn","lockBtn"]);
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
    // 右键点击树节点事件
    function fnOnRightClick(event, treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        $("#rm_add").unbind("click").bind("click", function(){
            fnAddDept(event, treeId, treeNode);
        });
        $("#rm_modify").unbind("click").bind("click", function(){
            fnToEdit(treeId, treeNode)
        });
        $("#rm_del").unbind("click").bind("click", function(){
            if(fnBfRemove(treeId, treeNode)){
                fnDelDept(event, treeId, treeNode);
            }
        });
        if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
            treeObj.cancelSelectedNode();
        } else if (treeNode) {
            treeObj.selectNode(treeNode);
        }
    }
    //点击重置按钮触发
    function fnReset(){
        Base.setValue("dept","所有组织");
        Base.setValue("deptId","1");
        Base.setValue("sex","-1");
        Base.setValue("islock","-1");
        Base.setValue("isShowSubOrg","1");
        Base.setValue("name","");
        Base.setValue("loginid","");
        Base.getObj("nameKey").reset();
		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		treeObj.selectNode(treeObj.getNodes()[0]);
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
        Base.submit("userQuery", "orgUserMgAction!queryUsers.do",{"dto['isShow']":isShow});
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
    // 添加子组织
    function fnAddDept(event, treeId, treeNode) {
        if (treeNode.effective == 0){
            Base.msgTopTip("<div class='msgTopTip'>该组织已经禁用：无法添加子组织</div>");
        } else if (treeNode.admin != true){
            Base.msgTopTip("<div class='msgTopTip'>该组织没有操作权限：无法添加子组织</div>");
        } else {
            var param={"dto['porgname']":treeNode.orgname,
                "dto['orglevel']":treeNode.orglevel,
                "dto['isleaf']":treeNode.isleaf,
                "dto['orgnamepath']":treeNode.orgnamepath,
                "dto['effective']":1,
                "dto['porgid']":treeNode.orgid,
                "dto['yab003']":treeNode.yab003,
                "dto['yab139']":treeNode.yab139,
                "dto['orgid']":treeNode.orgid,};
            Base.openWindow("newWin","新增组织","orgUserMgAction!toAddOrg.do",param,500,400,null,null,true);
        }
    }
    // 点击编辑按钮编辑组织信息
    function fnToEdit(treeId, treeNode) {
        if (treeNode.admin != true){
            Base.msgTopTip("<div class='msgTopTip'>你没有该组织的操作权限：无法修改</div>");
            return false;
        }
        var porgname="";
        if(treeNode.getParentNode()){
            porgname=treeNode.getParentNode().orgname;
        }
        var param={"dto['orgid']":treeNode.orgid,"dto['porgname']":porgname};
        Base.openWindow("newWin","修改组织","orgUserMgAction!toEditOrg.do",param,500,400,null,null,true);
        return false;
    }
    // 判断和提示能否删除组织
    function fnBfRemove(treeId, treeNode) {
        if (treeNode.admin != true){
            Base.msgTopTip("<div class='msgTopTip'>你没有操作该组织权限：无法删除该组织</div>");
            return false;
        }
        if (!treeNode.porgid || treeNode.porgid == "") {
            return Base.alert("不能删除顶级组织！", "warn"), false;
        } else if (treeNode.isParent) {
            return confirm("删除该组织会把下面的子组织一并删除,并且会删除组织相关的一切内容，确实要删除吗？");
        } else {
            return confirm("确实要删除该组织吗，删除组织会删除组织相关的一切内容，确认删除吗？");
        }
    }
    // 提交删除操作
    function fnDelDept(event, treeId, treeNode) {
        if (treeNode.admin != true){
            Base.msgTopTip("<div class='msgTopTip'>该组织没有操作权限：无法删除</div>");
            return false;
        }
        Base.submit(null, "orgUserMgAction!deleteOrg.do", {"dto['orgid']":treeNode.orgid}, false, false,
            function(){
                Base.msgTopTip("<div class='msgTopTip'>删除成功</div>");
                var treeObj = $.fn.zTree.getZTreeObj("orgTree");
                var parentNode=treeNode.getParentNode();
                if(parentNode.children.length==0){
                    treeObj.removeChildNodes(parentNode);
                }
                treeObj.removeNode(treeNode);
                //删除组织后查询
                fnReset();
                fnQueryUsers();
            }
        );
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
    //点击编辑按钮，弹出人员编辑框
    function fnEdit(data,e){
        var target=event.srcElement?event.srcElement:event.target;
        if(!$(target).hasClass("icon-edit")){
            return;
        }
        Base.showBoxComponent("editUser",target);
        Base.submit("","orgUserMgAction!toEditUser.do",{"dto['userid']":data.userid})
    }
    //点击表格中权限列
    function fnPermission(data,e){
        Base.openWindow("win", data.name + "的权限列表", "orgUserMgAction!queryUserPermission.do", {"dto['userid']":data.userid}, "90%", "90%", null,null,true);
    }
    //显示岗位表格
    function fnShowPossition(data,e){
        var target=event.srcElement?event.srcElement:event.target;
        if(!$(target).hasClass("icon-search")){
            return;
        }
        Base.showBoxComponent("b1",target);
        Base.submit("","orgUserMgAction!queryUserPosition.do",{"dto['userid']": data.userid});
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
</script>
<%@ include file="/ta/incfooter.jsp"%>