
<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.authority.api.vo.MenuVo"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random" %>
<%@tag import="java.util.Set" %>
<%@ tag import="com.yinhai.core.common.api.util.ValidateUtil" %>

<%--@doc--%>
<%@tag description='button按钮' display-name='button' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置标题，不支持html格式文本' name='key' type='java.lang.String' %>
<%@attribute description='设置button的功能类型可选 刷新页面resetPage,提交submit' name='type' type='java.lang.String' %>

<%@attribute description='type是submit时 设置是否自动校验 true/false,是否自动校验，默认true' name='isValidate' type='java.lang.String' %>
<%@attribute description='type是submit时 需要提交的组件id，可以是panel,fieldset,div,box,tabs,tab,form,datagrid以及输入元素的id。多个可以用逗号隔开。但是多个id里面不能有包含与被包含的关系' name='submitIds' type='java.lang.String' %>
<%@attribute description='type是submit时 action的地址' name='url' type='java.lang.String' %>
<%@attribute description='type是submit时 提交前的调用方法，必须返回true或false，如果返回false就不在继续调用' name='onSubmit' type='java.lang.String' %>
<%@attribute description='type是submit时 Function,业务成功（返回数据有success=true的数据的时候调用该方法),传入的是方法的定义，比如:successCallBack="fnMyCallBack"。注意不能写成:successCallBack="fnMyCallBack()"' name='successCallBack' type='java.lang.String' %>
<%@attribute description='type是submit时 Function,业务成功（返回数据有success=false的数据的时候调用该方法),传入的是方法的定义，比如:failureCallBack="fnMyCallBack"。注意不能写成:failureCallBack="fnMyCallBack()"' name='failureCallBack' type='java.lang.String' %>
<%@attribute description='type是submit时 手动传入js变量参数' name='parameter' type='java.lang.String' %>
<%@attribute description='type是submit时 true/false,默认为false，设置是否同步提交。主要用途，表单提交后要刷新整个页面或跳转到其他页面的时候以及需要使用文件上传功能的时候使用。如果设置为true相当于调用Base.submitForm' name='isSyncSubmit' type='java.lang.String' %>
<%@attribute description='type是submit时 是否提交空字段,true/false，true表示提交空字段，false表示采用全局配置' name='isIncludeNullFields' type='java.lang.String' %>

<%@attribute description='设置button的类型,有两种类型可选basebutton:基本按钮,linkbutton:链接型按钮,默认为基本按钮' name='buttonStyleType' type='java.lang.String' %>
<%@attribute description='设置basebutton基本按钮情况下,按钮是实心还是空心的 实心:false,空心:true 默认实心false' name='isHollowButton' type='java.lang.String' %>
<%@attribute description='设置按钮的含义类型 分别为主要样式按钮btn-main 成功样式按钮btn-success 提醒样式按钮 btn-warn 警告样式按钮 btn-fail 默认为主要样式 btn-main' name='meaningType' type='java.lang.String' %>
<%@attribute description='设置按钮的大小,分为三个size 大号large 中号normal 小号 small  默认:normal ' name='size' type='java.lang.String' %>
<%@attribute description='设置按钮后是否留一个5px 的间隔,这个主要用在组合按钮中隔开按钮使用' name='space' type='java.lang.String' %>
<%@attribute description='设置按钮图标,例如icon="icon-search" 显示为搜索按钮' name='icon' type='java.lang.String' %>
<%@attribute description='设置是否只显示图标不显示文字,true只显示图标不显示文字,false 显示图标和文字全部,默认全部显示' name='onlyShowIcon' type='java.lang.String' %>
<%@attribute description='true/false,是否加载中状态，默认false' name='loading' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='热键，如果只输入一个英文字母默认是alt+字母的组合，还可以输入ctrl+s这样的值' name='hotKey' type='java.lang.String' %>
<%@attribute description='单击事件，例如:onClick="fnOnClick()",在javascript中，function fnOnClick(){alert(111)}' name='onClick' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='徽标记显示内容，可以是数字、文本。如：badgeKey="99"' name='badgeKey' type='java.lang.String' %>
<%@attribute description='当徽标记为数字时显示的最大值，大于 badgeMax 时显示为 badgeMax+，为 0 时隐藏' name='badgeMax' type='java.lang.String' %>
<%@attribute description='true/false,是否显示徽标记，默认为显示：true' name='badgeDisplay' type='java.lang.String' %>
<%@attribute description='设置徽标记显示图标，如：badgeIcon="icon-search"' name='badgeIcon' type='java.lang.String' %>


