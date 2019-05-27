<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="org.owasp.esapi.ESAPI"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@ tag import="java.util.Random" %>
<%@ tag import="com.yinhai.core.common.api.config.impl.SysConfig" %>

<%-- @doc --%>
<%@tag description='数字输入框' display-name="number"%>
<%@attribute name="id" type="java.lang.String" rtexprvalue="true" required="true" description="组件id页面唯一"%>
<%@attribute name="key" type="java.lang.String" rtexprvalue="true" description="组件的label标签,不支持html标签 "%>
<%@attribute name="name" type="java.lang.String" rtexprvalue="true" description="组件的name属性，一般可以不设置，系统会根据id自动生成类似dto['id']这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据"%>
<%@attribute name="span" type="java.lang.String" rtexprvalue="true" description="当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span='2'表示跨两列 "%>
<%@attribute name="columnWidth" type="java.lang.String" rtexprvalue="true" description="设置layout为column布局的时候自定义占用容器行宽度百分比，可设置值为0-1之间的小数，如:0.1则表示占该行的1/10"%>
<%@attribute name="cssClass" type="java.lang.String" rtexprvalue="true" description="给该组件添加自定义样式class，如:cssClass='no-padding'"%>
<%@attribute name="cssStyle" type="java.lang.String" rtexprvalue="true" description="给该组件添加自定义样式，如:cssStyle='padding-top:10px'表示容器顶部向内占用10个像素"%>
<%@attribute name="cssInput" type="java.lang.String" rtexprvalue="true" description="单独设置input元素的css样式,例如:cssInput='font-size:20px;color:red'"%>
<%@attribute name="labelWidth" type="java.lang.String" rtexprvalue="true" description="label及key占的宽度，如labelWidth='120'"%>
<%@attribute name="labelStyle" type="java.lang.String" rtexprvalue="true" description="label自定义样式"%>
<%@attribute name="alignLeft" type="java.lang.String" rtexprvalue="true" description="=true/false,设置数字是否居左显示。默认为false居右"%>

<%@attribute name="onClick" type="java.lang.String" rtexprvalue="true" description="onClick事件，当单击控件时调用，此处填写函数调用如onClick='fnClick(this)'"%>
<%@attribute name="onChange" type="java.lang.String" rtexprvalue="true" description="onChange事件，当onChange值改变时调用，此处填写函数调用如onChange='fnChange(this)'"%>
<%@attribute name="onFocus" type="java.lang.String" rtexprvalue="true" description="onFocus事件，当控件获取焦点时，此处填写函数调用如onFocus='fnFocus(this)'"%>
<%@attribute name="onBlur" type="java.lang.String" rtexprvalue="true" description="onBlur事件，当失去焦点时调用，此处填写函数调用如onBlur='fnBlur(this)'"%>
<%@attribute name="onKeydown" type="java.lang.String" rtexprvalue="true" description="onKeydown，当按下键盘是调用，此处填写函数调用如onKeydown='fnKeydown(this)'"%>

<%@attribute name="disabled" type="java.lang.String" rtexprvalue="true" description="true/false,设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台，默认为false"%>
<%@attribute name="readOnly" type="java.lang.String" rtexprvalue="true" description="true/false,设置为只读，默认为false"%>
<%@attribute name="required" type="java.lang.String" rtexprvalue="true" description="true/false,设置是否必输，默认false，设置后代小红星"%>
<%@attribute name="display" type="java.lang.String" rtexprvalue="true" description="true/false,设置是否显示，默认为显示:true"%>
<%@attribute name="value" type="java.lang.String" rtexprvalue="true" description="组件页面初始化的时候的默认值"%>
<%@attribute name="precision" type="java.lang.String" rtexprvalue="true" description="小数位数，如precision='2',默认小数位为0"%>
<%@attribute name="asAamount" type="java.lang.String" rtexprvalue="true" description="true/false,设置数字显示为金额，每三位用逗号隔开。默认为false"%>
<%@attribute name="amountPre" type="java.lang.String" rtexprvalue="true" description="String,当asAamount设置为true的时候可以设置金额前面追加的符号，比如amountPre='￥'或amountPre='$'等"%>
<%@attribute name="numberRound" type="java.lang.String" rtexprvalue="true" description="true/false,当numberRound设置为true时表示四舍五入,false表示不四舍五入,默认false"%>
<%@attribute name="max" type="java.lang.String" rtexprvalue="true" description="最大值"%>
<%@attribute name="min" type="java.lang.String" rtexprvalue="true" description="最小值 "%>
<%@attribute name="softkeyboard" type="java.lang.String" rtexprvalue="true" description="是否显示软键盘"%>

