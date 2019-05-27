<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil" %>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>

<%--@doc--%>
<%@tag display-name="TaTree" description="树组件"%>
<%@attribute description='设置组件id' name='id' required='true' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='节点被点击触发事件' name='onClick' type='java.lang.String' %>
<%@attribute description='节点双击触发事件' name='onDblClick' type='java.lang.String' %>
<%@attribute description='设置节点数据，数组格式，例如data="[{id:1,pId:0,name:"中国"},{id:11,pId:1,name:"四川"}]"，但是优先会采用后台传回的数据' name='data' type='java.lang.String' %>
<%@attribute description='设置节点数据是否采用简单 Array 格式，true或false，默认true' name='isSimpleData' type='java.lang.String' %>
<%@attribute description='设置节点父子关系中子节点的标示属性，也是每个节点的唯一标示属性名称，默认为"id"，当 isSimpleData 为true时有效' name='childKey' type='java.lang.String' %>
<%@attribute description='设置节点父子关系中父节点的标示属性，默认为"pId"，当 isSimpleData 为true时有效' name='parentKey' type='java.lang.String' %>
<%@attribute description='设置显示节点名称的属性名，默认为"name"' name='nameKey' type='java.lang.String' %>
<%@attribute description='设置节点中保存勾选状态的属性名，默认为"checked"' name='checkedKey' type='java.lang.String' %>
<%@attribute description='设置是否异步获取子节点数据，true或false，默认false' name='async' type='java.lang.String' %>
<%@attribute description='设置异步获取子节点数据的 URL 地址' name='asyncUrl' type='java.lang.String' %>
<%@attribute description='设置异步时提交的与节点数据相关的必需属性，数组格式，例如asyncParam="["id","checked"]"' name='asyncParam' type='java.lang.String' %>
<%@attribute description='设置异步时提交的节点属性值之外的其他静态键值对数据，数组或json格式，例如asyncParamOther="[key,vlaue]"，asyncParamOther="{key1:value1, key2:value2}"' name='asyncParamOther' type='java.lang.String' %>
<%@attribute description='指定对异步返回数据进行预处理的函数，函数定义示例:fnAjaxDataFilter(treeId, parentNode, childNodes)' name='asyncDataFilter' type='java.lang.String' %>
<%@attribute description='设置节点上是否显示选择框，true或false，默认false' name='checkable' type='java.lang.String' %>
<%@attribute description='设置节点选择框的类型是复选框还是单选框，checkbox或radio，默认checkbox，checkable为true时有效' name='checkStyle' type='java.lang.String' %>
<%@attribute description='配置 radio 的分组范围是每一级还是整棵树，level或all，默认为level，当checkable为true且checkStyle="radio"时有效' name='checkRadioType' type='java.lang.String' %>
<%@attribute description='指定一个函数，当节点选择框被点击后最先触发，函数定义示例:fnBeforeCheck(treeId, treeNode)' name='beforeCheck' type='java.lang.String' %>
<%@attribute description='指定节点的onCheck事件函数，在节点选择框被点击时触发，函数定义示例:fnOnCheck(event, treeId, treeNode)' name='onCheck' type='java.lang.String' %>
<%@attribute description='设置是否显示节点图标，默认值true，也可以是一个返回boolean值的函数的名称，函数定义示例:fnShowIcon(treeId, treeNode)' name='showIcon' type='java.lang.String' %>
<%@attribute description='设置是否显示节点之间的连线，默认为true' name='showLine' type='java.lang.String' %>
<%@attribute description='设置节点展开、折叠时的动画速度，或取消动画，可选的值有（"slow", "normal", "fast", "", 数字毫秒值），默认为"fast"' name='expandSpeed' type='java.lang.String' %>
<%@attribute description='设置个性化文字样式，只针对显示的节点名称，json格式，如:{color:"#ff0011", background:"blue"}，也可设置为一个函数名称，该函数返回json格式的样式，函数定义示例:fnSetFont(treeId, treeNode)' name='fontCss' type='java.lang.String' %>
<%@attribute description='设置tree是否处于编辑状态，默认false，当设置为true即可编辑时将不会对节点url地址进行响应。' name='editable' type='java.lang.String' %>
<%@attribute description='当 editable = true 时，设置是否显示节点编辑按钮，默认true。' name='showEditBtn' type='java.lang.String' %>
<%@attribute description='当 editable = true 时，设置是否显示节点删除按钮，默认true。' name='showRemoveBtn' type='java.lang.String' %>
<%@attribute description='当 editable = true 时，确定拖拽操作是否允许移动节点，默认true。&lt;br/&gt;规则说明:&lt;br/&gt;1、dragCopy = true; dragMove = true 时，拖拽节点按下 Ctrl 键表明 copy 否则为 move&lt;br/&gt;2、dragCopy = true; dragMove = false 时，所有拖拽操作都是 copy&lt;br/&gt;3、dragCopy = false; dragMove = true 时，所有拖拽操作都是 move&lt;br/&gt;4、dragCopy = false; dragMove = false 时，禁止拖拽操作' name='dragMove' type='java.lang.String' %>
<%@attribute description='当 editable = true 时，确定拖拽操作是否允许复制节点，默认false。&lt;br/&gt;规则说明:&lt;br/&gt;1、dragCopy = true; dragMove = true 时，拖拽节点按下 Ctrl 键表明 copy 否则为 move&lt;br/&gt;2、dragCopy = true; dragMove = false 时，所有拖拽操作都是 copy&lt;br/&gt;3、dragCopy = false; dragMove = true 时，所有拖拽操作都是 move&lt;br/&gt;4、dragCopy = false; dragMove = false 时，禁止拖拽操作' name='dragCopy' type='java.lang.String' %>
<%@attribute description='设置在拖拽节点时是否锁定节点父节点属性，即保持isParent=true，默认false' name='keepParent' type='java.lang.String' %>
<%@attribute description='设置在拖拽节点时是否锁定节点叶子节点属性，即保持isParent=false，默认false' name='keepLeaf' type='java.lang.String' %>
<%@attribute description='该事件在节点的编辑按钮被点击后最先触发，如果返回 false，则不会进入节点名称编辑状态和触发onEdit事件。函数定义示例:fnBeforeEdit(treeId, treeNode)' name='beforeEdit' type='java.lang.String' %>
<%@attribute description='该事件在节点的删除按钮被点击后最先触发，如果返回 false，则不会触发onRemove事件。函数定义示例:fnBeforeRemove(treeId, treeNode)' name='beforeRemove' type='java.lang.String' %>
<%@attribute description='该事件在节点开始被拖拽时最先触发，如果返回 false，则不会触发onDrag事件。函数定义示例:fnBeforeDrag(treeId, treeNode)' name='beforeDrag' type='java.lang.String' %>
<%@attribute description='该事件在节点拖拽操作结束时最先触发，如果返回 false，则不会触发onDrop事件。函数定义示例:fnBeforeDrop(treeId, treeNode, targetNode, moveType, isCopy)' name='beforeDrop' type='java.lang.String' %>
<%@attribute description='该事件在编辑节点名称完毕并生效后触发，即 编辑输入框 onblur 事件后触发。函数定义示例:fnOnEdit(event, treeId, treeNode)' name='onEdit' type='java.lang.String' %>
<%@attribute description='该事件在点击节点的删除按钮后触发。函数定义示例:fnOnRemove(event, treeId, treeNode)' name='onRemove' type='java.lang.String' %>
<%@attribute description='该事件在节点开始被拖拽时触发。函数定义示例:fnOnDrag(event, treeId, treeNode)' name='onDrag' type='java.lang.String' %>
<%@attribute description='该事件在节点拖拽操作结束时触发。函数定义示例:fnOnDrop(event, treeId, treeNode, targetNode, moveType)' name='onDrop' type='java.lang.String' %>
<%@attribute description='该事件在节点被点击后最先触发，如果返回 false，则不会触发onClick事件，函数定义示例:fnBeforeClick(treeId, treeNode)' name='beforeClick' type='java.lang.String' %>
<%@attribute description='该事件在节点被双击后最先触发，如果返回 false，则不会触发onDblclick事件，函数定义示例:fnBeforeDblclick(treeId, treeNode)' name='beforeDblclick' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标右键单击后最先触发，如果返回 false，则不会触发onRightClick事件，函数定义示例:fnBeforeRightClick(treeId, treeNode)' name='beforeRightClick' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标右键点击后触发，函数定义示例:fnOnRightClick(event, treeId, treeNode)' name='onRightClick' type='java.lang.String' %>
<%@attribute description='该事件在点击处于折叠状态父节点的(+)图标或双击该节点后触发，如果返回 false，则不会触发onExpand事件，函数定义示例:fnBeforeExpand(treeId, treeNode)' name='beforeExpand' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标点击导致展开后触发，函数定义示例:fnOnExpand(event, treeId, treeNode)' name='onExpand' type='java.lang.String' %>
<%@attribute description='该事件在点击处于展开状态父节点的(-)图标或双击该节点后触发，如果返回 false，则不会触发onCollapse事件，函数定义示例:fnBeforeCollapse(treeId, treeNode)' name='beforeCollapse' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标点击导致折叠后触发，函数定义示例:fnOnCollapse(event, treeId, treeNode)' name='onCollapse' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标按键按下后最先触发，如果返回 false，则不会触发onMouseDown事件，函数定义示例:fnBeforeMouseDown(treeId, treeNode)' name='beforeMouseDown' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标按键按下后触发，函数定义示例:fnOnMouseDown(event, treeId, treeNode)' name='onMouseDown' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标按键抬起后最先触发，如果返回 false，则不会触发onMouseUp事件，函数定义示例:fnBeforeMouseUp(treeId, treeNode)' name='beforeMouseUp' type='java.lang.String' %>
<%@attribute description='该事件在节点被鼠标按键抬起后触发，函数定义示例:fnOnMouseUp(event, treeId, treeNode)' name='onMouseUp' type='java.lang.String' %>
<%@attribute description='该事件在节点被加入到树组件内渲染完毕后触发，函数定义示例:fnOnNodeCreated(event, treeId, treeNode)' name='onNodeCreated' type='java.lang.String' %>
<%@attribute description='该事件在节点需要异步加载时最先触发，如果返回false，则中断异步加载事件，也不会触发asyncSuccess和asyncError回调函数，函数定义示例:fnBeforeAsync(treeId, treeNode)' name='beforeAsync' type='java.lang.String' %>
<%@attribute description='该事件在异步操作结束并成功时触发，函数定义示例:fnAsyncSuccess(event, treeId, treeNode, msg), msg参数是异步获取的节点数据字符串，便于调试使用' name='asyncSuccess' type='java.lang.String' %>
<%@attribute description='该事件在异步操作结束并失败时触发，函数定义示例:fnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown), 后面3个参数参考jQuery API' name='asyncError' type='java.lang.String' %>
<%@attribute description='指定在编辑状态时鼠标移到节点上是否显示add按钮，默认false' name='showAddBtn' type='java.lang.String' %>
<%@attribute description='该事件在节点add按钮被点击后立刻触发，如果返回false，则不会触发onAdd事件，函数定义示例:fnBeforeAdd(treeId, treeNode)' name='beforeAdd' type='java.lang.String' %>
<%@attribute description='节点add按钮点击事件，函数定义示例:fnAdd(event, treeId, treeNode)' name='onAdd' type='java.lang.String' %>
<%@attribute description='指定在编辑状态时鼠标移到节点上是否显示accept按钮，默认false' name='showAcceptBtn' type='java.lang.String' %>
<%@attribute description='该事件在节点accept按钮被点击后立刻触发，如果返回false，则不会触发onAccept事件，函数定义示例:fnBeforeAccept(treeId, treeNode)' name='beforeAccept' type='java.lang.String' %>
<%@attribute description='节点accept按钮点击事件，函数定义示例:fnAccept(event, treeId, treeNode)' name='onAccept' type='java.lang.String' %>
<%@attribute description='设置鼠标移到edit按钮上时要显示的提示信息' name='editTitle' type='java.lang.String' %>
<%@attribute description='设置鼠标移到remove按钮上时要显示的提示信息' name='removeTitle' type='java.lang.String' %>
<%@attribute description='设置鼠标移到add按钮上时要显示的提示信息' name='addTitle' type='java.lang.String' %>
<%@attribute description='设置鼠标移到accept按钮上时要显示的提示信息' name='acceptTitle' type='java.lang.String' %>
<%@attribute description='设置 checkbox 的勾选操作对于父子节点的关联关系，默认值:{"Y":"ps", "N":"ps"}&lt;br/&gt;JSON格式说明:&lt;br/&gt;Y 属性定义 checkbox 被勾选后的情况；&lt;br/&gt;N 属性定义 checkbox 取消勾选后的情况；&lt;br/&gt;p 表示操作会影响父级节点；&lt;br/&gt;s 表示操作会影响子级节点。&lt;br/&gt;请注意大小写，不要改变' name='chkboxType' type='java.lang.String' %>
<%@attribute description='用于修正根节点父节点数据，即 parentKey 指定的属性值，默认为空' name='rootPId' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>

