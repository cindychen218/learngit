<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='tab页，只能放在tabs容器内' display-name='tab' %>
<%@attribute description='当该容器对子组件布局layout=column的时候，可以设置cols参数表面将容器分成多少列，默认不设置为1' name='cols' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='组件id' name='id' type='java.lang.String' %>
<%@attribute description='组件的label标签' name='key' type='java.lang.String' %>
<%@attribute description='设置该容器对子组件的布局类型，有column/border，默认为column，cols=1' name='layout' type='java.lang.String' %>
<%@attribute description='设置layout为border布局的时候布局的参数配置，如:layoutCfg="{leftWidth:200,topHeight:90,rightWidth:200,bottomHeight:100}"' name='layoutCfg' type='java.lang.String' %>
<%@attribute description='true/false.该tab页是否有关闭小按钮，默认为false' name='closable' type='java.lang.String' %>
<%@attribute description='true/false.该tab页是否可用，默认为true' name='enable' type='java.lang.String' %>
<%@attribute description='tab页标题的图标class，如icon="faceIcon icon-person"，可以到api文档字体图标示例查看' name='icon' type='java.lang.String' %>
<%@attribute description='tab是否被选中' name='selected' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%-- @doc --%>
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
		if ((this.id == null || this.id.length() == 0)) {
			int nextInt = new Random().nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math.abs(nextInt);
			id = "tatab_" + String.valueOf(nextInt);
		}
 %>
 
<div 
id="<%=id %>" 
	<% if( key != null ){ %>
title="${key}" 
	<%}%>	
	<% if( closable != null ){ %>
closable="${closable}" 
	<%}%>
	<% if( cssStyle != null ){ %>
style="${cssStyle}" 
	<%}%>
	<% if( cssClass != null ){ %>
class="${cssClass}" 
	<%}%>
	<% if( icon != null ){ %>
icon="${icon}" 
	<%}%>
	<% if( selected != null ){ %>
selected="${selected}" 
	<%}%>
	<% if( enable != null ){ %>
enable="${enable}" 
	<%}%>
	<% if( layout != null ){ %>
layout="${layout}" 
	<%}%>
	<% if( layoutCfg != null ){ %>
layoutCfg="${layoutCfg}" 
	<%}%>
	<% if( cols != null ){ %>
cols="${cols}" 
	<%}%>
>		

<jsp:doBody />

</div>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","tab"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI( function(){
	  var TaTab = window.tab;
	  var options = {
	      	id : "<%=id%>",
	   	};
	  
	  Ta.core.TaUIManager.register('<%=id%>',new TaTab('<%=id%>',options));
	});
}));
</script>