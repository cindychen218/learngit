<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<head>
	<title>批量配制项目</title>
	<%@ include file="/ta/inc.jsp" %>
</head>
<body style="overflow-x:hidden;">
<ta:pageloading/>
<ta:form id="form1" fit="true">
	<ta:text id="themeid" display="false"/>
	<ta:datagrid id="fieldGd" haveSn="true" snWidth="40" forceFitColumns="true" fit="true" heightDiff="50" selectType="checkbox" onSelectChange="fnQueryBack" columnFilter="true">
		<ta:datagridItem id="fieldname" key="数据库字段" showDetailed="true" align="center" dataAlign="center" width="100"/>
		<ta:datagridItem id="fieldcomment" key="数据库字段中文" showDetailed="true" align="center" dataAlign="center" width="100"/>
		<ta:datagridItem id="fieldtype" key="数据类型" collection="XQDATATYPE" showDetailed="true" align="center" dataAlign="center" width="100"/>
		<ta:datagridItem id="fieldsize" key="字段长度" showDetailed="true" align="center" dataAlign="center" width="100"/>
	</ta:datagrid>
	<ta:buttonGroup>
		<ta:button id="btnSelect" key="确定" onClick="fnSelect()"/>
		<ta:button key="取消" onClick="fnClose()"/>
	</ta:buttonGroup>
</ta:form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        init();
    });

    function init(){
        fnQuery();
    }

    //查询
    function fnQuery(){
        var _id = 'form1';
        var _url = 'themeController!toQueryStayFields.do';
        var _param = null;
        var _onsub = null;
        var _autoval = false;
        var _sucback = fnQueryBack;
        var _falback = fnQueryBack;
        Base.submit(_id, _url, _param, _onsub, _autoval, _sucback, _falback);
    }
    function fnQueryBack(){
        if(Base.getGridSelectedRows('fieldGd').length > 0){
            Base.setEnable('btnSelect');
        }else{
            Base.setDisabled('btnSelect');
        }
    }

    //确定
    function fnSelect(){
        if(Base.getGridSelectedRows('fieldGd').length > 0){
            var _id = 'form1';
            var _url = 'themeController!toSaveFields.do';
            var _param = null;
            var _onsub = null;
            var _autoval = false;
            var _sucback = fnSelectbacksue;
            var _falback = fnSelectbackfal;
            Base.submit(_id, _url, _param, _onsub, _autoval, _sucback, _falback);
        }
    }
    function fnSelectbacksue(){
        Base.alert("添加成功", 'success', fnClose);
    }
    function fnSelectbackfal(){
        Base.alert("添加失败", 'error');
    }

    //关闭
    function fnClose(){
        parent.Base.closeWindow('fields_edit');
    }
</script>
<%@ include file="/ta/incfooter.jsp" %>