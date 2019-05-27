<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="org.owasp.esapi.ESAPI" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method" %>
<%@tag import="java.util.Random" %>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Map" %>
<%@tag import="java.util.ArrayList" %>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory" %>
<%@ tag import="com.yinhai.core.common.api.config.impl.SysConfig" %>


<%--@doc--%>
<%@tag description='文本框' display-name="text" %>
<%@attribute description='设置组件id，页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='设置组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='设置input元素的类型，如：password，text，file等，默认text' name='type' type='java.lang.String' %>
<%@attribute description='设置组件的label标签,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='设置组件有多含义时，构成下拉label的数据，keys为一json数组，由name和key组成，name表示提交表单时，提交的参数名，key表示name对应的label名称，例如:keys=“[{\"name\":\"username\",\"key\":\"姓名\"},{\"name\":\"loginid\",\"key\":\"账号\"}]”' name='keys' type='java.lang.String' %>
<%@attribute description='设置标签类型，是否长文本标签' name='isLongLabel' type='java.lang.String' %>
<%@attribute description='设置标签类型，是否长文本提示标签' name='isLongLabelTip' type='java.lang.String' %>
<%@attribute description='添加label描述自定义宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='添加label描述自定义样式，如:labelStyle="font-size:16px"' name='labelStyle' type='java.lang.String' %>
<%@attribute description='添加自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String' %>

<%@attribute description='设置组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='设置组件是否必录，默认false，设置后带小红星' name='required' type='java.lang.String' %>
<%@attribute description='设置组件显示到前台后是否需要Decoder，不影响传入后台是的encode' name='needDecode' type='java.lang.String' %>
<%@attribute description='设置组件是否只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置组件是否不可用，默认为可用，不可用时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>

<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>

<%@attribute description='onBlur事件，当失去焦点时调用，此处填写函数调用如onBlur="fnBlur(this)"' name='onBlur' type='java.lang.String' %>
<%@attribute description='onChange事件，当文本框值发生改变并失去焦点时调用，此处填写函数调用如onChange="fnChange(this)"' name='onChange' type='java.lang.String' %>
<%@attribute description='onClick事件，当单击控件时调用，此处填写函数调用如onClick="fnClick(this)"' name='onClick' type='java.lang.String' %>
<%@attribute description='点击放大镜,在该点击事件前发生，例如:popWinBeforeClick="fnPopWinBeforeClick",在js中,function fnPopWinBeforeClick(){return true},一定要有返回值,且只有返回true时才执行点击事件' name='popWinBeforeClick' type='java.lang.String' %>
<%@attribute description='onFocus事件，当控件获取焦点时，此处填写函数调用如onFocus="fnFocus(this)"' name='onFocus' type='java.lang.String' %>
<%@attribute description='onKeydown，当按下键盘是调用，此处填写函数调用如onKeydown="fnKeydown(this)"' name='onKeydown' type='java.lang.String' %>
<%@attribute description='验证类型，如:require,url，email，ip，integer，number，maxLength,minLength,idcard，mobile，issue，chinese，zipcode，compare.可以多个验证同时验证
 格式//type 验证类型,//param ,传入参数比如maxLength传入参数param:["10"] 最大长度是10 ,如果有多个参数使用逗号隔开["10","20"]
 //msg:自定义验证失败提示信息,如果不写使用默认提示信息 msg:"自定义提示信息"
 validType=[{type:"url"},{type:"length",param:["0","10"]},{type:"email",msg:"自定义提示信息"},{type:"maxLength",param:[10],msg:"最大长度为10"},{type:"self",validateFn:fnSelfValidate]
  依次验证url,length,email,maxLength,自定义函数' name='validType' type='java.lang.String' %>

<%@attribute description='设置是否显示放大镜按钮' name='popWin' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的url' name='popWinUrl' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的url传递参数，此方式为get方式传参' name='popParam' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的时传递的控件id（非容器id）,以逗号分开，此方式为get方式传参' name='popSubmitIds' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的方式，有parent，top，self，默认self，例如:popWinType="top"，此时弹出框将以top方式弹出' name='popWinType' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的宽度,例如:popWinWidth="800"' name='popWinWidth' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的高度,例如:popWinHeight="500"' name='popWinHeight' type='java.lang.String' %>
<%@attribute description='是否显示软键盘，默认false' name='softkeyboard' type='java.lang.String' %>

<%@attribute description='在输入框尾部显示一个可以按的图标按钮' name='clickIcon' type='java.lang.String' %>
<%@attribute description='在输入框尾部按钮的按钮事件' name='clickIconFn' type='java.lang.String' %>
<%@attribute description='鼠标移动到尾部按钮上给得提示信息' name='clickIconTitle' type='java.lang.String' %>
<%@attribute description='是否当鼠标指上单元格时，在指针右下角显示此单元格的全部内容。常用于单元格内容过多，导致单元格无法完全显示全部信息的情况' name='showDetailed' type='java.lang.String' %>
<%@attribute description='是否启用辅助输入，无中文时自动清除头尾空白，有中文时清除所有空白（值改变时触发）' name='isTrim' type='java.lang.String' %>
<%@attribute description='输入框脱敏，针对姓名，电话，身份证号，银行卡号这类敏感信息脱敏，参数为name,idcard,date,email,zipcode,telephone,mobile' name='sensitive' type='java.lang.String' %>

<%@attribute description='添加鼠标移过输入对象提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大宽度，默认300' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大高度，默认500' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='添加组件帮助说明信息。例如textHelp="该项选择性别，影响XXX计算"' name='textHelp' type='java.lang.String' %>
<%@attribute description='设置textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='设置textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%@attribute description='添加输入提示文字' name='placeholder' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>



<%@attribute  name='suggest'  description='true/false 是否显示为建议输入模式,默认false' type='java.lang.String' %>
<%@attribute  name='suggestOptions'  description='suggest模式下,提示框的参数,为json对象例如suggestOptions="{url:"test.do",}"' type='java.lang.String' %>




<%--@doc--%>
<%
	String inputLeft=labelWidth;//input左侧label的宽度
	if(keys != null){
		List<Map> list = JSonFactory.json2bean(keys,ArrayList.class);
		key = list.get(0).get("key").toString();
		jspContext.setAttribute("key",key);
		if(labelWidth!=null){
			inputLeft=(Integer.parseInt(labelWidth))+"";
			labelWidth=(Integer.parseInt(labelWidth)-36)+"";
		}else {
			inputLeft=labelWidth;
		}
	}



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
// 	SecurityUtil.checkFieldStatus(fieldsAuthorization,request, id);
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
if ((id == null || id.length() == 0)) {
	Random random = new Random();
	int nextInt = random.nextInt();
	nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math.abs(nextInt);
	id = "tatext_" + String.valueOf(nextInt);
}
if(name == null || "".equals(name)){
   	name = "dto['"+id+"']";
}
IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
if(resultBean != null){
	Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
	if(v !=null && !"".equals(v)){
	   value= v.toString();
	}
}
//查找request
if(value != null && !"".equals(value) && request.getAttribute(id) != null){
	value = request.getAttribute(id).toString();
}
//查找session
if(value != null && !"".equals(value) && request.getSession().getAttribute(id) != null){
	value = request.getSession().getAttribute(id).toString();
}
if(type == null){
	type = "text";
}

if(value != null && !"".equals(value)){
	/*value = TagUtil.replaceXSSTagValue(value);*/
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
class="text-layout-Container <%if(isLongLabel !=null){%> text-layout-Container-longLabel <%}else if(isLongLabelTip != null){%> text-layout-Container-longLabelTip <%}%>  <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
<% if(span!=null){%> span="${span}"<%}%>
<% if(toolTip != null){%> title= "${toolTip}"<%} %>
> 
	<% if(key!=null && !"".equals(key.trim())){%>
		<label for="<%=id %>" class="text-label <%if(isLongLabel !=null){%> text-label-longLabel <%}else if(isLongLabelTip != null){%> text-label-longLabelTip <%}%> "
			style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
		>
			${key}
		</label>
	<%} %>
	<div class="text-input-Container <%if(isLongLabel !=null){%> text-input-Container-longLabel <%}else if(isLongLabelTip != null){%> text-input-Container-longLabelTip <%}%>"
	<% if (null != labelWidth) {%>
		style="margin-left:<%=inputLeft%>px"
	<%}else if(null == key || "".equals(key.trim())) {%>
		style="margin-left:0px;"
	<%} %>
>
<% if(isLongLabelTip != null) {%>
		<label>输入区|</label>
<%}%>
<input type="<%=type %>"
<% if(id!=null){%>
id="<%=id %>" 
<%}%>
<% if(name!=null){%>
name="<%=name %>" 
<%}%>
<% if(placeholder!=null){%>
placeholder="<%=placeholder %>" 
<%}%>
class="text-input <%if(isLongLabel !=null){%> text-input-longLabel <%}else if(isLongLabelTip != null){%> text-input-longLabelTip <%}%> <%if(sensitive!=null){%> sensitiveField <%}%>"
<% if(cssInput!=null){%>
style="${cssInput}" 
<%}%>
>
		<span class="faceIcon validateIcon"></span>
		<% if("true".equals(popWin)){ %>
			<span class="faceIcon icon-search textIcon textLongTimeIcon textPopIcon" ></span>
		<% } %>
		<% if (clickIcon != null) { %>
			<span class="faceIcon ${clickIcon} textIcon textLongTimeIcon" title="${clickIconTitle}" onClick="${clickIconFn}"></span>
		<% } %>
		<% if("true".equals(softkeyboard)){%>
			<span class="faceIcon icon-jianpan textIcon textLongTimeIcon textSoftKeyboardIcon" ></span>
		<%}%>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container"></div>
		<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag" %>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","text"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
Ta.core.TaUICreater.addUI(
	function(){
        var options = {
            <% if(needDecode!=null){%>
            required:${needDecode},
            <%}%>
            <%if (key!=null) {%>
            key: "${key}",
            <%}%>
            <%if (keys!=null) {%>
            keys: ${keys},
            <%}%>
            <%if (popWin!=null) {%>
            popWinFn: ${popWin},
            <%}%>
            <%if (popWinBeforeClick!=null) {%>
            popWinBeforeClick: ${popWinBeforeClick},
            <%}%>
            <%if (popParam!=null) {%>
            popParam: ${popParam},
            <%}%>
            <%if (popSubmitIds!=null) {%>
            popSubmitIds: "${popSubmitIds}",
            <%}%>
            <%if (popWinUrl!=null) {%>
            popWinUrl: "${popWinUrl}",
            <%}%>
            <%if (popWinWidth!=null) {%>
            popWinWidth: "${popWinWidth}",
            <%}%>
            <%if (popWinHeight!=null) {%>
            popWinHeight: "${popWinHeight}",
            <%}%>
            <%if (popWinType!=null) {%>
            popWinType: "${popWinType}",
            <%}%>
            <%if (placeholder != null) {%>
            placeholder: "${placeholder}",
            <%}%>
            <%if (softkeyboard!=null) {%>
            softkeyboard: ${softkeyboard},
            <%}%>
            <%if (textHelp != null) {%>
            textHelp: "${textHelp}",
            <%}%>
            <%if (textHelpWidth != null) {%>
            textHelpWidth: "${textHelpWidth}",
            <%}%>
            <%if (textHelpPosition != null) {%>
            textHelpPosition: "${textHelpPosition}",
            <%}%>
            <%if (value != null) {%>
            value: '<%=value%>',
            <%}%>
            <%if (readOnly != null) {%>
            readOnly: <%=readOnly%>,
            <%}%>
            <%if (disabled != null) {%>
            disabled: <%=disabled%>,
            <%}%>
            <%if (showDetailed != null) {%>
            showDetailed: ${showDetailed},
            <%}%>
            <%if (isTrim != null) {%>
            isTrim: ${isTrim},
            <%}%>
            <%if (sensitive != null){%>
            sensitive: "${sensitive}",
            <%}%>
            <%if(onClick!=null){%>
            onClick: "${onClick}",
            <%}%>
            <% if(onChange!=null){%>
            onChange: "${onChange}",
            <%}%>
            <% if(onKeydown!=null){%>
            onKeydown: "${onKeydown}",
            <%}%>
            <% if(onBlur!=null){%>
            onBlur: "${onBlur}",
            <%}%>
            <% if(onFocus!=null){%>
            onFocus: "${onFocus}",
            <%}%>
            <% if(required!=null){%>
            required:${required},
            <%}%>
            <% if(toolTip!=null){%>
            toolTip: "${toolTip}",
            <%}%>
            <% if(bpopTipMsg!=null){%>
            bpopTipMsg: "${bpopTipMsg}",
            <%}%>
            <% if(bpopTipWidth!=null){%>
            bpopTipWidth: "${bpopTipWidth}",
            <%}%>
            <% if(bpopTipHeight!=null){%>
            bpopTipHeight: "${bpopTipHeight}",
            <%}%>
            <% if(bpopTipPosition!=null){%>
            bpopTipPosition: "${bpopTipPosition}",
            <%}%>
            <% if(validType!=null){%>
            validType:${validType}
            <%}%>
        };
        Ta.core.TaUIManager.register("${id}", new TaText("${id}", options));
        //添加suggest  add by cy
        <% if("true".equals(suggest)){%>
        if (required_suggest) {
            required_suggest(function () {
                var sg_op={};
                sg_op=$.extend(sg_op,${suggestOptions});
                var sg = new TaSuggest($("#${id}"), sg_op);
                Ta.core.TaUIManager.register("${id}_suggest", sg);
                sg.suggest();
            })
        }
        <%}%>


});
}));
</script>