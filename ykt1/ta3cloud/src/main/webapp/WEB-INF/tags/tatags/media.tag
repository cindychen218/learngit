<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.ArrayList"%>
<%@tag import="java.util.List"%>
<%@tag import="java.util.Random" %>

<%-- @doc --%>
<%@tag description='多媒体组件可以用于，图片，音频，视频及word，excel的展示' display-name='media'%>
<%@attribute description='组件id' name='id' type='java.lang.String'%>
<%@attribute description='组件类型->图片:pic,音频:music,视频:video,office:office' name='type' type='java.lang.String' required="true"%>
<%@attribute description='宽度,不需要px' name='width' type='java.lang.String'%>
<%@attribute description='高度,不需要px' name='height' type='java.lang.String'%>
<%@attribute description='JSON格式字符串  多个url地址  例如:["url1","url2","url3","url4","url5","url6","url7"]' name='data' type='java.lang.String'%>
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
	if ((this.id == null || this.id.length() == 0)) {
		Random RANDOM = new Random();
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE
				? Integer.MAX_VALUE
				: Math.abs(nextInt);
		id = "tamedia_" + String.valueOf(nextInt);
	}
	if (type.equals("pic")) {
		if (width == null) {
				width = "677";
			}
		if (height == null) {
				height = "583";
		}
		String picPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<script type="text/javascript">
$(document).ready(function() {
	initLoad<%=id%>();
});
function initLoad<%=id%>(){
		function G(s){
			return document.getElementById(s);
		}
		function getStyle(obj, attr){
			if(obj.currentStyle){
				return obj.currentStyle[attr];
			}else{
				return getComputedStyle(obj, false)[attr];
			}
		}
		function Animate(obj, json){
			if(obj.timer){
				clearInterval(obj.timer);
			}
			obj.timer = setInterval(function(){
				for(var attr in json){
					var iCur = parseInt(getStyle(obj, attr));
					iCur = iCur ? iCur : 0;
					var iSpeed = (json[attr] - iCur) / 5;
					iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
					obj.style[attr] = iCur + iSpeed + 'px';
					if(iCur == json[attr]){
						clearInterval(obj.timer);
					}
				}
			}, 30);
		}

		var oPic = G("<%=id%>"+"picBox");
		var oList = G("<%=id%>"+"listBox");
		
		var oPrev = G("<%=id%>"+"prev");
		var oNext = G("<%=id%>"+"next");
		var oPrevTop = G("<%=id%>"+"prevTop");
		var oNextTop = G("<%=id%>"+"nextTop");

		var oPicLi = oPic.getElementsByTagName("li");
		var oListLi = oList.getElementsByTagName("li");
		var len1 = oPicLi.length;
		var len2 = oListLi.length;
		
		var oPicUl = oPic.getElementsByTagName("ul")[0];
		var oListUl = oList.getElementsByTagName("ul")[0];
		var w1 = oPicLi[0].offsetWidth;
		var w2 = oListLi[0].offsetWidth;

		oPicUl.style.width = w1 * len1 + "px";
		oListUl.style.width = w2 * len2 + "px";

		var index = 0;
		var num = 5;
		var num2 = Math.ceil(num / 2);

		function Change(){
			Animate(oPicUl, {left: - index * w1});
			if(index < num2){
				Animate(oListUl, {left: 0});
			}else if(index + num2 <= len2){
				Animate(oListUl, {left: - (index - num2 + 1) * w2});
			}else{
				Animate(oListUl, {left: - (len2 - num) * w2});
			}
			for (var i = 0; i < len2; i++) {
				oListLi[i].className = "";
				if(i == index){
					oListLi[i].className = "on";
				}
			}
		}
		oNextTop.onclick = oNext.onclick = function(){
			
			index ++;
			index = index == len2 ? 0 : index;
			Change();
		}
		oPrev.onmouseover = oNext.onmouseover = oPrevTop.onmouseover = oNextTop.onmouseover = function(){
			clearInterval(timer);
			}
		oPrev.onmouseout = oNext.onmouseout = oPrevTop.onmouseout = oNextTop.onmouseout = function(){
			timer=setInterval(autoPlay,4000);
			}
		oPrevTop.onclick = oPrev.onclick = function(){
			index --;
			index = index == -1 ? len2 -1 : index;
			Change();
		}
		var timer=null;
		timer=setInterval(autoPlay,4000);
		function autoPlay(){
			    index ++;
				index = index == len2 ? 0 : index;
				//Change();
			}
		for (var i = 0; i < len2; i++) {
			oListLi[i].index = i;
			oListLi[i].onclick = function(){
				index = this.index;
				Change();
			}
		}
		Change();
	}
</script>
<script type="text/javascript">
	layer.use('extend/layer.ext.js', function() {
				//初始加载即调用，所以需放在ext回调里
				layer.ext = function() {
					layer.photosPage({
						parent : '#testPicpicBox'
					});
				};
			}); 
</script>
<div id="<%=id%>" >
	<div  style="<%if (width != null) {%>width:<%=width%>px<%}%>;float:left; background:#0D0D0D;">
		<div class="mod18" style="<%if (width != null) {%>width:<%=width%>px<%}%>;">
			<span id="<%=id%>prev" 	class="btn prev" style="<%if (height != null) {%>top:<%=(int)(Float.parseFloat(height)*0.85)%>px<%}%>;width:10px;height:16px;"></span> 
			<span id="<%=id%>next" 	class="btn next" style="<%if (height != null) {%>top:<%=(int)(Float.parseFloat(height)*0.85)%>px<%}%>;width:10px;height:16px;"></span> 
			<span id="<%=id%>prevTop" 	class="btn prev" style="<%if (height != null) {%>top:<%=(int)(Float.parseFloat(height)*0.36927)%>px<%}%>;width:32px;height:48px;background:url(<%=picPath%>ta/resource/external/plugin/ta-media/img/prevBtnTop.png) 0 0 no-repeat;"></span> 
			<span id="<%=id%>nextTop" 	class="btn next" style="<%if (height != null) {%>top:<%=(int)(Float.parseFloat(height)*0.36927)%>px<%}%>;width:32px;height:48px;background:url(<%=picPath%>ta/resource/external/plugin/ta-media/img/nextBtnTop.png) 0 0 no-repeat;"></span>
			
			<div id="<%=id%>picBox" 	class="picBox" style="<%if (width != null) {%>width:<%=(int)(Float.parseFloat(width)*0.77695)%>px<%}%>;<%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.67581)%>px<%}%>;">
				<ul class="cf" style="<%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.64665)%>px<%}%>;">
					<%
						if (data != null) {
								List listTop = JSonFactory.json2bean(data, ArrayList.class);
								for (int i = 0; i < listTop.size(); i++) {
					%>
					<li style="<%if (width != null) {%>width:<%=(int)(Float.parseFloat(width)*0.77695)%>px<%}%>;<%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.67581)%>px<%}%>;"><img src="<%=listTop.get(i)%>" <%if (width != null) {%>width="<%=(int)(Float.parseFloat(width)*0.77695)%>px<%}%>" <%if (height != null) {%>height="<%=(int)(Float.parseFloat(height)*0.67581)%>px<%}%>"></li>
					<%
						}
					%>
				</ul>
			</div>
			<div id="<%=id%>listBox" class="listBox"  style="<%if (width != null) {%>width:<%=(int)(Float.parseFloat(width)*0.9483)%>px<%}%>;<%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.17152)%>px<%}%>;">
				<ul style="<%if (width != null) {%>width:<%=(int)(Float.parseFloat(width)*2.64697)%>px;left:-<%=(int)(Float.parseFloat(width)*0.75627)%>px;<%}%><%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.15094)%>px<%}%>;" class="cf">
					<%
						List listDown = JSonFactory.json2bean(data, ArrayList.class);
								for (int i = 0; i < listDown.size(); i++) {
					%>
					<li style="<%if (width != null) {%>width:<%=(int)(Float.parseFloat(width)*0.18759)%>px<%}%>;<%if (height != null) {%>height:<%=(int)(Float.parseFloat(height)*0.13207)%>px<%}%>;"><img src="<%=listTop.get(i)%>" <%if (width != null) {%>width="<%=(int)(Float.parseFloat(width)*0.15952)%>px<%}%>" <%if (height != null) {%>height="<%=(int)(Float.parseFloat(height)*0.12864)%>px<%}%>"></li>
					<%
						}
					%>
				</ul>
			</div>
			<%
				}
			%>
		</div>
	</div>
</div>
<%
	}
%>

<%
	if (type.equals("music")) {
		if (width == null) {
			width = "300";
		}
		if (height == null) {
			height = "50";
		}
		String cssStyleOuter = null;
		if (width != null) {
			if (cssStyleOuter != null) {
				cssStyleOuter += ";" + (width.endsWith("px") ? ("width:" + width) : (width.endsWith("%") ? ("width:" + width) : ("width:" + width + "px")));
			} else {
				cssStyleOuter = (width.endsWith("px") ? ("width:" + width) : (width.endsWith("%") ? ("width:" + width) : ("width:" + width + "px")));
			}
		}

		if (height != null) {
			if (cssStyleOuter != null) {
				cssStyleOuter += ";"
						+ (height.endsWith("px") ? ("height:" + (Integer.parseInt(height) + 10)) : (height.endsWith("%") ? ("height:" + (Float.parseFloat(height) + 0.05)) : ("height:"
								+ (Integer.parseInt(height) + 10) + "px")));
			} else {
				cssStyleOuter = (height.endsWith("px") ? ("height:" + (Integer.parseInt(height) + 10)) : (height.endsWith("%") ? ("height:" + (Float.parseFloat(height) + 0.05)) : ("height:"
						+ (Integer.parseInt(height) + 10) + "px")));
			}
		}
%>
<div id="<%=id%>" <%if (cssStyleOuter != null) {%> style="<%=cssStyleOuter%>" <%}%>>
	<audio <%if (width != null) {%> width="<%=width%>" <%}%> <%if (height != null) {%> height="<%=height%>" <%}%> controls="controls" preload="preload">

		<%
			if (data != null) {
					List list = JSonFactory.json2bean(data, ArrayList.class);
					for (int i = 0; i < list.size(); i++) {
		%>
		<source src="<%=list.get(i)%>"></source>
		<%
			}
				}
		%>
	</audio>
</div>
<%
	}
%>

<%
	if (type.equals("video")) {
		if (width == null) {
			width = "600";
		}
		if (height == null) {
			height = "260";
		}
		String cssStyleOuter = null;
		if (width != null) {
			if (cssStyleOuter != null) {
				cssStyleOuter += ";" + (width.endsWith("px") ? ("width:" + width) : (width.endsWith("%") ? ("width:" + width) : ("width:" + width + "px")));
			} else {
				cssStyleOuter = (width.endsWith("px") ? ("width:" + width) : (width.endsWith("%") ? ("width:" + width) : ("width:" + width + "px")));
			}
		}

		if (height != null) {
			if (cssStyleOuter != null) {
				cssStyleOuter += ";"
						+ (height.endsWith("px") ? ("height:" + (Integer.parseInt(height) + 10)) : (height.endsWith("%") ? ("height:" + (Float.parseFloat(height) + 0.05)) : ("height:"
								+ (Integer.parseInt(height) + 10) + "px")));
			} else {
				cssStyleOuter = (height.endsWith("px") ? ("height:" + (Integer.parseInt(height) + 10)) : (height.endsWith("%") ? ("height:" + (Float.parseFloat(height) + 0.05)) : ("height:"
						+ (Integer.parseInt(height) + 10) + "px")));
			}
		}
%>
<div <%if (cssStyleOuter != null) {%> style="<%=cssStyleOuter%>" <%}%>>
	<video id="<%=id%>" <%if (width != null) {%> width="<%=width%> " <%}%> <%if (height != null) {%> height="<%=height%>" <%}%> controls="controls" preload="preload">
		<%
			if (data != null) {
					List list = JSonFactory.json2bean(data, ArrayList.class);
					for (int i = 0; i < list.size(); i++) {
		%>
		<source src="<%=list.get(i)%>"></source>
		<%
			}
				}
		%>
	</video>
</div>
<%
	}
%>

<%
	if ("office".equals(type)) {
%>
<jsp:doBody />
<%
	}
%>

