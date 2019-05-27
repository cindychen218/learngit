<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>
<%--@doc--%>
<%@tag description='步骤条组件stepsItem必须和steps一起用' display-name='stepsItem' %>
<%@attribute name='id' description='设置组件id，页面唯一' type='java.lang.String' %>
<%@attribute name='key' description='每个步骤的标题' type='java.lang.String' %>
<%@attribute name='description' description='每个步骤标题下方的描述性文字' type='java.lang.String' %>
<%@attribute name='icon' description='当父容器withIcon为true时，每个步骤的标题图标，如:icon="icon-add",可以到icon.css查询' type='java.lang.String' %>
<%@attribute name='iconFont' description='设置图标大小，不加px,如:iconFont="30"，默认16' type='java.lang.String' %>
<%@attribute name='textHelp' description='鼠标移至步骤条时上方显示提示信息，内容自定义。例如textHelp="提示信息"' type='java.lang.String'%>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute name='beforeSelect' description='该事件在步骤被选中前触发，如果返回 false，则不会触发步骤选中事件。如：beforeSelect="fnBeforeSelect"' type='java.lang.String' %>
<%@attribute name='onClick' description='单击事件，例如:onClick="fnOnClick",在javascript中，function fnOnClick(id,step)，id为点击步骤id，step为点击步骤的步骤数' type='java.lang.String' %>
<%@attribute name='afterSelected' description='该事件在步骤被选中后触发，例如:afterSelected="fnAfterSelected",在javascript中，function fnAfterSelected(step)，step为当前步骤的步骤数' type='java.lang.String' %>
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
    if ((this.id == null || this.id.length() == 0)) {
        int nextInt = new Random().nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        this.id = "step_" + String.valueOf(nextInt);
    }
%>
<div class="step-item" id="<%=id%>">
    <div class="step-item-status">
        <div class="step-item-line">
            <% if(icon!=null) { %>
                <div class="step-item-icon faceIcon ${icon}" style="<% if(iconFont!=null) { %> font-size: ${iconFont}px;<%}%>"></div>
            <%}%>
            <div class="step-item-spot"></div>
        </div>
    </div>
    <div class="step-item-content">
        <% if(key!=null) { %> <div class="step-item-title">${key}</div><%}%>
        <% if(description!=null) { %><div class="step-item-description">${description}</div><%}%>
    </div>
</div>
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
                            <%if (textHelp != null) {%>
                            textHelp : "${textHelp}",
                            <%}%>
                            <%if (beforeSelect != null) {%>
                            beforeSelect : "${beforeSelect}",
                            <%}%>
                            <%if (onClick != null) {%>
                            onClick : "${onClick}",
                            <%}%>
                            <%if (afterSelected != null) {%>
                            afterSelected : "${afterSelected}",
                            <%}%>
                        };
                        Ta.core.TaUIManager.register('<%=id%>',new TaStep('<%=id%>',options));
                    })
                }

            });
    }));
</script>