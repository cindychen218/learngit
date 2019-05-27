<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.modules.authority.ta3.domain.ipo.IFieldAuthrity"  %>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>

<%--@doc--%>
<%@tag description='用于输出div标签，支持自动适应剩余高度，布局和被布局' display-name='t_text' %>
<%@attribute name="id"  type="java.lang.String" description="容器组件在页面上的唯一id"%>

<%--@doc--%>



<%@include file="../columnhead.tag" %>

<input id="<%=id%>"  type="text" />

<%@include file="../columnfoot.tag" %>