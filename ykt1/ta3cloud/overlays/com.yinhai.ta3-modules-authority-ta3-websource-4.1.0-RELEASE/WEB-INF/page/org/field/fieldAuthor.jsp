<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>字段采集</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body style="margin:0px;padding:1px;" class="no-scrollbar" layout="border" layoutCfg="{leftWidth:450,rightWidth:300}">
<ta:pageloading />
<ta:box position="left" key="岗位维护">
	<ta:box fit="true" cssStyle="overflow:auto;">
		<ta:fieldset id="queryPos" cols="2">
			<ta:selectTree columnWidth="0.75"  url="#"  labelWidth="60"   fontCss="treeEffective"
						   selectTreeBeforeClick="orgTreeBeforeClick"  idKey="orgid" parentKey="porgid"
						   nameKey="orgname"
						   targetDESC="pos_orgname" treeId="orgTree" targetId="pos_orgid" key="组织" required="true"/>
			<ta:box columnWidth="0.25">
				<ta:checkboxgroup id="pos_isDisDecPositions" span="2">
					<ta:checkbox key="包含子组织" checked="true" value="0"/>
				</ta:checkboxgroup>
			</ta:box>
			<ta:text id="positionname" key="岗位" placeholder="请输入岗位名称..." columnWidth="0.75" labelWidth="60"/>
			<ta:buttonGroup columnWidth="0.25" align="left">
				<ta:button key="查找" onClick="fnQueryPos();" icon="icon-search"></ta:button>
			</ta:buttonGroup>
		</ta:fieldset>
		<ta:panel key="岗位列表(灰色表示无权进行权限管理，但可以分配人员)" fit="true" hasBorder="true" cssStyle="margin-top:10px;">
			<ta:datagrid id="positionGrid" forceFitColumns="true" fit="true"  onRowClick="fnClk">
				<ta:datagridItem id="positionname" width="90" key="岗位名称" showDetailed="true"
								 sortable="true" formatter="fnPositionName"/>
				<ta:datagridItem id="orgnamepath" width="221" showDetailed="true" key="所属组织"
								 sortable="true"/>
				<ta:datagridItem id="positiontype" key="岗位类型" formatter="fnPositionType"></ta:datagridItem>
				<ta:dataGridToolPaging url="fieldAuthorMgAction!queryPosition.do" submitIds="queryPos"
									   showExcel="false" pageSize="10"/>
			</ta:datagrid>
		</ta:panel>
	</ta:box>
</ta:box>
<ta:box position="center" id="boxcenter" cssStyle="padding:10px;">
	<ta:box cols="2" fit="true">
		<ta:box fit="true" cssStyle="padding:0px 10px 0px 0px" columnWidth="0.4">
			<ta:panel fit="true" key="岗位下有使用权限的菜单">
				<ta:box fit="true" cssStyle="overflow:auto">
					<ta:tree id="authorAllMenuTree" onClick="fnGetFieldsByMenuId" childKey="menuid" parentKey="pmenuid" nameKey="menuname"></ta:tree>
				</ta:box>
			</ta:panel>
		</ta:box>
		<ta:box fit="true" columnWidth="0.6">
			<ta:panel key="权限控制字段" fit="true" headerButton='[{"id":"btnSave","name":"保存","click":"fnSaveAuthorFields()"}]'>
				<ta:datagrid id="fieldsGird" fit="true" forceFitColumns="true" >
					<ta:datagridItem id="fieldid" key="字段ID" align="center" dataAlign="left" width="100" formatter="fnFieldIdFormatter"/>
					<ta:datagridItem id="fieldname" key="字段名称" align="center" dataAlign="left" width="100" formatter="fnFieldIdFormatter"/>
					<ta:datagridItem id="look" key="查看" align="center" dataAlign="center" width="40" formatter="fnViewForMatter" click="fnViewClick"/>
					<ta:datagridItem id="edit" key="编辑" align="center" dataAlign="center" width="40" formatter="fnViewForMatter" click="fnEditClick"/>
				</ta:datagrid>
			</ta:panel>
		</ta:box>
	</ta:box>
