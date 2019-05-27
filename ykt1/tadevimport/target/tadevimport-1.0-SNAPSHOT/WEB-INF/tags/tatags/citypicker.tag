<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag description='省市区乡村五级级联选择框' display-name='cityPicker' %>
<%@attribute description='组件id，页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='组件的label标签,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="100"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute name="required" type="java.lang.String" rtexprvalue="true" description="true/false,设置是否必输，默认false，设置后代小红星"%>
<%@attribute name="toolTip" type="java.lang.String" rtexprvalue="true" description="必输提示"%>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台 true不可用,false 可用 默认false ' name='disabled' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='是否是显示简化名称,默认显示true简化名称 类型(比如四川省,显示为四川)' name='simple' type='java.lang.String' %>
<%@attribute description='初始显示在输入框的值' name='placeholder' type='java.lang.String' %>
<%@attribute description='选择的层级,默认有3个选择层级 level=3 可以取值1,2,3,4,5' name='level' type='java.lang.String' %>
<%@attribute description='设置第一层级名称 默认为 省 ' name='levelOneName' type='java.lang.String' %>
<%@attribute description='设置第二层级名称 默认为 市 ' name='levelTwoName' type='java.lang.String' %>
<%@attribute description='设置第三层级名称 默认为 区/县 ' name='levelThreeName' type='java.lang.String' %>
<%@attribute description='设置第四层级名称 默认为 街道/乡镇 ' name='levelFourName' type='java.lang.String' %>
<%@attribute description='设置第五层级名称 默认为 社区/村 ' name='levelFiveName' type='java.lang.String' %>
<%@attribute description='设置省的默认值'  name='province' type='java.lang.String' %>
<%@attribute description='设置市的默认值,上一级省必填的 '  name='city' type='java.lang.String' %>
<%@attribute description='设置县默认值,上两级省市是必须的'  name='district' type='java.lang.String' %>
<%@attribute description='设置乡默认值,上三级省市县是必须的'  name='xiang' type='java.lang.String' %>
<%@attribute description='设置村默认值,上四级省市县乡是必须的'  name='cun' type='java.lang.String' %>

<%@attribute description='后台相应请求的地址,这里会传入上级选择的区域' required="true" name='url' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='因为该组件为异步加载,该方法是组件加载完成回调传入参数为该组件,用于动态设置选择框的属性的例如:loadedComponentCallBack=function(ct){ct.setValue()}'  name='loadedComponentCallBack' type='java.lang.String' %>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>

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
%>

<div class="city-picker" >
	<% if(key!=null && !"".equals(key.trim())){%>
	<label
			for="<%=id %>"
			<% if (null != labelStyle) {%>
			style="<%=labelStyle%>"
			<%} %>
            <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>
	>${key}</label>
	<%}%>
	<div class="city-ta-picker
	<% if (cssClass != null){%>
	  ${cssClass}
	<%}%>"
			<% if (cssStyle != null){%>
			style="${cssStyle}"
			<%}%>
            <% if (null != labelWidth) {%>
         style="margin-left:<%=labelWidth%>px"
            <%}else if(null == key || "".equals(key.trim())) {%>
         style="margin-left:0px;"
            <%} %>
	>
		<input id="<%=id%>"
			   readonly
			   type="text"
			   data-toggle="city-picker"
		>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container" id="textHelp_<%=id%>"></div>
		<%}%>
	</div>
	<input id="<%=id%>_code" name="dto['<%=id%>']" style="display:none" />
</div>


<script type="text/javascript">
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery", "TaUIManager", "CityPicker"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                if(required_citypicker){
                    required_citypicker(
                        function () {

                var options={};
                <% if( null != simple) {%>
                options.simple  =${simple};
                <% }%>
                <% if( null != level) {%>
                options.level  ="${level}";
                <% }%>
                <% if( null != url) {%>
                options.url  ="${url}";
                <% }%>
                <% if( null != required) {%>
                options.required  =${required};
                <% }%>
                <% if( null != toolTip) {%>
                options.toolTip  ="${toolTip}";
                <% }%>
                <% if( null != disabled) {%>
                options.disabled  =${disabled};
                <% }%>
                <% if( null != readOnly) {%>
                options.readOnly  =${readOnly};
                <% }%>
                <% if( null != placeholder) {%>
                options.placeholder  ="${placeholder}";
                <% }%>
                <% if( null != levelOneName) {%>
                options.levelOneName  ="${levelOneName}";
                <% }%>
                <% if( null != levelTwoName) {%>
                options.levelTwoName  ="${levelTwoName}";
                <% }%>
                <% if( null != levelThreeName) {%>
                options.levelThreeName  ="${levelThreeName}";
                <% }%>
                <% if( null != levelFourName) {%>
                options.levelFourName  ="${levelFourName}";
                <% }%>
                <% if( null != levelFiveName) {%>
                options.levelFiveName  ="${levelFiveName}";
                <% }%>
                <%if (textHelp != null) {%>
                options.textHelp = "${textHelp}";
                <%}%>
                <%if (textHelpWidth != null) {%>
                options.textHelpWidth = "${textHelpWidth}";
                <%}%>
                <%if (textHelpPosition != null) {%>
                options.textHelpPosition = "${textHelpPosition}";
                <%}%>
                <% if( null != province) {%>
                options.province  ="${province}";
                <% }%>
                <% if( null != city) {%>
                options.city  ="${city}";
                <% }%>
                <% if( null != district) {%>
                options.district  ="${district}";
                <% }%>
                <% if( null != xiang) {%>
                options.xiang  ="${xiang}";
                <% }%>
                <% if( null != cun) {%>
                options.cun  ="${cun}";
                <% }%>
                            var ct=new CityPicker('<%=id%>',options)
                    Ta.core.TaUIManager.register("<%=id%>",ct);
                            //add by cy 添加组件加载完成回调
                           if(${loadedComponentCallBack}){
                              var fn= ${loadedComponentCallBack};
                              fn(ct);
                           }
					}
					)
                }
            });
    }));
</script>
