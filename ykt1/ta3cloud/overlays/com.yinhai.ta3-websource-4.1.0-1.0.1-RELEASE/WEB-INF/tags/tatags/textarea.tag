<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="org.owasp.esapi.ESAPI"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random" %>
<%@ tag import="com.yinhai.core.common.api.config.impl.SysConfig" %>

<%--@doc--%>
<%@tag description='富文本框' display-name='textarea' %>
<%@attribute description='组件id' name='id' required='true' type='java.lang.String' %>
<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='组件的label标签' name='key' type='java.lang.String' %>
<%@attribute description='是否长文本标签,true/false' name='isLongLabel' type='java.lang.String' %>
<%@attribute description='是否长文本提示标签,true/false' name='isLongLabelTip' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>

<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='设置textarea的高度,例如:height="200",不要加px' name='height' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>

<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='设置是否必输' name='required' type='java.lang.String' %>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='验证类型，如:require,url，email，ip，integer，number，maxLength,minLength,idcard，mobile，issue，chinese，zipcode，compare.可以多个验证同时验证
 格式//type 验证类型,//param ,传入参数比如maxLength传入参数param:["10"] 最大长度是10 ,如果有多个参数使用逗号隔开["10","20"]
 //msg:自定义验证失败提示信息,如果不写使用默认提示信息 msg:"自定义提示信息"
 validType=[{type:"url"},{type:"length",param:["0","10"]},{type:"email",msg:"自定义提示信息"},{type:"maxLength",param:[10],msg:"最大长度为10"},{type:"self",validateFn:"fnSelfValidate"]
  依次验证url,length,email,maxLength,自定义函数' name='validType' type='java.lang.String' %>

<%@attribute description='onBlur' name='onBlur' type='java.lang.String' %>
<%@attribute description='onChange' name='onChange' type='java.lang.String' %>
<%@attribute description='onClick' name='onClick' type='java.lang.String' %>
<%@attribute description='onFocus' name='onFocus' type='java.lang.String' %>
<%@attribute description='onKeydown' name='onKeydown' type='java.lang.String' %>
<%@attribute description='onMouseover' name='onMouseover' type='java.lang.String' %>
<%@attribute description='onMouseout' name='onMouseout' type='java.lang.String' %>

<%@attribute description='required情况下提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='添加输入提示文字' name='placeholder' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='设置组件显示到前台后是否需要Decoder，不影响传入后台是的encode' name='needDecode' type='java.lang.String' %>

<%--弃用的属性--%>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='inputClass' type='java.lang.String' %>
<%@attribute description='最大字符数' name='maxLength' type='java.lang.String' %>
<%@attribute description='最小字符数' name='minLength' type='java.lang.String' %>


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

	String tcssStyle = "";
	String divHeight = "";
	//存在label文字时计算容器高度
	if(key != null){
		if(height == "" || height == null){
			height ="64";
		}
		divHeight = height+"px";
		if(isLongLabel !=null){
			tcssStyle = "height:" + (Integer.valueOf(height)+32) + "px;";
		}else if(isLongLabelTip !=null){
			tcssStyle = "height:" + (Integer.valueOf(height)+9) + "px;" + "padding-top: 9px;";
		}else {
			tcssStyle = "height:" + height + "px;";
		}
	}
	jspContext.setAttribute("divHeight",divHeight);
	if(cssStyle!=null){
		cssStyle = tcssStyle + cssStyle;
	}else{
		cssStyle = tcssStyle;
	}
	jspContext.setAttribute("cssStyle",cssStyle);

	if ((id == null || id.length() == 0)){
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math.abs(nextInt);
		id = "tatext_" + String.valueOf(nextInt);
		jspContext.setAttribute("id",id);
	}
	if (name == null || "".equals(name)){
		name = "dto['" + id + "']";
		jspContext.setAttribute("name",name);
	}
	// 优先 查找resultBean
	IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
	if(resultBean != null){
		Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
		if(v !=null && !"".equals(v)){
			value= v.toString();
		}
	}
	// 查找request
	if (value != null && !"".equals(value) && request.getAttribute(id) != null){
		value = request.getAttribute(id).toString();
	}
	// 查找session
	if (value != null && !"".equals(value) && request.getSession().getAttribute(id) != null){
		value = request.getSession().getAttribute(id).toString();
	}
	if (value != null && !"".equals(value)){
		jspContext.setAttribute("value",value);
	}
	if(value != null && !"".equals(value)){
		if(SysConfig.getSysConfigToBoolean("isXSSFilter",false)){
			if (needDecode=="true") {
				value = ESAPI.encoder().decodeForHTML(ESAPI.encoder().decodeForHTML(value));
			} else {
				value = ESAPI.encoder().encodeForHTML(value);
			}
		}
	}
%>



<%@include file="../columnhead.tag" %>

<div
	class="textarea-layout-Container <%if(isLongLabel !=null){%> textarea-layout-Container-longLabel <%}else if(isLongLabelTip != null){%> textarea-layout-Container-longLabelTip <%}%>  <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
	style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%> "
	<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if(span!=null){%> span="${span}"<%}%>
	<% if(toolTip != null){%> title= "${toolTip}"<%} %>
>
	<%if( key!=null && !"".equals(key.trim())){%>
	<label for="<%=id %>" class="textarea-label <%if(isLongLabel !=null){%> textarea-label-longLabel <%}else if(isLongLabelTip != null){%> textarea-label-longLabelTip <%}%> "
		style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
	>
		${key}
	</label>
	<%}%>
	<div class="textarea-input-Container <%if(isLongLabel !=null){%> textarea-input-Container-longLabel <%}else if(isLongLabelTip != null){%> textarea-input-Container-longLabelTip <%}%>"
		<% if (null != labelWidth) {%>
		style="margin-left:<%=labelWidth%>px;height: <%=divHeight%>; "
		<%}else if(null == key || "".equals(key.trim())) {%>
		style="margin-left:0px;height: <%=divHeight%>;"
		<%}else {%>
		style="height: <%=divHeight%>;"
		<%} %>
	>
	<textarea
        <%if( id!=null){%>
        id="${id}"
        <%}%>
        <%if( height!=null){%>
        style="height: 100%;width:100%;"
        <%}%>
        <%if( name!=null){%>
        name="${name}"
        <%}%>
			<% if(placeholder!=null){%>
		placeholder="<%=placeholder %>"
			<%}%>
		class="textarea-input <%if(isLongLabel !=null){%> textarea-input-longLabel <%}else if(isLongLabelTip != null){%> textarea-input-longLabelTip <%}%>"
		<% if(inputClass!=null){%>
		style="${inputClass}"
		<%}%>
        <%if( maxLength!=null){%>
        maxLength="${maxLength}"
        validType="length[0,${maxLength}]"
        <%}%>
        ></textarea>
	</div>
</div>
<script type="text/javascript">
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager","text"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                var TaTextarea = window.TaTextarea;
                var options={
                    <%if (value != null) {%>
                    value : '<%=value%>',
                    <%}%>
                    <%if (readOnly != null) {%>
                    readOnly : <%=readOnly%>,
                    <%}%>
                    <%if (disabled != null) {%>
                    disabled : <%=disabled%>,
                    <%}%>
                    <% if(required!=null){%>
                    required:${required},
                    <%}%>
					<% if(toolTip!=null){%>
					toolTip:"${toolTip}",
					<%}%>
					<% if(validType!=null){%>
					validType:${validType},
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
                    <%if(onClick!=null){%>
                    onClick:"${onClick}",
                    <%}%>
                    <% if(onChange!=null){%>
                    onChange:"${onChange}",
                    <%}%>
                    <% if(onKeydown!=null){%>
                    onKeydown:"${onKeydown}",
                    <%}%>
                    <% if(onBlur!=null){%>
                    onBlur:"${onBlur}",
                    <%}%>
                    <% if(onFocus!=null){%>
                    onFocus:"${onFocus}",
                    <%}%>
                	<% if(onMouseover!=null){%>
                    onMouseover:"${onMouseover}",
                    <%}%>
                	<% if(onMouseout!=null){%>
                    onMouseout:"${onMouseout}",
                    <%}%>
                    <%if (placeholder != null) {%>
                    placeholder : "${placeholder}",
                    <%}%>
                };
                Ta.core.TaUIManager.register("${id}",new TaTextarea("${id}",options));
            });
    }));
</script>
<%@include file="../columnfoot.tag" %>