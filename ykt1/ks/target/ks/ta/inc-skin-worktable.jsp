
<%@page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" id="linkskin" >
<script>
    function applySkin(skin){
        webFaceSkin.apply(linkskin,"<%=basePath%>indexSRC/worktable/",skin,null);
    }

    applySkin();
</script>