<%@attribute name="toolTip" type="java.lang.String" rtexprvalue="true" description="必输提示"%>
<%@attribute name='placeholder' description='提示文字' type='java.lang.String'%>
<%@attribute name="bpopTipMsg" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本 "%>
<%@attribute name="bpopTipWidth" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小"%>
<%@attribute name="bpopTipHeight" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小"%>
<%@attribute name="bpopTipPosition" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top"%>
<%@attribute name='textHelp' description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' type='java.lang.String'%>
<%@attribute name='textHelpWidth' description='textHelp宽度，默认200。例如textHelpWidth="200"' type='java.lang.String'%>
<%@attribute name='textHelpPosition' description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' type='java.lang.String'%>
<%@attribute name='fieldsAuthorization' description='是否需要权限控制' type='java.lang.String' %>
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

  if ((id == null || id.length() == 0)) {
     Random random = new Random();
	 int nextInt = random.nextInt();
	 nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math.abs(nextInt);
	 id = "tanumber_" + String.valueOf(nextInt);
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

  String validType = null;
  if(null != max && null != min){
	 validType = "number['"+ min+"','"+max+"']";
  }
  else if(null == max && null != min){
	 validType = "number["+ min+",'']";
  }
  else if(null != max && null == min){
	 validType = "number['',"+ max+"]";
  }else{
	 validType = "number";
  }
   
	if(value != null && !"".equals(value)){
		if(SysConfig.getSysConfigToBoolean("isXSSFilter",false)){
			value = ESAPI.encoder().encodeForHTML(value);
		}
	}
%>

<%@include file="../columnhead.tag" %>
<div class="number-layout-div <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
		<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
		<% if(span!=null){%> span="${span}"<%}%>
		<% if(toolTip != null){%> title="${toolTip}" <%}%>
> 
	<% if (key != null && !"".equals(key.trim())){%>
		<label for="<%=id %>" class="number-label"
			   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
		>
		${key}
		</label>
	<%} %>

<div class="number-input-div <% if("true".equals(softkeyboard)){%>softkeyboard-div <%}%>"
		<% if (null != labelWidth) {%>
	 style="margin-left:<%=labelWidth%>px"
		<%}else if(null == key || "".equals(key.trim())) {%>
	 style="margin-left:0px;"
		<%} %>
>
	<input type="text"
		   id="<%=id %>"
		   name="<%=name %>"
		<% if(placeholder!=null){%>
		   placeholder="<%=placeholder %>"
		<%}%>
		<% if ("true".equals(required)){%>
		   required="${required}"
		<%}%>
		   class="number-input numberfield <%if(asAamount != null){%> amountfield <%}%>"
		   validType="<%=validType %>"
		   style="<% if (cssInput != null){%>  ${cssInput}; <%}%> <%if("true".equals(alignLeft)){%> text-align: left; <%}%>"
		>
	<span class="faceIcon validateIcon"></span>
	<% if("true".equals(softkeyboard)){%>
		<span class="faceIcon icon-jianpan numberIcon numberLongTimeIcon numberSoftKeyboardIcon" ></span>
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
		require(["TaUIManager","number"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(
	function(){
		  var options = {
			  <%if (softkeyboard != null) {%>
			  	softkeyboard : ${softkeyboard},
			  <%}%>
			  <%if (placeholder != null) {%>
			  	placeholder : "${placeholder}",
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
              <%if (precision != null) {%>
              	precision : ${precision},
              <%}%>
              <%if (numberRound != null) {%>
              	numberRound : ${numberRound},
              <%}%>
              <%if (asAamount != null) {%>
              	asAamount : ${asAamount},
              <%}%>
              <%if (amountPre != null) {%>
              	amountPre : "${amountPre}",
              <%}%>
              <%if (min != null) {%>
              	min : ${min},
              <%}%>
              <%if (max != null) {%>
              	max : ${max},
              <%}%>
              <%if (value != null) {%>
              	value : <%=value%>,
              <%}%>
              <%if (disabled != null) {%>
              	disabled : <%=disabled%>,
              <%}%>
              <%if (readOnly != null) {%>
              	readOnly : <%=readOnly%>,
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
              <% if(required!=null){%>
              required:${required},
              <%}%>
              <% if(toolTip!=null){%>
              toolTip:"${toolTip}",
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
              bpopTipPosition:"${bpopTipPosition}"
              <%}%>

		  };
	  Ta.core.TaUIManager.register("<%=id%>",new TaNumber("${id}",options));
	}


 )}));
</script>