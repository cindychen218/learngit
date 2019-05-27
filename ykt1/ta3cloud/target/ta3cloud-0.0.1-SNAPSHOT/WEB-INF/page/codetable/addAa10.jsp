<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>代码表查看</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:pageloading/>
<ta:panel id="box1" fit="true" withButtonBar="true" hasBorder="false" >
    <ta:text id="codeType"  key="代码类别" bpopTipPosition="bottom" required="true" validType='[{type:"maxLength",param:[20],msg:"最大长度为20"}]'/>
    <ta:text id="codeTypeDESC"  key="类别名称" bpopTipPosition="bottom" required="true" validType='[{type:"maxLength",param:[50],msg:"最大长度为50"}]'/>
    <ta:text id="codeValue"  key="代码值" required="true" validType='[{type:"maxLength",param:[6],msg:"最大长度为6"}]'/>
    <ta:text id="codeDESC"  key="代码名称"  required="true" validType='[{type:"maxLength",param:[50],msg:"最大长度为50"}]'/>
    <ta:selectInput id="yab003"  key="经办机构" collection="YAB003"/>
    <ta:panelButtonBar align="right">
        <ta:button key="保存" icon="icon-addTo" onClick="fnSave()" id="saveBtn"/>
        <ta:button key="关闭" icon="icon-close2" onClick="parent.Base.closeWindow('add')"/>
    </ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
    });
    function fnSave(){
        Base.submit("box1","appCodeMainController!addAa10.do",null,null,null,function(){
            parent.Base.closeWindow("add");
        });
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>