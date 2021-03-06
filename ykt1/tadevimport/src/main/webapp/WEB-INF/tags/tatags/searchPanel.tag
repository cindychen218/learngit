<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='搜索面板' display-name='searchPanel' %>
<%@attribute description='设置组件id' name='id' type='java.lang.String' %>
<%@attribute description='需要过滤对象的id(表格id)' name='listId' type='java.lang.String' required="true" %>
<%@attribute description='需要过滤的目标列(目标做成可以传入)' name='listFilterColId' type='java.lang.String' required="true" %>
<%@attribute description='是否显示搜索框,默认true' name='showSearchBar' type='java.lang.String' %>
<%@attribute description='搜索框的类型,默认text,可取值 text,number,date,collection,tree' name='searchType' type='java.lang.String' %>
<%@attribute description='指定searchPanel的宽度，如width="300px"' name='width' type='java.lang.String' %>
<%@attribute description='指定searchPanel的高度,如height="300px"' name='height' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置父容器layout为column布局的时候自定义占用容器行宽度百分比，可设置值为0-1之间的小数，如:0.1则表示占该行的1/10' name='columnWidth' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute name="fit"  type="java.lang.String" description="true/false ,是否自动适应剩余高度,如果设置为true，那么该组件的所有父辈组件都要设置fit为true或height为固定值。该组件兄弟组件间只能有一个设置fit=true。如果兄弟组件在后面且可见，那么需要设置heightDiff高度补差"%>
<%@attribute description='true/false ,当fit设置为true的时候组件底部高度补差，后同级后面的组件留下一定高度，如:heightDiff="100",不需要加px' name='heightDiff' type='java.lang.String' %>
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
    String tcssStyle = "";
    if(cssStyle != null){
        tcssStyle = cssStyle;
    }

    if (width != null) {
        tcssStyle = "width:"+width+";"+tcssStyle;
    }

    if (height != null) {
        tcssStyle = "height:"+height+";"+tcssStyle;
    }

    if(tcssStyle.trim().length()>0)
    {
        cssStyle = tcssStyle;
    }
    String tcss="";
    if(cssClass!= null){
        tcss = cssClass;
    }
    tcss=" search-panel grid " +tcss;
    cssClass=tcss;
    if ((this.id == null || this.id.length() == 0)) {
        Random RANDOM = new Random();
        int nextInt = RANDOM.nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        id = "searchPanel_" + String.valueOf(nextInt);
    }

    if(showSearchBar == null){
        showSearchBar = "true";
    }

%>

<%@include file="../columnhead.tag" %>

<div  id="<%=id%>"
        <% if( cssStyle != null ){ %>
         style="<%=cssStyle%>"
        <%}%>
        <% if( cssClass != null ){ %>
         class="<%=cssClass %>"
        <%}%>
        <% if( heightDiff != null ){ %>
      heightDiff="${heightDiff}"
        <%}%>
        <%if (span != null && !"".equals(span)) {%> span="${span}"<%} %>
        <%if (columnWidth != null && !"".equals(columnWidth)) {%> columnWidth="${columnWidth}"<%} %>
        <%if(fit !=null) {%> fit="${fit}"<%} %>
>
<%if( "true".equals(showSearchBar)){%>
    <div class="search-insert-con">

    </div>
<%}%>

    <div class="search-list-con " >
        <jsp:doBody />
    </div>

</div>
<%@include file="../columnfoot.tag" %>

<script>

    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI(
            function(){
                if(required_searchPanel){
                    required_searchPanel(
                        function () {
                            var options={};
                            options.searchType="default";
                            <% if ( searchType!= null) {%>
                              options.searchType ="<%=searchType%>";
                            <% }%>
                            <% if ( listId!= null) {%>
                            options.listId ="<%=listId%>";
                            <% }%>
                            <% if ( listFilterColId!= null) {%>
                            options.listFilterColId ="<%=listFilterColId%>";
                            <% }%>

                            var searchPanel=window.searchPanel;
                            Ta.core.TaUIManager.register("<%=id%>",new searchPanel("<%=id%>",options));


                        }
                    )
                }

            });
    }));


</script>