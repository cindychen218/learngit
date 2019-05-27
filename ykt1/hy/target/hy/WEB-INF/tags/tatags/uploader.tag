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
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置父容器layout为column布局的时候自定义占用容器行宽度百分比，可设置值为0-1之间的小数，如:0.1则表示占该行的1/10' name='columnWidth' type='java.lang.String' %>
<%@attribute description='当该容器被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>
<%@attribute description='上传地址，后台action中需定义File成员变量及getset方法（File数组-多文件）' name='url' type='java.lang.String' %>
<%@attribute description='后台接收参数名,默认id' name='name' type='java.lang.String' %>
<%@attribute description='true/false,设置是否为多文件上传，默认为false' name='multiple' type='java.lang.String' %>
<%@attribute description='设置传入参数，例如{"dto.userId" : "2323", "dto.userName" : "lins"}' name='parameter' type='java.lang.String' %>
<%@attribute description='设置要提交的表单ids,用逗号分隔' name='submitIds' type='java.lang.String' %>
<%@attribute description='true/false,设置button是否为自动上传，默认为false，false则需手动调用方法上传' name='autoSubmit' type='java.lang.String' %>
<%@attribute description='上传并发数。允许同时最大上传进程数。' name='threads' type='java.lang.String' %>
<%@attribute description='设置分片上传属性，不设置则默认不使用分片,如：chunkedOptions="{chunked:true,chunkSize:5242880,chunkRetry:2}"' name='chunkedOptions' type='java.lang.String' %>
<%@attribute description='设置组件id' name='id' type='java.lang.String' %>
<%@attribute description='设置组件为图片上传模式，此模式下文件列表会生成图片缩略图' name='imageUp' type='java.lang.String' %>
<%@attribute description='图片预览大小，设置宽高(默认120*80)，"120*80" 宽120px,高80px' name='previewSize' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='根据类名绑定选择文件按钮，多个按钮选择文件的情况下可以使用' name='selectByClass' type='java.lang.String' %>
<%@attribute description='拖拽上传，文件拖拽的区域id，例如：页面上有<div id="upArea"></div> ，设置dndArea="upArea"' name='dndArea' type='java.lang.String' %>
<%@attribute description="当开始上传流程时触发" name="startUpload" type="java.lang.String" %>
<%@attribute description="某个文件开始上传前触发，一个文件只会触发一次，传入当前file对象" name="uploadStart" type="java.lang.String" %>
<%@attribute description="当所有文件上传成功时触发" name="uploadFinished" type="java.lang.String" %>
<%@attribute description="当前文件上传出错时触发,传入两个参数，file对象 和 reason 出错的code" name="uploadError" type="java.lang.String" %>
<%@attribute description="当前文件上传成功时触发,传入两个参数,file对象 和 服务端返回的数据response，可用框架setData给response设置返回数据" name="uploadSuccess" type="java.lang.String" %>
<%@attribute description="不管成功或失败，单个文件上传完成时触发，参数file" name="uploadComplete" type="java.lang.String" %>
<%@attribute description='自定义模式，自定义各种接口，不按照框架默认' name='custom' type='java.lang.String' %>
<%@attribute description="当有文件被添加进队列的时候触发回调，参数file，注：仅在custom模式下有用" name="fileQueued" type="java.lang.String" %>
<%@attribute description="当文件被移除队列时触发回调，参数file，注：仅在custom模式下有用" name="fileDequeued" type="java.lang.String" %>
<%@attribute description="文件上传过程中创建进度条实时显示回调，参数file,percentage(百分比)，注：仅在custom模式下有用" name="uploadProgress" type="java.lang.String" %>


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

    Random RANDOM = new Random();
    int nextInt = RANDOM.nextInt();
    nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
            .abs(nextInt);
    String pid = "uploader_" + String.valueOf(nextInt);

    if(name == null || "".equals(name)){
        name = id;
    }

    if(selectByClass==null){
        selectByClass = "";
    }
