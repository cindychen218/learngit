<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="org.owasp.esapi.ESAPI" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method" %>
<%@tag import="java.util.Random" %>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Map" %>
<%@tag import="java.util.ArrayList" %>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory" %>
<%@ tag import="com.yinhai.core.common.api.config.impl.SysConfig" %>


<%--@doc--%>
<%@tag description='文件浏览组件' display-name="text" %>
<%@attribute description='设置组件id，页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='设置文件是否允许预览,默认值true,可以点击图标预览' name='isPreview' type='java.lang.String' %>
<%@attribute description='设置文件是否允许下载,默认true,可以下载' name='isDownload' type='java.lang.String' %>
<%@attribute description='设置文件是否允许上传,默认true,显示一个上传样式图标,但是这个上传图标功能需要自己实现' name='isUpload' type='java.lang.String' %>
<%@attribute description='设置文件是否允许删除,默认true,显示删除图标' name='isRemove' type='java.lang.String' %>
<%@attribute description='设置simple模式是否显示图片缩略图,默认true,显示缩略图' name='isShowMiniView' type='java.lang.String' %>
<%@attribute description='设置预览是否显示缩略图（预览目标包括非图片文件时不推荐使用,该属性只对图片有用,默认false,不显示' name='viewWithThumbnail' type='java.lang.String' %>
<%@attribute description='设置文件请求系统请求路径，默认Base.globvar.basePath，主要用于文件并没有在本服务上的情况' name='sysPath' type='java.lang.String' %>

<%@attribute description='设置simple模式,文件元素的大小，默认100' name='eleSize' type='java.lang.String' %>
<%@attribute description='设置视频预览播放组件的高度,默认400' name='mediaHeight' type='java.lang.String' %>
<%@attribute description='设置视频预览播放组件的宽度,默认600' name='mediaWidth' type='java.lang.String' %>
<%@attribute description='设置组件office预览模式pdf/html,默认pdf，openoffice在处理pdf和html两种目标时，对某些源文件格式或者内容都存在一定的缺陷，但总的来说，除了excel表格，pdf目标格式表现的更好，注：该属性亦支持在传入数据上随同文件信息一起指定，并未强制要求fileview都必须是同一个预览目标格式' name='previewOfficeMode' type='java.lang.String' %>
<%@attribute description='设置组件展示模式,simple、list、simpleList,默认simple' name='showFileMode' type='java.lang.String' %>
<%@attribute description='设置组件预览控制条展示模式，simpleBar、boxBar,默认boxBar' name='showFileBarMode' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>

<%@attribute description='文件列表' name='datas' type='java.lang.String' %>
<%@attribute description='设置上传函数,这里会传入addFun函数 用来作为添加fileView显示使用' name='uploadFun' type='java.lang.String' %>
<%@attribute description='设置删除前校验函数,返回true那么继续执行删除,返回false,阻断删除' name='beforeRemoveFun' type='java.lang.String' %>
<%@attribute description='设置下载前校验函数,返回true 那么继续执行下载,返回false,阻断下载' name='beforeDownloadFun' type='java.lang.String' %>

<%@attribute name="height"  type="java.lang.String" description='自定义容器的高度，如:height="100px"'%>
<%@attribute name='fit' description='是否自动适应剩余高度,如果设置为true，那么该组件的所有父辈组件都要设置fit为true或height为固定值。&lt;/br&gt;该组件兄弟组件间只能有一个设置fit=true。&lt;/br&gt;如果兄弟组件在后面且可见，那么需要设置heightDiff高度补差' type='java.lang.String' %>
<%@attribute name='heightDiff' description='true/false ,当fit设置为true的时候组件底部高度补差，后同级后面的组件留下一定高度，如:heightDiff="100",不需要加px' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>

<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%--@doc--%>
<%

	String parnetIsfiledscontrol = "";
	try{
		JspTag parent = TagUtil.getTa3ParentTag(getParent());
		PropertyDescriptor pd1 = new PropertyDescriptor("fieldsAuthorization", parent.getClass());
		Method method1 = pd1.getReadMethod();
	    parnetIsfiledscontrol = (String)method1.invoke(parent);
	}catch(Exception e){
	}
	if("true".equals(parnetIsfiledscontrol)){
		fieldsAuthorization="true";
	}
