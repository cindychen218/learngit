<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html>
<head>
	<title>导入试题</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar" style="padding:0px;margin:0px">
<ta:pageloading/>
	<ta:form id="form1">
		<ta:panel id="pnl1" cols="2">
			<ta:tree id="chapterTree" showLine="true"  showIcon="true"
					 keepLeaf="true" keepParent="true" editable="true"
					 addTitle="新增" showAddBtn="true"
					 editTitle="编辑" showEditBtn="true"
					 removeTitle="删除" showRemoveBtn="true" beforeClick="fnBeforeClick" />
			<ta:form id="frmFile" enctype="multipart/form-data" methord="post">
				<ta:text id="chapter_id" display="false"/>
				<ta:uploader id="theFile" url="questionManagementAction!batchImport.do" autoSubmit="true" submitIds="chapter_id"  multiple="false" threads="1"
                             custom="true" fileQueued="fnFileQueued" columnWidth="0.3"></ta:uploader>
			</ta:form>
			<ta:buttonLayout span="2">
				<ta:button id="export" key="导入" onClick="fnExport()"/>
				<ta:button id="save" key="保存" onClick="fnSave()"/>
			</ta:buttonLayout>
		</ta:panel>
		<ta:tabs>
			<ta:tab id="successTab" key="导入成功">
				<ta:datagrid id="dg1" fit="true" forceFitColumns="true" selectType="checkbox">
					<ta:datagridItem id="a" key="教材" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="章节" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="试题难度" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="是否子题" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="题干内容" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="提示内容" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项1" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项2" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项3" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项4" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项5" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项6" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项7" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项8" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项9" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项10" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="正确选项" dataAlign="true" showDetailed="true"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab id="failedTab" key="导入失败">
				<ta:datagrid id="dg2" fit="true" forceFitColumns="true" selectType="checkbox">
					<ta:datagridItem id="a" key="教材" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="章节" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="试题难度" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="是否子题" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="题干内容" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="提示内容" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项1" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项2" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项3" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项4" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项5" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项6" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项7" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项8" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项9" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="选项10" dataAlign="true" showDetailed="true"/>
					<ta:datagridItem id="a" key="正确选项" dataAlign="true" showDetailed="true"/>
				</ta:datagrid>
			</ta:tab>
		</ta:tabs>
	</ta:form>
</body>
</html>
<script  type="text/javascript">
	$(document).ready(function () {
		$("body").taLayout();
		getchapterTree();
	})
	function  fnExport() {
			Ta
    }
    function  fnSave(){

    }

    function fnBeforeClick(treeId, treeNode) {
		Base.setValue("chapter_id",treeNode.id);
	}

    function fnFileQueued(file){
        Base.setValue("theFile", file.name);
    }

	var getchapterTree = function(){
		Base.submit("","questionManagementAction!queryChapter.do",null,null,false,function(data){
			if(data.fieldData.str != null && data.fieldData.str != "" && data.fieldData.str != undefined){
				var str = data.fieldData.str;
				var fields = eval("("+str+")");
				Base.recreateTree("chapterTree",null,fields);
				Base.expandTree("chapterTree");
				Base.collapseTree("chapterTree");
			}

		});
	}
</script>
<%@ include file="/ta/incfooter.jsp"%>