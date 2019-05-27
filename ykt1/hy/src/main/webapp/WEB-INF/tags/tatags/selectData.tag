
<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag description='下拉框选择数据后，显示在指定位置，可多选，可删除，类似下拉框功能' display-name="selectData" %>
<%@attribute description='设置组件id，页内唯一，查询获取当前输入内容的标识和参数名称' name='id' type='java.lang.String'  required="true"%>
<%@attribute description='设置组件的提交到后台的参数名称，如果可以多选，则提交的是一个以hiddenValue组成的以“,”号隔开的字符串，后台dto中可取出其值。不同于一般组件，id和name标识的是同一个input，可以省略name属性，该组件name属性是必须的，这是由于该组件符合显示输入框与真实值输入框分离的情况，且用户需要知道如何区分它们以便在查询、保存时获取对应的值，例如name=‘managers’'  name='name' type='java.lang.String'  required="true"%>
<%@attribute description='设置组件的label描述,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='添加label描述自定义宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='添加label描述自定义样式，如:labelStyle="font-size:16px"' name='labelStyle' type='java.lang.String' %>
<%@attribute description='添加自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>

<%@attribute description='设置组件页面初始化的时候的默认值,如:{id:"",name:""}' name='value' type='java.lang.String' %>
<%@attribute description='设置组件是否必录，默认false，设置后带小红星' name='required' type='java.lang.String' %>
<%@attribute description='设置组件是否只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置组件是否不可用，默认为可用，不可用时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>

<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>

<%@attribute description='设置输入多少个字符时开始查询，默认两个字符，如需修改，请将该值设置成大于0的数字，例如：inputQueryNum=‘3’' name='inputQueryNum' type='java.lang.Integer' %>
<%@attribute description='设置是否能多选，默认false，表示不能多选' name='multiple' type='java.lang.String' %>
<%@attribute description='指定查询url，该url返回一个形如[{‘orgid’：‘1’，‘orgname’：‘银海软件’}，{‘orgid’：‘2’，‘orgname’：‘企业创新中心’}]的列表' name='url' type='java.lang.String' %>
<%@attribute description='指定请求时提交元素数据，多个元素id以逗号隔开'  name='submitIds' type='java.lang.String'%>
<%@attribute description='指定item显示值字段名，默认"name"，如displayValue="orgname"' name='displayValue' type='java.lang.String' %>
<%@attribute description='指定item真实值字段名，默认"id"，如hiddenValue="orgid"' name='hiddenValue' type='java.lang.String' %>
<%@attribute description='指定鼠标移入item时，默认"title"，显示的内容字段'  name='titleValue' type='java.lang.String'%>

<%@attribute description='添加输入提示内容' name='placeholder' type='java.lang.String' %>
<%@attribute description='当required属性为true时，设置默认错误提示信息' name='toolTip' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
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

<%@include file="../columnhead.tag" %>
<div id="selectData_<%=id %>"
	 class="selectData-layout-Container  <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if(span!=null){%> span="${span}"<%}%>
	<% if(toolTip != null){%> title = "${toolTip}"<%} %>
>
	<% if(key!=null && !"".equals(key.trim())){%>
		<label for="<%=id %>" class="selectData-label "
			   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
		>
		${key}
		</label>
	<%} %>
	<div class="selectData-input-Container"
			<% if (null != labelWidth) {%>
		 style="margin-left:<%=labelWidth%>px"
			<%}else if(null == key || "".equals(key.trim())) {%>
		 style="margin-left:0px;"
			<%} %>
	>
		<div class="selectData-input-box">
			<div class="selectData-selected-ul"></div>
			<input id="<%=name%>" name="dto['<%=name%>']" style="display:none;"/>
			<input
					<% if(id!=null){%>
					id="<%=id %>"
					name="dto['<%=id%>']"
					<%}%>
					class="selectData_input"
					<%if(placeholder!=null){ %>
					placeholder="<%=placeholder%>"
					<%} %>
					autocomplete="off" disableautocomplete
			/>
			<span class="faceIcon validateIcon"></span>
		</div>
		<div class="selectData-win-Container" ></div>
	</div>
</div>
<%@include file="../columnfoot.tag" %>
<script>
    (function(factory){
        if (typeof require === 'function' ) {
            require(["jquery","TaUIManager","selectData"], factory);
        } else {
            factory(jQuery);
        }
    })(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                if(required_selectData){
                    required_selectData(function () {
                        var option = {};
                        <%if(inputQueryNum!=null) {%>
                        option.inputQueryNum = <%=inputQueryNum%>;
                        <%}%>
                        <%if(url!=null && !"".equals(url)) {%>
                        option.url = "<%=url%>";
                        <%}%>
                        <%if(placeholder!=null) {%>
                        option.placeholder = "<%=placeholder%>";
                        <%}%>
                        <%if(titleValue!=null && !"".equals(titleValue)) {%>
                        option.titleValue = "<%=titleValue%>";
                        <%}%>
                        <%if(hiddenValue!=null && !"".equals(hiddenValue)) {%>
                        option.hiddenValue = "<%=hiddenValue%>";
                        <%}%>
                        <%if(displayValue!=null && !"".equals(displayValue)) {%>
                        option.displayValue = "<%=displayValue%>";
                        <%}%>
                        <%if(multiple!=null && !"".equals(multiple)) {%>
                        option.multiple = <%=multiple%>;
                        <%}%>
                        <%if(name!=null && !"".equals(name)) {%>
                        option.name = "<%=name%>";
                        <%}%>
                        <%if(submitIds!=null && !"".equals(submitIds)) {%>
                        option.submitIds = "<%=submitIds%>";
                        <%}%>
                        <%if (value != null) {%>
                        option.value = <%=value%>;
                        <%}%>
                        <%if (readOnly != null) {%>
                        option.readOnly = <%=readOnly%>;
                        <%}%>
                        <%if (disabled != null) {%>
                        option.disabled = <%=disabled%>;
                        <%}%>
                        <% if(required!=null){%>
                        option.required = ${required};
                        <%}%>
                        <% if(toolTip!=null){%>
                        option.toolTip="${toolTip}";
                        <%}%>
                        var selectData = TaSelectData("<%=id%>",option);
                        Ta.core.TaUIManager.register("<%=id%>",selectData);
                    })
                }

            });
    });
</script>