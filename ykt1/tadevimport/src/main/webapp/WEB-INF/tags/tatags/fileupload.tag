<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='上传组件' display-name='fileupload' %>
<%@attribute description='设置组件id' name='id' type='java.lang.String' %>
<%@attribute description='设置标题，支持html格式文本' name='key' type='java.lang.String' %>
<%@attribute description='上传地址，action中需定义File成员变量及getset方法（File数组-多文件）' name='url' type='java.lang.String' %>
<%@attribute description='后台接收参数名,默认id' name='name' type='java.lang.String' %>
<%@attribute description='true/false,设置是否为多文件上传，默认为false' name='multiple' type='java.lang.String' %>
<%@attribute description='设置传入参数，例如{dto["userId"] : "2323", dto["userName"] : "lins"}' name='parameter' type='java.lang.String' %>
<%@attribute description='true/false,设置button是否为自动上传，默认为true，false则需手动调用方法上传' name='autoSubmit' type='java.lang.String' %>
<%@attribute description='设置需要提交的表单元素id，以逗号分开，暂不支持datagrid及容器id' name='submitIds' type='java.lang.String' %>
<%@attribute description='true/false,设置button为toolbar按钮样式，默认为false' name='asToolBarItem' type='java.lang.String' %>
<%@attribute description='设置组件style样式' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置组件class样式' name='cssClass' type='java.lang.String' %>

<%@attribute description='设置是否显示' name='display' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='提交数据前执行操作' name='onSubmit' type='java.lang.String' %>
<%@attribute description='选择文件发生改变触发事件' name='onChange' type='java.lang.String' %>
<%@attribute description='上传成功回调,格式onUploadSuccess=functionName,函数格式functionName(data){}' name='onUploadSuccess' type='java.lang.String' %>

<%@attribute description='热键，如果只输入一个英文字母默认是alt+字母的组合，还可以输入ctrl+s这样的值' name='hotKey' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%--没有效果的属性--%>
<%@attribute description='按钮图标，默认为icon-save' name='icon' type='java.lang.String' %>
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
			disabled = "true";
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}
%>

<%
		if ("false".equals(display) || "none".equals(display)) {
			if (this.cssStyle == null) {
				this.cssStyle = "display:none;";
			} else {
				this.cssStyle += ";display:none;";
			}
		}
		
		if (null != hotKey) {
			if (hotKey.length() == 1)
				hotKey = "Alt+" + hotKey;
		}

	if (cssClass == null) {
		cssClass = "sexybutton_163";
	} else {
		cssClass = "sexybutton_163 " + cssClass;
	}

	if("true".equals(asToolBarItem)){
		cssClass +=" toolbarbt";
	}
		if ((this.id == null || this.id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tabutton_" + String.valueOf(nextInt);
		}
		if(name == null || "".equals(name)){
        	this.name = id;
        }
		//change by cy  样式太丑了
/* 		if(icon == null){
			icon = "icon-save";
		} */
 %>

	
<button id="<%=id%>" 
<% if(cssStyle != null){ %>
style = "<%=cssStyle %>"
<%} %>
class="<%=cssClass %>"
<% if( disabled != null && "true".equals(disabled)){ %>
disabled="true" 
<%}%>
<% if( toolTip != null ){ %>
title="${toolTip}" 
<%}%>
<% if (hotKey != null){%>
hotKey="${hotKey}" 
<%}%>
type="button"
>
<span class="button_span" 
>
<%if(icon != null){%>
	<span style="height:16px;width:16px;padding-left: 0px;float: left;margin-top: 6px;" class="<%=icon %>"></span>
<%}%>
      <% if (key != null){%>
        ${key}
      <%}else{%>
	 &nbsp;	
	  <%}%>
</span>

</button>
<script>

	(function(factory){
		if (typeof require === 'function') {
			require(["jquery","TaUIManager","fileupload"], factory);
		} else {
			factory(jQuery);
		}
	}(function($){
		Ta.core.TaUICreater.addUI(	
		function(){
		     if(required_fileupload){
		         required_fileupload(function () {
                     var TaFileupload = window.fileupload;
                     var options = {
                         url : "${url}",
                         name : "<%=name%>",
                         <% if( icon != null){%>icon : "<%=icon %>", <%}%>
                         <% if( multiple != null){%>multiple : ${multiple}, <%}%>
                         <% if( submitIds != null){%>submitIds : "${submitIds}", <%}%>
                         <% if( parameter != null){%>param :${parameter},<%}%>
                         <% if( disabled != null){%>disabled :${disabled},<%}%>
                         <% if( autoSubmit != null){%>autoSubmit :${autoSubmit},<%}%>
                         <% if( onChange != null){%>onChange :${onChange},<%}%>
                         <% if( onSubmit != null){%>onSubmit :${onSubmit},<%}%>
                         <% if( onUploadSuccess != null){%>onUploadSuccess :${onUploadSuccess}<%}%>
                     };

                     Ta.core.TaUIManager.register('<%=id%>',new TaFileupload('<%=id%>',options));
                 })
			 }

		});
	}));


</script>	