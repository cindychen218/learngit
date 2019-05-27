<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor" %>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='buttonGroup,按钮以组合,输入框按钮组合,button,submit,selectButton,text类组合' display-name="buttonGroup" %>
<%@attribute description='center/left/right，默认center。设置容器内按钮或者输入框的对齐方式，例如:align="center"' name='align' type='java.lang.String' %>
<%@attribute description='top/bottom，设置容器在页面的位置top:固定在顶部,bottom:固定在容器底部' name='position' type='java.lang.String' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='数字，当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
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
if(cssClass==null){
	cssClass = "button-container  group ";
}else{
	cssClass = "button-container  group  "+cssClass;
}
if("right".equals(align) || "left".equals(align)){
	cssClass += " "+align;
}else{
	cssClass += " center";
}
	if("top".equals(position)){
		cssClass += " fixed-top";
	}else if("bottom".equals(position)){
		cssClass += " fixed-bottom";
	}
 jspContext.setAttribute("cssClass",cssClass);
if ((this.id == null || this.id.length() == 0)) {

	int nextInt = RANDOM.nextInt();
	nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
			.abs(nextInt);
	id = "taButtonGroup_" + String.valueOf(nextInt);
	jspContext.setAttribute("id", id);
}
%>
 <%@include file="../columnhead.tag" %>
<div
		id="${id}"
		class="${cssClass}"
		<% if (cssStyle != null) {%>
		style="${cssStyle}"
		<%}%>
		<% if (span != null) {%>
		span="${span}"
		<%}%>
		<% if (columnWidth != null) {%>
		columnWidth="${columnWidth}"
		<%}%>>
	   <div class="content">
       <jsp:doBody/>
	</div>

</div>
<script type="text/javascript">
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","buttonGroup"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(
			function(){
	var options = {
			txtId:"${id}",
			align:"${align}"
		};
	Ta.core.TaUIManager.register("${id}",new TaButtonGroup("${id}",options));
});
}));
</script>
<%@include file="../columnfoot.tag" %>