<%--没有用的功能先写上使项目部报错--%>
<%@attribute description='按钮样式，是否为确认类型，比如保存，更新等操作，默认false，只适用于163风格' name='isok' type='java.lang.String' %>
<%@attribute description='是否在新样式按钮上显示图标，默认false，不显示' name='isShowIcon' type='java.lang.String' %>
<%@attribute description='true/false,设置button为toolbar按钮样式，默认为false' name='asToolBarItem' type='java.lang.String' %>

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
	if("false".equals(display)|| "none".equals(display)){
		if(cssStyle ==null){
			cssStyle = "display:none;";
		}else{
			cssStyle += ";display:none;";
		}
		jspContext.setAttribute("cssStyle", cssStyle);
	}
	cssClass += "linkbutton".equals(buttonStyleType)?" linkbutton ":" basebutton ";
	cssClass+="true".equals(isHollowButton)?" hollow ":" solid ";
	cssClass+= ValidateUtil.isNotEmpty(meaningType)? " "+meaningType:" btn-main ";
	cssClass+=ValidateUtil.isNotEmpty(size)?" "+size:" normal";
	cssClass+="true".equals(space)?" space ":" ";
	jspContext.setAttribute("cssClass",cssClass);
	if ((id == null || id.length() == 0)) {
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
				.abs(nextInt);
		id = "tabutton_" + String.valueOf(nextInt);
		jspContext.setAttribute("id", id);
	}
%>
<%if("true".equals(jspContext.getAttribute("outputting"))){ %>
<button id="${id}"
		class="tabutton ${cssClass} <%=ValidateUtil.isNotEmpty(onlyShowIcon)?" only-show-icon ":" "%>"
		<% if (hotKey != null){%>
		hotKey="${hotKey}"
		<%}%>
		<% if (cssStyle != null){%>
		style="${cssStyle}"
		<%}%>
		type="button"
		<% if (onClick != null){%>
		onClick="${onClick}"
		<%}%>
		<% if (columnWidth != null){%>
		columnWidth="${columnWidth}"
		<%}%>
		<% if (toolTip != null){%>
		title="${toolTip}"
		<%}%>>
	<span class="faceIcon button-icon <% if (icon != null){%>${icon}<%}%>"></span>
	<span class="button-text">${key}</span>
	<%if(badgeKey != null || badgeIcon != null){ %>
	<sup class="badge-button faceIcon <% if (badgeIcon != null){%> badgeIcon ${badgeIcon}<%}%>" style="<%if("false".equals(badgeDisplay) || "none".equals(badgeDisplay)){%> display:none;<%}%>"></sup>
	<%}%>
</button>
<%}%>

<%@include file="../columnfoot.tag" %>
<script>

    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager","button"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                var taButton = window.button;
                var options = {
                    type : "${type}",
                    <% if (disabled != null) {%>
                    disabled :${disabled},
                    <% }%>
                    <% if (loading != null) {%>
                    loading :${loading},
                    <% }%>
                    isSyncSubmit : <%=isSyncSubmit%>,
                    submitIds : <%=submitIds%>,
                    url : <%=url%>,
                    onSubmit : <%=onSubmit%>,
                    parameter :<%=parameter%>,
                    isValidate : <%=isValidate%>,
                    successCallBack : <%=successCallBack%>,
                    failureCallBack : <%=failureCallBack%>,
                    isIncludeNullFields : <%=isIncludeNullFields%>,
					<% if (badgeKey != null) {%>
                    badgeKey : "<%=badgeKey%>",
					<% }%>
                    <% if (badgeMax != null) {%>
                    badgeMax : <%=badgeMax%>,
                    <% }%>
                    <% if (badgeIcon != null) {%>
                    badgeIcon : "<%=badgeIcon%>",
                    <% }%>
                };
                Ta.core.TaUIManager.register("<%=id%>",new taButton("<%=id%>",options));});
    }));

</script>