<%@attribute description='是否显示搜索框，默认false' name='showSearch' type='java.lang.String' %>
<%@attribute description='搜索框描述label' name='searchLabel' type='java.lang.String' %>
 <%@attribute description='搜索范围，指定字段(多个字段用逗号隔开)，默认 namekey ' name='searchColumn' type='java.lang.String' %>
<%@attribute description='label占的宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='输入框的宽度' name='inputWidth' type='java.lang.String' %>
<%@attribute description='label自定义样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='定义搜索面板内容（注意：tId是保留的树节点ID字段，且用户自定义列信息时，如果tId、childKey、namekey列不存在于表格列配置时则会按后面的默认值配置默认添加到第一列），格式[{id:"xx",key:"xx",hiddenColumn:true/false},{id:"xx",key:"xx",hiddenColumn:true/false}...],默认值[{id:"tId",key:"tId",hiddenColumn:true},{id:"childKey",key:"childKey",hiddenColumn:true},{id:"namekey",key:"namekey",hiddenColumn:false}...],其中hiddenColumn默认false,width默认100' name='searchPanelGrid' type='java.lang.String' %>
<%@attribute description='展示右键菜单,true/false,默认false，内容有showAddBtn,showEditBtn,showRemoveBtn,showAcceptBtn' name='showRightMenu' type='java.lang.String' %>
<%--@doc--%>
<%


	String parnetIsfiledscontrol = "";
	try{
		JspTag parent = TagUtil.getTa3ParentTag(getParent());
		PropertyDescriptor pd1 = new PropertyDescriptor("fieldsAuthorization", parent.getClass());
		Method method1 = pd1.getReadMethod();
	    parnetIsfiledscontrol = (String)method1.invoke(parent);
	   }
	catch(Exception e){
	}
	if("true".equals(parnetIsfiledscontrol)){
		fieldsAuthorization="true";
	}
	if ("true".equals(fieldsAuthorization)) {
		String status = SecurityUtil.getFieldStatus(request, id);
		if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_DEFAULT.equals(status)
				|| ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_EDIT.equals(status)) {
			// 正常
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_ONLY_LOOK.equals(status)) {
			// 只能查看
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}

	if(childKey==null){
		childKey = "id";
	}

	if(parentKey==null){
		parentKey = "pId";
	}

	if(nameKey == null){
		nameKey = "name";
	}

	if (labelStyle != null) {
		String style = "";
		if (labelWidth != null) {
			style = "width:"+labelWidth+"px";
		}
		style = labelStyle+";"+style;
		labelStyle = style;
	}else{
		if (labelWidth != null) {
			labelStyle = "width:"+labelWidth+"px";
		}
	}
	String ipw="";
	if(inputWidth!=null){
		ipw="width:"+inputWidth+";";
	}

