<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='fieldset框，适用于存放输入组件' display-name='fieldset' %>
<%@attribute name='id'   description='组件id页面唯一'  type='java.lang.String' %>
<%@attribute name='key' description='对fieldset设置标题，支持html格式文本' type='java.lang.String' %>
<%@attribute name='cssClass' description='给该组件添加自定义样式class，如:cssClass="no-padding"'  type='java.lang.String' %>
<%@attribute name='cssStyle' description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"表示容器顶部向内占用10个像素' type='java.lang.String' %>
<%@attribute name='align' description='标题对齐方式 （左：left，中：center，右：right）'  type='java.lang.String' %>

<%@attribute name='layout' description='可设置该容器对子组件的布局类型为column,(border不适用,无layoutConfig属性)，column为按列布局，默认分为一列，如要制定列数设置cols属性' type='java.lang.String' %>
<%@attribute name='cols' description='当该容器对子组件布局layout=column的时候，可以设置cols参数表面将容器分成多少列，默认值为1,表示分为一列'  type='java.lang.String' %>
<%@attribute name='columnWidth' description='设置父容器layout为column布局的时候自定义占用容器行宽度百分比，可设置值为0-1之间的小数，如:0.1则表示占该行的1/10' type='java.lang.String' %>
<%@attribute name='span' description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' type='java.lang.String' %>
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

        if (align != null) {
       		//align = "text-align:" + align + ";" + cssStyle;
			jspContext.setAttribute("keyAlign", align);
		}
		if (cols != null) {
			
		}else{
			jspContext.setAttribute("cols", "1");
		}
		if (layout != null) {
		}else{
			jspContext.setAttribute("layout", "column");
		}		
		if ((id == null || id.length() == 0)) {

			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tafieldset_" + String.valueOf(nextInt);
			jspContext.setAttribute("id", id);
		}
%>
<%@include file="../columnhead.tag" %>
<div <%
	
	if( id!=null){%>
	 id="${id}" 	 
	<%}%>
	<%
	if( layout!=null){%>
	 layout="${layout}" 
	<%}else{%>
	 layout="column" 
	<%}%>
	<%if( columnWidth!=null){%>
	 columnWidth="${columnWidth}" 	 
	<%}%>	
	<%if( span!=null){%>
	 span="${span}" 
	<%}%>		
	<%
	//System.out.println(cols);
	if( cols!=null){%>
	 cols="${cols}" 
	<%}%>
	<%if( cssStyle!=null ){ %>
	style=" ${cssStyle}"
	<%} %>
	<%if( cssClass!=null ){ %>
	class=" ${cssClass}"
	<%} %>		
	>
	<%if( key!=null){%>
	<div  class="tafieldset-header "
	<%if( jspContext.getAttribute("keyAlign")!=null ){ %>
	style="text-align:${keyAlign}"
	<%} %>
	>
	<div class="fieldset-header-bg"></div>
	<h2>${key}</h2>
	</div>
	<%} %>
	<div
	 class="tafieldset-body"
	>
		<jsp:doBody/> 
		<div style="clear:both"></div>
	</div>
</div>
<%@include file="../columnfoot.tag" %>