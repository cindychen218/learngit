<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.common.api.util.DESUtil"%>

<%--@doc--%>
<%@tag description='datagrid工具条，包含有分页与导出按钮等' display-name='dataGridToolPaging' %>
<%@attribute description='是否显示分页条' name='showPagingBar' type='java.lang.String' %>
<%@attribute description='是否显示分页条中的按钮' name='showButton' type='java.lang.String' %>0
<%@attribute description='设置默认分页大小，默认400,每页最大设置条数为99999,超过99999将自动转换成99999' name='pageSize' type='java.lang.String' %>
<%@attribute description='设置是否显示分页文字描述，默认显示' name='showDetails' type='java.lang.String' %>
<%@attribute description='设置是否显示总条数，默认显示' name='showCount' type='java.lang.String' %>
<%@attribute description='数据获取地址,如果showPagingBar显示分页则该项必须' name='url'  type='java.lang.String' %>
<%@attribute description='参数，json格式' name='parameter' type='java.lang.String' %>
<%@attribute description='提交数据ids，包括查询条件的所有id' name='submitIds' type='java.lang.String' %>
<%@attribute description='分页每次请求获取数据成功时的回调函数，默认传入参数（data）为当前请求返还的表格数据，例如successCallBack=‘success’,在javascript中定义 function success(data) {var gridData = data.lists.grid2.list;//data.lists.grid2.list 为一个表格数据数组,其中grid2是你jsp中的datagrid的id alert(gridData[0].aac001) }' name='successCallBack' type='java.lang.String' %>
<%@attribute description='分页查询中的校验函数，如果校验不通过，不查询返回数据，该属性为一个function。返回true为通过，false为不通过' name='validateForm' type='java.lang.String' %>

<%@attribute description='是否显示导出excel按钮' name='showExcel' type='java.lang.String' %>
<%@attribute description='导出全部数据时的必填项，sql查询，例如:sqlStatementName="ac01.getList"' name='sqlStatementName' type='java.lang.String' %>
<%@attribute description='导出全部数据时的必填项，sql查询时的返回类型，例如:resultType="com.yinhai.demo.domain.Ac01Domain"或者resultType="java.util.HashMap"' name='resultType' type='java.lang.String' %>
<%@attribute description='true/false,导出时是导出码值还是描述值,默认true,表示导出码值,false表示导出描述值' name='expKeyOrName' type='java.lang.String' %>
<%@attribute description='导出按钮控制,1导出当前页,2导出选择行,3导出全部.例如selectExpButtons="1,2"表示只显示当前和选择按钮' name='selectExpButtons' type='java.lang.String' %>
<%@attribute description='excel导出的文件名，默认 export' name='exportFileName' type='java.lang.String' %>
<%@attribute description='导出是否有表头,true/false,默认true' name='exportWithHead' type='java.lang.String' %>
<%--<%@attribute description='导出Excel格式,true/false,默认false' name='isXlsx' type='java.lang.String' %>--%>

<%@attribute description='是否显示最大化按钮默认显示' name='showToFull' type='java.lang.String' %>
<%@attribute description='全部导出使用的dao的beanid,默认为dao' name='exportBean' type='java.lang.String' %>
<%@attribute description='文件后缀名xlsx/xls/csv' name='suffix' type='java.lang.String' %>
<%--@doc--%>
<%
	if(sqlStatementName != null){
      byte[] encryptData =  DESUtil.encrypt(sqlStatementName.getBytes(), "reYj6fIsWGE=");
      sqlStatementName = DESUtil.encryptBASE64(encryptData).trim();
   }
%>
o.showToolpaging = true;
o.showToFull=true;
<% if( null != showToFull)  { %>
o.showToFull = ${showToFull};
<% }%>
<% if( null != showPagingBar)  { %>
o.showPagingBar = ${showPagingBar};
<% }else {%>
    o.showPagingBar=true;
<% }%>
<% if( null != showExcel)  { %>
o.showExcel = ${showExcel};
<% }%>
o.pagingOptions = {};
o.pagingOptions.buttons=[];
o.exportOptions={};
<% if( null != pageSize)  { %>
o.pagingOptions.pageSize = ${pageSize};
<% }%>
<% if( null != showCount)  { %>
o.pagingOptions.showCount = ${showCount};
<% }%>
<% if( null != validateForm)  { %>
o.pagingOptions.validateForm = ${validateForm};
<% }%>
<% if( null != url)  { %>
o.pagingOptions.url = "${url}";
<% }%>
<% if( null != submitIds)  { %>
o.pagingOptions.submitIds = "${submitIds}";
<% }%>
<% if( null != parameter)  { %>
o.pagingOptions.param = ${parameter};
<% }%>
<% if( null != showButton)  { %>
o.pagingOptions.showButton = ${showButton};
<% }%>
<% if( null != successCallBack)  { %>
o.pagingOptions.successCallBack = ${successCallBack};
<% }%>
<% if( null != showDetails)  { %>
o.pagingOptions.showDetails = ${showDetails};
<% }%>
<% if( null != sqlStatementName)  { %>
o.exportOptions.sqlStatementName = "<%=sqlStatementName %>";
<% }%>
<% if( null != resultType)  { %>
o.exportOptions.resultType = "${resultType}";
<% }%>
<% if( null != expKeyOrName)  { %>
o.exportOptions.expKeyOrName = ${expKeyOrName};
<% }%>
<% if( null != selectExpButtons)  { %>
o.exportOptions.selectExpButtons = "${selectExpButtons}";
<% }%>
<% if( null != exportFileName)  { %>
o.exportOptions.exportFileName = "${exportFileName}";
<% }%>
<% if( null != exportWithHead)  { %>
o.exportOptions.exportWithHead = "${exportWithHead}";
<% }%>
<%--<% if( null != isXlsx)  { %>
o.exportOptions.isXlsx = "${isXlsx}";
<% }%>--%>
<% if( null != exportBean)  { %>
o.exportOptions.exportBean = "${exportBean}";
<% } else { %>
o.exportOptions.exportBean = "dao" ;
<% }%>
<% if( null != suffix)  { %>
o.exportOptions.suffix = "${suffix}";
<% } else { %>
o.exportOptions.suffix = "xlsx" ;
<% }%>
<jsp:doBody />