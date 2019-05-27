<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>数据源管理</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" layout="border" layoutCfg="{leftWidth:345}"  id="hintbody" style="padding:0px;margin:0px">
<ta:pageloading/>
<ta:box position="left" key="主题维护">
    <ta:box cssStyle="padding:10px;" fit="true">
        <%--<ta:text id="searchbox" cssClass="searchbox" placeholder="输入后回车检索" clickIcon="icon-search" clickIconFn="fnQuery()"></ta:text>--%>
        <ta:box fit="true" cssStyle="overflow:auto;">
            <ta:tree id="themeTree" childKey="id" nameKey="name" parentKey="pid" showLine="true" async="false" onClick="fnClkTree" beforeEdit="fnToEdit"  showRemoveBtn="fnShowRemove" editable="true" showAddBtn="fnShowAdd" showEditBtn="fnShowEdit" beforeRemove="fnBfDel"
             onRemove="fnDelTheme" keepLeaf="true" editTitle="编辑当前主题" removeTitle="删除当前主题" addTitle="添加主题" onAdd="fnAddTheme"/>
        </ta:box>
    </ta:box>
</ta:box>
<ta:box position="center" cssStyle="padding:10px;">
    <ta:fieldset cols="12" id="fieldQuery">
        <ta:text id="themeid"  display="false"/>
        <ta:text id="datasourceid"  display="false"/>
        <ta:text id="fieldname" span="3" cssStyle="margin-right:20px" labelWidth="70" key="字段名称" textHelp="支持模糊查询"></ta:text>
        <ta:selectInput id="fieldiscondition" key="作为查询条件" span="3"  collection="YESORNO"></ta:selectInput>
        <ta:selectInput id="fielddisplaytype" key="查询展现形式" span="3" value="1"  collection="XQDISPLAY"></ta:selectInput>
        <ta:buttonGroup span="3">
            <ta:button key="查询" id="btnQuery" icon="icon-search" disabled="true" onClick="fnQueryFields()"></ta:button>
        </ta:buttonGroup>
    </ta:fieldset>
    <ta:buttonGroup align="left" cssStyle="margin-left:0px;margin-top:10px;" id="btngrp">
        <ta:button id="addBtn" key="新增" disabled="true" icon="icon-addTo" onClick="addField()" />
        <ta:button id="batchAddBtn" key="批量新增"  disabled="true" icon="icon-addTo" onClick="batchAddField()" />
        <ta:button id="deleteBtn" key="删除" icon="icon-delete" onClick="delField()" disabled="true"/>
    </ta:buttonGroup>
    <ta:panel fit="true" key="字段列表" cssStyle="margin-top:10px;">
        <ta:datagrid enableColumnMove="true" onSelectChange="fnSlctChg" id="fieldGd" fit="true"  selectType="checkbox" forceFitColumns="true">
            <ta:datagridItem id="fieldid" asKey="true" key="fieldid" hiddenColumn="true" />
            <ta:datagridItem id="themeid" asKey="true" key="themeid" hiddenColumn="true" />
            <ta:datagridItem id="editIcon" icon="icon-edit"  align="center" dataAlign="center" click="fnEditField" key="编辑" />
            <ta:datagridItem id="fieldsort" key="排序号" showDetailed="true"  hiddenColumn="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldname" key="数据库字段" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldalias" key="数据库字段AS别名" showDetailed="true" align="center" dataAlign="center" width="120"/>
            <ta:datagridItem id="fieldcomment" key="数据库字段中文" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldtype" key="数据类型" collection="XQDATATYPE" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldtreecode" key="代码类别" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldiscondition" key="是否查询条件" collection="YESORNO" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fielddisplaytype" key="查询条件展现形式" collection="XQDISPLAY" showDetailed="true" align="center" dataAlign="center" width="100"/>
            <ta:datagridItem id="fieldisgroup" key="是否分组" collection="YESORNO" showDetailed="true" align="center" dataAlign="center" width="100"/>
        </ta:datagrid>
    </ta:panel>
