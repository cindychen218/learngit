<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>批量导入</title>
	<%@ include file="/ta/inc.jsp"%>
	<style>
		.uploader-label{
			height:38px; line-height:38px; font-size:14px; color: #404040; text-align:right; padding-right: 10px;
		}
	</style>
</head>
<body class="no-scrollbar">
<ta:pageloading/>
<ta:box fit="true"  id="box1">
	<ta:textarea id="uploadSm" key="批量导入说明" height="120"  labelWidth="120" readOnly="true"></ta:textarea>
	<%--<ta:buttonGroup>--%>
		<%--<ta:fileupload key="导入组织和人员" url="uploadOrgUserAction!detachUploadOrgAndUser.do" id="orgUserFile" icon="icon-setting" onSubmit="fnClearGridData"></ta:fileupload>--%>
		<%--<ta:fileupload key="导入组织" url="uploadOrgUserAction!detachUploadOrg.do" id="orgFile" icon="icon-organization" onSubmit="fnClearGridData"></ta:fileupload>--%>
		<%--<ta:fileupload key="导入人员" url="uploadOrgUserAction!detachUploadUser.do" id="userFile" icon="icon-adduser" onSubmit="fnClearGridData"></ta:fileupload>--%>
	<%----%>
	<%--</ta:buttonGroup>--%>
	<ta:box cols="3">
		<ta:box cssClass="uploader-label">导入组织和人员:</ta:box>
		<ta:uploader url="uploadOrgUserAction!detachUploadOrgAndUser.do" id="orgUserFile" span="2"></ta:uploader>
	</ta:box>
	<ta:box cols="3">
		<ta:box cssClass="uploader-label">导入组织:</ta:box>
		<ta:uploader url="uploadOrgUserAction!detachUploadOrg.do" id="orgFile" span="2"></ta:uploader>
	</ta:box>
	<ta:box cols="3">
		<ta:box cssClass="uploader-label">导入人员:</ta:box>
		<ta:uploader url="uploadOrgUserAction!detachUploadUser.do" id="userFile" span="2"></ta:uploader>
	</ta:box>
	<ta:box fit="true" cols="2">
		<ta:panel fit="true" key="本次操作导入失败的组织信息">
			<ta:datagrid id="errorOrgs" fit="true" forceFitColumns="true" columnFilter="true">
				<ta:datagridItem id="errorrow" key="错误行" width="20"></ta:datagridItem>
				<ta:datagridItem id="errormsg" key="错误信息" showDetailed="true"></ta:datagridItem>
			</ta:datagrid>
		</ta:panel>
		<ta:panel fit="true" key="本次操作导入失败的人员信息" cssStyle="margin-left:10px;">
			<ta:datagrid id="errorUsers" fit="true" forceFitColumns="true" columnFilter="true">
				<ta:datagridItem id="errorrow" key="错误行" width="20"></ta:datagridItem>
				<ta:datagridItem id="errormsg" key="错误信息" showDetailed="true"></ta:datagridItem>
			</ta:datagrid>
		</ta:panel>
	</ta:box>
</ta:box>

</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
// 	$("#uploadSm").css({"resize":"none","fontSize":"14px","lineHeight":"20px"});
// 	$("#uploadSm").parent().css({"border":"0px","boxShadow":"none"});
    });
    function fnClearGridData(){
        Base.clearGridData("errorOrgs");
        Base.clearGridData("errorUsers");
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>