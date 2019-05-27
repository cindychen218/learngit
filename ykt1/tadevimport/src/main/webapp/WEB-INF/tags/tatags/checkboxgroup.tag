<%@tag pageEncoding="UTF-8"  trimDirectiveWhitespaces="true"%>
<%@tag import="com.alibaba.fastjson.JSONArray"%>
<%@tag import="com.alibaba.fastjson.JSONObject"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean" %>
<%@tag import="com.yinhai.core.common.api.util.StringUtil" %>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="com.yinhai.modules.codetable.api.domain.vo.AppCodeVo"%>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor" %>
<%@tag import="java.lang.reflect.Method" %>
<%@tag import="java.util.ArrayList" %>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Random" %>

<%--@doc--%>
<%@tag description='用于包围checkbox的容器' display-name='checkboxgroup' %>
<%@attribute description='设置组件id,页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置组件布局方式,固定为column,不能删除，TagUtil计算依赖' name='layout' type='java.lang.String'%>
<%@attribute description='对checkboxGroup设置标题,不支持html格式' name='key' type='java.lang.String' %>
<%@attribute description='当该容器对子组件布局layout=column的时候，可以设置cols参数表面将容器分成多少列，默认不设置为1' name='cols' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='true/false,设置是否必选,默认为:false' name='required' type='java.lang.String' %>
<%@attribute description='设置最大选择数,例如:maxSelect="2",表示最多只能选择两个checkbox' name='maxSelect' type='java.lang.String' %>
<%@attribute description='设置最小选择数,例如:minSelect="2",表示最少要选择两个checkbox' name='minSelect' type='java.lang.String' %>

<%@attribute name="bpopTipMsg" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本 "%>
<%@attribute name="bpopTipWidth" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小"%>
<%@attribute name="bpopTipHeight" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小"%>
<%@attribute name="bpopTipPosition" type="java.lang.String" rtexprvalue="true" description="鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top"%>

<%@attribute description='设置label的宽度' name='labelWidth' type='java.lang.String' %>
<%@attribute description='设置label的样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='required 时信息提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='true/false,是否可以见,默认:true' name='display' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='根据码表自动生成checkbox，例如:collection="aac004"' name='collection' type='java.lang.String' %>
<%@attribute description='设置过滤这些数据不生成checkbox，例如:filter="1,2,3"表示key为1,2,3的数据项不生成checkbox' name='filter' type='java.lang.String' %>
<%@attribute description='true/false,对设置的filter数据是否进行反向过滤显示，默认false' name='reverseFilter' type='java.lang.String' %>
<%@attribute description='true/false,是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%@attribute description='在页面构建checkbox,例如:data="[{"id":"1","name":"成都"},{"id":"2","name":"重庆"}]"' name='data' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
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
	JSONArray json2bean = null;
	if(null != data && !"".equals(data)){
		json2bean = JSonFactory.json2bean(data,JSONArray.class);
		data = json2bean.toJSONString();
	}else if (null != collection && !"".equals(collection)) {
		collection = collection.toString();
		String yab003 = null;
		if("true".equals(filterOrg)){
			UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
			if(userAccountInfo != null)
				yab003 = userAccountInfo.getPositionOrg().getYab003();
		}
		String str = CodeTableUtil.getCodeListJson(collection, yab003);
		List<JSONObject> codeList = JSonFactory.json2bean(str,ArrayList.class);
		if(null!=codeList &&codeList.size()>0){
			if(filter!=null&&!"".equals(filter)){
				for(int j = 0 ; j < codeList.size();j++){
					JSONObject next = codeList.get(j);
					String[] split = filter.split(",");
					if(reverseFilter!=null && !"".equals(reverseFilter)){
						if("true".equals(reverseFilter)){//进行反向过滤,判断当前对象是否
							boolean exist = false;
							for(int i = 0 ; i < split.length;i++){
								if(split[i].equals(next.getString("id"))){
									exist=true;
									break;
								}
							}
							if(!exist){
								codeList.remove(next);
								j--;
							}
						}
						else{//不进行反向过滤,判断当前对象是否存在过滤的list，如果在，则去除
							for(int i = 0 ; i < split.length;i++){
								if(split[i].equals(next.getString("id"))){
									codeList.remove(next);
									j--;
									break;
								}
							}
						}
					}
					else {//默认不进行反向过滤
						for(int i = 0 ; i < split.length;i++){
							if(split[i].equals(next.getString("id"))){
								codeList.remove(next);
								j--;
								break;
							}
						}
					}
				}

			}
		}
		data = JSonFactory.bean2json(codeList);
		json2bean = JSonFactory.json2bean(data,JSONArray.class);
	}
	
	String validType = null;

	if(minSelect==null && "true".equals(required)){
		minSelect = "1";
	}
	
	if (maxSelect != null || minSelect !=null) {
		String min = "",max = "";
		if(maxSelect != null)max = maxSelect;
		if(minSelect != null)min = minSelect;
		validType = "[{type:'checkboxgroup',param:["+min+","+max+"]}]";
	}

    jspContext.setAttribute("_checkboxgroup_id",id,PageContext.REQUEST_SCOPE);
	if ((id == null || id.length() == 0)) {
		Random RANDOM = new Random();
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
				.abs(nextInt);
		id = "tacheckboxgroup_" + String.valueOf(nextInt);
	}
	
	jspContext.setAttribute("_checkboxgroup_obj",this,PageContext.REQUEST_SCOPE);

	Integer col = (StringUtil.isEmpty(cols)?Integer.valueOf("1"):Integer.valueOf(cols));
	String w = Math.floor((100/col.doubleValue()) * 100) / 100 + "%";
