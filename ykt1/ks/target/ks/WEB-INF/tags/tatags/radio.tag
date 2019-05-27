<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"  %>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean" %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@ tag import="java.util.Random" %>

<%--@doc--%>
<%@tag description='Radio' display-name='radio,强烈建议放入radioGroup中使用' %>
<%@attribute description='设置组件id，页内唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置组件的label描述' name='key' type='java.lang.String' %>
<%@attribute description='设置组件的提交到后台的参数名称，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='添加label描述自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='添加自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>

<%@attribute description='设置是否选中,默认为不选中：false' name='checked' type='java.lang.String' %>
<%@attribute description='设置是否只读,默认非只读模式：false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置是否不可用,默认为可用：false，不可用时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>

<%@attribute description='设置组件处于选中状态时的值' name='value' type='java.lang.String' %>
<%@attribute description='添加自定义onClick事件' name='onClick' type='java.lang.String' %>

<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>

<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
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
<%
		IResultBean resultBean = (IResultBean) TagUtil.getResultBean();
		//查找radioGroup是否有值，如果有值，查看当前radio是否等于当前radio的值
		Object obj = jspContext.getAttribute("_radiogroup_obj",PageContext.REQUEST_SCOPE);
		JspTag taRadioGroup = TagUtil.getTa3ParentTag(getParent());
		String radioGroupId = null;
		if(taRadioGroup != null && !"".equals(taRadioGroup) && taRadioGroup.equals(obj)){
			radioGroupId = (String)jspContext.getAttribute("_radiogroup_id",PageContext.REQUEST_SCOPE);
			String cgValue = null;
			if(resultBean != null){
				Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(radioGroupId);
	    		if(v !=null && !"".equals(v)){
	    			cgValue = v+"";
	    		}
			}
	    	//查找request
	    	//if(value != null && !"".equals(value) && radioGroupId != null){
	    	//	cgValue = radioGroupId;
	    	//}
	       	//查找session
	    	if(value != null && !"".equals(value) && request.getSession().getAttribute("_radiogroup_id") != null){
	    		cgValue = (String)request.getSession().getAttribute("_radiogroup_id");
	    	}
			if(cgValue!=null && cgValue.equals(value)){
				checked = "true";
			}
		}	
			//如果是直接给当前radio的id赋值的情况下
	    	//优先 查找resultBean
			Boolean _value = false;
	    	if(id!=null){
	    		/**
	    		 * radiogroup的id存在，radio的id也存在；优先采用radiogroupId
	    		 */
			  if(resultBean != null){
			   		Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(radioGroupId);
			   		if(v ==null || "".equals(v)){
			   			v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
			   		}
			   		
			   		if(v !=null && !"".equals(v)){
			   			v = v+"";
			   			if(v.equals(value)){
			   				_value = true;
			   			}
			   		}
				 }
				 //查找request
				 if(value != null && !"".equals(value) && request.getAttribute(id) != null){
				 	 String _v = request.getAttribute(id).toString();
				 	 if(_v.equals(value)) {
				 	 	_value = true;
				 	 }
				 }
				 //查找session
				 if(value != null && !"".equals(value) && request.getSession().getAttribute(id) != null){
				 	 String _v = request.getSession().getAttribute(id).toString();
				 	 if(_v.equals(value)) {
				 	 	_value = true;
				 	 }
				 }             	
	    	}
	    	//如果resultBean，request，session设置了有该id的值，改组件就会被勾选
	        if(_value){
	        	checked = "true";
	        }
			
	        if ((id == null || id.length() == 0)) {
				Random RANDOM = new Random();
				int nextInt = RANDOM.nextInt();
				nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
						.abs(nextInt);
				id = "taradio_" + String.valueOf(nextInt);
			}
	        
	        if(null == name){
	        	if(radioGroupId==null)
	        		name = "dto['"+id+"']";
	        	else
	        		name = "dto['"+radioGroupId+"']";
	        }   
    	   
%>

<%@include file="../columnhead.tag" %>
<div id="<%=id %>_radioDiv"
	 class="radio-layout-Container radio-uncheck <% if(cssClass != null ){ %> ${cssClass}  <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if( columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if( span != null ){ %> span="${span}"  <%}%>
	<% if( toolTip != null ){ %> title="${toolTip}" <%}%>
>
<input id="<%=id%>"
type="radio"
	<% if( value != null ){ %>
value="${value}"
	<%}%>
name="<%=name %>"
style="display:none;"
>
<label <% if( labelStyle != null ){ %> style="${labelStyle}" <%}%> class="radio-label">
	<% if( key != null ){ %>${key}<%}%>
</label>
</div>
<script>
(function(factory){
	if (typeof require === 'function' ) {
		require(["jquery","TaUIManager","radio"], factory);
	} else {
		factory(jQuery);
	}
})(function($){
	Ta.core.TaUICreater.addUI( 
	function(){
	    var options = {
            <% if( "true".equals(checked)){ %>
            	checked : <%=checked %>,
            <%}%>
            <% if( readOnly != null && "true".equals(readOnly)){%>
            	readOnly : <%=readOnly%>,
            <%}%>
            <% if( disabled != null && "true".equals(disabled)){%>
            	disabled : <%=disabled%>,
            <%}%>
            <% if( onClick != null){ %>
            	onClick : "${onClick}"
            <%}%>
		};
		var radio = new TaRadio("<%=id%>",options);
		Ta.core.TaUIManager.register("<%=id%>",radio);
	});
});
</script>
<%@include file="../columnfoot.tag" %>