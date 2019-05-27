<%@tag pageEncoding="UTF-8" %>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean" %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@ tag import="java.util.Random" %>

<%--@doc--%>
<%@tag description='checkbox组件' display-name="checkbox"%>
<%@attribute description='true/false,默认false，设置是否不可用' name='disabled' type='java.lang.String' %>
<%@attribute description='true/false,默认true，设置是否显示' name='display' type='java.lang.String' %>
<%@attribute description='设置组件style样式' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置组件css样式' name='cssClass' type='java.lang.String' %>
<%@attribute description='true/false,默认false，设置是否为只读' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置标题，不支持html格式文本' name='key' required='true' type='java.lang.String'  rtexprvalue="true"%>
<%@attribute description='单击事件,比如onClick="fnOnClick()",在javascript中，function fnOnClick(){alert(111)}' name='onClick' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='true/false,设置是否被选中，默认为false' name='checked' type='java.lang.String' %>
<%@attribute description='设置label的样式，例如:labelStyle="font-size:16px"' name='labelStyle' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='组件处于选中状态时的值' name='value' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
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
			
			String columnWidth = null;
			IResultBean resultBean = (IResultBean) TagUtil.getResultBean();
			//查找CheckboxGroup是否有值，如果有值，查看当前checkbox的值是否在里面
			Object obj = jspContext.getAttribute("_checkboxgroup_obj",PageContext.REQUEST_SCOPE);
			JspTag taCheckboxGroup = TagUtil.getTa3ParentTag(getParent());
			
			String checkboxgroupid = null;
			if(taCheckboxGroup != null && !"".equals(taCheckboxGroup) && taCheckboxGroup.equals(obj)){
				checkboxgroupid = (String)jspContext.getAttribute("_checkboxgroup_id",PageContext.REQUEST_SCOPE);
				Object cgValue = null;
				if(resultBean != null){
			    	Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(checkboxgroupid);
			    	if(v !=null && !"".equals(v)){
			    		cgValue = v;
			    	}
				}
			    //查找request
			    //if(value != null && !"".equals(value) && checkboxgroupid != null){
			    //	cgValue = checkboxgroupid;
			    //}
			    //查找session
			    if(value != null && !"".equals(value) && request.getSession().getAttribute("_checkboxgroup_id") != null){
			    	cgValue = request.getSession().getAttribute("_checkboxgroup_id");
			    }
			    if(cgValue!=null){
			    	if(cgValue instanceof String){
			    		if(cgValue.equals(value)){
			    			checked = "true";
			    		}
			    	}else if(cgValue instanceof String[]){
			    		String[] tmp = (String[])cgValue;
			    		
			    		for(int i=0;i<tmp.length;i++){
			    			if(tmp[i].equals(value)){
			    				checked = "true";
			    				break;
			    			}
			    		}
			    	}
			    }
			}    
			//如果是直接给当前checkbox的id赋值的情况下
	    	//优先 查找resultBean
			Boolean _value = false;
	    	if(id != null){
		    	if(resultBean != null){
		    		Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
		    		if(v !=null && !"".equals(v) && (v.toString()).equals(value)){
		    			_value = true;
		    		}
		    	}
		    	//查找request
		    	if(value != null && !"".equals(value) && request.getAttribute(id) != null){
		    		_value = (request.getAttribute(id)==null?false:true);
		    	}
		    	//查找session
		    	if(value != null && !"".equals(value) && request.getSession().getAttribute(id) != null){
		    		_value = (request.getSession().getAttribute(id)==null?false:true);
		    	}
		    	//如果resultBean，request，session设置了有该id的值，该组件就会被勾选
		        if(_value){
		        	checked = "true";
		        }
	    	}
	    	
			if ((id == null || id.length() == 0)) {
				Random RANDOM = new Random();
				int nextInt = RANDOM.nextInt();
				nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
						.abs(nextInt);
				id = "tacheckbox_" + String.valueOf(nextInt);
			}
			
			if (name == null || "".equals(name)) {
				if (checkboxgroupid == null){
					name = "dto['" + id + "']";
				}else{
					name = "dto['" + checkboxgroupid + "']";
				}	
			}
			
%>

<%@include file="../columnhead.tag" %>
<div id="<%=id %>_chkboxDiv"
	style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	class="checkbox-layout-Container checkbox-uncheck <% if( cssClass != null ){ %> ${cssClass} <%} %>"
	<% if( columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if( span != null ){ %> span="${span}"  <%}%>
	<% if( toolTip != null ){ %> title="${toolTip}"  <%}%>
	<% if( onClick != null ){ %> _onClick="${onClick}"  <%}%>
>
<input id="<%=id %>"
type="checkbox" 
	<% if( value != null ){ %>
value="${value }" 
	<%}%>
name="<%=name %>"
style="display:none;"					
/> 
<label  <% if( labelStyle != null ){ %> style="${labelStyle}"  <%}%> >
	<% if( key != null ){ %> ${key} <%}%>
</label>
</div>
<script>

(function(factory){
	if (typeof require === 'function' ) {
		require(["jquery","TaUIManager","checkbox"], factory);
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
        };
		var checkbox = new TaCheckbox("<%=id%>",options);
		Ta.core.TaUIManager.register("<%=id%>",checkbox);
	});
});

</script>
<%@include file="../columnfoot.tag" %>