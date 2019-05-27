<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html>
<head>
	<title>缓存管理</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" style="padding:10px;margin:0px">
<ta:fieldset  cols="3" key="缓存查询">
	<ta:selectInput id="cacheName" key="缓存名称" onSelect="fnSelectCacheName"/>
</ta:fieldset>
<ta:panel key="缓存列表" fit="true" withToolBar="true">
	<ta:panelToolBar>
		<ta:button key="查询" onClick="fnQueryCache()"/>
		<ta:button key="删除选择行" onClick="fnDeleteCache()"></ta:button>
		<ta:button key="清空全部行" onClick="fnClearCache()"></ta:button>
	</ta:panelToolBar>
	<ta:datagrid id="cacheGrid" fit="true" forceFitColumns="true" haveSn="true" selectType="checkbox" columnFilter="true">
		<ta:datagridItem id="cacheKey" key="缓存键值" width="300"></ta:datagridItem>
		<ta:datagridItem id="cacheKeyType" key="缓存键值类型" width="80"></ta:datagridItem>
		<ta:datagridItem id="info" key="查看" icon="icon-search" width="50" click="fnCheckCache"></ta:datagridItem>
	</ta:datagrid>
</ta:panel>
</body>
</html>
<script  type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
    });

    //根据缓存名称查询缓存
    function fnQueryCache(){
        var cacheName = Base.getValue("cacheName");
        console.log(cacheName)
        if(cacheName == ""){
            Base.alert("请选择缓存名称！","warn");
            return;
        }
        Base.submit("cacheName","cacheMgAction!queryCacheList.do");
    }

    //选择缓存事件
    function fnSelectCacheName(key,value){
        if(value == "")return;
        fnQueryCache();
    }

    //删除选择的缓存
    function fnDeleteCache(){
        var select = Base.getGridSelectedRows("cacheGrid");
        if(select.length==0){
            Base.alert("请至少选择一项！","warn");
            return;
        }
        var cacheName = Base.getValue("cacheName");
        if(cacheName == ""){
            Base.alert("请选择缓存名称！","warn");
            return;
        }
        var cacheKeys = [],cacheKeyTypes = [];
        for(var i=0,len=select.length;i<len;i++){
            cacheKeys.push(select[i].cacheKey);
            cacheKeyTypes.push(select[i].cacheKeyType);
        }
        Base.submit("cacheName","cacheMgAction!deleteCacheByKey.do",{"dto['cacheKey']":cacheKeys.join("#"),"dto['cacheKeyType']":cacheKeyTypes.join("#")},null,false,function(){
            fnQueryCache();
            Base.alert("缓存已删除！","success");
        });
    }

    //清空缓存
    function fnClearCache(){
        var cacheName = Base.getValue("cacheName");
        if(cacheName == ""){
            Base.alert("请选择缓存名称！","warn");
            return;
        }
        Base.submit("cacheName","cacheMgAction!clearCache.do",null,null,false,function(){
            fnQueryCache();
            Base.alert("缓存"+cacheName+"已清空！","success");
        });
    }

    //查看缓存信息
    function fnCheckCache(data,e){
        Base.openWindow("cacheWin","缓存信息","cacheMgAction!queryCacheByKey.do",{"dto['cacheName']":data.cacheName,"dto['cacheKey']":data.cacheKey,"dto['cacheKeyType']":data.cacheKeyType}, "60%", "400", null,null,true);
    }
</script>