</ta:box>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
        $("body").taLayout();
    });
    function fnGetW(w){
        var all = document.body.scrollWidth * 0.8;
        if(all < w){
            return all;
        }
        return w;
    }
    function fnGetH(h){
        var all = document.body.scrollHeight * 0.8;
        if(all < h){
            return all;
        }
        return h;
    }
    //左侧树处理方法
    function fnClkTree(e, treeId, treeNode){
        if(treeNode.id != 0&&treeNode.pid != 0){
            Base.setValue("themeid",treeNode.id)
            Base.setValue("datasourceid",treeNode.pid)
            Base.setEnable("addBtn,batchAddBtn,btnQuery");
            fnQueryFields();
        }else{
            Base.setDisabled("addBtn,batchAddBtn,btnQuery");
        }
    }
    function fnToEdit(treeId, treeNode){
        var datasourceid = treeNode.pid;
        var _id = 'theme_edit';
        var _title = '配制主题';
        var _url = 'themeController!toEditTheme.do';
        var _param={"dto['themeid']":treeNode.id,"dto['datasourceid']":datasourceid};
        var _w = fnGetW(700);
        var _h = fnGetH(350);
        var _load = null;
        var _close = null;
        var _iframe = true;
        Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
        return false;
    }
    function fnBfDel(treeId, treeNode){
        return confirm("确认要删除该主题吗?");
    }
    function fnDelTheme(event, treeId, treeNode){
        var themeid = treeNode.id;
        var _param = {'dto.themeid':themeid};
        Base.submit("","themeController!toDelTheme.do",_param,null,false,function (data) {
            Base.clearGridData("fieldGd");
        });
    }
    function fnAddTheme(event, treeId, treeNode){
        var datasourceid = treeNode.id;
            var _id = 'theme_edit';
            var _title = '配制主题';
            var _url = 'themeController!toEditTheme.do';
            var _param = {'dto.datasourceid':datasourceid};
            var _w = fnGetW(700);
            var _h = fnGetH(350);
            var _load = null;
            var _close = function(){
            var treeObj = $.fn.zTree.getZTreeObj("themeTree");
            treeObj.refresh();
        };
            var _iframe = true;
            Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
    }
    function fnBeforeDrop(){}
    function fnOnDrop(){}
    function fnShowRemove(treeId, treeNode){
        if(treeNode.id == 0||treeNode.pid == 0)
            return false;
        else
            return true;
    }
    function fnShowEdit(treeId, treeNode){
        if(treeNode.id == 0||treeNode.pid == 0)
            return false;
        else
            return true;
    }
    function fnShowAdd(treeId, treeNode){
        if(treeNode.id == 0||treeNode.pid != 0)
            return false;
        else
            return true;
    }
    //右侧查询部分
    function fnQueryFields(){
        Base.submit("datasourceid,themeid,fieldname,fieldiscondition,fielddisplaytype","themeController!toQueryFields.do");
    }
    //右侧datagrid部分
    function addField(){
        var themeid = Base.getValue('themeid');
        var datasourceid = Base.getValue('datasourceid');
        if(themeid != ''){
            var _id = 'field_edit';
            var _title = '配制字段';
            var _url = 'themeController!toEditField.do';
            var _param = {'dto.themeid':themeid,'dto.datasourceid':datasourceid};
            var _w = fnGetW(800);
            var _h = fnGetW(600);
            var _load = null;
            var _close = fnQueryFields;
            var _iframe = true;
            Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
        }
    }
    function batchAddField(){
        var themeid = Base.getValue('themeid');
        var datasourceid = Base.getValue('datasourceid');
        if(themeid != ''){
            var _id = 'fields_edit';
            var _title = '批量配制字段';
            var _url = 'themeController!toBatchEditFields.do';
            var _param = {'dto.themeid':themeid,'dto.datasourceid':datasourceid};
            var _w = fnGetW(800);
            var _h = fnGetW(500);
            var _load = null;
            var _close = fnQueryFields;
            var _iframe = true;
            Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
        }
    }
    function fnEditField(data,e){
        var fieldid = data.fieldid;
        var themeid = Base.getValue('themeid');
        var datasourceid = Base.getValue('datasourceid');
        var _id = 'field_edit';
        var _title = '配制字段';
        var _url = 'themeController!toEditField.do';
        var _param = {'dto.themeid':themeid,'dto.datasourceid':datasourceid,'dto.fieldid':fieldid};
        var _w = fnGetW(800);
        var _h = fnGetW(600);
        var _load = null;
        var _close = fnQueryFields;
        var _iframe = true;
        Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);

    }
    function delField(){
        var _id = 'fieldGd';
        var _url = 'themeController!toDelFields.do';
        var _param = null;
        var _onsub = null;
        var _autoval = false;
        var _sucback = fnQueryFields;
        Base.submit(_id, _url, _param, _onsub, _autoval,_sucback);
    }
    function fnSlctChg(){
        if(Base.getGridSelectedRows('fieldGd').length >= 1){
            Base.setEnable('deleteBtn');
        }else{
            Base.setDisabled('deleteBtn');
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>