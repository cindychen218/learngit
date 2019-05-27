<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<%
    boolean isAutAdminBusinessMenu = SysConfig.getSysConfigToBoolean("isAutAdminBusinessMenu", false);
%>
<html>
<head>
    <title>新增管理员</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar no-padding">
<ta:pageloading />
<ta:panel withButtonBar="true" hasBorder="false" id="addAdminForm" fit="true" >
    <ta:box cssStyle="padding:10px;" cols="2" fit="true">
        <ta:fieldset cols="2" span="2">
            <ta:text id="username" key="姓名" placeholder="请输入姓名..." labelWidth="70" />
            <ta:buttonGroup align="left">
                <ta:button key="查询[Q]" onClick="fnSearch()" hotKey="Q" icon="icon-search" />
            </ta:buttonGroup>
        </ta:fieldset>
        <ta:box fit="true" id="contentDIV" cols="2" span="2" cssStyle="margin-top:10px;">
            <ta:box fit="true" columnWidth="0.6">
                <ta:panel id="manInfoBox"  key="人员列表(非管理员)"  fit="true">
                    <ta:datagrid id="userGrid" fit="true" forceFitColumns="true" haveSn="true" onRowClick="fnSetFastPermissionOptions" showHeaderSeach="true">
                        <ta:datagridItem id="loginid" key="登录号" width="80" searchType="default"></ta:datagridItem>
                        <ta:datagridItem id="name" key="姓名" width="80" searchType="default"></ta:datagridItem>
                        <ta:datagridItem id="orgnamepath" key="所属路径" width="600" showDetailed="true" searchType="default"></ta:datagridItem>
                        <ta:dataGridToolPaging url="adminUserMgAction!queryNoAdminUsers.do" pageSize="200" showExcel="false" submitIds="addAdminForm"></ta:dataGridToolPaging>
                    </ta:datagrid>
                </ta:panel>
            </ta:box>
            <ta:box id="fastSetBox" fit="true" cssStyle="overflow: hidden;margin-left:10px;background:white;" columnWidth="0.4">
                <ta:box height="50%" cols="2" cssStyle="border-bottom:1px dashed #ccc;">
                    <ta:box fit="true" cssStyle="line-height:25px;text-indent: 5px;">
                        <div class="title">快速设置默认管理范围</div>
                        <div id="fastsetorg" style="min-height:25px;" ></div>
                    </ta:box>
                    <ta:box fit="true" cssStyle="text-indent: 20px;line-height:25px;margin-left:10px;">
                        管理员只能授权自己所能管理的组织，如果该组织及其子组织不在管理员所能管理组织下，则不能进行授权
                    </ta:box>
                </ta:box>
                <ta:box height="50%" cols="2">
                    <ta:box fit="true"  cssStyle="line-height:25px;text-indent: 5px;">
                        <div class="title">快速设置数据区管理范围</div>
                        <div id="yab139s" style="min-height:25px;" ></div>
                    </ta:box>
                    <ta:box fit="true" cssStyle="text-indent: 20px;line-height:25px;margin-left:10px;">
                        管理员只能授权自己所能管理的数据区，如果这些数据区不包括该人员所在组织的经办机构默认数据区，则不能进行授权，只能授权包含的数据区
                    </ta:box>
                </ta:box>
            </ta:box>
        </ta:box>
    </ta:box>
    <ta:panelButtonBar align="right">
        <ta:button key="保存[S]" onClick="fnDetachAdd()" icon="icon-addTo" hotKey="S" id="btn1"/>
        <ta:button key="关闭[X]" onClick="parent.Base.closeWindow('addAdmin')" icon="icon-close2" hotKey="X"/>
    </ta:panelButtonBar>
</ta:panel>
</body>
</html>
<script type="text/javascript">
    // left:750px;
    $(document).ready(function() {
        $("body").taLayout();
        fnSearch();
    })
    //人员查询(非管理员)
    function fnSearch() {
        clearFastDiv();
        Base.submit("addAdminForm", "adminUserMgAction!queryNoAdminUsers.do");
    }
    //点击人员时设置权限快速设置里面的选项
    function fnSetFastPermissionOptions(e,rowdata){
        clearFastDiv();
        queryInfo(rowdata.positionid,rowdata.name);
    }
    /**
     * 清空
     **/
    function clearFastDiv(){
        $("#fastsetorg").html("");
        $("#yab139s").html("");
    }

    //点击保存按钮触发的事件
    function fnDetachAdd(){
        var rowData = Base.getGridSelectedRows("userGrid"); //获得表格选中行的JSON数组
        if(rowData.length == 0){
            Base.msgTopTip("请选择一个管理员!");
            return;
        }
        debugger;
        if(!<%=isAutAdminBusinessMenu%>) {
            Base.confirm("确定将此人设置为管理员？设置管理员后将删除此人的经办类菜单使用权限",function(yes){
                if(yes) {
                    fnAdd(rowData[0]);
                }
            });
        }else{
            fnAdd(rowData[0]);
        }

    }

    function fnAdd(rowData){
        var orgid = $("#orgid:checked").val();
        var yab139s = "";
        $("input[name='yab139']:checked").each(function(i){//遍历每一个名字为yab139的复选框，其中选中的执行函数
            if(i==0){
                yab139s += $(this).val();//将选中的值添加到数组yab139s中
            }else{
                yab139s += ","+$(this).val();//将选中的值添加到数组yab139s中
            }
        });
        var param = {"dto['positionid']":rowData.positionid,"dto['orgid']":orgid,"dto['yab139s']":yab139s,"dto['userid']":rowData.userid};
        Base.submit(null,"adminUserMgAction!addAdminUser.do",param,null,false,function(){
            parent.Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>保存成功</div>");
            parent.Base.submit("", "adminUserMgAction!queryAdminMgUsers.do");
            parent.Base.closeWindow("addAdmin");
        });
    }
    function queryInfo(positionid,name){
        Base.showMask();
        $.ajax({
            type:"post",
            url:"<%=path%>/org/admin/adminUserMgAction!queryForFastPermissionSettion.do",// 跳转到 action
            data:{
                "dto['positionid']":positionid
            },
            dataType:"json",
            success:function(data){
                Base.hideMask();
                var yab139CurList = data.yab139CurList;//当前用户拥有的管理权限

                var arrOrg = data.org.orgnamepath.split("/")
                var org = "<input id='orgid' type='checkbox' name='orgid' checked='checked' value='"+data.org.orgid+"'/>默认:"+name+" 的直属组织-->"+ arrOrg[arrOrg.length-1];
                $("#fastsetorg").html(org);

                var yab139s = "";

                for(i=0;i<data.datas.length;i++){  //目标用户拥有的默认数据区--
                    for(j=0;j<yab139CurList.length;j++){//当前用户（管理员）拥有的数据区权限
                        if(data.datas[i].codeValue == yab139CurList[j].codeValue){
                            yab139s += "<input id='yab139'"+i+"  type='checkbox' name='yab139' checked='checked' value='"+data.datas[i].codeValue+"'/>"+data.datas[i].codeDesc+"&nbsp;&nbsp;";
                            break;
                        }
                        if(j== yab139CurList.length - 1)
                            yab139s += "<input id='yab139'"+i+"  type='checkbox' name='yab139'  value='"+data.datas[i].codeValue+"' disabled='disabled' />"+data.datas[i].codeDesc+"&nbsp;&nbsp;";
                    }

                }
                $("#yab139s").html(yab139s);
            },
            error : function() {
                Base.hideMask();
// 	             alert("请求异常！");
            }
        });
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>