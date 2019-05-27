<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random" %>

<%-- @doc --%>
<%@tag description='多媒体组件地址' display-name='mediaUrl'%>
<%@attribute description='id' name='id' type='java.lang.String'%>
<%@attribute description='文件位置' name='url' required="true" type='java.lang.String'%>
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
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}
%>
<%
	String swfPath = request.getContextPath();
	String swfBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+swfPath+"/";
	if ((this.id == null || this.id.length() == 0)) {
		Random RANDOM = new Random();
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE
				? Integer.MAX_VALUE
				: Math.abs(nextInt);
		id = "tamediaUrl_" + String.valueOf(nextInt);
	}
	PropertyDescriptor pd = new PropertyDescriptor("type", TagUtil
			.getTa3ParentTag(getParent()).getClass());
	Method method = pd.getReadMethod();
	String st = (String) method.invoke(TagUtil
			.getTa3ParentTag(getParent()));
	PropertyDescriptor pdWidth = new PropertyDescriptor("width", TagUtil
			.getTa3ParentTag(getParent()).getClass());
	Method methodWidth = pdWidth.getReadMethod();
	String width = (String) methodWidth.invoke(TagUtil
			.getTa3ParentTag(getParent()));
	PropertyDescriptor pdHeight = new PropertyDescriptor("height", TagUtil
			.getTa3ParentTag(getParent()).getClass());
	Method methodHeight = pdHeight.getReadMethod();
	String height = (String) methodHeight.invoke(TagUtil
			.getTa3ParentTag(getParent()));
	if (st.equals("pic")) {
%>
<img src="${url}" />
<%
	}
%>
<%
	if (st.equals("music") || st.equals("video")) {
%>
<source src="${url}"></source>
<%
	}
%>

<%if("office".equals(st) ){ 
	if(width == null){
		width = "300";
	}
	if(height == null){
		height = "650";
	}
%>
<div id="<%=id%>" style="width:<%=width%>px;height:<%=height%>px;display:block"></div>
<script type="text/javascript">   
            var fp = new FlexPaperViewer(     
                '<%=swfBasePath%>FlexPaperViewer',  
                '<%=id%>', { config : {  
                SwfFile : escape('<%=url%>'),
			Scale : 0.6,
			ZoomTransition : 'easeOut',
			ZoomTime : 0.5,
			ZoomInterval : 0.2,
			FitPageOnLoad : true,
			FitWidthOnLoad : false,
			FullScreenAsMaxWindow : false,
			ProgressiveLoading : false,
			MinZoomSize : 0.2,
			MaxZoomSize : 5,
			SearchMatchAll : false,
			InitViewMode : 'SinglePage',

			ViewModeToolsVisible : true,
			ZoomToolsVisible : true,
			NavToolsVisible : true,
			CursorToolsVisible : true,
			SearchToolsVisible : true,

			localeChain : 'en_US'
		}
	});
</script>
<%} %>

