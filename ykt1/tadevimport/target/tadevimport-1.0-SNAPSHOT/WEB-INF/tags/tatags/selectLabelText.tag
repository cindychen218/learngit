<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="org.owasp.esapi.ESAPI"%>
<%@tag import="java.util.ArrayList"%>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Map" %>
<%@tag import="java.util.Random" %>
<%@ tag import="com.yinhai.core.common.api.config.impl.SysConfig" %>

<%--@doc--%>
<%@tag description='可选择label文本框' display-name="selectLabelText" %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>
<%@attribute description='当required属性为true时，设置默认错误提示信息' name='toolTip' type='java.lang.String' %>
<%@attribute description='构成下拉label的数据，必输，keys为一json数组，由id和key组成，id表示提交表单时，需要提交的字段，key表示id对应的label名称，例如:keys=“[{\"id\":\"username\",\"key\":\"姓名\"},{\"id\":\"loginid\",\"key\":\"账号\"}]”' name='keys' type='java.lang.String'  required="true"%>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='onBlur事件，当失去焦点时调用，此处填写函数调用如onBlur="fnBlur(this)"' name='onBlur' type='java.lang.String' %>
<%@attribute description='onChange事件，当onChange值改变时调用，此处填写函数调用如onChange="fnChange(this)"' name='onChange' type='java.lang.String' %>
<%@attribute description='onClick事件，当单击控件时调用，此处填写函数调用如onClick="fnClick(this)"' name='onClick' type='java.lang.String' %>
<%@attribute description='点击放大镜,在该点击事件前发生，例如:popWinBeforeClick="fnPopWinBeforeClick",在js中,function fnPopWinBeforeClick(){return true},一定要有返回值,且只有返回true时才执行点击事件' name='popWinBeforeClick' type='java.lang.String' %>
<%@attribute description='onFocus事件，当控件获取焦点时，此处填写函数调用如onFocus="fnFocus(this)"' name='onFocus' type='java.lang.String' %>
<%@attribute description='onKeydown，当按下键盘是调用，此处填写函数调用如onKeydown="fnKeydown(this)"' name='onKeydown' type='java.lang.String' %>
<%@attribute description='true/false,设置是否必输，默认false，设置后代小红星' name='required' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='验证类型，如:url，email，ip，integer，number，idcard，mobile，issue，chinese，zipcode，compare' name='validType' type='java.lang.String' %>
<%@attribute description='自定义验证,validType属性必须设置成self才会生效,validFunction为回调函数，例如validFunction=“fnSelfValidate”，在js中必须返回一个形如：{"message":"只能为数字","result":false}的json对象，message表示验证失败提示信息，result表示是否通过验证' name='validFunction' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='最大字符数' name='maxLength' type='java.lang.String' %>
<%@attribute description='最小字符数' name='minLength' type='java.lang.String' %>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='可以设置input元素的类型，如：password，text，file等，默认text' name='type' type='java.lang.String' %>
<%@attribute description='单独设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String' %>
<%@attribute description='设置是否显示放大镜按钮' name='popWin' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的url' name='popWinUrl' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的url传递参数，此方式为get方式传参' name='popParam' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的时传递的控件id（非容器id）,以逗号分开，此方式为get方式传参' name='popSubmitIds' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的方式，有parent，top，self，默认self，例如:popWinType="top"，此时弹出框将以top方式弹出' name='popWinType' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的宽度,例如:popWinWidth="800"' name='popWinWidth' type='java.lang.String' %>
<%@attribute description='点击放大镜按钮后弹出win的高度,例如:popWinHeight="500"' name='popWinHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='是否显示软键盘' name='softkeyboard' type='java.lang.String' %>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%@attribute description='提示文字' name='placeholder' type='java.lang.String' %>
<%--@doc--%>
<%
	
