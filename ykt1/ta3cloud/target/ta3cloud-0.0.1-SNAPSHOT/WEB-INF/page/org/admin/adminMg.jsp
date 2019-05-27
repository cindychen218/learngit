<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<%
	boolean isOpenMultipleAuthMode = SysConfig.getSysConfigToBoolean("isMutileOrg", false);
%>
<html>
<head>
	<title>管理员权限管理</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" style="margin:0;padding:0;">
<ta:pageloading />
<div id="hintbody" style="display:none;"></div>
<ta:box cssStyle="display:none;" id="adminInfo">
	<ta:text id="positionid"></ta:text>
	<ta:text id="name"></ta:text>
	<ta:text id="userid"></ta:text>
	<ta:text id="orgnamepath"></ta:text>
</ta:box>
<ta:box layout="border" layoutCfg="{leftWidth:475,allowLeftResize:true}">
	<ta:box position="left" cssStyle="padding:10px;background:#EEEEEE" key="管理员维护">
		<ta:panel id="panel1" fit="true" hasBorder="true" withToolBar="true">
			<ta:panelToolBar>
				<ta:buttonGroup align="center" >
					<ta:button key="新增管理员" onClick="addAdminMg()" id="addAdminbtn"/>
					<ta:button id="movePermission" key="转移权限" onClick="fnTransformAuthority()" disabled="true"/>
					<ta:button id="deletePermission" key="移除" onClick="fnDeleteAdminMg()" disabled="true"/>
				</ta:buttonGroup>
				<ta:buttonGroup align="center" >
					<ta:selectButton key="批量使用权限操作" >
						<ta:selectButtonItem key="授予权限" onClick="fnBatchPermissions(2)"  />
						<ta:selectButtonItem key="回收权限" onClick="fnBatchPermissions(1)"  />
					</ta:selectButton>
					<ta:selectButton key="批量授权权限操作"  >
						<ta:selectButtonItem key="授予权限" onClick="fnBatchPermissions(4)"  />
						<ta:selectButtonItem key="回收权限" onClick="fnBatchPermissions(3)"  />
					</ta:selectButton>
				</ta:buttonGroup>
			</ta:panelToolBar>
			<ta:datagrid fit="true" selectType="checkbox" id="adminMgGrid" onSelectChange="fnChecked" haveSn="true" showHeaderSeach="true">
				<ta:datagridItem id="name" 	key="姓名"  width="60" click="fnSetFastPermissionOptions" searchType="default"></ta:datagridItem>
				<ta:datagridItem id="orgnamepath" align="left" key="所属组织" showDetailed="true" width="190" click="fnSetFastPermissionOptions" searchType="default"></ta:datagridItem>
				<ta:datagridItem id="authmode" collection="authmode" key="权限认证方式"  width="100" click="fnSetFastPermissionOptions" searchType="collection"></ta:datagridItem>
			</ta:datagrid>
		</ta:panel>
	</ta:box>
	<ta:box position="center" id="boxcenter" cssStyle="padding:10px;">
		<ta:box  height="5%" >
			<span style="font-weight:700;padding-left:10px;width:70px;">管理员 &nbsp;&nbsp;:&nbsp;&nbsp;</span><span id="adminName" style="width:70px;font-style:italic;"></span></span>
			<span style="font-weight:700;padding-left:30px;">所属组织 &nbsp;&nbsp;:&nbsp;&nbsp;</span><span id="adminOrgnamepath" style="font-style:italic;"></span></span>
		</ta:box>
		<ta:box height="47%" cols="2">
			<ta:panel key="管理类功能权限" fit="true"  id="managePermission" headerButton="[{'id':'btn_mp','name':'更改','click':'fnAdminUsePermission(1);'}]" scalable="true">
				<ta:datagrid fit="true" id="grid1" forceFitColumns="true" haveSn="true" snWidth="35">
					<ta:datagridItem id="name"  key="功能名称"  align="center" dataAlign="left"  formatter="fnMenuname" width="500px" > </ta:datagridItem>
					<ta:datagridItem id="effecttivetime" hiddenColumn="false" key="有效期" align="center" dataAlign="center" width="100px"></ta:datagridItem>
					<ta:datagridItem id="33" key="移除权限" align="center" dataAlign="center" click="fnRemoveMgPermission" icon="icon-delete" width="60px" ></ta:datagridItem>
				</ta:datagrid>
			</ta:panel>
			<ta:panel key="授权权限" fit="true"  id="givePermission" headerButton="[{'id':'btn_gp','name':'更改','click':'fnAdminUsePermission(2);'}]"  scalable="true" cssStyle="margin-left:10px;">
				<ta:datagrid fit="true" id="grid2" haveSn="true" forceFitColumns="true" snWidth="35">
					<ta:datagridItem id="name" key="功能名称" align="center" dataAlign="left" formatter="fnMenuname" width="500px" ></ta:datagridItem>
					<ta:datagridItem id="grantPer"  key="授权权限" align="center" dataAlign="center" formatter="fnPerFormatter" width="60px" ></ta:datagridItem>
					<ta:datagridItem id="grantRePer"  key="再授权" align="center" dataAlign="center"	formatter="fnAutFormatter" width="60px" ></ta:datagridItem>
				</ta:datagrid>
			</ta:panel>
		</ta:box>
		<ta:box  height="48%"  cols="2">
			<ta:panel key="可管理的组织范围" fit="true" id="manageOrg"  scalable="true" headerButton="[{'id':'btn_mo','name':'更改','click':'fnAdminUsePermission(3);'}]">
				<ta:datagrid fit="true" id="grid3" columnFilter="true"  haveSn="true" forceFitColumns="true" snWidth="35">
					<ta:datagridItem id="orgname"  showDetailed="true"	key="组织名称" align="center" dataAlign="left"   width="150px" ></ta:datagridItem>
					<ta:datagridItem id="orgnamepath" showDetailed="true" 	key="组织路径" align="center" dataAlign="left"   width="350px" ></ta:datagridItem>
					<ta:datagridItem id="removePer" key="移除权限" align="center" dataAlign="center" click="fnRemoveOrgPermission" icon="icon-delete" width="50px" ></ta:datagridItem>
				</ta:datagrid>
			</ta:panel>
			<ta:panel key="可管理的数据区范围" fit="true" id="manageYab003Scope" cssStyle="margin-left:10px;"  scalable="true" headerButton="[{'id':'btn_my','name':'更改','click':'fnAdminUsePermission(4);'}]">
				<ta:datagrid fit="true" id="grid4" haveSn="true" forceFitColumns="true" snWidth="35">
					<ta:datagridItem id="codeDESC" 	key="数据区名称"  	align="center" dataAlign="left" width="350px" ></ta:datagridItem>
					<ta:datagridItem id="removePer" key="移除权限" 	align="center" dataAlign="center" click="fnRemoveAdminYab003Scope" icon="icon-delete" 	width="50px" ></ta:datagridItem>
				</ta:datagrid>
			</ta:panel>
		</ta:box>
	</ta:box>
