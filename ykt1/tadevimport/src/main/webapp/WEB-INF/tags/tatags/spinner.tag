<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='数字微调框' display-name='spinner' %>
<%@attribute description='组件id页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='组件的label标签,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"表示容器顶部向内占用10个像素' name='cssStyle' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='columnWidth' name='columnWidth' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>

<%@attribute description='true/false,设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台，默认为false' name='disabled' type='java.lang.String' %>
<%@attribute description='true/false,设置是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='true/false,设置为只读，默认为true只读' name='readOnly' type='java.lang.String' %>
<%@attribute description='输入框是否允许输入,true允许输入false不允许输入,只能通过箭头点击控制,默认true可以输入' name='isAllowInput' type='java.lang.String' %>
<%@attribute description='true/false,设置是否必输，默认false，设置后代小红星' name='required' type='java.lang.String' %>
<%@attribute name="toolTip" type="java.lang.String" rtexprvalue="true" description="必输提示"%>

<%@attribute description='初始化大小值' name='defValue' type='java.lang.String' %>
<%@attribute description='每次添加和减少的值' name='addValue' type='java.lang.String' %>
<%@attribute description='最大值' name='max' type='java.lang.String' %>
<%@attribute description='最小值' name='min' type='java.lang.String' %>
<%@attribute description='验证类型，如:require,url，email，ip，integer，number，maxLength,minLength,idcard，mobile，issue，chinese，zipcode，compare.可以多个验证同时验证
 格式//type 验证类型,//param ,传入参数比如maxLength传入参数param:["10"] 最大长度是10 ,如果有多个参数使用逗号隔开["10","20"]
 //msg:自定义验证失败提示信息,如果不写使用默认提示信息 msg:"自定义提示信息"
 validType=[{type:"url"},{type:"length",param:["0","10"]},{type:"email",msg:"自定义提示信息"},{type:"maxLength",param:[10],msg:"最大长度为10"},{type:"self",validateFn:"fnSelfValidate"]
  依次验证url,length,email,maxLength,自定义函数' name='validType' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%--废弃属性--%>
<%@attribute description='每次添加和减少的值value' name='value' type='java.lang.String' %>
<%@attribute description='readonly,下个版本弃用,建议使用readOnly' name='readonly' type='java.lang.String' %>
<%@attribute description='整个控件不可以使用' name='notUse' type='java.lang.String' %>
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
    String divLeft= null;
if (labelStyle != null) {
			String style = "";
			if (labelWidth != null) {
				style = "width:" + labelWidth + "px";
			}
			style = labelStyle + ";" + style;
			labelStyle = style;
			//addParameter("labelStyle", labelStyle);
			jspContext.setAttribute("labelStyle", labelStyle);
		} else {
			if (labelWidth != null) {
				//addParameter("labelStyle", "width:" + findString(labelWidth)+ "px");
				labelStyle="width:" + labelWidth+ "px";
				jspContext.setAttribute("labelStyle", "width:" + labelWidth+ "px");		
			}
		}
		if(labelWidth != null){
            divLeft  = Integer.valueOf(labelWidth)+32+"";
            jspContext.setAttribute("divLeft", divLeft);
        }

		if (null != cssClass) {
			cssClass = "spinner-layout-container "+ cssClass;//add by zzb
			//addParameter("cssClass", cssClass);
			jspContext.setAttribute("cssClass", cssClass);		
		} else {
			//addParameter("cssClass", "fielddiv");
			cssClass="spinner-layout-container";//add by zzb
			jspContext.setAttribute("cssClass", cssClass);	
			//System.out.println(jspContext.getAttribute("cssClass"));	
		}
		if ("false".equals(display) || "none".equals(display)) {
			if (cssStyle == null) {
				cssStyle = "display:none;";
			} else {
				cssStyle += ";display:none;";
			}
		}
		
		if ((id == null || id.length() == 0)) {

			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "taspinner_" + String.valueOf(nextInt);
			//addParameter("id", id);
			jspContext.setAttribute("id", id);
		}
		if (name == null || "".equals(name)) {
			name = "dto['" + id + "']";
			//addParameter("name", name);
			jspContext.setAttribute("name", name);
		}
		// 优先 查找resultBean
		IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
		if (resultBean != null) {
			Object v = resultBean.getFieldsData() == null ? null : resultBean
					.getFieldsData().get(id);
			if (v != null && !"".equals(v)) {
				value = v.toString();
			}
		}
		// 查找request
		if (value!= null && !"".equals(value)
				&& request.getAttribute(id) != null) {
			value = request.getAttribute(id).toString();
		}
		// 查找session
		if (value != null && !"".equals(value)
				&& request.getSession().getAttribute(id) != null) {
			value = request.getSession().getAttribute(id).toString();
		}
 %>
<%@include file="../columnhead.tag" %>
<div 
<%if(cssClass!=null){%>
class="${cssClass}" 
<%}%>
<%if(cssStyle!=null){%>
style="${cssStyle}" 
<%}%>
<%if(columnWidth!=null){%>
 columnWidth="${columnWidth}" 
<%}%>
<%if(span!=null){%>
span="${span}" 
<%}%>
> 
<%if(key!=null){%>
<label 
	 for="${id}" 
class="fieldLabel" 
	<%if(labelStyle!=null){%>
style="${labelStyle}" 
	<%}%>
>

${key} 
	</label> 
<%}%>
<div class="spinner-input-container"
	<% if (null != labelWidth) { %>
	style="margin-left:<%=divLeft%>px"
	<%}else if(null == key || "".equals(key.trim())) {%>
	style="margin-left:32px;"
	<%} %>
>
    <input type="number" id="${id}" name="${name}">
    <span class="spinner-ctr-up faceIcon icon-add2"></span>
    <span class="spinner-ctr-down faceIcon icon-reduce2"></span>
<script type="text/javascript">
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","numberSpinner"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
		
		Ta.core.TaUICreater.addUI( function(){
		    if(required_spinner){
		        required_spinner(function () {
                    var spinner = window.spinner;
                    var options = {
                        <%if(max!=null){%>
                        max: ${max},
                        <%}%>
                        <%if(min!=null){%>
                        min: ${min},
                        <%}%>
                        <%if(defValue!=null){%>
                        defValue: ${defValue},
                        <%}%>
                        <%if(addValue!=null){%>
                        addValue: ${addValue},
                        <%}%>
                        <%if(readonly!=null || readOnly!=null){%>
                        readOnly : (<%=readOnly%>||<%=readonly%>),
                    <%}%>
                    <% if(required!=null){%>
                    required:${required},
                    <%}%>
                    <% if(toolTip!=null){%>
                    toolTip:"${toolTip}",
                        <%}%>
                        <%if (disabled != null) {%>
                        disabled : <%=disabled%>,
                    <%}%>
                    <%if (isAllowInput != null) {%>
                    isAllowInput : <%=isAllowInput%>,
                    <%}%>
                    <%if (validType != null) {%>
                    validType : <%=validType%>,
                    <%}%>

                };
                    Ta.core.TaUIManager.register("${id}",new spinner("${id}",options));
                })
			}

 }); 
 }));
</script>	
</div>
</div>
<%@include file="../columnfoot.tag" %>