%>

<%@include file="../columnhead.tag" %>

<div id="<%=id %>"
	class="checkboxgroup-layout-Container <% if( cssClass != null ){ %> ${cssClass} <%} %>"
	style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if( span != null ){ %> span="${span}"  <%}%>
	<% if( toolTip != null ){ %> title="${toolTip}"  <%}%>
>
	<% if(key!=null && !"".equals(key.trim())){%>
	<label for="<%=id %>" class="checkboxgroup-label" title="鼠标单击全选或取消"
		   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
	>
	${key}
	</label>
	<%} %>
	<div class="checkboxgroup-Container" layout="column"
			<% if( cols != null ){ %>
		 cols="${cols}"
			<%}%>
			<% if (null != labelWidth) {%>
		 style="margin-left:<%=labelWidth%>px"
			<%}else if(null == key || "".equals(key.trim())) {%>
		 style="margin-left:0px;"
			<%} %>
	>

	<jsp:doBody />

	<% 
	if( json2bean != null ){ 
		IResultBean resultBean = (IResultBean) TagUtil.getResultBean();
		Object cgValue = null;
		if(resultBean != null){
	    	Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
	    	if(v !=null && !"".equals(v)){
	    		cgValue = v;
	    	}
		}
		 
		for(int i = 0; i <json2bean.size(); i++){
			String checked = "false";
			JSONObject obj = json2bean.getJSONObject(i);
			String sid = obj.getString("id");
			String sname = obj.getString("name");
			String checkStr = obj.getString("checked");
			if(cgValue!=null){
		    	if(cgValue instanceof String){
		    		if(cgValue.equals(sid)){
		    			checked = "checked";
		    		}
		    	}else if(cgValue instanceof String[]){
		    		String[] tmp = (String[])cgValue;
		    		for(int j=0;j<tmp.length;j++){
		    			if(tmp[j].equals(sid)){
		    				checked = "checked";
		    				break;
		    			}
		    		}
		    	}
		    }
		    if(ValidateUtil.isNotEmpty(checkStr)){
				if("true".equals(checkStr)){
					checked = "checked";
				}
			}
	%>
		<div class='ez-fl ez-negmx' style='width:<%=w %>;'>
	        <div  class="checkbox-layout-Container
	        <%if( "true".equals(checked) || "checked".equals(checked)){ %>
			checkbox-checked
			<%}else{%>
			checkbox-uncheck
			<%}%>
	        ">
				<input id="check_<%=sid %>_<%=id%>" type="checkbox" value="<%=sid %>" name="dto['<%=id %>']" style="display:none"
				<%if( "true".equals(checked) || "checked".equals(checked)){ %>
					checked="<%=checked %>" 
				<%}%>
				/>
				<label>
				<%=sname %>
				</label>
			</div>
		</div>
      	<% }%>
    <%}%>
	</div>
<div style="clear:both"></div>
</div>	
<script>

(function(factory){
	if (typeof require === 'function' ) {
		require(["jquery","TaUIManager","checkboxGroup","checkbox"], factory);
	} else {
		factory(jQuery);
	}
})(function($){
	Ta.core.TaUICreater.addUI( 
	function(){ 
		var options = {
            <% if(validType!=null){%>
            validType:<%=validType%>,
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
            <% if(toolTip!=null){%>
            toolTip:"${toolTip}",
            <%}%>
            <%if (readOnly != null) {%>
            readOnly : <%=readOnly%>,
            <%}%>
            <%if (disabled != null) {%>
            disabled : <%=disabled%>,
            <%}%>
		};
		<% if( json2bean != null ){%>
			options.hasCollectionOrData = true;
			//add by xp  新增collection/data时的checkbox对象注册
			<% 
			for(int i = 0; i <json2bean.size(); i++){
				JSONObject obj = json2bean.getJSONObject(i);
				String sid = obj.getString("id");
				%>
				Ta.core.TaUIManager.register("check_<%=sid %>_<%=id%>",new TaCheckbox("check_<%=sid %>_<%=id%>"));
			<%
			}
			%>
		<% }%>
		var checkboxGroup = new TaCheckboxGroup("<%=id%>",options);
		Ta.core.TaUIManager.register("<%=id%>",checkboxGroup);
	});
});
</script>
<%@include file="../columnfoot.tag" %>