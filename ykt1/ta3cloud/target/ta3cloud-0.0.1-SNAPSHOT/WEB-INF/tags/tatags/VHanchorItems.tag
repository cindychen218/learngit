<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>

<%--@doc--%>
<%@tag description='横向和纵向锚点组件item必须和VHanchor一起用' display-name='VHanchorItem' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='组件需要指向的链接组件' name='targetId' type='java.lang.String'  required='true'%>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置锚点标题' name='key' type='java.lang.String' %>
<%--@doc--%>

<%
    String className = "anchor_btn";
    if(cssClass!=null){
        className=className+" "+cssClass;
    }
%>

<div id="<%=id%>"
     class="<%=className%>"
        <% if( cssStyle != null ){ %>
     style="<%=cssStyle%>"
        <%}%>
        <% if( targetId != null ){ %>
     data-targetId="<%=targetId%>"
        <%}%>
>
    <% if(key!=null) { %>
        ${key}
    <%}%>
    <jsp:doBody />
</div>
