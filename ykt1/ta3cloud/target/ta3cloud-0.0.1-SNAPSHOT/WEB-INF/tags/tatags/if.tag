<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag description='多个radio的容器' display-name='for' %>
<%@taglib tagdir="/WEB-INF/tags/tatags" prefix="ta" %>
<%@attribute name="test" required="true" description="用EL表达式进行判断,如:${userid==null}" type="java.lang.String"%>
<%
	if ("true".equals(test)) {
%>
<jsp:doBody/>
<%
	}
%>