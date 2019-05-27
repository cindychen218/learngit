<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%--@doc--%>
<%@tag description='datagrid分页条上的按钮组件' display-name='gridToolButton' %>
<%@attribute description='设置按钮图标' name='icon' type='java.lang.String' %>
<%@attribute description='设置组件id' name='id' type='java.lang.String' %>
<%@attribute description='设置标题，不支持html格式文本' name='key' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='单击事件' name='onClick' type='java.lang.String' %>
<%--@doc--%>
<%
%>
var buttonStr = "";
buttonStr += '<button id="${id}" class="tabutton basebutton solid btn-main normal focus ${cssClass} <% if( null != disabled) {%> disabled <% }%> " <% if( null != disabled) {%> disabled = ${disabled} <% }%> type="button" style="padding: 0px 17px; margin: 0 2px; height: 28px; <% if( null != cssStyle) {%>  ${cssStyle} <% }%>"';
<% if( null != onClick) {%>
buttonStr += " onClick=\"${onClick}\"";
<% }%>
buttonStr += '>';
<% if( null != icon) {%>
buttonStr += '<span class="faceIcon button-icon ${icon}"></span>';
<% }%>
<% if( null != key){ %>
buttonStr += '<span class="button-text"> ${key}</span>';
<% }%>
buttonStr += '</button>';
o.pagingOptions.buttons.push($(buttonStr));