<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html>
<head>
    <title>超级管理员管理</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" layout="border" layoutCfg="{leftWidth:375}" id="hintbody" style="padding:0px;margin:0px">
<ta:pageloading/>
<ta:box position="left" key="组织维护">
    <ta:box cssStyle="padding:10px;" fit="true">
        <ta:box fit="true" cssStyle="overflow:auto;">
            <ta:tree showSearch="true" searchPanelGrid="[{id:'orgname',key:'组织名称'},{id:'orgnamepath',key:'组织路径'}]" id="orgTree" childKey="orgid" nameKey="orgname" parentKey="porgid" fontCss="treeEffective" showLine="true" async="false"
                     editable="true" onClick="fnClk" keepLeaf="true" />
        </ta:box>
    </ta:box>
</ta:box>
<ta:box position="center" cssStyle="padding:10px;">
    <ta:fieldset cols="12" id="userQuery">
        <ta:text id="dept" key="组织"  labelWidth="50"  span="4" readOnly="true" clickIcon="icon-close2" clickIconTitle="点击还原为所有组织" clickIconFn="fnClear()" />
        <ta:checkboxgroup id="isShowSubOrg" span="1">
            <ta:checkbox key="子组织" value="1" checked="true" onClick="fnOnClick()"/>
        </ta:checkboxgroup>
        <ta:text span="3" id="selectLabelText" labelWidth="70" cssStyle="margin-right:20px" keys="[{name:'name',key:'姓名'},{name:'loginid',key:'账户'}]" textHelp="姓名支持模糊查询;账户不支持模糊查询，但支持多个账户查询，以逗号隔开"></ta:text>
        <ta:buttonGroup span="4">
            <ta:button key="查询" icon="icon-search" onClick="fnQueryUsers()"></ta:button>
            <ta:button key="重置" icon="icon-refresh" onClick="Base.resetData('userQuery')"></ta:button>
            <ta:button key="↓" id="showmore" onClick="showMore(this,'more')"/>
        </ta:buttonGroup>
        <ta:box span="12" cols="3" id="more" cssStyle="display:none">
            <ta:radiogroup key="性别" id="sex" cols="3" labelWidth="50">
                <ta:radio key="男" value="1" />
                <ta:radio key="女" value="2" />
                <ta:radio key="不限" value="-1" checked="checked" />
            </ta:radiogroup>
            <ta:radiogroup key="锁定标志" id="islock" cols="3" labelWidth="80">
                <ta:radio key="锁定" cssStyle="color:gray;text-decoration: line-through;" value="1" />
                <ta:radio key="未锁" value="0" />
                <ta:radio key="不限" value="-1" checked="checked" />
            </ta:radiogroup>
        </ta:box>
        <ta:text id="deptId" key="树的orgId" display="false" value="1"/>
        <ta:text id="effective" display="false" value="-1"/>
    </ta:fieldset>
    <ta:panel headerButton="[{'id':'batchAddDeveloper','name':'批量新增','click':'batchAddDeveloper();'},
	{'id':'batchCancleDeveloper','name':'批量移除','click':'batchCancleDeveloper();'}]" fit="true" key="人员列表" cssStyle="margin-top:10px;">
        <ta:datagrid enableColumnMove="true"  id="userGd" fit="true"  selectType="checkbox" haveSn="true" forceFitColumns="true">
            <ta:datagridItem id="userid" asKey="true" key="userid" hiddenColumn="true" />
            <ta:datagridItem id="isdeveloper" asKey="true" key="isdeveloper" hiddenColumn="true" />
            <ta:datagridItem id="positionid" asKey="true" key="positionid" hiddenColumn="true" />
            <ta:datagridItem id="name" asKey="true" key="姓名" showDetailed="true" align="center" dataAlign="center" formatter="fnNameFormatter"/>
            <ta:datagridItem id="sex" key="性别" align="center" dataAlign="center"  collection="SEX"/>
            <ta:datagridItem id="loginid" sortable="true" key="登录账号" width="80" align="center" dataAlign="center" showDetailed="true" />
            <ta:datagridItem id="orgnamepath" key="所属组织" showDetailed="true" width="400" />
            <ta:datagridItem id="islock" key="锁定标志" width="150" collection="YESORNO" asKey="true" />
            <ta:datagridItem id="icon1"  align="center" dataAlign="center"  key="操作" formatter="fnOpFormatter" />
            <ta:dataGridToolPaging url="developerMg!queryUsers.do"  submitIds="userQuery" pageSize="10"/>
        </ta:datagrid>
    </ta:panel>