</ta:box>
<ta:text id="positionid" display="false" />
<ta:text id="menuid" display="false" />
<ta:boxComponent height="200px" width="500px" id="b2" arrowPosition="vertical">
	<ta:datagrid id="find" fit="true" haveSn="true" forceFitColumns="true">
		<ta:datagridItem id="orgid" key="组织id" hiddenColumn="false" />
		<ta:datagridItem id="orgname" key="岗位名称" showDetailed="true" width="100" />
		<ta:datagridItem id="orgnamepath" key="岗位路径" showDetailed="true" width="300" />
	</ta:datagrid>
</ta:boxComponent>
<ta:box cssStyle="display:none">
	<ta:tree id="sortTree" childKey="id" parentKey="pid" nameKey="fieldid"/>
</ta:box>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
        $("body").taLayout();
        hideAllTreeNodes("authorAllMenuTree");
        //树判断
    });

    /**查询岗位*/
    function fnQueryPos(){
        Base.clearGridDirty("positionGrid");
        Base.submit("queryPos","fieldAuthorMgAction!queryPosition.do",null,null,null,function(){
        });
    }
    //格式化positionname,禁用的显示废除线,子孙岗位显示蓝色
    function fnPositionType(row, cell, value, columnDef, dataContext){
        if(dataContext.positiontype==1){
            return "公共岗位";
        }
        else if(dataContext.positiontype==2){
            return "个人岗位";
        }
        else{
            return "其他";
        }
    }
    //格式化positionname,禁用的显示废除线,子孙岗位显示蓝色
    function fnPositionName(row, cell, value, columnDef, dataContext){
        if(dataContext.effective == 0 && dataContext.isDescendant == 0){
            return "<span style='color:blue;text-decoration:line-through;'>"+value+"</span>";
        }else if(dataContext.effective == 0 && dataContext.isDescendant == null){
            return "<span style='text-decoration:line-through;'>"+value+"</span>";
        }else if(dataContext.isDescendant == 0 && dataContext.effective == 1){
            return "<span style='color:blue;'>"+value+"</span>";
        }else if(dataContext.iscopy == 1) {
            return "<span style='color:#C2B4B4;'>"+value+"</span>";
        }else{
            return value;
        }
    }
    <%-- 表格formatter 用于区别 effective，islock，positiontype 显示不同的颜色 --%>
    function fnNameFormatter(row, cell, value, columnDef, dataContext) {
        if (dataContext.effective == 0) {
            return "<span style='color:red;text-decoration:line-through;';>" + value + "</span>";
        }
        if (dataContext.islock == 1) {
            return "<span style='color:brown;text-decoration:line-through;'>" + value + "</span>";
        }
        if (dataContext.positiontype == 0) {
            return "<span style='color:red'>" + value + "</span>";
        }
        return value;
    }
    // 判断和提示能否删除组织
    function fnBfRemove(treeId, treeNode) {
        if (treeNode.admin != true) {
            Base.msgTopTip("你没有操作该组织权限：无法删除该组织");
            return false;
        }
        if (!treeNode.porgid || treeNode.porgid == "") {
            return Base.alert("不能删除顶级组织！", "warn"), false;
        } else if (treeNode.isParent) {
            return confirm("删除该组织会把下面的子组织一并删除,并且会删除组织相关的一切内容，确实要删除吗？");
        } else {
            return confirm("确实要删除该组织吗，删除组织会删除组织相关的一切内容，确认删除吗？");
        }
    }

    // 单击查询人员数据
    function fnClk(e, treeNode) {
        fnClickPosition(treeNode);
        Base.setValue("positionid", treeNode.positionid);
    }
    // 组织样式
    function treeEffective(treeId, treeNode){
        if(1==treeNode.isleaf){
            if(treeNode.effective == "0" && !treeNode.admin){
                return {'text-decoration':'line-through','color': 'red'};
            }else if(treeNode.effective == "0" && treeNode.admin){
                return {'text-decoration':'line-through'};
            }else if(treeNode.effective != "0" && !treeNode.admin){
                return {'color': 'red'};
            }else{
                return {'text-decoration':'none'};
            }
        }
        else{
            if(!treeNode.admin){
                return {'color': 'red'};
            }
            else{
                return {'text-decoration':'none'};
            }
        }
    }
    <%--选择某一个岗位 显示对应岗位具有权限的菜单--%>
    function fnClickPosition(treeNode) {
        Base.submit("", "<%=basePath%>org/field/fieldAuthorMgAction!queryMenusByPositionId.do", {
            "dto['positionid']" : treeNode.positionid
        }, null, null, function(data) {
            Base.recreateTree("authorAllMenuTree",null,eval(data.fieldData.authorAllMenuTree));
            Base.setDisabled("btnSave");
            Base._setGridData("fieldsGird",[]);
            if (data.fieldData.hasAuhorTreeData.length > 0) {
                var tree = $.fn.zTree.getZTreeObj("authorAllMenuTree");
                var orgnialTreeData = tree.transformToArray(tree.getNodes());
                hideAllTreeNodes("authorAllMenuTree");
                var showData = data.fieldData.hasAuhorTreeData;//显示的tree数据
                for (var i = 0; i < showData.length; i++) {
                    for ( var temp in orgnialTreeData) {
                        if (showData[i].menuid == orgnialTreeData[temp].menuid) {
                            tree.showNode(orgnialTreeData[temp]);
                            orgnialTreeData[temp].url="";
                            tree.updateNode(orgnialTreeData[temp]);

                            if (orgnialTreeData[temp].menulevel < 2) {
                                tree.expandNode(orgnialTreeData[temp], true, false, false);

                            }
                            else{
                                tree.expandNode(orgnialTreeData[temp], false, false, false);
                            }
                        }
                    }
                }
            } else {
                hideAllTreeNodes("authorAllMenuTree");;
            }
        });
        //}
        /*else{
            hideAllTreeNodes("authorAllMenuTree");;
        }*/
    }
    <%--隐藏树的全部节点--%>
    function hideAllTreeNodes(treeId) {
        var tree = $.fn.zTree.getZTreeObj(treeId);
        var orgnialTreeData = tree.transformToArray(tree.getNodes());
        tree.hideNodes(orgnialTreeData);
    }
    <%--获取菜单下面权限控制的字段信息--%>
    function fnGetFieldsByMenuId(event,treeId,treeNode){
        if(treeNode.isFiledsControl==1){
            Base.clearGridData("fieldsGird");
            Base.submit("positionid", "<%=basePath%>org/field/fieldAuthorMgAction!queryFiledsByMenuId.do",
                {
                    "dto['menuid']" : treeNode.menuid
                },
                null, null, function(data) {
                    var _gridData = Base.getGridData("fieldsGird");
                    var gridData = sortTreeData(_gridData)
                    if(gridData.length==0){
                        Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>此菜单未采集字段权限</div>");
                        return;
                    }
                    for(var i = 0 ;i < gridData.length;i++){
                        if(!gridData[i].look){
                            gridData[i].look=1;
                        }
                        if(!gridData[i].edit){
                            gridData[i].edit=1;
                        }
                        if(!gridData[i].fieldid){
                            gridData[i].fieldid=gridData[i].fieldauthrityId.fieldid;
                        }
                        if(!gridData[i].row){
                            gridData[i].row=i;
                        }
                    }
                    Base._setGridData("fieldsGird",gridData);

                    Base.setEnable("btnSave");
                    Base.setValue("menuid",treeNode.menuid);
                });
        }
        else {
            Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>此菜单未配置字段权限</div>");
            Base.setDisabled("btnSave");
            Base._setGridData("fieldsGird",[]);
        }
    }
    <%--表格查看formatter--%>
    function fnViewForMatter(row, cell, value, columnDef, dataContext){
        if(value==1){
            return "<input type='checkbox' checked='true'/>";
        }
        else {
            return "<input type='checkbox' />";
        }
    }
    <%--查看点击事件--%>
    function fnViewClick(data,e){
        if(data.look==1){
            var sc = getStartAndCount(data);
            var allData = Base.getGridData("fieldsGird");
            for(var i = sc.start;i<=(sc.count+sc.start);i++){
                var row = allData[i].row +1;
                allData[i].look = 0;
                allData[i].edit = 0 ;
                Base.setGridRowData("fieldsGird",row,allData[i]);
            }
        }
        else if(data.look==0){
            var sc = getStartAndCount(data);
            var allData = Base.getGridData("fieldsGird");
            for(var i = sc.start;i<=(sc.count+sc.start);i++){
                var row = allData[i].row +1;
                allData[i].look = 1 ;
                Base.setGridRowData("fieldsGird",row,allData[i]);
            }
        }
    }
    <%--编辑点击事件--%>
    function fnEditClick(data,e){
        if(data.edit==1){
            var sc = getStartAndCount(data);
            var allData = Base.getGridData("fieldsGird");
            for(var i = sc.start;i<=(sc.count+sc.start);i++){
                var row = allData[i].row +1;
                allData[i].edit=0;
                Base.setGridRowData("fieldsGird",row,allData[i]);
            }
        }
        else if(data.edit==0){
            var sc = getStartAndCount(data);
            var allData = Base.getGridData("fieldsGird");
            for(var i = sc.start;i<=(sc.count+sc.start);i++){
                var row = allData[i].row +1;
                allData[i].look = 1 ;
                allData[i].edit=1;
                Base.setGridRowData("fieldsGird",row,allData[i]);
            }
        }
    }
    <%--保存权限控制信息--%>
    function fnSaveAuthorFields(){
        Base.submit("menuid,positionid", "<%=basePath%>org/field/fieldAuthorMgAction!grantAuthorToFields.do",
            {
                "dto['fieldAuthor']" : Ta.util.obj2string(Base.getGridData("fieldsGird"))
            },
            null, null, function(data) {
                Base.msgTopTip("<div style='width:160px;margin:0 auto;font-size:16px;margin-top:5px;text-align:center;'>保存成功</div>");
            });
    }

    <%-- 格式化字段id--%>
    function fnFieldIdFormatter(row, cell, value, columnDef, dataContext) {
        if (dataContext.fieldlevel == "1") {
            return value;
        } else {
            var count = (dataContext.fieldlevel-2) * 1;
            return "<div style='text-indent: "+ count +"em;'><span style='color:#DBDEE4;'>┊┄</span>" + value + "</div>";
        }
    }
    <%--通过data确定起始位置，以及条数--%>
    function getStartAndCount(data){
        var allGridData = Base.getGridData("fieldsGird");
        var start = 0 ;
        var count = 0;
        for( var i = 0 ; i < allGridData.length ; i ++){
            if(allGridData[i].id==data.id){
                start = i;
                for(var j = i +1 ; j < allGridData.length ; j++){
                    if(allGridData[j].fieldlevel<= data.fieldlevel){
                        break
                    }
                    count++;
                }
                break;
            }
        }
        return {"start":start,"count":count};
    }
    <%--重新排序字段顺序 按照树的数据格式来--%>
    function sortTreeData(data){
        var treeObj = $.fn.zTree.getZTreeObj("sortTree");
        var oldnodes = treeObj.transformToArray(treeObj.getNodes());
        //删除原来的树
        for (var i = 0; i < oldnodes.length; i++) {
            treeObj.removeNode(oldnodes[i]);
        }
        //新增加现在的树
        treeObj.addNodes(null, {
            id : 1,
            pid : 1,
            fieldid : 'fieldGather',
            fieldname : '字段采集',
            fieldlevel : 0
        });
        treeObj.addNodes(treeObj.getNodes()[0], data);
        var nodes =  treeObj.transformToArray(treeObj.getNodes());
        nodes.splice(0,1);
        var sortData = [];
        for(var i = 0 ; i < nodes.length ; i ++){
            var temp = {};
            temp.id= nodes[i].id;
            temp.pid= nodes[i].pid;
            temp.fieldid= nodes[i].fieldid;
            temp.fieldname= nodes[i].fieldname;
            temp.fieldlevel= nodes[i].fieldlevel;
            temp.menuid= nodes[i].menuid;
            temp.edit = nodes[i].edit;
            temp.look = nodes[i].look;
            sortData.push(temp);
        }

        return sortData
    }
    function orgTreeBeforeClick(treeId,treeNode){
        if (treeNode.admin != true){
            Base.msgTopTip("你没有该组织的操作权限：无法操作");
            return false;
        }
    }
    function fnFomatter(row, cell, value, columnDef, dataContext) {
        if (dataContext.islock == 1) {
            return "<span style='color:red;'>" + value + "</span>";
        }
        if (dataContext.effective == 0) {
            return "<span style='text-decoration:line-through;'>" + value + "</span>";
        }
        return value;
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>