</ta:box>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
        $("body").taLayout();
        fnPageGuide(parent.currentBuinessId);
        //判断是否显示认证模式
        var isOpenMultipleAuthMode = "<%=isOpenMultipleAuthMode%>";
        if(!isOpenMultipleAuthMode){
            Base.setGridColumnHidden("adminMgGrid","authmode");
        }
        else{
            Base.setGridColumnShow("adminMgGrid","authmode");
        }
    })
    function fnPageGuide(currentBuinessId){
        var data = [
            {id:$("#hintbody"),
                message:"针对管理员的功能操作。<br/>1.可增删管理员;<br/>2.修改管理员“系统管理类菜单”的使用权限；管理员的“授权权限”和“再授权权限”；管理员可管理的“组织范围”；管理员可管理的“数据区范围”；<br/>3.可转移管理员权限"
            },
            {id:$("#adminMgGrid"),
                message:"点击表格中的管理员，可以在右边的表格中查询出该管理员的相关管理功能信息"
            },
            {id:$("#managePermission"),
                message:"授权给该管理员的“系统管理类菜单”的使用权限，点击“更改”，可对该管理员的“系统管理类菜单”的使用权限进行更改"
            },
            {id:$("#givePermission"),
                message:"该管理员的菜单授权权限和再授权权限，打√表示具有权限"
            },
            {id:$("#manageOrg"),
                message:"该管理员的组织管理范围，蓝色的为可管理"
            },
            {id:$("#manageYab003Scope"),
                message:"该管理员的可管理的数据区范围"
            }
        ];
        new TaHelpTip($("body")).helpTip({
            replay : false,
            show : true,
            cookname : currentBuinessId,
            data : data
        });
    }
    //弹出新增管理员窗口
    function addAdminMg() {
        Base.openWindow("addAdmin", "新增管理员", "adminUserMgAction!toAddAdminMgUser.do", "", "850", "480", null,null,true);
    }
    //转移权限
    function fnTransformAuthority() {
        var o = Base.getGridSelectedRows("adminMgGrid");
        if (o.length == 0) {
            Base.alert("请选择管理员后再进行相关操作", "warn");
            return false;
        } else if (o.length > 1) {
            Base.alert("只能选择单条数据", "warn");
            return false;
        } else {
            Base.openWindow("transformWin", o[0].name + "->转移权限", "adminUserMgAction!toTransformAuthority.do", {
                "dto['positionid']" : o[0].positionid
            }, 625, "70%",null,null,true);
        }
    }
    //移出管理员
    function fnDeleteAdminMg() {
        var o = Base.getGridSelectedRows("adminMgGrid");
        if (o.length == 0) {
            Base.alert("请选择管理员后再进行相关操作", "warn");
            return false;
        } else if (o.length > 1) {
            Base.alert("只能选择单条数据", "warn");
            return false;
        } else {
            Base.confirm("确定删除管理员-->" + o[0].name + "?",function (yes) {
                if(yes){
                    Base.submit("", "adminUserMgAction!removeAdminMgUser.do", {
                        "dto['positionid']" : o[0].positionid
                    }, null, null, function() {
                        Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>移除管理员成功</div>");
                    })
                }
            })
        }
    }

    function fnBatchPermissions(flag) {
        var o = Base.getGridSelectedRows("adminMgGrid");
        if (o.length == 0) {
            Base.alert("请选择管理员后再进行相关操作", "warn");
            return false;
        } else {
            var str = "";
            for (var i = 0; i < o.length; i++) {
                str += o[i].positionid + ",";
            }
            str = str.substring(0, str.length - 1);
            console.log(str);
            switch (flag) {
                case 1:
                    Base.openWindow("opWin", "批量回收使用权限", "adminUserMgAction!toRecyclePermissions.do", {
                        "positionids" : str,
                        "dto['positionType']" : 2
                    }, "35%", "80%", null, null, true);
                    break;
                case 2:
                    Base.openWindow("opWin", "批量授予使用权限", "adminUserMgAction!toGrantUsePermissions.do", {
                        "positionids" : str,
                        "dto['positionType']" : 2
                    }, "35%", "80%", null, null, true);
                    break;

                case 3:
                    Base.openWindow("grantingWin","批量回收授权权限","adminUserMgAction!toRecycleAuthorityPermissions.do",{"positionids":str,"dto['positionType']":2},"70%","80%",null,null,true);
                    break;
                case 4:
                    Base.openWindow("grantingWin","批量授予授权权限","adminUserMgAction!toGrantAuthorityPermissions.do",{"positionids":str,"dto['positionType']":2},"70%","80%",null,null,true);
                    break;
                default:
                    break;
            }
        }
    }

    /**
     *复选框选中事件
     **/
    function fnChecked(rowdataArray,n){
        Base.clearGridData("grid1");
        Base.clearGridData("grid2");
        Base.clearGridData("grid3");
        Base.clearGridData("grid4");
        Base.setValue("positionid","");
        Base.setValue("name","");
        Base.setValue("userid","");
        Base.setValue("orgnamepath","");
        if(n==1)
            fnQueryPermissionInfo(rowdataArray[0]);
        else{
            $("#adminName").text("");
            $("#adminOrgnamepath").text("");
        }
        var o = Base.getGridSelectedRows("adminMgGrid");
        if (o.length == 1) {
            Base.setEnable(["movePermission","deletePermission"]);
        }else{
            Base.setDisabled(["movePermission","deletePermission"]);
        }
    }

    /**
     * 行点击事件
     **/
    function fnSetFastPermissionOptions(rowdata,e){
        Base.setSelectRowsByData("adminMgGrid",[{"positionid":rowdata.positionid}]);
    }
    /**
     * 查询被选中人员的权限信息
     **/
    function fnQueryPermissionInfo(rowdata){
        var positionid = rowdata.positionid;
        var name = rowdata.name;
        var userid = rowdata.userid;
        var orgnamepath = rowdata.orgnamepath;
        Base.setValue("positionid",positionid);
        Base.setValue("name",name);
        Base.setValue("userid",userid);
        Base.setValue("orgnamepath",orgnamepath);
        $("#adminName").text(name);
        $("#adminOrgnamepath").text(orgnamepath);
        var param = {"dto['positionid']":positionid,"dto['name']":name,"dto['userid']":userid};
        $("#boxcenter").ajaxStart(function(){
            Base.showMask("boxcenter");
        });
        $("#boxcenter").ajaxStop(function(){
            Base.hideMask();
        });
        Base.showMask("body");
        refreshGrid1(param);
        refreshGrid2(param);
        refreshGrid3(param);
        refreshGrid4(param);
    }
    var queryMask=0;
    /**
     *授权列渲染回调函数
     *参数的意思分别是行号row，列号cell，值value，该列属性信息columnDef，当前行数据dataContext，
     **/
    function fnPerFormatter(row, cell, value, columnDef, dataContext) {

        var checked1 = dataContext.checked1;
        if (checked1 == true)
            return "√";
        else
            return "";
    }
    /**
     *再授权列渲染回调函数
     *
     **/
    function fnAutFormatter(row, cell, value, columnDef, dataContext) {
        var checked2 = dataContext.checked2;
        if (checked2 == true)
            return "√";
        else
            return "";
    }

    /**
     * 弹出"管理类功能权限"页面
     **/
    function fnAdminUsePermission(flag) {
        var positionidTemp = Base.getValue("positionid");
        var nameTemp = Base.getValue("name");
        var useridTemp = Base.getValue("userid");
        var param = {"dto['positionid']":positionidTemp,"dto['name']":nameTemp,"dto['userid']":useridTemp};
        if (positionidTemp == "" && nameTemp == "") {
            Base.alert("请选择管理员后再进行相关操作", "warn");
            return false;
        }
        switch (flag) {
            case 1:
                Base.openWindow("adminUseWin", nameTemp + "->管理类功能权限", "adminUserMgAction!toFuncAdminUsePoermission2.do", {
                    "dto['positionid']" : positionidTemp,
                    "dto['positionType']" : 2
                }, 410, 450, null, function(){refreshGrid1(param)}, true);
                break;
            case 2:
                Base.openWindow("grantingWin", nameTemp + "->授权权限", "adminUserMgAction!toFuncGrantingPurview2.do", {
                    "dto['positionid']" : positionidTemp,
                    "dto['positionType']" : 2
                }, 820, 450, null, function(){refreshGrid2(param)}, true);
                break;
            case 3:
                Base.openWindow("mgScope", nameTemp + "->可管理的组织范围", "adminUserMgAction!toOrgMgScope2.do", {
                    "dto['positionid']" : positionidTemp
                }, 410, 450, null, function(){refreshGrid3(param)}, true);
                break;
            case 4:
                Base.openWindow("adminYab003Win", nameTemp + "->数据区范围", "adminUserMgAction!toAdminYab003Scope2.do", {
                    "dto['positionid']" : positionidTemp,
                    "dto['userid']" : useridTemp
                }, 410, 450, null, function(){refreshGrid4(param)}, true);
                break;
            default:
                break;
        }
    }
    /**
     * 自动刷新Grid1
     **/
    function refreshGrid1(param) {
        $.ajax({
            type:"post",
            url:"<%=path%>/org/admin/adminUserMgAction!toFuncAdminUsePoermission.do",// 跳转到 action
            data:param,
            dataType:"json",
            success:function(data){
                Base._setGridData("grid1",eval(data.lists.grid1));
                queryMask=queryMask+1;
                if(queryMask==4){
                    Base.hideMask();
                    queryMask=0;
                }
            },
            error : function() {

            }
        });
    }

    /**
     * 自动刷新Grid2
     **/
    function refreshGrid2(param) {
        $.ajax({
            type:"post",
            url:"<%=path%>/org/admin/adminUserMgAction!toFuncGrantingPurview.do",// 跳转到 action
            data:param,
            dataType:"json",
            success:function(data){
                Base._setGridData("grid2",eval(data.lists.grid2));
                queryMask=queryMask+1;
                if(queryMask==4){
                    Base.hideMask();
                    queryMask=0;
                }
            },
            error : function() {

            }
        });
    }

    /**
     * 自动刷新Grid3
     **/
    var arrayGrid3NewOrgs;
    function refreshGrid3(param) {
        $.ajax({
            type:"post",
            url:"<%=path%>/org/admin/adminUserMgAction!toOrgMgScope.do",// 跳转到 action
            data:param,
            dataType:"json",
            success:function(data){
                /*Base._setGridData("grid3",eval(data.lists.grid3));
                arrayGrid3NewOrgs = data.fieldData.grid3NewOrgs;
                newOrgsIndex = data.fieldData.grid3NewOrgsIndex;
                var hash={},orgCss={}; //组织表格的行样式
                orgCss.orgname="orgBlue";
                for(var i=0;i<arrayGrid3NewOrgs.length;i++){
                    for(var j=0;j<data.lists.grid3.list.length;j++){
                        if(data.lists.grid3.list[j].orgid == arrayGrid3NewOrgs[i].orgid){
                            hash[j] =  orgCss;
                            break;
                        }
                    }
                }
                Base.getObj("grid3").setCellCssStyles(0,hash);*/
                Base._setGridData("grid3",eval(data.lists.grid3));
                queryMask=queryMask+1;
                if(queryMask==4){
                    Base.hideMask();
                    queryMask=0;
                }
            },
            error : function()  {

            }
        });
    }

    /**
     * 自动刷新Grid4
     **/
    function refreshGrid4(param) {
        $.ajax({
            type:"post",
            url:"<%=path%>/org/admin/adminUserMgAction!queryTargetUserYab003Scope.do",// 跳转到 action
            data:param,
            dataType:"json",
            success:function(data){
                Base._setGridData("grid4",eval(data.lists.grid4));
                queryMask=queryMask+1;
                if(queryMask==4){
                    Base.hideMask();
                    queryMask=0;
                }
            },
            error : function() {

            }
        });
    }

    /**
     * 移除管理类功能权限
     **/
    function fnRemoveMgPermission(data, e) {
        var name = data.name;
        Base.confirm("确定删除功能\"" + name + "\"及其子功能的使用权限？",function (yes) {
            if(yes){
                var param = {
                    "dto['positionid']" : Base.getValue("positionid"),
                    "dto['id']" : data.id
                };
                Base.getJson("adminUserMgAction!removeMgPermission.do", param, function(data) {
                    refreshGrid1(param);
                    Base.msgTopTip("<div style='width:180px;margin:0 auto;font-size:12px;text-align:center;'>已移除  <b style='font-size:14px;text-align:center;'>" + name
                        + "</b> 权限!</div>");
                });
            }
        })
    }
    function validateGrid3(name){
        for(var i=0;i<arrayGrid3NewOrgs.length;i++){

            if(name == arrayGrid3NewOrgs[i].orgname){
                return true;
            }
            if(i== arrayGrid3NewOrgs.length-1){
                return false;
            }

        }
    }
    /**
     * 移除可管理的组织范围
     **/
    function fnRemoveOrgPermission(data, e) {
        var name = data.orgname;
        /*if(!validateGrid3(name)){
            alert("当前组织不属于该管理员，不能删除！");
            return;
        }*/
        Base.confirm("确定删除\"" + name + "\"组织的管理范围？",function (yes) {
			if(yes){
                var param = {
                    "dto['positionid']" : Base.getValue("positionid"),
                    "dto['id']" : data.orgid
                };
                Base.getJson("adminUserMgAction!removeOrgPermission.do", param, function(data) {
                    refreshGrid3(param);
                    Base.msgTopTip("<div style='width:180px;margin:0 auto;font-size:12px;text-align:center;'>已移除  <b style='font-size:14px;text-align:center;'>" + name
                        + "</b> 组织范围!</div>");
                });
			}
        })
    }

    /**
     * 移除可管理的数据区范围
     **/
    function fnRemoveAdminYab003Scope(data, e) {
        var name = data.codeDESC;
        Base.confirm("确定删除\"" + name + "\"数据区？",function (yes) {
            if(yes){
                var array = Base.getGridData("grid4");
                var param = {
                    "dto['positionid']" : Base.getValue("positionid"),
                    "dto['tCodeValue']" : data.codeValue,
                    "dto['gridData']" : Ta.util.obj2string(array)
                };
                Base.getJson("adminUserMgAction!removeAdminYab003Scope.do", param, function(d) {
                    Base.deleteGridRow("grid4",data.row);
                    Base.msgTopTip("<div style='width:200px;margin:0 auto;font-size:12px;text-align:center;'>已移除  <b style='font-size:14px;text-align:center;'>" + name
                        + "</b> 数据区范围!</div>");
                });
            }
        })
    }

    /** 格式化菜单名称*/
    function fnMenuname2(row, cell, value, columnDef, dataContext) {


        if (dataContext.orglevel == "0") {
            return "<span class='orggrid'>" + value + "</span>";
        } else {
            var count = (dataContext.orglevel) * 1;
            return "<div style='text-indent: "+ count +"em;'><span style='color:#DBDEE4;'>┊┄</span><span class='orggrid'>" + value + "</span></div>";
        }
    }
    /** 格式化菜单名称*/
    function fnMenuname(row, cell, value, columnDef, dataContext) {
        if (dataContext.menulevel == "1") {
            return value;
        } else {
            var count = (dataContext.menulevel - 1) * 1;
            return "<div style='text-indent: "+ count +"em;'><span style='color:#DBDEE4;'>┊┄</span>" + value + "</div>";
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>