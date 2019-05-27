<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%--@doc--%>
<%@tag description='横向和纵向锚点组件' display-name='VHanchor' %>
<%@attribute description='设置组件id，页面唯一' name='id' type='java.lang.String'  required='true'%>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='组件是水平还是竖直方向默认水平normal，竖直:vertical。vertical是固定定位；normal时想达到固定效果，可以把scrollContainerId设为同级容器，该容器cssStyle需要有滚动条样式，如：cssStyle="overflow:scroll"' name='direction' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='给该组件指定位置偏移的父容器，默认取最近的body' name='scrollContainerId' type='java.lang.String' %>
<%--@doc--%>
<%
    String className = "anchor";
    className = direction == null ? (className + " normal") : (className + " " + direction);
    if(cssClass!=null){
        className=className+" "+cssClass;
    }

    if(scrollContainerId==null){
        scrollContainerId="html,body";
    }else{
        scrollContainerId="#"+scrollContainerId;
    }

%>

<div id="<%=id%>" class="<%=className%>"
        <% if( cssStyle != null ){ %>
        style="<%=cssStyle%>"
        <%}%> >

    <%if(className.contains("vertical")){%>
    <div class="goto_top">
        <span class="faceIcon icon-arrow_top"></span>
        TOP
    </div>
    <div class="anchor-box">
        <jsp:doBody />
    </div>
    <div class="anchor-close">
        <span class="faceIcon icon-dbArrow_right"></span>
    </div>
    <%}else{ %>
    <div class="anchor-box">
        <jsp:doBody />
    </div>
    <%} %>
</div>
<script>
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI( function(){
            if(required_vhanchor){
                required_vhanchor(function () {
                    var options={};
                    <% if( scrollContainerId != null ){ %>
                    options.scrollContainerId = "<%=scrollContainerId%>";
                    <% } %>
                    var VHanchor=window.VHanchor;
                    Ta.core.TaUIManager.register('<%=id%>',new VHanchor('<%=id%>',options));
                })
            }

        });
    }));

</script>