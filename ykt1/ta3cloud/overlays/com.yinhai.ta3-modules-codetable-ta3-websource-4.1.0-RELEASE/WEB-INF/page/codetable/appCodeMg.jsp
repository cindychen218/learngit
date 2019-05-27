<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>代码表查看</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" style="padding:10px;">
<ta:pageloading/>
<ta:form id="formId" fit="true">
<ta:fieldset cols="5" id="appCodePanel">
	<ta:text id="codeType" key="代码类别" />
	<ta:text id="codeTypeDESC" key="类别名称" />
	<ta:text id="codeValue" key="代码值" />
	<ta:text id="codeDESC" key="代码名称" />
	<ta:selectInput id="yab003" key="经办机构"  collection="YAB003"/>
	<ta:buttonGroup align="center" span="5">
		<ta:button type="submit" icon="icon-search" key="查询[Q]" hotKey="Q" submitIds="appCodePanel" url="appCodeMainController!queryAa10.do"/>
		<ta:button icon="icon-refresh" key="重置[R]" hotKey="R" onClick="fnReset()" />
	</ta:buttonGroup>
</ta:fieldset>
<ta:panel withToolBar="true" fit="true" key="码表列表" cssStyle="margin-top:10px;">
	<ta:panelToolBar>
		<ta:button  key="新增码表" icon="icon-add2" onClick="fnAdd()" asToolBarItem="true"/>
		<ta:button key="重新加载缓存" onClick="fnRefresh();" icon="icon-refresh" asToolBarItem="true"/>
	</ta:panelToolBar>
	<ta:datagrid id="appCodeList" haveSn="true"  columnFilter="true" fit="true" forceFitColumns="true" >
		<ta:datagridItem id="codeType" key="代码类别" sortable="true" width="100"/>
		<ta:datagridItem id="codeTypeDESC" key="类别名称" sortable="true" width="100"/>
		<ta:datagridItem id="codeValue" key="代码值" sortable="true" width="100"/>
		<ta:datagridItem id="codeDESC" key="代码名称" sortable="true" width="100"/>
		<ta:datagridItem id="yab003" key="经办机构" sortable="true" width="100"/>
		<ta:datagridItemOperate showAll="false" id="a" name="操作">
			<ta:datagridItemOperateMenu name="重载缓存" icon="a" click="fnReloadCache"></ta:datagridItemOperateMenu>
			<ta:datagridItemOperateMenu name="编辑" icon="a" click="fnEdit"></ta:datagridItemOperateMenu>
			<ta:datagridItemOperateMenu name="删除" icon="a" click="fnRemove"></ta:datagridItemOperateMenu>
		</ta:datagridItemOperate>
	</ta:datagrid>
</ta:panel>
</ta:form>
</body>
</html>
<script type="text/javascript">
    function fnReset(){
        $("#formId")[0].reset();
        Base.clearGridData("appCodeList");
    }
    function fnReloadCache(rowdata){
        var param = {};
        param["dto['codeType']"] = rowdata.codeType;
        param["dto['codeValue']"] = rowdata.codeValue;
        param["dto['yab003']"] = rowdata.yab003;
        Base.confirm("该操作是执行码表在内存中的缓存清除以保证下次请求能够与数据库同步，请确认依据配置好集群server地址。",function(v){
            if(v)Base.submit("","appCodeMainController!reloadCache.do",param);
        });
    }
    function fnEdit(rowdata){
        var param = {};
        param["dto['codeType']"] = rowdata.codeType;
        param["dto['codeTypeDESC']"] = rowdata.codeTypeDESC;
        param["dto['codeValue']"] = rowdata.codeValue;
        param["dto['codeDESC']"] = rowdata.codeDESC;
        param["dto['orgId']"] = rowdata.yab003;
        Base.openWindow("edit","码表修改","appCodeMainController!toEditAa10.do",param,"300","300",null,function(){
            Base.submit("appCodePanel","appCodeMainController!queryAa10.do");
        },true);

    }
    function fnAdd(){
        Base.openWindow("add","码表新增","appCodeMainController!toAddAa10.do",{},"300","300",null,function(){
            Base.submit("appCodePanel","appCodeMainController!queryAa10.do");
        },true);
    }
    function fnRemove(rowdata){
        Base.confirm("确定删除该码表？",function(yes){
            if(yes){
                Base.submit("","appCodeMainController!removeAa10.do",{"dto['codeType']":rowdata.codeType,"dto['codeValue']":rowdata.codeValue,"dto['yab003']":rowdata.yab003},null,null,
                    function(){
                        Base.submit("appCodePanel","appCodeMainController!queryAa10.do");
                    });
            }
        })
    }
    /**
     * 重新加载页面码表
     */
    function fnRefresh(){
        Base.submit("","appCodeMainController!refreshAll.do");
    }
    $(document).ready(function () {
        $("body").taLayout();
    });
</script>
<%@ include file="/ta/incfooter.jsp"%>