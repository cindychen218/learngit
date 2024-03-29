<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.authority.api.vo.MenuVo"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>
<%@tag import="java.util.Set" %>

<%--@doc--%>
<%@tag description='anchor锚点组件' display-name='anchor' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String'  required='true'%>
<%@attribute description='目标组件选择器' name='targetSelector' type='java.lang.String' required='true' %>
<%@attribute description='顶层组件选择器，默认 html,body' name='positionSelector' type='java.lang.String'%>
<%@attribute description='设置描述' name='key' type='java.lang.String' %>
<%@attribute description='热键，如果只输入一个英文字母默认是alt+字母的组合，还可以输入ctrl+s这样的值' name='hotKey' type='java.lang.String' %>
<%@attribute description='设置按钮图标:例如icon="icon-edit"' name='icon' type='java.lang.String' %>
<%@attribute description='true/false,设置button为toolbar按钮样式，默认为false' name='asToolBarItem' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='按钮样式，是否为确认类型，比如保存，更新等操作，默认false，只适用于163风格' name='isok' type='java.lang.String' %>
<%@attribute description='是否在新样式按钮上显示图标，默认false，不显示' name='isShowIcon' type='java.lang.String' %>
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
		UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
		if(userAccountInfo != null && userAccountInfo.getUser() != null){
	         if (id != null && id.indexOf(".") > -1) {
	        	String url = id.replace(".", "/");
	        	url = "/" + url.substring(0, url.lastIndexOf("/")) + "!"
	        			+ url.substring(url.lastIndexOf("/") + 1) + ".do";
				Set<String> menuUrls = SecurityUtil.getCurrentUserPermissionUrls(request.getSession());
	        	if(menuUrls != null && menuUrls.contains(url)){
	        		jspContext.setAttribute("outputting", "true");
	        	} else {
	        		if ("developer".equals(userAccountInfo.getUser().getLoginId()) || "super".equals(userAccountInfo.getUser().getLoginId())) {
	        			jspContext.setAttribute("outputting", "true");
	        		}
	        	}
	        } else {
	        	jspContext.setAttribute("outputting", "true");
	        }
		}else{
			jspContext.setAttribute("outputting", "true");
		}
		boolean isGroup = false;
		if(null != getParent()){
	    	 String st = getParent().getClass().toString();
	    	 if(null != st && st.length()>0){
	    	   isGroup = st.contains("buttonGroup") || st.contains("buttongroup");
	    	 }
		}
        if (null != hotKey) {
        	if(hotKey.length()==1)hotKey = "Alt+"+hotKey;
            jspContext.setAttribute("hotKey", hotKey);
        }
        
        if("false".equals(display)|| "none".equals(display)){
        	if(this.cssStyle ==null){
        		this.cssStyle = "display:none;";
        	}else{
        		this.cssStyle += ";display:none;";
        	}
        	jspContext.setAttribute("cssStyle", cssStyle);
        }
        if(isGroup){
        	if(cssClass==null){
        		cssClass = "sexybutton_163";
        	}else{
        		cssClass = "sexybutton_163 "+cssClass;
        	}
        	if(this.cssStyle ==null){
        		this.cssStyle = "float:left;";
        	}else{
        		this.cssStyle += ";float:left;";
        	}
        	jspContext.setAttribute("cssStyle", cssStyle);
        }else{
			if(cssClass==null){
				cssClass = "sexybutton_163";
			}else{
				cssClass = "sexybutton_163 "+cssClass;
			}
        }
        if("true".equals(asToolBarItem)){
        	cssClass +=" toolbarbt";
        }
        jspContext.setAttribute("cssClass",cssClass);
        if ((this.id == null || this.id.length() == 0)) {

			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tabutton_" + String.valueOf(nextInt);
			jspContext.setAttribute("id", id);
		}
 %>
 <%if("true".equals(jspContext.getAttribute("outputting"))){ %>
 <%if(isGroup){ %>
<button id="${id}" 
class="${cssClass}" 
<% if (hotKey != null){%>
hotKey="${hotKey}" 
<%}%>
<% if (cssStyle != null){%>
style="${cssStyle}" 
<%}%>
<% if (disabled != null && "true".equals(disabled)){%>
disabled="${disabled}"
<%}%>
<% if (columnWidth != null){%>
columnWidth="${columnWidth}"
<%}%>
<% if (toolTip != null){%>
title="${toolTip}" 
<%}%>>

<span class="button_span <% if (isok != null && "true".equals(isok)){%>isok<%} %>" 
>
<%if(icon != null){
	if(isShowIcon != null && "true".equals(isShowIcon)) {%>
	<span style="height:16px;width:16px;padding-left: 0px;float: left;margin-top: 6px;" class="${icon}"></span>
<%}}%>
      <% if (key != null){%>
        ${key}
      <%}else{%>
	 &nbsp;	
	  <%}%>
</span>
</button>
<%}else{%>
<button id="${id}" 
<% if (cssClass != null){%>
class="${cssClass}" 
<%}else{%>
class="sexybutton"
<%}%>
type="button"
<% if (hotKey != null){%>
hotKey="${hotKey}" 
<%}%>
<% if (cssStyle != null){%>
style="${cssStyle}" 
<%}%>
<% if (disabled != null && "true".equals(disabled)){%>
disabled="${disabled}"
<%}%>
<% if (columnWidth != null){%>
columnWidth="${columnWidth}"
<%}%>
<% if (toolTip != null){%>
title="${toolTip}" 
<%}%>>
	<span>
		<span>	
		    <% if (icon != null){%>
			<span style="height:16px;width:16px;padding-left: 0px;float: left;margin-top: 3px;" class="${icon}"></span>
			<span >
				<%}%>
				<%if(key !=null){ %>
					 <%=key%> 
				<%}%>	
				<%if(icon !=null){ %>
					</span>
				<%} %>	
		</span>
	</span>
</button>
<%}%>
<%}%>

<%@include file="../columnfoot.tag" %>
<script>
$("#<%=id %>").click(function(){
    <%if(positionSelector==null){
        positionSelector = "html,body";
    }%>
    var obj = $("<%=targetSelector%>");
    var positionSelector = "<%=positionSelector%>";


    $(positionSelector).animate({scrollTop:obj.offset().top-3},500);
});
</script>