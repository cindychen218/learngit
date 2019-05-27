
<%@page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" id="linkskin" >
<link rel="stylesheet" id="linkskinHelpTip">
<link rel="stylesheet" id="linkskinWindow">
<link rel="stylesheet" id="linkskinFilePreview">
<script>
    function applySkin(skin){
        webFaceSkin.apply(linkskin,"<%=basePath%>indexSRC/css/",skin,null);
        webFaceSkin.apply(linkskinHelpTip,"<%=facePath%>skin/",skin,"/support/helpTip/helpTip");
        webFaceSkin.apply(linkskinWindow,"<%=facePath%>skin/",skin,"/support/indexWindow/indexWindow");
        webFaceSkin.apply(linkskinFilePreview,"<%=facePath%>skin/",skin,"/support/filepreview/filepreview");
        if(skin){
            location.reload();
        }
    }
    applySkin();
</script>

