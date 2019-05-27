<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='开关,用于两种状态之间的切换' display-name='switch' %>
<%@attribute name='id' description='设置组件id，页面唯一' type='java.lang.String' %>
<%@attribute description='组件的label标签,不支持html标签' name='key' type='java.lang.String' %>

<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='当该组件被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置label的宽度,不加px' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='设置开关宽度，不加px' name='switchWidth' type='java.lang.String' %>
<%@attribute description='设置开关高度，不加px' name='switchHeight' type='java.lang.String' %>

<%@attribute name='isOpen' description='设置开关是否打开,默认为关闭：false' type='java.lang.String' %>
<%@attribute name='disabled' description='设置开关是否不可用,默认为可用：false' type='java.lang.String' %>
<%@attribute name='display' description='设置是否显示，默认为显示：true' type='java.lang.String' %>
<%@attribute name='onClick' description='单击事件，例如:onClick="fnOnClick",在javascript中，function fnOnClick(isOpen){alert(isOpen);} //isOpen为当前开关的状态，true：开启，false：关闭' type='java.lang.String' %>
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
    if ((this.id == null || this.id.length() == 0)) {
        int nextInt = new Random().nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        this.id = "switch_" + String.valueOf(nextInt);
    }
%>

<%
    IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
    if(resultBean != null){
        Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
        if(v !=null && !"".equals(v)){
            isOpen= v.toString();
        }
    }
//查找request
    if(isOpen != null && !"".equals(isOpen) && request.getAttribute(id) != null){
        isOpen = request.getAttribute(id).toString();
    }
//查找session
    if(isOpen != null && !"".equals(isOpen) && request.getSession().getAttribute(id) != null){
        isOpen = request.getSession().getAttribute(id).toString();
    }

    if(isOpen == null){
        isOpen = "false";
    }
%>

<%@include file="../columnhead.tag" %>
<div class="switch-layout-Container <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
     style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
        <% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
        <% if(span!=null){%> span="${span}"<%}%>
>
    <% if(key!=null && !"".equals(key.trim())){%>
    <label class="switch-label" style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>">${key}</label>
    <%} %>
    <label class="switch-Container" for="<%=id%>">
        <input type="checkbox" id="<%=id%>" name="dto['<%=id%>']">
        <div class="switch-box" style="<%if (switchWidth != null){%>width:<%=switchWidth%>px;<%}%> <%if (switchHeight != null){%>height:<%=switchHeight%>px;<%}%>">
            <div class="switch-inner" style="<%if (switchHeight != null){%>width:<%=Integer.valueOf(switchHeight)-4%>px;height:<%=Integer.valueOf(switchHeight)-4%>px;left:<%=switchHeight%>px;margin-left:-<%=Integer.valueOf(switchHeight)-2%>px;<%}%>"></div>
        </div>
    </label>
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
                var options = {
                    <% if( isOpen != null){%>
                    isOpen : <%=isOpen%>,
                    <%}%>
                    <% if( disabled != null && "true".equals(disabled)){%>
                    disabled : <%=disabled%>,
                    <%}%>
                    <% if( onClick != null){ %>
                    onClick : <%=onClick%>,
                    <%}%>
                };
                Ta.core.TaUIManager.register('<%=id%>',new TaSwitch('<%=id%>',options));
            });
    }));
</script>
