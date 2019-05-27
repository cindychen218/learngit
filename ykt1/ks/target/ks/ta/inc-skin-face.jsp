
<%@page language="java" pageEncoding="UTF-8"%>
<!-- 在不后台持久化用户个性设置的条件下，为避免布局出错，必须要有默认样式 -->
<link rel="stylesheet" id="linkskinDefault" title="default" href="<%=facePath%>skin/<%=faceSkin%>/ta3Cloud.css" >
<link rel="stylesheet" id="linkskin">
<script>
    function applySkin(skin){
        webFaceSkin.apply(linkskin,"<%=facePath%>skin/",skin,"/ta3Cloud");
    }

    applySkin();
</script>