%>

<%@include file="../columnhead.tag" %>
<% if("true".equals(custom)){%>
<div style="height: 19px;min-width: 56px;" class="tabutton basebutton hollow btn-main normal webuploader-choose <%=selectByClass%>" id="<%=id%>"
    style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
>
    <span>选择文件</span>
</div>
<%}else{%>
<div
        <%if (span != null && !"".equals(span)) {%>
        span="${span}"
        <%} %>
        <%if (columnWidth != null && !"".equals(columnWidth)) {%>
        columnWidth="${columnWidth}"
        <%} %>
        style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
        id="<%=pid%>"
>
    <div class="wu-example">
        <div>
            <div style="height:19px;min-width: 56px;" class="tabutton basebutton hollow btn-main normal webuploader-choose <%=selectByClass%>" id="<%=id%>"><span>选择文件</span>
            </div>
            <button class="tabutton basebutton solid btn-main normal webuploader-start" id="<%=id%>_up">
                <span class='button-icon icon-shangchuan faceIcon'></span>
                <span class="button-text">开始上传</span>
            </button>
            <div class="tabutton webuploader-show" id="<%=id%>_show">展示上传内容<a class="faceIcon icon-arrow2_up "></a>
            </div>
            <div style="clear: both;"></div>
        </div>
        <div class="webuploader-list-box">
            <div id="<%=id%>_thelist" class="webuploader-list"></div>
        </div>
    </div>
</div>
<%}%>

<%@include file="../columnfoot.tag" %>

<script>

    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI( function(){
                if(required_uploader){
                    required_uploader(function () {
                        var TaWebuploader = window.TaWebuploader;
                        var options = {
                            pid:"<%=pid%>",
                            swf: "${facePath}support/webuploader/Uploader.swf",
                            url : "${url}",
                            name : "<%=name%>",
                            <% if(imageUp !=null) {%>imageUp:${imageUp},<%}%>
                            <% if( multiple != null){%>multiple : ${multiple}, <%}%>
                            <% if( parameter != null){%>param :$.extend({"ta_tag":"uploader"},${parameter}),<%}else{%>param: {"ta_tag":"uploader"},<%}%>
                            <% if( submitIds != null){%>submitIds :'${submitIds}',<%}%>
                            <% if( autoSubmit != null){%>autoSubmit :${autoSubmit},<%}%>
                            <% if( dndArea != null){%>dndArea :"${dndArea}",<%}%>
                            <% if( startUpload != null){%>startUpload :${startUpload},<%}%>
                            <% if( uploadStart != null){%>uploadStart :${uploadStart},<%}%>
                            <% if( uploadFinished != null){%>uploadFinished :${uploadFinished},<%}%>
                            <% if( uploadError != null){%>uploadError :${uploadError},<%}%>
                            <% if( uploadSuccess != null){%>uploadSuccess :${uploadSuccess},<%}%>
                            <% if(threads!=null){%>threads :${threads},<%}%>
                            <% if(previewSize!=null){%>previewSize :"${previewSize}",<%}%>
                            <% if(custom!=null){%>custom:${custom},<%}%>
                            <% if(selectByClass!=null){%>selectByClass:"${selectByClass}",<%}%>
                            <% if(fileQueued!=null){%>fileQueued:${fileQueued},<%}%>
                            <% if(fileDequeued!=null){%>fileDequeued:${fileDequeued},<%}%>
                            <% if(uploadProgress!=null){%>uploadProgress:${uploadProgress},<%}%>
                            <% if(uploadComplete!=null){%>uploadComplete:${uploadComplete},<%}%>
                            <% if(chunkedOptions!=null){%>chunkedOptions:${chunkedOptions},<%}%>
                        };

                        Ta.core.TaUIManager.register('<%=id%>',new TaWebuploader('<%=id%>',options));
                    })
                }
        });

    }));


</script>