</ta:box>
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
    })
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
    //点击显示子组织触发事件
    function fnOnClick(){
        fnQueryUsers();
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
    function batchAddDeveloper(){
        var gridSelected = Base.getGridSelectedRows("userGd");
        if(gridSelected.length==0){
            return Base.alert("请至少选择一条数据","warn");
        }
        var exists="";
        var submitData=[];
        for(var i = 0 ;i< gridSelected.length;i++){
            if(gridSelected[i].isdeveloper==1){
                exists+=gridSelected[i].name+",";
            }
            else{
                submitData.push(gridSelected[i].positionid);
            }
        }
        if(submitData.length==0){
            return Base.alert("选择的数据都是超级管理员","warn");
        }
        if(exists!=""){
            exists = exists.substring(0,exists.length-1);
            Base.confirm("勾选人员中 ["+exists+"] 已经是超级管理员,是否继续?",function(yes){
                if(yes){
                    Base.submit(null,"developerMg!batchAddDevelopers.do",{"dto.selected":Ta.util.obj2string(submitData)},null,null,function(){
                        Base.msgTopTip('批量设置成功');
                        fnQueryUsers();
                    })
                }
            })
        }
        else{
            Base.submit(null,"developerMg!batchAddDevelopers.do",{"dto.selected":Ta.util.obj2string(submitData)},null,null,function(){
                Base.msgTopTip('批量设置成功');
                fnQueryUsers();
            })
        }
    }
    function batchCancleDeveloper(){
        var gridSelected = Base.getGridSelectedRows("userGd");
        if(gridSelected.length==0){
            return Base.alert("请至少选择一条数据","warn");
        }
        var exists="";
        var submitData=[];
        for(var i = 0 ;i< gridSelected.length;i++){
            if(gridSelected[i].isdeveloper==0){
                exists+=gridSelected[i].name+",";
            }
            else{
                submitData.push(gridSelected[i].positionid);
            }
        }
        if(submitData.length==0){
            return Base.alert("选择的数据都是非超级管理员","warn");
        }
        if(exists!=""){
            exists = exists.substring(0,exists.length-1);
            Base.confirm("勾选人员中 ["+exists+"] 本已不是超级管理员,是否继续?",function(yes){
                if(yes){
                    Base.submit(null,"developerMg!batchCancleDevelopers.do",{"dto.selected":Ta.util.obj2string(submitData)},null,null,function(){
                        Base.msgTopTip('批量设置成功');
                        fnQueryUsers();
                    })
                }
            })
        }
        else{
            Base.submit(null,"developerMg!batchCancleDevelopers.do",{"dto.selected":Ta.util.obj2string(submitData)},null,null,function(){
                Base.msgTopTip('批量设置成功');
                fnQueryUsers();
            })
        }
    }
    /**
     * 表格单个操作
     * */
    function fnOpFormatter(row, cell, value, columnDef, dataContext){
        var isdeveloper = dataContext.isdeveloper;
        if(1==isdeveloper){
            return "<button class='tabutton basebutton solid btn-main small ' onclick='cancleDeveloper("+dataContext.positionid+")' title='移除当前超级管理员'><span class='button-icon faceIcon'></span><span class='button-text'>移除</span></button>"
        }
        else{
            return "<button class='tabutton basebutton solid btn-main small ' onclick='addDeveloper("+dataContext.positionid+")' title='新增当前超级管理员'><span class='button-icon faceIcon'></span><span class='button-text'>新增</span></button>"
        }
    }
    function addDeveloper(positionid) {
        Base.submit(null,"developerMg!addDevelopers.do",{"dto.positionid":positionid},null,null,function(){
            Base.msgTopTip('设置超级管理员成功');
            fnQueryUsers();
        })
    }
    function cancleDeveloper(positionid) {
        Base.submit(null,"developerMg!cancleDevelopers.do",{"dto.positionid":positionid},null,null,function(){
            Base.msgTopTip('取消设置超级管理员成功');
            fnQueryUsers();
        })
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
    //点击查询按钮触发
    function fnQueryUsers(){
        Base.clearGridDirty("userGd");
        var isShow=false;
        if($("#more").css("display")=="block"){
            isShow=true;
        }else{
            isShow=false;
        }
        Base.submit("userQuery", "developerMg!queryUsers.do",{"dto['isShow']":isShow});
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>