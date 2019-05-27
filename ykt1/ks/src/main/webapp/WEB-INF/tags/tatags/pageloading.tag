<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%-- @doc --%>
<%@tag description='页面加载显示' display-name='pageloading'%>
<%@attribute description='提示信息' name='value' type='java.lang.String' %>


<div id="pageloading">
	<div class="pageloading" >
        <span class="plane"></span>
        <span class="cloud-max"></span>
        <span class="cloud-mid"></span>
        <span class="cloud-min"></span>
    </div>
	<div class="pageloading-text">
<%if(value!=null){%>
	${value}
<% }else{%>
        努力加载中...
<%}%>
	</div>
</div>