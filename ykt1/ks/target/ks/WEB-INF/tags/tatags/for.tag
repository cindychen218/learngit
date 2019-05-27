<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="java.util.List"%>
<%@tag import="java.util.Iterator"%>

<%--@doc--%>
<%@tag description='多个radio的容器' display-name='for' %>
<%@taglib tagdir="/WEB-INF/tags/tatags" prefix="ta" %>
<%@attribute name="bean" description="request中的容器对象" required="true" type="java.lang.String"%>
<%@attribute name="var" description="bean容器中的元素对象名称" required="true" type="java.lang.String"%>
<%
	List list = (List)request.getAttribute(bean);
	Iterator iterator = list.iterator();
	while (iterator.hasNext()) {
		jspContext.setAttribute(var, iterator.next(), PageContext.REQUEST_SCOPE);
%>
<jsp:doBody/>
<%
	}
%>