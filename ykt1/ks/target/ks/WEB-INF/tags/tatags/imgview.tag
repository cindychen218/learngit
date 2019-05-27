<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%-- @doc --%>
<%@tag description='图片展示' display-name='imgview' %>
<%@attribute description='组件id' name='id' type='java.lang.String' %>
<%@attribute description='图片路径' name='src' type='java.lang.String' %>
<%@attribute description='图片长度' name='width' type='java.lang.String' %>
<%@attribute description='图片宽度' name='height' type='java.lang.String' %>
<%@attribute description='图片名称' name='alt' type='java.lang.String' %>
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
	String span =null;
	String columnWidth = null;
%>
<%@include file="../columnhead.tag" %>
<div 
<% if( null !=width){%>
width="${width}" 
<%}%>
class="zoom" 
>
<div 
class="zoom_pic"
>
<img 
<% if( null !=id){%>
id="${id}" 
<%}%>
<% if( null !=alt){%>
alt="${alt}" 
<%}%>
class="z_pic" 
<% if( null !=height){%>
height="${height}" 
<%}%>
 <% if( null !=width){%>
width="${width}" 
<%}%>
/>	
</div>
<div 
class="zoom_name" 
>
<% if( null !=alt){%>
${alt}
<%}%>
</div>
</div>
<%@include file="../columnfoot.tag" %>
<script>
<% if( null !=src){%>
	$("#${id}").attr("src",Base.globvar.contextPath+"/${src}");
<%}%>
$(".z_pic").xzy_zoom(600,450,5,200);  
</script>