List<Map> list = JSonFactory.json2bean(keys,ArrayList.class);
jspContext.setAttribute("keys", list);
String key = list.get(0).get("key").toString();
jspContext.setAttribute("key",key);
String id = list.get(0).get("id").toString();
jspContext.setAttribute("id",id);
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
	}
}

if(null != cssClass){
	cssClass = "fielddiv fielddiv_163 "+cssClass;
}else{
	cssClass = "fielddiv fielddiv_163";
}

if("false".equals(display) || "none".equals(display)){
   	if(cssStyle ==null){
   		cssStyle = "display:none;";
   	}else{
   		cssStyle += ";display:none;";
   	}
}
if(validType == null || "length".equals(validType))
{
	if(null != maxLength && null != minLength)
	{
		validType="length["+ minLength+","+maxLength+"]";
	}
	else if(null == maxLength && null != minLength)
	{
		validType="length["+ minLength+",9999]";
	}
	else if(null != maxLength && null == minLength)
	{
		validType="length[0,"+maxLength+"]";
	}
}
String inputStyle="textinput";
if(readOnly != null && !"false".equals(readOnly)){
	inputStyle +=" readonly";
}
if(disabled !=null && !"false".equals(disabled)){
	inputStyle +=" disabled";
}
if(type == null){
	type = "text";
}

if(value != null && !"".equals(value)){
	if(SysConfig.getSysConfigToBoolean("isXSSFilter",false)){
		value = ESAPI.encoder().encodeForHTML(value);
	}
}

String textHelpStyle="";
if(textHelpWidth != null){
	String temp = "";
	if(textHelpWidth.endsWith("px")){
		temp = textHelpWidth.substring(0,textHelpWidth.length()-2);
	}else{
		temp = textHelpWidth;
	}
	if("bottomRight".equals(textHelpPosition) || "topRight".equals(textHelpPosition)){
		textHelpStyle += "width:"+temp+"px;";
	}else{
		textHelpStyle += "width:"+temp+"px;left:-"+(Integer.valueOf(temp)+10)+"px;";
	}
}else{
	if("bottomRight".equals(textHelpPosition) || "topRight".equals(textHelpPosition)){
		textHelpStyle += "width:200px;";
	}else{
		textHelpStyle += "width:200px;left:-210px;";
	}
}
%>
<%@include file="../columnhead.tag" %>
<div 
<% if(cssClass!=null){%>
class="<%=cssClass%>" 
<%}%>
<% if(cssStyle!=null){%>
style="<%=cssStyle%>" 
<%}%>
<% if(columnWidth!=null){%>
columnWidth="${columnWidth}" 
<%}%>
<% if(span!=null){%>
span="${span}" 
<%}%>
> 
<div style="position: relative;height:28px; float:left;<%if(labelWidth!=null){%>width:<%=labelWidth%>px;<%}else{%>width:100px;<%}%>">
	<div class="selectLabelText_label" id="selectLabelTextLabelClick_<%=id%>">
		<%if(required != null && "true".equals(required)){ %>
		<span style="height:28px; float:left;line-height: 28px;color:red">*</span>
		<%} %>
		<span class="selectLabelText_label_span" id="selectLabelText_label_span_<%=id%>"><%=key%> </span>
	</div>
	<div class="selectLabelText_C" >
	<%
	for(int i = 1 ; i < list.size(); i++){
	%>
	<div class="selectLabelClick" _id="<%=list.get(i).get("id")%>"><%=list.get(i).get("key") %></div>
	<%
	}
	 %>
	</div>
</div>
	<%
	if(readOnly != null && !"false".equals(readOnly)){
	%>
	<div class="fielddiv2 readonly" 
	<%
	}else if(disabled !=null && !"false".equals(disabled)){%>
	<div class="fielddiv2 disabled"
	<%}else{ %>
	<div class="fielddiv2" 
	<%} %>
	<% if(labelWidth!=null){%>
	style="margin-left:${labelWidth}px" 
	<%}%>