// 	SecurityUtil.checkFieldStatus(fieldsAuthorization,request, id);
	if ("true".equals(fieldsAuthorization)) {
			String status = SecurityUtil.getFieldStatus(request, id);
			if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_DEFAULT.equals(status)
					|| ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_EDIT.equals(status)) {
				// 正常
			} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_ONLY_LOOK.equals(status)) {
				// 只能查看
				// disabled = "true";
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
	id = "taFileview_" + String.valueOf(nextInt);
}

IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
if(resultBean != null){
	Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
	if(v !=null && !"".equals(v)){
	   datas= JSonFactory.bean2json(v);
	}
}
//查找request
if(datas != null && !"".equals(datas) && request.getAttribute(id) != null){
	datas = JSonFactory.bean2json(request.getAttribute(id));
}
//查找session
if(datas != null && !"".equals(datas) && request.getSession().getAttribute(id) != null){
	datas = JSonFactory.bean2json(request.getSession().getAttribute(id));
}

if(datas != null && !"".equals(datas)){
	/*datas = TagUtil.replaceXSSTagValue(datas);*/
	if(SysConfig.getSysConfigToBoolean("isXSSFilter",false)){
		datas = ESAPI.encoder().encodeForHTML(datas);
	}
}
%>
<%@include file="../columnhead.tag" %>
<div id="<%=id%>" class="grid fileviewGroup-layout"
	 style="<%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
		<%if(span !=null) {%>
	 span="${span}"
		<%} %>
		<%if(columnWidth !=null) {%>
	 columnWidth="${columnWidth}"
		<%} %>
	 layout="column"
		<%if(fit !=null) {%>
	 fit="${fit}"
		<%} %>
		<%if(height !=null) {%>
	 height="${height}"
		<%} %>
		<%if(heightDiff !=null) {%>
	 heightDiff="${heightDiff}"
		<%} %>
>

	<div style="clear: both"></div>
</div>
<%@include file="../columnfoot.tag" %>
<script>
    (function (factory) {
        if (typeof require === 'function') {
            require(["jquery", "TaUIManager", "fileview"], factory);
        } else {
            factory(jQuery)
        }
    }(function ($) {

        Ta.core.TaUICreater.addUI(
            function () {
                var options = {
                    sysPath:Base.globvar.basePath,
                    <% if(datas!=null){%>
                    datas:<%=datas%>,
                    <%}%>
                    <% if(previewOfficeMode!=null){%>
                    previewOfficeMode:"${previewOfficeMode}",
                    <%}%>
                    <% if(showFileMode!=null){%>
                    showFileMode:"${showFileMode}",
                    <%}%>
                    <% if(showFileBarMode!=null){%>
                    showFileBarMode:"${showFileBarMode}",
                    <%}%>
                    <% if(isPreview!=null){%>
                    isPreview:${isPreview},
                    <%}%>
                    <% if(isDownload!=null){%>
                    isDownload:${isDownload},
                    <%}%>
                    <% if(isUpload!=null){%>
                    isUpload:${isUpload},
                    <%}%>
                    <% if(isRemove!=null){%>
                    isRemove:${isRemove},
                    <%}%>
                    <% if(isShowMiniView!=null){%>
                    isShowMiniView:${isShowMiniView},
                    <%}%>
                    <% if(uploadFun!=null){%>
                    uploadFun:${uploadFun},
                    <%}%>
                    <% if(beforeRemoveFun!=null){%>
                    beforeRemoveFun:${beforeRemoveFun},
                    <%}%>
					<% if(beforeDownloadFun!=null){%>
                    beforeDownloadFun:${beforeDownloadFun},
                	<%}%>
                    <% if(eleSize!=null){%>
                    eleWidth:${eleSize},
                    <%}%>
                    <% if(viewWithThumbnail!=null){%>
                    viewWithThumbnail:${viewWithThumbnail},
                    <%}%>
                    <% if(mediaHeight!=null){%>
                    mediaHeight:"${mediaHeight}",
                    <%}%>
                    <% if(mediaWidth!=null){%>
                    mediaWidth:"${mediaWidth}",
                    <%}%>
                };

                window.required_fileview(function () {
                    Ta.core.TaUIManager.register("<%=id%>", new TaFileView("<%=id%>", options));
                })
            });
    }));
</script>