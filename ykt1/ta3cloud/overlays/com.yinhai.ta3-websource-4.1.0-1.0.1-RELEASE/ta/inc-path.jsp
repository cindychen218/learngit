<%@page import="com.yinhai.core.common.api.config.impl.SysConfig"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = path+"/";
String facePath = basePath + SysConfig.getSysConfig("FaceResourcePath") +"/"+ SysConfig.getSysConfig("FaceVersion") + "/";
String faceSkin = SysConfig.getSysConfig("FaceSkin");
request.setAttribute("basePath", basePath);
request.setAttribute("facePath", facePath);
request.setAttribute("faceSkin", faceSkin);
%>
<script>
    var Base = {};
    Base.globvar = {};
    Base.globvar.contextPath = "<%=request.getContextPath()%>";
    Base.globvar.basePath = "<%=basePath%>";
    Base.globvar.facePath = "<%=facePath%>";
    Base.globvar.currentMenuId="<%=request.getAttribute("ta3.currentmenu")%>";
    <!-- 版本、皮肤、语言 -->
    Base.globvar.FaceVersion = "<%=SysConfig.getSysConfig("FaceVersion")%>";
    Base.globvar.FaceResourcePath = "<%=SysConfig.getSysConfig("FaceResourcePath")%>";
    Base.globvar.FaceSkin = "<%=SysConfig.getSysConfig("FaceSkin")%>";
    Base.globvar.langType = '<%=response.getLocale().toString()%>';
    <!-- 可配置样式 -->
    Base.globvar.developMode = <%=SysConfig.getSysConfig("developMode", "true")%>;
    Base.globvar.isOpenErrorDetail = "<%=SysConfig.getSysConfig("isOpenErrorDetail")%>";
    Base.globvar.menuLeve1OneStyle = "<%=SysConfig.getSysConfig("menuLeve1OneStyle")%>";
    Base.globvar.menuLeve1TwoIfIcon = "<%=SysConfig.getSysConfig("menuLeve1TwoIfIcon")%>";
    Base.globvar.menuLevelThreeDropdownIfIcon = "<%=SysConfig.getSysConfig("menuLevelThreeDropdownIfIcon")%>";
    Base.globvar.menuLevelThreeStyle = "<%=SysConfig.getSysConfig("menuLevelThreeStyle")%>";
    Base.globvar.columnsWidthsOverView = <%=SysConfig.getSysConfig("columnsWidthsOverView")%>;
    Base.globvar.menuLevelThreeDropdownIfShowAll = <%=SysConfig.getSysConfig("menuLevelThreeDropdownIfShowAll")%>;
    Base.globvar.leftmenuWidth = "<%=SysConfig.getSysConfig("leftmenuWidth")%>";
    Base.globvar.pageSize = <%=SysConfig.getSysConfig("pageSize")%>;
    Base.globvar.mobileRegex = <%=SysConfig.getSysConfig("mobileRegex")%>;

</script>
<script>


    function setCookie(name, value) {
        var exp = new Date();
        exp.setTime(exp.getTime() + 365*30*24*60*60*1000);
        document.cookie = name + "="+ encodeURIComponent (value) + ";expires=" + exp.toGMTString()+";path=/";
    }

    function getCookie(cookieName) {
        var strCookie = document.cookie;
        var arrCookie = strCookie.split("; ");
        for(var i = 0; i < arrCookie.length; i++){
            var arr = arrCookie[i].split("=");
            if(cookieName == arr[0]){
                return decodeURIComponent(arr[1]);
            }
        }
        return "";
    }

    var webFaceSkin = {
        setSkin:function (skin) {
            Base.globvar.FaceSkin = skin;
            setCookie("_FaceSkin",skin);
        },
        getSkin:function () {
            var _FaceSkin = getCookie("_FaceSkin");
            Base.globvar.FaceSkin = (_FaceSkin == undefined||_FaceSkin=="")?Base.globvar["FaceSkin"]:_FaceSkin;
            return Base.globvar.FaceSkin;
        },
        apply :function (linkskin,url,skin,target){
            if (!skin) {
                skin=this.getSkin();
            }
            target = target?target:'';
            linkskin.href = url+skin+target+".css";
            this.setSkin(skin);
        }
    }
</script>