> 
<% if(popWin!=null && !"false".equals(popWin)){%>
<span class="innerIcon popWin_163" id="fn_<%=id %>"></span>
<%}%>
<%-- <% if(softkeyboard!=null){%> --%>
<%-- <span class="softkeyboard" id="softkeyboard_<%=id %>"></span> --%>
<%-- <%}%> --%>
		<input type="<%=type %>" 
<% if(id!=null){%>
id="<%=id %>" 
<%}%>
<%if (toolTip != null) {%>
toolTip = "${toolTip}"
<%} %>
<% if(name!=null){%>
name="<%=name %>" 
<%}%>
<% if(value!=null){%>
value="<%=value %>" 
<%}%>
<% if(placeholder!=null){%>
placeholder="<%=placeholder %>" 
<%}%>
<% if(readOnly!=null && !"false".equals(readOnly)){%>
readOnly="${readOnly}" 
<%}%>
<% if(disabled!=null && !"false".equals(disabled)){%>
disabled="${disabled}" 
<%}%>
<% if(required!=null){%>
required="${required}" 
<%}%>
class="<%=inputStyle%>" 
<% if(validType!=null){%>
validType="<%=validType%>" 
<%}%>
<% if(validFunction!=null){%>
validFunction="<%=validFunction%>" 
<%}%>
<% if(maxLength!=null){%>
maxLength="${maxLength}" 
<%}%>
<% if(onClick!=null){%>
onClick="${onClick}" 
<%}%>
<% if(onChange!=null){%>
onChange="${onChange}" 
<%}%>
<% if(onKeydown!=null){%>
onKeydown="${onKeydown}" 
<%}%>
<% if(onBlur!=null){%>
onBlur="${onBlur}" 
<%}%>
<% if(onFocus!=null){%>
onFocus="${onFocus}" 
<%}%>
<% if(cssInput!=null){%>
style="${cssInput}" 
<%}%>
>
<%if(textHelp != null){ %>
<div class="textInfo">
	<div class="textInfo_content ffb_163
	 <%if(textHelpPosition != null)%>${textHelpPosition}" style="<%=textHelpStyle%>">${textHelp}</div>
</div>
<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag" %>

<script>
(function(factory){
	if (typeof require === 'function') {
	    
		require(["jquery","TaUIManager","selectLabelText"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI( function(){
	  var taSelectLabelText = window.selectLabelText;
	  var options = {
			selectLabelTextId:"<%=id%>",
			<%if (popWin!=null && !"false".equals(popWin)) {%>
				popWinFn : true ,
			<%}%>
			<%if (popWinBeforeClick!=null) {%>
				popWinBeforeClick : "${popWinBeforeClick}",
			<%}%>
			<%if (popParam!=null) {%>
				popParam : ${popParam} ,
			<%}%>
			<%if (key!=null) {%>
				key : "${key}" ,
			<%}%>
			<%if (popSubmitIds!=null) {%>
				popSubmitIds : "${popSubmitIds}" ,
			<%}%>
			<%if (popWinUrl!=null) {%>
				popWinUrl : "${popWinUrl}" ,
			<%}%>
			<%if (popWinWidth!=null) {%>
				popWinWidth : "${popWinWidth}" ,
			<%}%>
			<%if (popWinHeight!=null) {%>
				popWinHeight : "${popWinHeight}" ,
			<%}%>
			<%if (popWinType!=null) {%>
				popWinType : "${popWinType}" ,
			<%}%>
			<%if (softkeyboard != null && "true".equals(softkeyboard)) {%>
			softkeyboard : "${softkeyboard}", 
			<%}%>
			<%if (placeholder != null) {%>
			placeholder : "${placeholder}", 
			<%}%>
			<%if ("topLeft".equals(textHelpPosition) || "topRight".equals(textHelpPosition)) {%>
			textPosition : "true"
			<%}%>
	   	};
	  Ta.core.TaUIManager.register("<%=id%>",new taSelectLabelText("${id}",options));
	 });
}));
</script>