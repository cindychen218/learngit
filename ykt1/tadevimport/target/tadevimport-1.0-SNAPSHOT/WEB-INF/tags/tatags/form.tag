<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor" %>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='类似于表单form元素,form标签禁止嵌套使用,一个页面可以有多个form标签' display-name='form' %>
<%@attribute name='id'   description='组件id页面唯一'  type='java.lang.String' %>
<%@attribute name='action' description='form提交的地址，一般不需要设置' type='java.lang.String' %>
<%@attribute name='enctype' description='设置form提交的类型，如果是文件上传必须设置为multipart/form-data，一般不设置' type='java.lang.String' %>
<%@attribute name='methord' description='当需要使用表单提交方法时使用，如文件上传，可以设置post或get方式' type='java.lang.String' %>
<%@attribute name='cssClass' description='给该组件添加自定义样式class，如:cssClass="no-padding"'  type='java.lang.String' %>
<%@attribute name='cssStyle' description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"表示容器顶部向内占用10个像素' type='java.lang.String' %>
<%@attribute name='fit' description='是否自动适应剩余高度,如果设置为true，那么该组件的所有父辈组件都要设置fit为true或height为固定值。&lt;/br&gt;该组件兄弟组件间只能有一个设置fit=true。&lt;/br&gt;如果兄弟组件在后面且可见，那么需要设置heightDiff高度补差' type='java.lang.String' %>
<%@attribute name='heightDiff' description='true/false ,当fit设置为true的时候组件底部高度补差，后同级后面的组件留下一定高度，如:heightDiff="100",不需要加px' type='java.lang.String' %>

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
if (null == methord) {
	methord = "POST";
}
if ((id == null || id.length() == 0)) {
	Random random = new Random();
	int nextInt = random.nextInt();
	nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math.abs(nextInt);
	id = "taform_" + String.valueOf(nextInt);
}
%>
<%@include file="../columnhead.tag" %>
<form method="post"
  id="<%=id %>"
<% if (action != null){%>
  action="${action}"
<%}%>
<% if (enctype != null){%>
  enctype="${enctype}"
<%}%>
<% if (cols != null){%>
  cols="${cols}"
<%}%>
<% if (span != null){%>
  span="${span}"
<%}%>
<% if (fit != null){%>
  fit="${fit}"
<%}%>
<% if (heightDiff != null){%>
  heightDiff="${heightDiff}"
<%}%>
<% if (cssStyle != null){%>
  style="${cssStyle}"
<%}%>
<% if (cssClass != null){%>
  class="${cssClass}"
<%}%>
<% if (columnWidth != null){%>
  columnWidth="${columnWidth}"
<%}%>	
<% if (methord != null){%>
  method="<%=methord %>"
<%}%>      
>
<jsp:doBody/>
<div style="clear:both"></div>
</form>
<script type="text/javascript">
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","form"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(	
	function(){
		var options = {
				txtId:"<%=id %>"
			};
			
		Ta.core.TaUIManager.register("<%=id %>",new taform(options));
	});
}));
</script>
<%@include file="../columnfoot.tag" %>	