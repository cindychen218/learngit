<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@attribute description='容器组件在页面上的唯一id' name='id' type='java.lang.String' %>
<%@attribute description='是否显示toolbar' name='display' type='java.lang.String' %>
<%@attribute description='cssClass' name='cssClass' type='java.lang.String' %>
<%@tag description='工具栏' display-name='toolbar' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%--@doc--%>
<%
	String parnetIsfiledscontrol = "";
	try{
		JspTag parent = TagUtil.getTa3ParentTag(getParent());
		PropertyDescriptor pd1 = new PropertyDescriptor("fieldsAuthorization", parent.getClass());
		Method method1 = pd1.getReadMethod();
	    parnetIsfiledscontrol = (String)method1.invoke(parent);
	   }
	catch(Exception e){
	}
	if("true".equals(parnetIsfiledscontrol)){
		fieldsAuthorization="true";
	}
	if ("true".equals(fieldsAuthorization)) {
		String status = SecurityUtil.getFieldStatus(request, id);
		if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_DEFAULT.equals(status)
				|| ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_EDIT.equals(status)) {
			// 正常
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_ONLY_LOOK.equals(status)) {
			// 只能查看
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}
%>
<%
  final Random RANDOM = new Random();
		if ((id == null || id.length() == 0)) {

			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tatoolbar_" + String.valueOf(nextInt);
			jspContext.setAttribute("id", id);
		}
%>

<div id="${id}" 
class="toolbar toolbar_163"
  <%if(display!=null&&display.equals("false")){ %>
  style="display:none;"	 
  <%} %>
>
<center><table cellpadding="0" cellspacing="0"><tr>
<td>
<div class="toolbarcenter toolbarcenter_163">
<jsp:doBody/>
</td></tr></table></center>
</div>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","toolbar"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI( function(){
		var options = {
			txtId:"${id}"
		};
		
		Ta.core.TaUIManager.register("${id}",new tatoolbar(options));
	});
}));
</script>