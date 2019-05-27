<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag description='下拉树' display-name='selectTree' %>
<%@attribute name="treeId" description="树id，必填，这个id必须与后台request或者session或者application绑定" type="java.lang.String" required="true"%>
<%@attribute name="toolTip" type="java.lang.String" rtexprvalue="true" description="必输提示"%>
<%@attribute name="url" description="url地址，必填" type="java.lang.String" required="true"%>
<%@attribute name="selectTreeCallback" description='自定义节点点击事件,例如selectTreeCallback="fnClickSelectTree",js中，function fnClickSelectTree(event, treeId, treeNode){alert(treeId)}。如果不写，默认调用框架方法，将值赋值给targetId和targetDESC指定的输入框' type="java.lang.String"%>
<%@attribute name="selectTreeBeforeClick" description="该事件在节点被点击后最先触发，如果返回 false，则不会触发onClick事件，函数定义示例:fnBeforeClick(treeId, treeNode)" type="java.lang.String"%>
<%@attribute name="selectTreeLoadComplete" description='该事件在树加载完成之后触发,如初始化只读，或设值的时候使用，例如selectTreeLoadComplete="fnLoadComplete",js中，function fnLoadComplete(event, treeId, treeNode, msg){Base.setReadOnly(treeId)}' type="java.lang.String" %>
<%@attribute name="data" description='设置节点数据，数组格式，例如data="[{id:1,pId:0,name:"中国"},{id:11,pId:1,name:"四川"}]"，但是优先会采用后台传回的数据' type="java.lang.String"%>
<%@attribute name="targetDESC" description="显示的输入框的id，用于显示节点数据，必填" type="java.lang.String" required="true"%>
<%@attribute name="targetId" description="目标id，用于存放节点id，必填" type="java.lang.String" required="true"%>
<%@attribute name="key" description="下拉树key" type="java.lang.String"%>
<%@attribute name="cssClass" description='给该组件添加自定义样式class，如:cssClass=“no-padding"' type="java.lang.String"%>
<%@attribute name="cssStyle" description='给该组件添加自定义样式，如:cssStyle=”padding-top:10px"' type="java.lang.String"%>
<%@attribute name="height" description="下拉树高度" type="java.lang.String"%>
<%@attribute name="width" description="下拉树宽度，默认和输入框同宽" type="java.lang.String"%>
<%@attribute name="minLevel" description="只能选择的最小层级" type="java.lang.String"%>
<%@attribute name="maxLevel" description="只能选择的最大层级" type="java.lang.String"%>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute name="asyncParam" description='设置异步时提交的与节点数据相关的必需属性，数组格式，例如asyncParam="["id","checked"]"' type="java.lang.String"%>
<%@attribute name='asyncParamOther'  description='设置异步时提交的节点属性值之外的其他静态键值对数据，数组或json格式，例如asyncParamOther="[key,vlaue]"，asyncParamOther="{key1:value1, key2:value2}"' type='java.lang.String' %>

<%@attribute name="nameKey" description='设置显示节点名称的属性名，默认为"name"' type="java.lang.String"%>
<%@attribute name="idKey" description='设置节点父子关系中子节点的标示属性，也是每个节点的唯一标示属性名称，默认为"id"' type="java.lang.String"%>
<%@attribute name="parentKey" description='设置节点父子关系中父节点的标示属性，默认为"pId"' type="java.lang.String"%>
<%@attribute name="fontCss" description='设置个性化文字样式，只针对显示的节点名称，json格式，如:{color:"#ff0011", background:"blue"}，也可设置为一个函数名称，该函数返回json格式的样式，函数定义示例:fnSetFont(treeId, treeNode)' type="java.lang.String"%>
<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='设置初始值,例如:value="idkey,namekey"' name="value"  type="java.lang.String"%>
<%@attribute description='设置是否必选，默认false，设置后带小红星' name='required' type='java.lang.String' %>
<%@attribute description='设置是否只读,默认非只读模式：false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置是否不可用,默认为可用：false，不可用时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>

<%@attribute description='多选模式,true/false 默认false' name='isMultiple' type='java.lang.String' %>
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
		String status = SecurityUtil.getFieldStatus(request, treeId);
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
	IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
	if(resultBean != null){
		Object v = resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(treeId);
		if(v !=null && !"".equals(v)){
			value = v.toString();
		}
	}
%>
<%@include file="../columnhead.tag" %>
<div class="selectTree-layout-Container <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if(span!=null){%> span="${span}"<%}%>
	<% if(toolTip != null){%> title= "${toolTip}"<%} %>
>
	<% if(key!=null && !"".equals(key.trim())){%>
		<label for="<%=targetDESC%>" class="selectTree-label"
			   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
		>
			${key}
		</label>
	<%}%>

	<div class="selectTree-input-Container"
			<% if (null != labelWidth) {%>
		 style="margin-left:<%=labelWidth%>px"
			<%}else if(null == key || "".equals(key.trim())) {%>
		 style="margin-left:0px;"
			<%} %>
	>
		<input type="hidden" id="<%=targetId %>" name="dto['<%=targetId %>']">
		<input type="text" id="<%=targetDESC%>"
			   name="dto['<%=targetDESC%>']"
			   class="selectTree-input"
			   autocomplete="off" disableautocomplete
		>
		<span class="faceIcon validateIcon"></span>
		<span class="faceIcon icon-arrow_down selectTreeIcon" id="fnShowSelectTree_<%=treeId%>" title="点击展开下拉树"></span>
		<span class="faceIcon icon-close selectTreeIcon" id="fn_${treeId}_remove" title="清除"></span>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container"></div>
		<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag" %>
