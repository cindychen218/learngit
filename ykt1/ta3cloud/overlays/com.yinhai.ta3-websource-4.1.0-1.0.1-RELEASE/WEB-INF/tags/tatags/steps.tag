<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='步骤条,引导用户按照流程完成任务的导航条' display-name='steps' %>
<%@attribute name='id' description='设置组件id，页面唯一' type='java.lang.String' %>
<%@attribute name='span' description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' type='java.lang.String' %>
<%@attribute name='columnWidth' description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' type='java.lang.String' %>
<%@attribute name='size' description='设定步骤数,必输，如：size="5"' type='java.lang.String' required="true" %>
<%@attribute name='current' description='指定当前步骤，从0开始记数,最大为"size-1"。默认为0。' type='java.lang.String'%>
<%@attribute name='withIcon' description='true/false，是否是带图标的步骤条，默认false' type='java.lang.String'%>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
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
<%--@doc--%>
<%
    if ((this.id == null || this.id.length() == 0)) {
        int nextInt = new Random().nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        this.id = "steps_" + String.valueOf(nextInt);
    }
%>
<%@include file="../columnhead.tag" %>
<div class="steps-layout-container" id="<%=id%>" size="<%=size%>">
    <jsp:doBody />
</div>
<%@include file="../columnfoot.tag" %>
<script>
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                if(required_steps){
                    required_steps(function () {
                        var options = {
                            <%if (size != null) {%>
                            size : "${size}",
                            <%}%>
                            <%if (current != null) {%>
                            current : "${current}",
                            <%}%>
                            <%if (withIcon != null) {%>
                            withIcon : "${withIcon}",
                            <%}%>
                        };
                        Ta.core.TaUIManager.register('<%=id%>',new TaSteps('<%=id%>',options));
                    })
                }
            });
    }));
</script>
