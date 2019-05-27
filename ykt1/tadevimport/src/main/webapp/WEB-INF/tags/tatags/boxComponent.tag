<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="java.util.Random"  %>

<%--@doc--%>
<%@tag description='悬浮框容器' display-name='boxComponent' %>
<%@attribute name="id"  type="java.lang.String" description="容器组件在页面上的唯一id" required="true"%>
<%@attribute name="cssClass"  type="java.lang.String" description="设置该容器的CSS中class样式，例如 cssClass='edit-icon'"%>
<%@attribute name="cssStyle"  type="java.lang.String" description="设置该容器的CSS中style样式，例如 cssStyle='font-size:12px'" %>
<%@attribute name="cols"  type="java.lang.String" description="当该容器对子组件布局layout=column的时候，可以设置cols参数表面将容器分成多少列，默认值为1,表示分为一列，例如 cols=2"%>
<%@attribute name="height"  type="java.lang.String" description='自定义容器的高度，如:height="100px"'%>
<%@attribute name="width"  type="java.lang.String" description='自定义容器的宽度，如:width="100px"'%>
<%@attribute name="arrowPosition"  type="java.lang.String" description='悬浮框箭头朝向，默认为horizontal，vertical表示垂直自适应，horizontal水平自适应'%>

<%@attribute name="span"  type="java.lang.String" description="设置该容器在父亲容器column布局中所跨列数，例如 span='2'"%>
<%@attribute name="columnWidth"  type="java.lang.String" description=''%>
<%@attribute name="layout"  type="java.lang.String" description='column/border,设置该容器的布局类型，例如 layout="column"'%>
<%@attribute name="layoutCfg"  type="java.lang.String" description='设置layout为border布局的时候布局的参数配置，如:layoutCfg="{leftWidth:200,topHeight:90,rightWidth:200,bottomHeight:100}"'%>
<%--@doc--%>
<%

		if(layout == null){
			layout = "column";
		}
		if(height!=null){
			if(height.endsWith("%")){
			}else if(height.endsWith("px")){
				  cssStyle="height:"+height+";"+cssStyle;
			}else{
				float  heightVal=Float.parseFloat(height);
				if(0<heightVal  && heightVal<1){
				}else{
					cssStyle="height:"+height+"px;"+cssStyle;
				}
			}
		}
		if(width!=null){
			if(width.endsWith("%")){
			}else if(width.endsWith("px")){
				  cssStyle="width:"+width+";"+cssStyle;
			}else{
				float  widthVal=Float.parseFloat(width);
				if(0<widthVal  && widthVal<1){
				}else{
					cssStyle="width:"+width+"px;"+cssStyle;
				}
			}
		}
		if(arrowPosition == null) {
			arrowPosition="horizontal";
		}
		if ((id == null || id.length() == 0)) {
			Random RANDOM = new Random();
			int nextInt = RANDOM.nextInt();
			nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
					.abs(nextInt);
			id = "tagrid_" + String.valueOf(nextInt);
		}
%>

<%@include file="../columnhead.tag" %>
<div id="<%=id%>"
	class="boxComponent"
	_position="<%=arrowPosition%>"
>
<b class="boxComponent_b"></b>
<div class="boxComponent_1 ${cssClass}"
	<%if(cssStyle !=null) {%>
	style="<%=cssStyle%>"
	<%} %> 
	<%if(cols !=null) {%>
	cols="${cols}"
	<%} %> 
	<%if(layout !=null) {%>
	layout="<%=layout %>" 
	<%} %> 
	<%if(layoutCfg !=null) {%>
	layoutCfg="${layoutCfg}"
	<%} %> 
>
<jsp:doBody />
<div style="clear:both"></div>
</div>
</div>
<script type="text/javascript">
(function(factory){
	if (typeof require === 'function') {
		require(["jquery","TaUIManager","boxComponent"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
	Ta.core.TaUICreater.addUI(
		function(){
			var options = {
				txtId:"<%=id%>"
			};

			Ta.core.TaUIManager.register("<%=id%>",new taboxcomponent(options));
		});
}));
</script>
<%@include file="../columnfoot.tag" %>