<script>
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager","selectTree"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(function(){

            var taSelectTree = window.SelectTree;
            $(document).ready(function () {
                var options = {};
                options.url = "<%=url%>";
                //新增变量start
                <%if(ValidateUtil.isNotEmpty(treeId)){%>
                options.treeId = "<%=treeId%>";
                <%}%>
                <%if(ValidateUtil.isNotEmpty(targetDESC)){%>
                options.targetDESC = "<%=targetDESC%>";
                <%}%>
                <%if(ValidateUtil.isNotEmpty(targetId)){%>
                options.targetId = "<%=targetId%>";
                <%}%>
                <%if(ValidateUtil.isNotEmpty(minLevel)){%>
                options.minLevel = "<%=minLevel%>";
                <%}%>
                <%if(ValidateUtil.isNotEmpty(maxLevel)){%>
                options.maxLevel = "<%=maxLevel%>";
                <%}%>
                <%if (textHelp != null) {%>
                options.textHelp = "${textHelp}";
                <%}%>
				<%if (textHelpWidth != null) {%>
                options.textHelpWidth = "${textHelpWidth}";
				<%}%>
				<%if (textHelpPosition != null) {%>
                options.textHelpPosition = "${textHelpPosition}";
				<%}%>
				<%if(ValidateUtil.isNotEmpty(required)){%>
				options.required = <%=required%>;
				<%}%>
				<%if(ValidateUtil.isNotEmpty(toolTip)){%>
				options.toolTip ="<%=toolTip%>";
				<%}%>
                <%if(ValidateUtil.isNotEmpty(readOnly)){%>
                options.readOnly =<%=readOnly%>;
                <%}%>
                <%if(ValidateUtil.isNotEmpty(disabled)){%>
                options.disabled =<%=disabled%>;
                <%}%>
                //新增变量end
                <%if(ValidateUtil.isNotEmpty(selectTreeCallback)){%>
                options.selectTreeCallback = <%=selectTreeCallback%>;
                <%}%>
                <%if (ValidateUtil.isNotEmpty(selectTreeBeforeClick)){%>
                options.selectTreeBeforeClick = <%=selectTreeBeforeClick%>;
                <%}%>
                <%if (ValidateUtil.isNotEmpty(selectTreeLoadComplete)){%>
                options.selectTreeLoadComplete = <%=selectTreeLoadComplete%>
                    <%}%>
                    <%if(ValidateUtil.isNotEmpty(cssStyle)){%>
                    options.cssStyle = "<%=cssStyle%>";
                <%}%>
                <%if (ValidateUtil.isNotEmpty(cssClass)){%>
                options.cssClass = "<%=cssClass%>";
                <%}%>
                <%if (ValidateUtil.isNotEmpty(height)){%>
                options.height = '<%=height%>';
                <%}%>
                <%if (ValidateUtil.isNotEmpty(width)){%>
                options.width = '<%=width%>';
                <%}%>
                <%if (ValidateUtil.isNotEmpty(nameKey)){%>
                options.nameKey = '<%=nameKey%>';
                <%}%>
                <%if (ValidateUtil.isNotEmpty(idKey)){%>
                options.idKey = '<%=idKey%>';
                <%}%>
                <%if (ValidateUtil.isNotEmpty(parentKey)){%>
                options.parentKey = '<%=parentKey%>';
                <%}%>
                <%if (ValidateUtil.isNotEmpty(fontCss)){%>
                options.fontCss = <%=fontCss%>;
                <%}%>
                <%if (ValidateUtil.isNotEmpty(asyncParam)){%>
                options.asyncParam = <%=asyncParam%>;
                <%}%>
                <%if (ValidateUtil.isNotEmpty(asyncParamOther)){%>
                options.asyncParamOther = <%=asyncParamOther%>;
                <%}%>
                <%if (ValidateUtil.isNotEmpty(value)){%>
                options.value = "<%=value%>";
                <%}%>
                <%if (ValidateUtil.isNotEmpty(isMultiple)){%>
					options.check = {
						enable:<%=isMultiple%>,
						chkStyle: "checkbox",
						chkboxType: { "Y": "ps", "N": "ps" }
					};
                <%}%>

                <%
					String treeData = data;
					if(treeData == null || "".equals(treeData)){
						if((treeData == null || "".equals(treeData)) && request.getAttribute(treeId) != null){
							treeData = (String)request.getAttribute(treeId);
						}
						if((treeData == null || "".equals(treeData)) && request.getSession().getAttribute(treeId) != null){
							treeData = (String)request.getSession().getAttribute(treeId);
						}
						if((treeData == null || "".equals(treeData)) && request.getSession().getAttribute(treeId) != null){
							treeData = (String)application.getAttribute(treeId);
						}
					}
				%>
                var nodesData = <%=treeData%>;
                options.nodesData = nodesData;
                Ta.core.TaUIManager.register("<%=treeId%>",new taSelectTree("dropdownTreeBackground_<%=treeId%>",options));
            });
        });
//requirejs
    }));
</script>