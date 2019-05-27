<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag description='skip锚点组件' display-name='skip' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String'  required='true'%>
<%@attribute description='目标组件JSON' name='targets' type='java.lang.String' required='true' %>
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
 %>
 <div id="<%=id %>" class="skip" >
 </div>
 <div id="<%=id %>_skip_container" class="skip_container">
 	<div id="skip_line"  class="skip_line"  ></div>
 	<div id="skip_arrow" class="skip_arrow" ></div>
 </div>
<%@include file="../columnfoot.tag" %>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","skip"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(  function(){
	var TaSkip = window.taskip;
	var options={
		<%if (targets != null) {%>
			targets : ${targets}
		<%}%>
	};
	Ta.core.TaUIManager.register("<%=id%>",new TaSkip("<%=id%>",options));
	});
}));
</script>