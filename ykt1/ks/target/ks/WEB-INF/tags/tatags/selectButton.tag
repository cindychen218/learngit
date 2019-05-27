<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.authority.ta3.domain.ipo.IFieldAuthrity"%>
<%@tag import="com.yinhai.modules.org.api.util.IOrgConstants"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method" %>
<%@tag import="java.util.Random"%>
<%@tag import="java.util.Set"%>

<%--@doc--%>
<%@tag description='selectButton按钮,下拉按钮，只能放selectButtonItem' display-name='selectButton' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置组件描述，不支持html格式文本' name='key' type='java.lang.String' %>
<%@attribute description='添加组件自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加组件自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='添加Button元素的css样式,例如:cssButton="color:red;"' name='cssButton' type='java.lang.String' %>
<%@attribute description='设置按钮图标:例如icon="icon-edit"' name='icon' type='java.lang.String' %>
<%@attribute description='绑定热键，如果只输入一个英文字母默认是alt+字母的组合，还可以输入ctrl+s这样的值' name='hotKey' type='java.lang.String' %>

<%@attribute description='设置是否不可用,默认为可用：false' name='disabled' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>

<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>

<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
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
		UserAccountInfo _us = SecurityUtil.getUserAccountInfo(request);
		if(_us != null && _us.getUser() != null){
	         if (id != null && id.indexOf(".") > -1) {
	        	String url = id.replace(".", "/");
	        	url = "/" + url.substring(0, url.lastIndexOf("/")) + "!"
	        			+ url.substring(url.lastIndexOf("/") + 1) + ".do";
	        	Set<String> perviewSet  = (Set<String>) request.getSession().getAttribute(IOrgConstants.USER_PERVIEW_FLAG);
	        	if(perviewSet != null && perviewSet.contains(url)){
	        		jspContext.setAttribute("outputting", "true");
	        	} else {
	        		if ("developer".equals(_us.getUser().getLoginId()) || "super".equals(_us.getUser().getLoginId())) {
	        			jspContext.setAttribute("outputting", "true");
	        		}
	        	}
	        } else {
	        	jspContext.setAttribute("outputting", "true");
	        }
		}else{
			jspContext.setAttribute("outputting", "true");
		}
        if (null != hotKey) {
        	if(hotKey.length()==1)hotKey = "Alt+"+hotKey;
            jspContext.setAttribute("hotKey", hotKey);
        }

        if ((this.id == null || this.id.length() == 0)) {
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "taSelectButton_" + String.valueOf(nextInt);
			jspContext.setAttribute("id", id);
		}
 %>
 <%@include file="../columnhead.tag" %>
<%if("true".equals(jspContext.getAttribute("outputting"))){ %>
<div class="select-button <%if(cssClass==null){%> ${cssClass} <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
>
<button id="${id}" 
class="tabutton basebutton hollow btn-main normal"
<% if (hotKey != null){%>
hotKey="${hotKey}" 
<%}%>
type="button"
<% if (columnWidth != null){%>
columnWidth="${columnWidth}"
<%}%>
<% if (toolTip != null){%>
title="${toolTip}" 
<%}%>
<% if(cssButton!=null){%>
style="${cssButton}"
<%}%>>
<% if (icon != null){%>
<span class="button-icon faceIcon ${icon} "></span>
<%} %>
<span class="button-text" >
      <% if (key != null){%>
        ${key}
      <%}else{%>
	 &nbsp;	
	  <%}%>
</span>
<span class="button-arrow icon-arrow_down faceIcon"></span>
</button>
<div class="select-content">
	<div class="content">
	<jsp:doBody/> 	
	</div>
</div>
</div>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","selectButton"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(function(){
	    if(required_selectButton){
	        required_selectButton(function () {
	            var TaSelectButton=window.TaSelectButton;
                var options={
                    <% if (disabled != null && "true".equals(disabled)){%>
                    disabled:${disabled}
                    <%}%>
                };
                Ta.core.TaUIManager.register("${id}",new TaSelectButton("${id}",options));
            })
		}

		})
	}));
</script>
<%}%>
<%@include file="../columnfoot.tag" %>