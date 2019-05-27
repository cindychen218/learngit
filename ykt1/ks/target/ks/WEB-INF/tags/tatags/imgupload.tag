<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='上传组件' display-name='imgupload' %>
<%@attribute description='上传地址，' name='url' type='java.lang.String' %>
<%@attribute description='预览窗口宽度，不加px' name='width' type='java.lang.String' %>
<%@attribute description='预览窗口高度，不加px' name='height' type='java.lang.String' %>
<%@attribute description='上传按钮显示名称' name='key' type='java.lang.String' %>

<%@attribute description='上传图片前执行操作  onSubmit="fnsubmit" function fnsubmit(uploader,file)  (return false 停止上传)' name='onSubmit' type='java.lang.String' %>
<%@attribute description='选择文件发生改变触发事件  function fnchange(uploader)' name='onChange' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='设置组件id' name='id' type='java.lang.String' %>
<%@attribute description='设置是否显示' name='display' type='java.lang.String' %>
<%@attribute description='设置组件style样式' name='cssStyle' type='java.lang.String' %>
<%@attribute description='设置组件class样式' name='cssClass' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%--@doc--%>
<style>
  	.show{
  		left:0px;
  		top:30px;
  		width:0px;
  		height:0px;
  		border: 0px;
  		position: absolute;
  		overflow:hidden;
  		background:#FAFAD2;
  		z-index:1000;
  		box-shadow:5px 5px 5px #444;
		-moz-box-shadow:5px 5px 5px #444;
		-webkit-box-shadow:5px 5px 5px #444;
  	}
  	.showHeader{background:#20B2AA;height:25px;}
  	.showHeader a{font-size:14px;margin-left:5px;}
  	.preview{
  		border-bottom: 1px solid lightblue;
  		overflow-y: auto;
  	}
  	.preview .pre_chk{
  		border: 1px solid #FF7F50;
  	}
    .preview .file-name{
    	width:120px;
    	text-overflow:ellipsis;
	 	white-space:nowrap; 
		overflow:hidden; 
		margin:5px;
    }
    .preview .file-name:hover{overflow:visible;}
    .preview .progress{ height: 4px; font-size: 0; line-height: 4px; background: orange; width: 0;}
    .preview div{
    	margin:5px;
    	float:left;
    	border: 1px solid transparent;
    }
    .show button{
    	float:left;
    	width:50px;  	
    	height:30px;
    	border: 1px solid #c0c0c0;
  		border-radius: 0px;
  		cursor: pointer;
    }
    .show button:hover{
    	background:#20aaaa;
    }
   .browse{
   		background:#6495ED;
   		width:66px;
   		height:30px;
   		font-family: Microsoft YaHei, verdana;
   		font-size:12px;
   		color:#fff;
   		border:0px;
   }
   .disabled{
   		background:#6495ED;
   		font-family: Microsoft YaHei, verdana;
   		font-size:12px;
   		color:#fff;
   		border:0px;
   		opacity:0.33;
   }
   .start_upload{
   		background:#20B2AA;
   		font-family: Microsoft YaHei, verdana;
   		font-size:12px;
   		color:#fff;   
   		margin-right:5px;		
   }
   .bottom_resize{
		bottom:1px; right:1px;cursor:nw-resize; 
		position:absolute; 
		width:10px; 
		height:10px; 
		font-size:0;
	} 
  </style>
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
		if ("false".equals(display) || "none".equals(display)) {
			if (this.cssStyle == null) {
				this.cssStyle = "display:none;";
			} else {
				this.cssStyle += ";display:none;";
			}
		}

	if (cssClass == null) {
		cssClass = "sexybutton_163";
	} else {
		cssClass = "sexybutton_163 " + cssClass;
	}
		
		if ((this.id == null || this.id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tabutton_" + String.valueOf(nextInt);
		}
 %>
	
<div id="<%=id%>" 
<% if(cssStyle != null){ %>
style = "<%=cssStyle %>"
<%} %>
class="<%=cssClass %>"
<% if( toolTip != null ){ %>
title="${toolTip}" 
<%}%>
>
 	<button id="<%=id%>_browse" 
 		<% if( disabled != null && "true".equals(disabled)){ %>
 		disabled="${disabled}"
 		class="browse disabled" 
		<%}else{%>
 		class="browse" 
 	<%}%>
 	>选择图片</button>
    <div id="imgshow" class="show">
   	 	<div id="showHeader" class="showHeader" ><a>预览窗口</a></div>
    	<div id="preview" class="preview">
    	</div>
    	<div id="img_buttons">
    		<button id="start_upload" class="start_upload" style="width:80px" >开始上传</button>
    		<button id="imgAll">全选</button>
        	<button id="imgDe" >删除</button>
        	<button id="imgClose" >关闭</button>
    	</div>
    	<div id="img_resize" class="bottom_resize icon-arrow-out"></div>
    </div> 
</div>
<script>

(function(factory){
	if (typeof require === 'function') {	
		require(["jquery","TaUIManager","imgupload"], factory);		
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI( 
			function(){ 
				  var TaImgupload = window.imgupload;
				  var options = {
						url : "${url}",
						<% if( key != null){%>key :"${key}",<%}%>
						<% if( width != null){%>width :"${width}",<%}%>
						<% if( height != null){%>height :"${height}",<%}%>
						<% if( onChange != null){%>onChange :${onChange},<%}%>
						<% if( onSubmit != null){%>onSubmit :${onSubmit}<%}%>
				   	};
				  
				  Ta.core.TaUIManager.register("<%=id%>",new TaImgupload('<%=id%>',options));
			});
		}
		
		));

</script>