%>
<%if("true".equals(showSearch)){%>
<div class="tree-search">
	<% if(searchLabel!=null && !"".equals(searchLabel.trim())){%>
	<label for="${id}_search" class="tree-search-label"
			<% if (null != labelStyle) {%>
		   style="<%=labelStyle%>"
			<%} %>
	>${searchLabel}</label>
	<%} %>
	<div class="tree-search-field"
			<% if (null != labelWidth) {%>
		 style="margin-left:${labelWidth}px;<%=ipw%>"
			<%}else if(null == searchLabel || "".equals(searchLabel.trim())) {%>
		 style="margin-left:0px;<%=ipw%>"
			<%} else%>
			<%{%>
		 style="<%=ipw%>"
			<%} %>
	>
		<input id="${id}_search" class="tree-search-input" type="text">
		<span class="faceIcon icon-search"></span>
	</div>
</div>
<%} %>
<div fit="true" class="grid" style="overflow:auto;height: 100%">
	<ul id="${id}" class="ztree" style="${cssStyle}" ></ul>
</div>
<script>
(function(factory){
	if (typeof require === 'function') {
		require(["jquery", "TaUIManager", "tree"], factory);
	} else {
		factory(jQuery);
	}
}(function($){
Ta.core.TaUICreater.addUI(function(){
var options = {};
var setting = {
	view:{
		<% if(showIcon != null){%>
		showIcon:${showIcon}==false?false:true,
		<% }else{%>
		showIcon:true,
		<% }%>
		<% if(showLine != null){%>
		showLine:${showLine}==false?false:true,
		<% }else{%>
		showLine:true,
		<% }%>
		showTitle:true,
		<% if(expandSpeed != null && !"".equals(expandSpeed)){%>
		expandSpeed:"${expandSpeed}"?"${expandSpeed}":"fast",
		<% }else{%>
		expandSpeed:"fast",
		<% }%>
		<%if(!"".equals(fontCss) && fontCss != null){ %>
		fontCss:${fontCss},
		<% }%>
		selectedMulti:false,
		autoCancelSelected:false
	},
	async:{
	<%if(!"".equals(asyncUrl) && asyncUrl != null){ %>
		url:"${asyncUrl}",
	<%}%>
	<%if(!"".equals(asyncParam) && asyncParam != null){ %>
		autoParam:${asyncParam},
	<%}%>
	<%if(!"".equals(asyncParamOther) && asyncParamOther != null){ %>
		otherParam:${asyncParamOther},
	<%}%>
	<%if(!"".equals(asyncDataFilter) && asyncDataFilter != null){ %>
		dataFilter:${asyncDataFilter},
	<%}%>
	<% if(async != null){%>
	  	enable:${async}==true?true:false
	<% }else{%>
		enable:false
	<%}%>
	},
	check:{
	<%if(checkStyle != null && !"".equals(checkStyle)){ %>
		chkStyle:"${checkStyle}",
	<%}%>
	<%if(checkRadioType != null && !"".equals(checkRadioType)){ %>
		radioType:"${checkRadioType}",
	<%}%>
	<%if(chkboxType != null && !"".equals(chkboxType)){ %>
		chkboxType:${chkboxType},
	<%}%>
	<%if(checkable != null && !"".equals(checkable)){%>
		enable:${checkable}==true?true:false
	<% }else{%>
		enable:false
	<% }%>
	},
	data:{
		keep:{
			<%if(keepParent != null){ %>
			parent:${keepParent}?true:false,
			<%}%>
			<%if(keepLeaf != null){ %>
			leaf:${keepLeaf}?true:false
			<%}%>
		},
		key:{
			<% if(checkedKey != null && !"".equals(checkedKey)){%>
			checked:"${checkedKey}",
			<% }%>
			<% if(nameKey != null && !"".equals(nameKey)){%>
			name:"<%=nameKey%>",
			<% }%>
			children:"children"
		},
		simpleData:{
			<% if(childKey != null && !"".equals(childKey)){%>
			idKey:"<%=childKey%>",
			<% }%>
			<% if(parentKey != null && !"".equals(parentKey)){%>
			pIdKey:"<%=parentKey%>",
			<% }%>
			<% if(rootPId != null && !"".equals(rootPId)){%>
			rootPId:"${rootPId}",
			<% }%>
			<% if(isSimpleData != null && !"".equals(isSimpleData)){%>
			enable:${isSimpleData}==false?false:true
			<% }else{%>
			enable:true
			<%}%>
		}
	},
	edit:{
		drag:{
		<% if(dragMove != null){%>
			isMove:${dragMove}==false?false:true,
		<% }%>
		<% if(dragCopy != null){%>
			isCopy:${dragCopy}==true?true:false,
		<% }%>
			inner:true,
			prev:true,
			next:true
		},
		<% if(showEditBtn != null){ %>
        <%--showRemoveBtn:${showRemoveBtn}==false?false:true,--%>
        showRenameBtn:${showEditBtn}==true?true:(typeof ${showEditBtn}=="function"?${showEditBtn}: false),
		<% }else{%>
		showRenameBtn:true,
		<% }%>

		<% if(showRemoveBtn != null){ %>
		<%--showRemoveBtn:${showRemoveBtn}==false?false:true,--%>
			showRemoveBtn:${showRemoveBtn}==false?false:(typeof ${showRemoveBtn}=="function"?${showRemoveBtn}: true),
		<% }else{%>
		showRemoveBtn:true,
		<% }%>

		<% if(showAddBtn != null){ %>
            <%--showRemoveBtn:${showRemoveBtn}==false?false:true,--%>
            showAddBtn:${showAddBtn}==false?false:(typeof ${showAddBtn}=="function"?${showAddBtn}: true),
		<% }else{%>
		showAddBtn:false,
		<% }%>
		<% if(showAcceptBtn != null){ %>
		showAcceptBtn:${showAcceptBtn}==false?false:true,
		<% }else{%>
		showAcceptBtn:false,
		<% }%>
		<% if(editTitle != null && !"".equals(editTitle)){ %>
		renameTitle:"${editTitle}",
		<% }else{%>
		renameTitle:"编辑节点",
		<% }%>
		<% if(removeTitle != null && !"".equals(removeTitle)){ %>
		removeTitle:"${removeTitle}",
		<% }else{%>
		removeTitle:"删除该节点",
		<% }%>
		<% if(addTitle != null && !"".equals(addTitle)){ %>
		addTitle:"${addTitle}",
		<% }else{%>
		 addTitle:"添加子节点",
		<% }%>
		<% if(acceptTitle != null && !"".equals(acceptTitle)){ %>
		acceptTitle:"${acceptTitle}",
		<% }else{%>
		acceptTitle:"自定义行为",
		<% }%>
		<% if(editable != null){ %>
		enable:${editable}==true?true:false,
		<% }else{%>
		enable:false
		<%}%>
	},
	callback:{
		<% if(beforeCheck != null && !"".equals(beforeCheck)){%>
		beforeCheck:${beforeCheck},
		<% }%>
		<% if(onCheck != null && !"".equals(onCheck)){%>
		onCheck:${onCheck},
		<% }%>
		<% if(beforeEdit != null && !"".equals(beforeEdit)){%>
		beforeEditName:${beforeEdit},
		<% }%>
		<% if(beforeRemove != null && !"".equals(beforeRemove)){%>
		beforeRemove:${beforeRemove},
		<% }%>
		<% if(beforeDrag != null && !"".equals(beforeDrag)){%>
		beforeDrag:${beforeDrag},
		<% }%>
		<% if(beforeDrop != null && !"".equals(beforeDrop)){%>
		beforeDrop:${beforeDrop},
		<% }%>
		<% if(onEdit != null && !"".equals(onEdit)){%>
		onRename:${onEdit},
		<% }%>
		<% if(onRemove != null && !"".equals(onRemove)){%>
		onRemove:${onRemove},
		<% }%>
		<% if(onDrag != null && !"".equals(onDrag)){%>
		onDrag:${onDrag},
		<% }%>
		<% if(onDrop != null && !"".equals(onDrop)){%>
		onDrop:${onDrop},
		<% }%>
		<% if(beforeClick != null && !"".equals(beforeClick)){%>
		beforeClick:${beforeClick},
		<% }%>
		<% if(onClick != null && !"".equals(onClick)){%>
		onClick:${onClick},
		<% }%>
		<% if(beforeDblclick != null && !"".equals(beforeDblclick)){%>
        beforeDblClick:${beforeDblclick},
		<% }%>
		<% if(onDblClick != null && !"".equals(onDblClick)){%>
		onDblClick:${onDblClick},
		<% }%>
		<% if(beforeRightClick != null && !"".equals(beforeRightClick)){%>
		beforeRightClick:${beforeRightClick},
		<% }%>
		<% if(onRightClick != null && !"".equals(onRightClick)){%>
		onRightClick:${onRightClick},
		<% }%>
		<% if(beforeExpand != null && !"".equals(beforeExpand)){%>
		beforeExpand:${beforeExpand},
		<% }%>
		<% if(onExpand != null && !"".equals(onExpand)){%>
		onExpand:${onExpand},
		<% }%>
		<% if(beforeCollapse != null && !"".equals(beforeCollapse)){%>
		beforeCollapse:${beforeCollapse},
		<% }%>
		<% if(onCollapse != null && !"".equals(onCollapse)){%>
		onCollapse:${onCollapse},
		<% }%>
		<% if(beforeMouseDown != null && !"".equals(beforeMouseDown)){%>
		beforeMouseDown:${beforeMouseDown},
		<% }%>
		<% if(onMouseDown != null && !"".equals(onMouseDown)){%>
		onMouseDown:${onMouseDown},
		<% }%>
		<% if(beforeMouseUp != null && !"".equals(beforeMouseUp)){%>
		beforeMouseUp:${beforeMouseUp},
		<% }%>
		<% if(onMouseUp != null && !"".equals(onMouseUp)){%>
		onMouseUp:${onMouseUp},
		<% }%>
		<% if(onNodeCreated != null && !"".equals(onNodeCreated)){%>
		onNodeCreated:${onNodeCreated},
		<% }%>
		<% if(beforeAsync != null && !"".equals(beforeAsync)){%>
		beforeAsync:${beforeAsync},
		<% }%>
		<% if(asyncSuccess != null && !"".equals(asyncSuccess)){%>
		onAsyncSuccess:${asyncSuccess},
		<% }%>
		<% if(asyncError != null && !"".equals(asyncError)){%>
		onAsyncError:${asyncError},
		<% }%>
		<% if(beforeAdd != null && !"".equals(beforeAdd)){%>
		beforeAdd:${beforeAdd},
		<% }%>
		<% if(onAdd != null && !"".equals(onAdd)){%>
		onAdd:${onAdd},
		<% }%>
		<% if(beforeAccept != null && !"".equals(beforeAccept)){%>
		beforeAccept:${beforeAccept},
		<% }%>
		<% if(onAccept != null && !"".equals(onAccept)){%>
		onAccept:${onAccept},
		<% }%>
		"end":null
	}
} ;
	<%
	String treeData = data;
	if(treeData == null || "".equals(treeData)){
	    //TODO 是否不改放开resultBean 这导致selectTree 与 tree 的赋值行为不完全一致
	    IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
		if(resultBean != null){
			Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
			if(v !=null && !"".equals(v)){
			   treeData= v.toString();
			}
		}
		if((treeData == null || "".equals(treeData)) && request.getAttribute(id) != null){
			treeData = (String)request.getAttribute(id);
		}
		if((treeData == null || "".equals(treeData)) && request.getSession().getAttribute(id) != null){
			treeData = (String)request.getSession().getAttribute(id);
		}
		if((treeData == null || "".equals(treeData)) && request.getSession().getAttribute(id) != null){
			treeData = (String)application.getAttribute(id);
		}
	}

	 %>
var nodesData = <%=treeData%>;
options.id = "${id}";
<%if("true".equals(showSearch)){%>
options.showSearch = ${showSearch};
<%}%>
<%if(null != searchColumn){%>
options.searchColumn = "${searchColumn}";
<%}%>
<%if(null!=searchPanelGrid){%>
options.searchPanelGrid = <%=searchPanelGrid%>;
<%}%>
<%if(null!=showRightMenu){%>
options.showRightMenu = <%=showRightMenu%>;
<%}%>
options.setting = setting;
options.nodesData = nodesData;
Ta.core.TaUIManager.register("${id}", new TaTree("${id}",options));
});

}));
</script>