<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag description='级联选择框' display-name='cascadePicker' %>
<%@attribute description='组件id，页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='组件的label标签,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="100"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute name="required" type="java.lang.String" rtexprvalue="true" description="true/false,设置是否必输，默认false，设置后代小红星"%>
<%@attribute name="toolTip" type="java.lang.String" rtexprvalue="true" description="必输提示"%>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台 true不可用,false 可用 默认false ' name='disabled' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='初始显示在输入框的值' name='placeholder' type='java.lang.String' %>
<%@attribute description='后台相应请求的地址,返回所有数据' required="true" name='url' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='默认值' name='value' type='java.lang.String' %>
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
	if (labelStyle != null) {
		String style = "";
		if (labelWidth != null) {
			style = "width:"+labelWidth+"px";
		}
		style = labelStyle+";"+style;
		labelStyle = style;
	}else{
		if (labelWidth != null) {
			labelStyle = "width:"+labelWidth+"px";
			cssStyle = "margin-left:"+labelWidth+"px;"+cssStyle;
		}
	}
%>
<%--document--%>
<div id="<%=id %>_cascadeBox" class="cascadeBox cascade-layout-Container ">
	<% if(key!=null && !"".equals(key.trim())){%>
    	<label for="<%=id %>" class="cascade-label " 
    		<% if (null != labelStyle) {%>
    				style="<%=labelStyle%>"
			<%} %>
    	>${key}</label>
    <%}%>
    <div class="cascade-input-Container 
	    <% if (cssClass != null){%>
		  ${cssClass}
		<%}%>" 
		<% if (cssStyle != null){%>
			style="${cssStyle}"
		<%}%>
		>
        <input id="<%=id %>" name="dto['<%=id %>']" style="display:none"  />
        <input id="<%=id %>_desc" name="dto['<%=id %>_desc']" class="cascade-input" 
	        <% if(placeholder!=null){%>
				placeholder="<%=placeholder %>" 
			<%}%> 
		/>
        <span id="<%=id %>_arrow" class="faceIcon icon-arrow_down cascade-arrow"></span>
        <span id="<%=id %>_clear" class="faceIcon icon-close cascade-clear"></span>
    </div>
</div>

<script type="text/javascript">
	Ta.core.TaUICreater.addUI(
			function () {
				if (required_cascadepicker) {
					required_cascadepicker(function(){
						var options={};
						<% if( null != url) {%>
						options.url  ="${url}";
						<% }%>
						<% if( null != required) {%>
						options.required  =${required};
						<% }%>
						<% if( null != toolTip) {%>
						options.toolTip  ="${toolTip}";
						<% }%>
						<% if( null != disabled) {%>
						options.disabled  =${disabled};
						<% }%>
						<% if( null != readOnly) {%>
						options.readOnly  =${readOnly};
						<% }%>
						<% if( null != value) {%>
						options.defaultValue  ="${value}";
						<% }%>
						Ta.core.TaUIManager.register("<%=id%>", new cascadePicker('<%=id%>', options));
					});
				}
			});
</script>
