<%@tag pageEncoding="UTF-8"  trimDirectiveWhitespaces="true" %>
<%@tag import="com.alibaba.fastjson.JSONArray"%>
<%@tag import="com.alibaba.fastjson.JSONObject"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean" %>
<%@tag import="com.yinhai.core.common.api.util.StringUtil" %>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil" %>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@ tag import="java.beans.PropertyDescriptor" %>
<%@ tag import="java.lang.reflect.Method" %>
<%@tag import="java.util.ArrayList" %>
<%@tag import="java.util.List" %>
<%@ tag import="java.util.Random" %>

<%--@doc--%>
<%@tag description='多个radio的容器' display-name='radiogroup' %>
<%@attribute description='设置组件id，页内唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置组件的label描述,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='添加label描述自定义宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='添加label描述自定义样式，如labelStyle="font-size:12px;"' name='labelStyle' type='java.lang.String' %>
<%@attribute description='添加自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>

<%@attribute description='设置是否必选，默认false，设置后带小红星' name='required' type='java.lang.String' %>
<%@attribute description='设置组件为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置是否不可用，默认为可用，不可用时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>

<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>
<%@attribute description='设置组件布局方式,固定为column,不能删除，TagUtil计算依赖' name='layout' type='java.lang.String'%>
<%@attribute description='容器以column方式布局时，设置cols参数将容器分成n列，默认值为1,表示分为一列' name='cols' type='java.lang.String' %>

<%@attribute description='在页面构建radio,例如:data="[{"id":"1","name":"男"},{"id":"2","name":"女"}]"' name='data' type='java.lang.String' %>
<%@attribute description='根据码表自动生成radio，例如:collection="aac004"' name='collection' type='java.lang.String' %>
<%@attribute description='设置码表加载是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%@attribute description='设置码表加载过滤这些数据不生成checkbox，例如:filter="1,2,3"表示key为1,2,3的数据项不生成checkbox' name='filter' type='java.lang.String' %>
<%@attribute description='设置码表加载过滤数据方式为反向过滤，默认false' name='reverseFilter' type='java.lang.String' %>

<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='添加鼠标移过输入对象提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大宽度，默认300' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大高度，默认500' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>

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
	//通过码表构建radio
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
	
	if ((id == null || id.length() == 0)) {
		Random RANDOM = new Random();
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE
				: Math.abs(nextInt);
		id = "taradiogroup_" + String.valueOf(nextInt);
	}
	
	jspContext.setAttribute("_radiogroup_id",id,PageContext.REQUEST_SCOPE);
	jspContext.setAttribute("_radiogroup_obj",this,PageContext.REQUEST_SCOPE);
	
	
	Integer col = (StringUtil.isEmpty(cols)?Integer.valueOf("1"):Integer.valueOf(cols));
	String w = Math.floor((100/col.doubleValue()) * 100) / 100 + "%";
%>
<%@include file="../columnhead.tag" %>
<div id="<%=id %>"
	 class="radiogroup-layout-Container <% if( cssClass != null ){ %> ${cssClass} <%} %>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if( columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if( span != null ){ %> span="${span}"  <%}%>
	<% if( toolTip != null ){ %> title="${toolTip}"  <%}%>
>
	<% if(key!=null && !"".equals(key.trim())){%>
	<label for="<%=id %>" class="radiogroup-label"
		   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
	>
	${key}
	</label>
	<%} %>

	<div class="radiogroup-Container" layout="column"
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
	<% if( json2bean != null ){ 
		//查找radioGroup是否有值，如果有值，查看当前radio是否等于当前radio的值
		IResultBean resultBean = (IResultBean) TagUtil.getResultBean();
		String rgValue = null;
		if(resultBean != null){
			Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
    		if(v !=null && !"".equals(v)){
    			rgValue = v+"";
    		}
		}
		for(int i = 0; i <json2bean.size(); i++){
			JSONObject obj = json2bean.getJSONObject(i);
			String sid = obj.getString("id");
			String sname = obj.getString("name");
			if(rgValue!=null && rgValue.equals(sid)){
			%>
				<div class='ez-fl ez-negmx' style='width:<%=w %>;'>
			        <div class="radio-layout-Container radio-checked">
						<input id="radio_<%=sid %>_<%=id%>" type="radio" value="<%=sid %>" name="dto['<%=id %>']" checked="checked" style="display:none">
						<label>
						<%=sname %>
						</label>
					</div>
				</div>
			<% }else{%>
				<div class='ez-fl ez-negmx' style='width:<%=w %>;'>
			        <div class="radio-layout-Container radio-uncheck">
						<input id="radio_<%=sid %>_<%=id%>" type="radio" value="<%=sid %>" name="dto['<%=id %>']" style="display:none">
						<label>
						<%=sname %>
						</label>
					</div>
				</div>
			<% }
	%>
		
      	<% }%>
    <%}%>
	</div>
	<div style="clear:both"></div>
</div>	

<script>
(function(factory){
	if (typeof require === 'function' ) {
		require(["jquery","TaUIManager","radioGroup","radio"], factory);
	} else {
		factory(jQuery);
	}
})(function($){
	Ta.core.TaUICreater.addUI( 
	function(){ 
		var options = {
            <% if(required!=null){%>
            required:${required},
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
		};
		<% if( json2bean != null ){%>
			options.hasCollectionOrData = true;
			
			//add by zzb  新增collection/data时的radio对象注册
			<% 
				for(int i = 0; i <json2bean.size(); i++){
					JSONObject obj = json2bean.getJSONObject(i);
					String sid = obj.getString("id");
					%>
						Ta.core.TaUIManager.register("radio_<%=sid %>_<%=id%>",new TaRadio("radio_<%=sid %>_<%=id%>"));
					<% 
				}	
			%>
		<% }%>
		var taradioGroup = new TaRadioGroup("<%=id%>",options);
		Ta.core.TaUIManager.register("<%=id%>",taradioGroup);
	});
});
</script>
<%@include file="../columnfoot.tag" %>