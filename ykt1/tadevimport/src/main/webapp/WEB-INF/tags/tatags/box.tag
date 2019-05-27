<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"  %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='用于输出div标签，支持自动适应剩余高度，布局和被布局' display-name='box' %>
<%@attribute name="id"  type="java.lang.String" description="容器组件在页面上的唯一id"%>
<%@attribute name="cssClass"  type="java.lang.String" description="设置该容器的CSS中class样式，例如 cssClass='edit-icon'"%>
<%@attribute name="cssStyle"  type="java.lang.String" description="设置该容器的CSS中style样式，例如 cssStyle='font-size:12px'" %>
<%@attribute name="span"  type="java.lang.String" description="设置该容器所在父亲容器column布局中所跨列数，例如 span='2'"%>
<%@attribute name="key"  type="java.lang.String" description="当box的父亲容器layout为border时指定它的标题值"%>
<%@attribute name="layout"  type="java.lang.String" description='column/border,设置该容器的布局类型，例如 layout="column"'%>
<%@attribute name="cols"  type="java.lang.String" description="当该容器对子组件布局layout=column的时候，可以设置cols参数表面将容器分成多少列，默认值为1,表示分为一列 "%>
<%@attribute name="layoutCfg"  type="java.lang.String" description='设置layout为border布局的时候布局的参数配置，如:layoutCfg="{leftWidth:200,topHeight:90,rightWidth:200,bottomHeight:100}"'%>
<%@attribute name="columnWidth"  type="java.lang.String" description='设置该容器所占父亲容器column布局中当前位置的百分比，该值在0-1之间，例如 columnWidth="0.03"'%>
<%@attribute name="position"  type="java.lang.String" description='设置父亲容器layout为border布局的时候该组件所在位置（top/left/center/right/bottom）'%>
<%@attribute name="fit"  type="java.lang.String" description="true/false ,是否自动适应剩余高度,如果设置为true，那么该组件的所有父辈组件都要设置fit为true或height为固定值。该组件兄弟组件间只能有一个设置fit=true。如果兄弟组件在后面且可见，那么需要设置heightDiff高度补差"%>
<%@attribute name="heightDiff"  type="java.lang.String" description='当fit设置为true的时候组件底部高度补差，为同级后面的组件留下一定高度，如:heightDiff="100",不需要加px'%>
<%@attribute name="minWidth"  type="java.lang.String" description="设置最小宽度，当分辨率或浏览器被缩小的时候该组件的最小保持宽度，如果其父容器大于此宽度则以大的为准，如:400，不需要加px"%>
<%@attribute name="height"  type="java.lang.String" description='自定义box的高度，如:height="100px"'%>
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
	SecurityUtil.checkFieldStatus(fieldsAuthorization,request, id);
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
		if(layout == null){
			layout = "column";
		}
		
		if(height!=null){
			if(height.endsWith("%")){
			}else if(height.endsWith("px")){
				  cssStyle="height:"+height+";"+cssStyle;
			}else{
				float  heightVal=Float.parseFloat(height);
				if(0<heightVal  && heightVal<1){
				}else{
					cssStyle="height:"+height+"px;"+cssStyle;
				}
			}
		}
		if ((id == null || id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tagrid_" + String.valueOf(nextInt);
		}
%>

<%@include file="../columnhead.tag" %>

<div id="<%=id%>"
	class="grid ${cssClass} "
	<%if(key !=null) {%>
	title="${key}" 
	<%} %> 
	<%if(span !=null) {%>
	span="${span}"
	<%} %> 
	<%if(layout !=null) {%>
	layout="<%=layout %>" 
	<%} %> 
	<%if(position !=null) {%>
	position="${position}"
	<%} %> 
	<%if(columnWidth !=null) {%>
	columnWidth="${columnWidth}"
	<%} %> 
	<%if(cols !=null) {%>
	cols="${cols}"
	<%} %> 
	<%if(layoutCfg !=null) {%>
	layoutCfg="${layoutCfg}"
	<%} %> 
	<%if(cssStyle !=null) {%>
	style="<%=cssStyle%>"
	<%} %> 
	<%if(fit !=null) {%>
	fit="${fit}"
	<%} %> 
	<%if(minWidth !=null) {%>
	minWidth="${minWidth}"
	<%} %> 
	<%if(height !=null) {%>
	height="${height}"
	<%} %> 
	<%if(heightDiff !=null) {%>
	heightDiff="${heightDiff}" 
	<%} %>        
>
<jsp:doBody />
<div style="clear:both"></div>
</div>
<%@include file="../columnfoot.tag" %>