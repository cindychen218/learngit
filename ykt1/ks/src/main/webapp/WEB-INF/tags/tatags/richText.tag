<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='多功能上传组件' display-name='uploader' %>
<%@attribute description='组件id' name='id' type='java.lang.String' required="true" %>
<%@attribute description='组件高,px或者百分比都可以' name='height' type='java.lang.String' %>
<%@attribute description='组件宽,px或者百分比都可以' name='width' type='java.lang.String' %>
<%@attribute description='richText外部容器样式' name='cssStyle' type='java.lang.String' %>
<%@attribute description='控制提交时是html还是text，默认为html' name='submitType' type='java.lang.String' %>
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
    if(width==null){
        width = "800px";
    }
    if(height==null){
        height = "300px";
    }
    String styleStr = "width:" + width + ";height:" + height+";";
    if(cssStyle!=null && !"".equals(cssStyle)){
        styleStr += cssStyle;
    }

    if(submitType==null){
        submitType = "html";
    }
%>
<div style="<%=styleStr%>">
    <iframe scrolling="no" onload="iframeOnload()" name="richFrame_<%=id%>" src="${facePath}support/wangEditor/richTextFrame.html" frameborder="0" width="100%" height="100%"></iframe>
</div>

<script>

    var attributeObj = {
        id : "<%=id%>",
        width:"<%=width%>",
        height:"<%=height%>"
    };
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        if(required_richText){
            required_richText(function () {
                var TaRichText = window.TaRichText;

            })
        }
    }));

    function iframeOnload(){
        var options = {
            submitType:'<%=submitType%>'
        };
        Ta.core.TaUIManager.register('<%=id%>',new TaRichText('<%=id%>',options));
    }

</script>