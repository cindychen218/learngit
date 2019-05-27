<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@ tag import="java.util.Random" %>

<%-- @doc --%>
<%@tag description='期号选择框' display-name='issue'%>
<%@attribute description='组件id页面唯一' name='id' required='true' type='java.lang.String'%>
<%@attribute description='组件的label标签,不支持html标签' name='key' type='java.lang.String'%>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String'%>
<%@attribute description='是否显示选择面板,默认true,设置false则不显示面板' name='showSelectPanel' type='java.lang.String'%>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String'%>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"表示容器顶部向内占用10个像素' name='cssStyle' type='java.lang.String'%>
<%@attribute description='单独设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String'%>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String'%>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String'%>
<%@attribute description='设置该容器所占父亲容器column布局中当前位置的百分比，该值在0-1之间，例如 columnWidth="0.03"' name='columnWidth' type='java.lang.String'%>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String'%>

<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String'%>
<%@attribute description='true/false,设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台，默认为false' name='disabled' type='java.lang.String'%>
<%@attribute description='true/false,设置是否显示，默认为显示:true' name='display' type='java.lang.String'%>
<%@attribute description='true/false,设置是否必输，默认false，设置后代小红星' name='required' type='java.lang.String'%>
<%@attribute description='true/false,设置为只读，默认为true只读' name='readOnly' type='java.lang.String'%>

<%@attribute description='onBlur事件，当失去焦点时调用，此处填写函数调用如onBlur="fnBlur(this)"' name='onBlur' type='java.lang.String'%>
<%@attribute description='onChange事件，当onChange值改变时调用，此处填写函数调用如onChange="fnChange(this)"' name='onChange' type='java.lang.String'%>
<%@attribute description='onClick事件，当单击控件时调用，此处填写函数调用如onClick="fnClick(this)"' name='onClick' type='java.lang.String'%>
<%@attribute description='onFocus事件，当控件获取焦点时，此处填写函数调用如onClick="fnFocus(this)"' name='onFocus' type='java.lang.String'%>

<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String'%>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String'%>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String'%>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String'%>
<%@attribute description='鼠标经过提示信息' name='toolTip' type='java.lang.String'%>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='issue起始年,yyyy' name='rangeMin' type='java.lang.String' %>
<%@attribute description='issue结束年,yyyy' name='rangeMax' type='java.lang.String' %>

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
	if ((this.id == null || this.id.length() == 0)) {
		Random RANDOM = new Random();
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE
				? Integer.MAX_VALUE
				: Math.abs(nextInt);
		id = "taissue_" + String.valueOf(nextInt);
	}
	if (name == null || "".equals(name)) {
		name = "dto['" + id + "']";
	}
	// 优先 查找resultBean
	IResultBean resultBean = (IResultBean) TagUtil.getResultBean();
	if (resultBean != null) {
		Object v = resultBean.getFieldsData() == null
				? null
				: resultBean.getFieldsData().get(id);
		if (v != null && !"".equals(v)) {
			this.value = v.toString();
		}
	}
	// 查找request
	if (value != null && !"".equals(value)
			&& request.getAttribute(this.id) != null) {
		value = request.getAttribute(this.id).toString();
	}
	// 查找session
	if (value != null && !"".equals(value)
			&& request.getSession().getAttribute(this.id) != null) {
		value = request.getSession().getAttribute(this.id).toString();
	}
%>
<%@include file="../columnhead.tag"%>
<div class="issue-layout-Container <% if(cssClass != null ){ %> ${cssClass}  <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	 <% if(columnWidth != null ){ %> columnWidth="${columnWidth}" <%}%>
	 <% if(span != null ){ %> span="${span}" <%}%>
	 <% if(toolTip != null ){ %> title="${toolTip}" <%}%>>


	<% if(key!=null && !"".equals(key.trim())){%>
		<label for="<%=id %>" class="issue-label"
			   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
		>
		${key}
		</label>
	<%} %>
	<div class="issue-input-Container"
		<% if(labelWidth != null ){ %>
			style="margin-left:${labelWidth}px"
		<%}else if(null == key || "".equals(key.trim())) {%>
		 	style="margin-left:0px;"
		<%}%>
	>
		<input type="text"
			   maxlength = "6"
				<% if(id != null ){ %>
			   id="<%=id %>"
				<%}%>
				<% if(name != null ){ %>
			   name="<%=name %>"
				<%}%>
			   class="issue-input issuefield"
				<% if(cssInput != null ){ %>
			   style="${cssInput}"
			   autocomplete="off" disableautocomplete
				<%}%>
		/>
		<span class="faceIcon validateIcon"></span>
		<span class='faceIcon icon-date issueIcon'></span>
		<div id="<%=id%>_issue_winContainer" class="issue-win-Container"></div>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container"></div>
		<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag"%>
<script>
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager","issue"], factory);
        } else {
            factory(jQuery);
        }
    }( function($){
        Ta.core.TaUICreater.addUI(
            function(){
                var options = {
                    <%if (value != null) {%>
                    value : "<%=value%>",
                    <%}%>
                    <% if(required != null){%>
                    required : ${required},
                    <%}%>
                    <%if (disabled != null) {%>
                    disabled : <%=disabled%>,
                    <%}%>
                    <%if (readOnly != null) {%>
                    readOnly : <%=readOnly%>,
                    <%}%>
                    <%if (showSelectPanel != null) {%>
                    showSelectPanel : ${showSelectPanel},
                    <%}%>
                    <% if(bpopTipMsg!=null){%>
                    bpopTipMsg:"${bpopTipMsg}",
                    <%}%>
                    <% if(bpopTipWidth!=null){%>
                    bpopTipWidth:"${bpopTipWidth}",
                    <%}%>
                    <% if(bpopTipHeight!=null){%>
                    bpopTipHeight:"${bpopTipHeight}",
                    <%}%>
                    <% if(bpopTipPosition!=null){%>
                    bpopTipPosition:"${bpopTipPosition}",
                    <%}%>
                    <%if (textHelp != null) {%>
                    textHelp : "${textHelp}",
                    <%}%>
                    <%if (textHelpWidth != null) {%>
                    textHelpWidth : "${textHelpWidth}",
                    <%}%>
                    <%if (textHelpPosition != null) {%>
                    textHelpPosition : "${textHelpPosition}",
                    <%}%>
                    <%if(onClick!=null){%>
                    onClick:"${onClick}",
                    <%}%>
                    <% if(onChange!=null){%>
                    onChange:"${onChange}",
                    <%}%>
                    <% if(onBlur!=null){%>
                    onBlur:"${onBlur}",
                    <%}%>
                    <% if(onFocus!=null){%>
                    onFocus:"${onFocus}",
                    <%}%>
                    <% if(rangeMin!=null){%>
                    rangeMin:${rangeMin},
                    <%}%>
                    <% if(rangeMax!=null){%>
                    rangeMax:${rangeMax},
                    <%}%>
                };

                Ta.core.TaUIManager.register("<%=id%>", new TaIssue("${id}",options));
            });
    }));


</script>