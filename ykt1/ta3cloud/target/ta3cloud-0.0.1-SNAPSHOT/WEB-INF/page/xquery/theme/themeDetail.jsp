<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<head>
    <title>主题定义</title>
    <%@ include file="/ta/inc.jsp" %>
</head>
<body style="overflow-x:hidden;">
<ta:pageloading/>
<ta:form id="form1">
    <ta:box>
        <ta:text id="themeid" display="false" />
        <ta:text id="datasourceid" display="false"/>
        <ta:text id="menuid" display="false"/>
        <ta:text id="themename" key="主题名称" required="true" labelWidth="120" validType='[{type:"maxLength",param:[50],msg:"最大长度为50"}]'  bpopTipPosition="bottom"/>
        <ta:text id="themetable" key="主题库表" required="true" labelWidth="120" placeholder="选择表或视图" />
        <ta:textarea id="themewhere" labelWidth="120" key="基础WHERE<br/>条件" height="80"  validType='[{type:"maxLength",param:[160],msg:"最大长度为160"}]' />
        <ta:textarea id="themewheredesc" labelWidth="120" key="基础WHERE<br/>条件的变量说明" validType='[{type:"maxLength",param:[260],msg:"最大长度为260"}]'/>
    </ta:box>
    <ta:buttonGroup cssStyle="margin-top:20px">
        <ta:button id="btnSave" key="保存" onClick="fnSave()"/>
        <ta:button key="关闭" onClick="fnClose()"/>
    </ta:buttonGroup>
</ta:form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
    });
    //保存
    function fnSave(){
        var _id = 'form1';
        var _url = 'themeController!saveTheme.do';
        var _param = null;
        var _onsub = null;
        var _autoval = true;
        var _succCallback = function(data){
            Base.setDisabled('btnSave');
            var isUpdate = data.fieldData.isUpdate;
            var treeObj=parent.$.fn.zTree.getZTreeObj("themeTree");
            if(isUpdate){
                var upNode=treeObj.getNodeByParam("id",Base.getValue("themeid"));
                upNode.id=Base.getValue("themeid");
                upNode.pid=Base.getValue("datasourceid");
                upNode.name=Base.getValue("themename");
                treeObj.updateNode(upNode,false);
            }else{
                var addNode = treeObj.getNodeByParam(treeObj.setting.data.simpleData.idKey, Base.getValue("datasourceid"));
                addNode.isParent = true;
                treeObj.updateNode(addNode);
                treeObj.addNodes(addNode, data.fieldData.childNode,false );
            }
        }
        Base.submit(_id, _url, _param, _onsub, _autoval,_succCallback);
    }
    //关闭
    function fnClose(){
        parent.Base.closeWindow('theme_edit')
    }
    function fnCallBack(data){
            Base.setValue("themetable",data[0]);
    }
    required_suggest(function () {
        options={};
        options.paramIds="themetable,datasourceid";
        options.instance1=1;
        options.columns=2;
        options.digit=2;
        options.time=1000;
        options.height=200;
        options.selectColumn=1;
        options.url="themeController!suggestThemeTable.do";
        options.beforeSubmit=function () {
            return true;
        }
        options.callBackFun=fnCallBack;
        var me = new TaSuggest($("#themetable"),options);
        me.suggest();
    })
</script>
<%@ include file="/ta/incfooter.jsp" %>