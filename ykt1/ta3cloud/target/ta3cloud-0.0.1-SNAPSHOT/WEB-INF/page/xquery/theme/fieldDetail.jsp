<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<head>
    <title>配制项目</title>
    <%@ include file="/ta/inc.jsp" %>
    <style>
        .tafieldset-header h2 {
            font-size: 14px;
            line-height: 42px;
            font-weight: 400;
            display: inline;
            font-family: Microsoft Yahei,verdana;
            cursor: default;
            color: #2a3542;
            background-image: none;
            padding-left: 12px;
        }
        .border_fld{
            border: solid #D3E8F7;
            border-width: 1px 1px 1px 1px;
            background-image: none!important;
        }
    </style>
</head>
<body style="overflow:hidden;">
<ta:pageloading/>
<ta:form id="form1" fit="true" heightDiff="50">
    <ta:box>
        <ta:number id="fieldid" display="false"/>
        <ta:number id="themeid" display="false"/>
    </ta:box>
    <ta:box cols="3" cssStyle="margin-top:10px">
        <ta:selectInput id="fieldname_sel" key="数据库字段" required="true" onSelect="fnSelectField"/>
        <ta:text id="fieldname" key="数据库字段"  display="false" readOnly="true" />
        <ta:text id="fieldcomment" key="字段中文" readOnly="true" validType='[{type:"maxLength",param:[100],msg:"最大长度为100"}]'/>
        <ta:text id="fieldalias" key="字段AS别名" readOnly="true"  validType='[{type:"maxLength",param:[30],msg:"最大长度为30"}]' required="true"/>
        <ta:selectInput id="fieldtype" key="数据类型" readOnly="true" collection="XQDATATYPE" required="true"/>
        <ta:text id="fieldtreecode" key="代码类别" validType='[{type:"maxLength",param:[60],msg:"最大长度为60"}]'/>
        <ta:number id="fieldsort" key="排序号" min="1" max="9999" bpopTipPosition="bottom"/>
        <ta:selectInput id="fieldisgroup" key="作为分组" value="1"  collection="YESORNO"></ta:selectInput>
    </ta:box>
    <ta:box cssStyle="margin-top:15px">
        <ta:box cols="5">
            <ta:checkbox id="fieldiscondition" key="作为查询条件" span="1" value="1" onClick="fnClickQueryBox()"/>
            <ta:box>&nbsp;</ta:box>
        </ta:box>
        <ta:box cols="2" id="queryBox" cssStyle="display:none;">
            <ta:fieldset key="查询条件展现形式" align="center" cssClass="border_fld">
                <ta:radiogroup id="fielddisplaytype" collection="XQDISPLAY" cols="4" cssStyle="text-align:left; margin-left:20px"/>
            </ta:fieldset>
            <ta:fieldset key="支持的关系符" align="center"  cssClass="border_fld">
                <ta:checkboxgroup id="fieldrelation" collection="XQRELA" cols="4" cssStyle="text-align:left; margin-left:20px"/>
            </ta:fieldset>
        </ta:box>
    </ta:box>
    <ta:box cssStyle="margin-top:15px">
        <ta:box cols="5">
            <ta:checkbox id="fieldiscount" key="作为统计项" span="1"  value="1" onClick="fnClickCountBox()"/>
            <ta:box>&nbsp;</ta:box>
        </ta:box>
        <ta:fieldset id="countFld" key="查询条件展现形式" align="center" cssClass="border_fld" cssStyle="display:none;">
            <ta:checkboxgroup id="countway" collection="XQCOUNT" cols="4" cssStyle="text-align:left; margin-left:20px"/>
        </ta:fieldset>
    </ta:box>
</ta:form>
<ta:buttonGroup cssStyle="margin-top:10px;">
    <ta:button id="btnSave" key="保存" onClick="fnSave()"/>
    <ta:button key="关闭" onClick="fnClose()"/>
</ta:buttonGroup>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        init();
    });
    function init() {
        if(Base.getValue('fieldiscount') == '1'){
            Base.showObj('countFld');
        }else{
            Base.hideObj('countFld');
        }
        if(Base.getValue('fieldiscondition') == '1'){
            Base.showObj('queryBox');
        }else{
            Base.hideObj('queryBox');
        }
    }
    function fnSelectField(key,value){
        var themeid = Base.getValue("themeid");
        var _id = '';
        var _url = 'themeController!getFieldProp.do';
        var _param = {"dto['fieldName']":key,"dto['themeid']":themeid};
        var _onsub = null;
        var _autoval = false;
        var _sucback = null;
        Base.submit(_id, _url, _param, _onsub, _autoval, _sucback);
    }
    //选择作为查询条件
    function fnClickQueryBox(){
        if(Base.getValue('fieldiscondition') == '1'){
            Base.showObj('queryBox');
        }else{
            Base.hideObj('queryBox');
        }
    }
    //选择作为统计项
    function fnClickCountBox(){
        if(Base.getValue('fieldiscount') == '1'){
            Base.showObj('countFld');
        }else{
            Base.hideObj('countFld');
        }
    }
    //保存
    function fnSave(){
        var _id = 'form1';
        var _url = 'themeController!toSaveField.do';
        var _param = null;
        var _onsub = null;
        var _autoval = true;
        var _sucback = function(){
            Base.setDisabled("btnSave")
        };
        Base.submit(_id, _url, _param, _onsub, _autoval, _sucback);
    }
    //关闭
    function fnClose(){
        parent.Base.closeWindow('field_edit');
    }
</script>
<%@ include file="/ta/incfooter.jsp" %>