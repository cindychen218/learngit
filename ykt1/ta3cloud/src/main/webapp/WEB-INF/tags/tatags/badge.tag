<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='徽标记,用于显示需要处理的消息条数等' display-name='badge' %>
<%@attribute name='id' description='设置组件id，页面唯一' type='java.lang.String' %>
<%@attribute name='span' description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' type='java.lang.String' %>
<%@attribute name='columnWidth' description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' type='java.lang.String' %>
<%@attribute name='cssClass' description='给该组件添加自定义样式class，如:cssClass="no-padding"' type='java.lang.String'%>
<%@attribute name='cssStyle' description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"表示容器顶部向内占用10个像素' type='java.lang.String'%>
<%@attribute name='cssBadge' description='徽标记设置css样式,例如:cssBadge="background-color:blue"' type='java.lang.String'%>

<%@attribute name='key' description='待处理的标题描述文字，当徽标记包裹其他组件时该属性无效' type='java.lang.String' %>
<%@attribute name='icon' description='待处理的标题图标，如：icon="icon-search"，当徽标记包裹其他组件时该属性无效' type='java.lang.String' %>
<%@attribute name='badgeKey' description='徽标记显示内容，可以是数字、文本。如：badgeKey="99"' type='java.lang.String' %>
<%@attribute name='badgeIcon' description='设置徽标记显示图标，如：badgeIcon="icon-search"' type='java.lang.String' %>
<%@attribute name='badgeMax' description='当徽标记为数字时显示的最大值，大于 badgeMax 时显示为 badgeMax+，为 0 时隐藏' type='java.lang.String' %>
<%@attribute name='badgeDisplay' description='true/false,是否显示徽标记，默认为显示：true' type='java.lang.String' %>
<%@attribute name='badgePosition' description='设置徽标记显示位置，有三种位置可选left：居左，right：居右，topRight：右上方。默认为右上方。当徽标记包裹其他组件时该属性无效，徽标记固定显示在右上方' type='java.lang.String' %>
<%@attribute name='isDot' description='true/false，徽标记是否为小圆点，默认false' type='java.lang.String' %>

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
        this.id = "badge_" + String.valueOf(nextInt);
    }
%>
<%@include file="../columnhead.tag" %>

<div class="badge-layout-Container <% if(cssClass != null ){ %> ${cssClass}<%}%>" style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%>">
    <div class="badge-Container">
        <div class="badge-key faceIcon <% if (icon != null){%> ${icon}<%}%>"><%if(key != null){ %>${key}<%}%></div>
        <sup id="<%=id%>" class="badge-sup <%if("true".equals(isDot)){%> isDot <%}%> faceIcon <% if (badgeIcon != null){%> badgeIcon ${badgeIcon}<%}%>" style="<%if("false".equals(badgeDisplay) || "none".equals(badgeDisplay)){%> display:none;<%}%> <%if(cssBadge !=null){%> <%=cssBadge%>; <%}%>"></sup>
        <div class="badge-tag-Container"><jsp:doBody /></div>
    </div>
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
                if(required_badge){
                    required_badge(function () {
                        var options = {
                            <% if (isDot != null) {%>
                            isDot : <%=isDot%>,
                            <% }%>
                            <%if (badgeKey != null) {%>
                            badgeKey : "${badgeKey}",
                            <%}%>
                            <% if (badgeMax != null) {%>
                            badgeMax : <%=badgeMax%>,
                            <% }%>
                            <% if (badgeIcon != null) {%>
                            badgeIcon : "<%=badgeIcon%>",
                            <% }%>
                            <% if (badgeDisplay != null) {%>
                            badgeDisplay : "<%=badgeDisplay%>",
                            <% }%>
                            <% if (badgePosition != null) {%>
                            badgePosition : "<%=badgePosition%>",
                            <% }%>
                        };
                        Ta.core.TaUIManager.register('<%=id%>',new TaBadge('<%=id%>',options));
                    })
                }
            });
    }));
</script>
