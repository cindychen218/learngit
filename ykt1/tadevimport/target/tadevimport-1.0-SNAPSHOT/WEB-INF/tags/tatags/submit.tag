<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.org.api.util.IOrgConstants"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>
<%@tag import="java.util.Set"%>
<%@ tag import="com.yinhai.core.common.api.util.ValidateUtil" %>

<%--@doc--%>
<%@tag description='提交按钮' display-name='submit' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='true/false,设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='true/false,设置是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='组件id' name='id' type='java.lang.String' %>
<%@attribute description='按钮的名称' name='key' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='热键，如果只输入一个英文字母默认是atl+字母的组合，还可以输入ctrl+s这样的值' name='hotKey' type='java.lang.String' %>
<%@attribute description='true/false,是否自动校验，默认true' name='isValidate' type='java.lang.String' %>
<%@attribute description='需要提交的组件id，可以是panel,fieldset,div,box,tabs,tab,form,datagrid以及输入元素的id。多个可以用逗号隔开。但是多个id里面不能有包含与被包含的关系' name='submitIds' type='java.lang.String' %>
<%@attribute description='action的地址' name='url' type='java.lang.String' required="true"%>
<%@attribute description='提交前的调用方法，必须返回true或false，如果返回false就不在继续调用' name='onSubmit' type='java.lang.String' %>
<%@attribute description='Function,业务成功（返回数据有success=true的数据的时候调用该方法),传入的是方法的定义，比如:successCallBack="fnMyCallBack"。注意不能写成:successCallBack="fnMyCallBack()"' name='successCallBack' type='java.lang.String' %>
<%@attribute description='Function,业务成功（返回数据有success=false的数据的时候调用该方法),传入的是方法的定义，比如:failureCallBack="fnMyCallBack"。注意不能写成:failureCallBack="fnMyCallBack()"' name='failureCallBack' type='java.lang.String' %>
<%@attribute description='手动传入js变量参数,如：{"dto.userId" : "2323", "dto.userName" : "lins"}  ' name='parameter' type='java.lang.String' %>
<%@attribute description='true/false,默认为false，设置是否同步提交。主要用途，表单提交后要刷新整个页面或跳转到其他页面的时候以及需要使用文件上传功能的时候使用。如果设置为true相当于调用Base.submitForm' name='isSyncSubmit' type='java.lang.String' %>
<%@attribute description='是否提交空字段,true/false，true表示提交空字段，false表示采用全局配置' name='isIncludeNullFields' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>


<%-- 没用功能--%>
<%@attribute description='图标样式class名称,如:icon-add,可以到icon.css查询' name='icon' type='java.lang.String' %>
<%@attribute description='设置是否为paneltoolbar中使用的按钮' name='asToolBarItem' type='java.lang.String' %>
<%@attribute description="设置提交时显示蒙层的对象id。可以panel，fieldset等。如果设置为'body'，就整个页面显示蒙层。" name='showMask' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='组件所占用的列数' name='span' type='java.lang.String' %>
<%@attribute description='按钮样式，是否为确认类型，比如保存，更新等操作，默认false，只适用于163风格' name='isok' type='java.lang.String' %>
<%@attribute description='是否在新样式按钮上显示图标，默认false，不显示' name='isShowIcon' type='java.lang.String' %>

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
 /* 对形如id="test.xxAction.save"的按钮做出权限判断，如果没有/test/xxAction!save.do的操作权限，则不输出 */
 		String outputting = "";
		UserAccountInfo _us = SecurityUtil.getUserAccountInfo(request);
		if(_us != null && _us.getUser() != null){
		    if (id != null && id.indexOf(".") > -1) {
		   	String url = id.replace(".", "/");
		   	url = "/" + url.substring(0, url.lastIndexOf("/")) + "!"
		   			+ url.substring(url.lastIndexOf("/") + 1) + ".do";
		   	Set<String> perviewSet  = (Set<String>) request.getSession().getAttribute(IOrgConstants.USER_PERVIEW_FLAG);
		   	if(perviewSet != null && perviewSet.contains(url)){
		   		outputting = "true";
		   	} else {
		   		if ("developer".equals(_us.getUser().getLoginId()) || "super".equals(_us.getUser().getLoginId())) {
		   			outputting = "true";
		   		}
		   	}
		   } else {
			   outputting = "true";
		   }
		}else{
			outputting = "true";
		}
        
        if (null != hotKey) {
        	if(hotKey.length()==1)hotKey = "Alt+"+hotKey;
			jspContext.setAttribute("hotKey", hotKey);
        }
                
 
        if ("false".equals(isValidate)) {
            isValidate = "false";
        }else{
        	isValidate = "true";
        }
        if (null != onSubmit) {
        }else{
        	onSubmit = "null";
        }
        if (null != submitIds) {
            submitIds = "'"+submitIds+"'";
        }else{
        	submitIds = "null";
        }
        
        if (null != url) {
        	url = "'"+url+"'";
        }else{
        	url = "null";
        }
        
        if (null != successCallBack) {
        }else{
        	 successCallBack = "null";
        }
        
        if (null != failureCallBack) {
        }else{
        	failureCallBack= "null";
        }
        
        if (null != parameter) {
        }else{
        	parameter = "null";
        }
		if ("false".equals(display) || "none".equals(display)) {
			if (cssStyle == null) {
				cssStyle = "display:none;";
			} else {
				cssStyle += ";display:none;";
			}
			jspContext.setAttribute("cssStyle", cssStyle);
		}
		cssClass += " basebutton ";
		cssClass += " solid ";
		cssClass += " btn-main ";
		cssClass += " normal";
		cssClass += " ";
		jspContext.setAttribute("cssClass", cssClass);
        if ((id == null || id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tasubmit_" + String.valueOf(nextInt);
		}     
        
%>

<%if(outputting !=null && "true".equals(outputting)){%>
<button id="<%=id%>"
		class="tabutton ${cssClass}"
		<% if (hotKey != null){%>
		hotKey="${hotKey}"
		<%}%>
		<% if (cssStyle != null){%>
		style="${cssStyle}"
		<%}%>
		type="button"
		<% if (columnWidth != null){%>
		columnWidth="${columnWidth}"
		<%}%>
		<% if (toolTip != null){%>
		title="${toolTip}"
		<%}%>>

	<span class="faceIcon button-icon"></span>
	<span class="button-text">${key}</span>
</button>
<% }%>
<%@include file="../columnfoot.tag" %>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","submit"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
Ta.core.TaUICreater.addUI( 
	function(){
        var taButton = window.button;
	 	var options = {
            type : "submit",
            <% if (null != disabled) {%>
            disabled :${disabled},
            <% }%>
			isSyncSubmit : <%=isSyncSubmit%>,
			submitIds : <%=submitIds%>,
			url : <%=url%>,
			onSubmit : <%=onSubmit%>,
			isValidate : <%=isValidate%>,
			parameter :<%=parameter%>,
			successCallBack : <%=successCallBack%>,
			failureCallBack : <%=failureCallBack%>,
			isIncludeNullFields : <%=isIncludeNullFields%>
	   	};
	    Ta.core.TaUIManager.register("<%=id%>",new taButton("<%=id%>",options));
	});
}));
</script>