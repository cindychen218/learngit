<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='竖向tabsVertical页的容必须和tabVertical结合使用' display-name='tabsVertical' %>
<%@attribute description='组件id' name='id' type='java.lang.String' %>
<%@attribute name="span"  type="java.lang.String" description="设置该容器所在父亲容器column布局中所跨列数，例如 span='2'"%>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，注：设置宽高请用width,height属性' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px",注：设置宽高请用width,height属性' name='cssStyle' type='java.lang.String' %>
<%@attribute description='是否自动适应剩余高度,如果设置为true，那么该组件的所有父辈组件都要设置fit为true或height为固定值。&lt;/br&gt;该组件兄弟组件间只能有一个设置fit=true。&lt;/br&gt;如果兄弟组件在后面且可见，那么需要设置heightDiff高度补差' name='fit' type='java.lang.String' %>
<%@attribute description='true/false ,当fit设置为true的时候组件底部高度补差，后同级后面的组件留下一定高度，如:heightDiff="100",不需要加px' name='heightDiff' type='java.lang.String' %>
<%@attribute description='指定tabs的宽度，如width="300"' name='width' type='java.lang.String' %>
<%@attribute description='指定tabs的高度,如height="300"' name='height' type='java.lang.String' %>
<%@attribute description='指定tabs选项卡的宽度，如tabWidth="300"' name='tabWidth' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='Function，当tab被选择的时候触发的事件,传入方法定义（不加括号）,默认传参选中的那个tab的id，如:onSelect="fnSelect"，在javascript中定义函数function fnSelect(tabid){}' name='onSelect' type='java.lang.String' %>
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
		/*
		 * 这里对width和height进行处理，如果width或height有值，则在style中加上width和height
		 */
		String tcssStyle = "";
		if(cssStyle != null){
			tcssStyle = cssStyle;
		}
		
		if (width != null) {
			tcssStyle = "width:"+width+"px;"+tcssStyle;
		}
		
		if (height != null) {
			tcssStyle = "height:"+height+"px;"+tcssStyle;
		}
		
		if(tcssStyle.trim().length()>0)
		{
			cssStyle = tcssStyle;
		}				
		if ((this.id == null || this.id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tatabsVertical_" + String.valueOf(nextInt);
		}
 %>
<%@include file="../columnhead.tag" %>
<div layout="tabs"  	
	<% if( id != null ){ %>
id="<%=id %>" 
	<%}%>
	<% if( fit != null ){ %>
fit="${fit}" 
	<%}%>
	<% if( span != null ){ %>
span="${span}" 
	<%}%>
   <% if( columnWidth != null ){ %>
columnWidth="${columnWidth}" 	 
   <%}%>	
	<% if( cssStyle != null ){ %>
style="<%=cssStyle%>" 
	<%}%>
class="verticalTabs ${cssClass}"
	<% if( heightDiff != null ){ %>
heightDiff="${heightDiff}" 
	<%}%>
	<% if( width != null ){ %>
width="${width}" 
	<%}%>
	<% if( height != null ){ %>
height="${height}" 
	<%}%>

>				
<div class="v-tabs">
</div>
<div class="v-con">
	<div>
		<jsp:doBody />
	</div>
</div>
</div>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","tabsVertical"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI( function(){
	    if(required_tabsVertical){
            required_tabsVertical(function () {
                var options = {};
                <% if( id != null ){ %>
                options.id = "<%=id%>";
                <% } %>
                <% if( cssStyle != null ){ %>
                options.cssClass = "<%=cssClass%>";
                <% } %>
                <% if( cssStyle != null ){ %>
                options.cssStyle = "<%=cssStyle%>";
                <% } %>
                <% if( width != null ){ %>
                options.width = "<%=width%>";
                <% } %>
                <% if( height != null ){ %>
                options.height = "<%=height%>";
                <% } %>
                <% if( tabWidth != null ){ %>
                options.tabWidth = "<%=tabWidth%>";
                <% } %>
                <% if( onSelect != null ){ %>
                options.onSelect = <%=onSelect%>;
                <% } %>

                Ta.core.TaUIManager.register('<%=id%>',new TaVerticalTabs('<%=id%>',options));
            })
		}

	});
}));
</script>
<%@include file="../columnfoot.tag" %>