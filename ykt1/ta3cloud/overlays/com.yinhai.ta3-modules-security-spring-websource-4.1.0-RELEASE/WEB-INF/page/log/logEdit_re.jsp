<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>登录环境详细查询</title>
    <%@ include file="/ta/inc.jsp" %>
</head>
<body class="no-scrollbar">
<ta:pageloading/>
<ta:form id="form1" fit="true">
    <ta:box cols="4">
        <ta:text id="statType" display="false"/>
        <ta:text id="gridColumnType" display="false"/>

        <ta:text id="userid" key="用户id"/>

        <ta:text id="typecs" key="客户端系统"/>
        <ta:text id="typecss" key="客户端分辨率"/>
        <ta:text id="typecb" key="客户端浏览器"/>

        <ta:date id="startDate" key="开始日期" showSelectPanel="true" display="false"/>
        <ta:date id="endDate" key="结束日期" showSelectPanel="true" display="false"/>

        <ta:number id="timePoint" key="时点" display="false" max="23" min="0"/>
    </ta:box>

    <ta:buttonGroup>
        <ta:button key="查询" onClick="fnQueryDetail_re()" />
        <ta:button key="关闭" onClick="fnClose()" />
    </ta:buttonGroup>

    <ta:datagrid id="gridDetial" haveSn="true" snWidth="40" forceFitColumns="true" fit="true">
        <ta:datagridItem id="logid" hiddenColumn="true"/>
        <ta:datagridItem id="userid" key="用户ID" dataAlign="center" width="80"/>
        <ta:datagridItem id="username" key="姓名" dataAlign="center"/>
        <ta:datagridItem id="logintime" key="登录时间" dataAlign="center" width="120"/>
        <ta:datagridItem id="clientip" key="客户端ip" dataAlign="center"/>
        <ta:datagridItem id="clientsystem" key="客户端系统" dataAlign="center"/>
        <ta:datagridItem id="clientbrowser" key="客户端浏览器" dataAlign="center"/>
        <ta:datagridItem id="clientscreensize" key="客户端分辨率" dataAlign="center"/>
        <ta:dataGridToolPaging url="${basePath}security/loginLogAnalysisAction!queryReDetail.do" submitIds="form1" pageSize="100" />
    </ta:datagrid>
</ta:form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
        editInit();
    });

    //初始化
    function editInit(){
        var statType = Base.getValue('statType');
        if(statType == '1'){
            //登录环境详情查询 按操作系统分析
            Base.hideObj('typecs');
        }else if(statType == '2'){
            //登录环境详情查询 按分辨率分析
            Base.hideObj('typecss');
        }else if(statType == '3'){
            //登录环境详情查询 按浏览器分析
            Base.hideObj('typecb');
        }else{
            //在线情况详情查询
            Base.hideObj('typecs');
            Base.hideObj('typecss');
            Base.hideObj('typecb');
            Base.hideObj('timePoint');
            Base.showObj('startDate');
            Base.showObj('endDate');
        }
        if(Base.getValue('gridColumnType') != ''){
            Base.hideObj('startDate,endDate');
        }
        fnQueryDetail_re();
    }

    //环境数据明细查询
    function fnQueryDetail_re(){
        Base.clearGridData('gridDetial');
        var _id = 'form1';
        var _url = '${basePath}security/loginLogAnalysisAction!queryReDetail.do';
        var _param = {"dto.gridId":"gridDetial"};
        var _onsub = null;
        var _autoval = false;
        Base.submit(_id, _url, _param, _onsub, _autoval);
    }

    //关闭
    function fnClose(){
        parent.Base.closeWindow('re_edit');
    }
</script>
<%@ include file="/ta/incfooter.jsp" %>