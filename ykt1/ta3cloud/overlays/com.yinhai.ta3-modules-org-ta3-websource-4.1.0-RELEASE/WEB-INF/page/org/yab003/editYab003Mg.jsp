<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>经办机构管理</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body id="body1" class="no-scrollbar no-padding" >
<ta:pageloading/>
<ta:panel id="editPanel" fit="true" withButtonBar="true" hasBorder="false" bodyStyle="padding:10px 10px 0px 0px;">
	<ta:text id="yab003" display="false"></ta:text>
	<ta:text id="t_codeType"  key="代码类别" readOnly="true" value="YAB003"  bpopTipPosition="bottom"/>
	<ta:text id="t_codeTypeDESC"  key="类别名称" readOnly="true" value="经办机构" required="true" />
	<ta:text id="t_codeValue"  key="代码值"  readOnly="true" required="true" />
	<ta:text id="t_codeDESC" key="组织名称" required="true" validType='[{type:"maxLength",param:[50],msg:"最大长度为50"}]'/>
	<ta:text id="t_codeDESC_old" key="组织名称" required="true"  display="false" />
	<ta:text id="t_orgId"  key="经办机构" display="false"/>
	<ta:panelButtonBar align="right">
		<ta:button id="confirmEdit" key="确认" onClick="confirmEdit()"></ta:button>
		<ta:button id="cancel" key="取消" onClick="cancelEdit()"></ta:button>
	</ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        Base.setValue("t_codeDESC_old",Base.getValue("t_codeDESC"));
    });

    function confirmEdit(){
        Base.submit("editPanel","agenciesMgAction!addOrEditTreeNode.do",{"dto['yab003']":Base.getValue("yab003"),"dto['codeType']":"YAB003"},null,null,function(){
            parent.Base.msgTopTip("修改成功");
            closeWindow();
        });
    }
    function cancelEdit(){
        parent.Base.setValue("yab003desc",Base.getValue("t_codeDESC_old"));
        parent.Base.closeWindow("editWindow");
    }
    function closeWindow(){
        parent.Base.setValue("yab003desc",Base.getValue("t_codeDESC"));
        parent.Base.closeWindow("editWindow");
    }
    //
    function fnClearCache(rowdata){
        var param = {};
        param["dto['codeType']"] = rowdata.codeType;
        param["dto['codeValue']"] = rowdata.codeValue;
        param["dto['orgId']"] = rowdata.orgId;
        Base.submit("","agenciesMgAction!clearcache.do",param);
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>