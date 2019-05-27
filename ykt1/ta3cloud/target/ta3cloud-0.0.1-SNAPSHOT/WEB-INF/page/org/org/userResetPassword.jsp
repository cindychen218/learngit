<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<ta:panel id="passInfo" hasBorder="false" expanded="false" fit="true" bodyStyle="padding:10px 10px 0px 0px;" withButtonBar="true">
	<ta:text id="newPassword" key="登录密码" required="true"  validType='[{type:"maxLength",param:[15],msg:"最大长度为15"}]' type="password" bpopTipPosition="bottom"/>
	<ta:text id="rpassword" key="确认密码" required="true" type="password" validType='[{type:"maxLength",param:[15],msg:"最大长度为15"},{type:"compare",param:["=","newPassword"]}]' bpopTipPosition="bottom"/>
	<ta:panelButtonBar>
		<ta:button id="saveUserBtn" key="保存[S]" icon="icon-addTo" hotKey="S" onClick="fnSavePass();"/>
		<ta:button id="closeWinBtn" key="关闭[X]" icon="icon-close2"  hotKey="X" onClick="Base.closeWindow('passWin');"/>
	</ta:panelButtonBar>
</ta:panel>
<script>
    $(function () {
        Base.focus("newPassword");
    });
    function fnSavePass() {
        if (Base.getValue("newPassword") == "")
            Base.alert("新密码不能为空！", "warn");
        else if (Base.getValue("newPassword") == Base.getValue("rpassword"))
            Base.submit("passInfo,userGd", "orgUserMgAction!resetPassword.do", null, null, true, function(){
                Base.closeWindow("passWin");
            });
        else
            Base.alert("两次输入的密码不一致，请检查！", "warn");
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>