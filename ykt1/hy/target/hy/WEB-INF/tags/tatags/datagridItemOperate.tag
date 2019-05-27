<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%--@doc--%>
<%@tag description='datagrid列操作按钮区域' display-name='datagridItemOperate' %>
<%@attribute name="id" description='列id' required="true"%>
<%@attribute name="name" description='列名'%>
<%@attribute name='width' description='列宽度，默认140px'%>
<%@attribute name="showAll" description='是否显示全部。true显示全部，false有更多选项。默认false'%>
<%@attribute name="showNum" description='显示多少个按钮。默认1个，最大为列操作按钮数之和。其余显示在更多中'%>
<%@attribute name="setShowMenu" description='设置显示按钮的回调函数，当函数返回true时按钮显示，false按钮不显示。默认传参`function(operateMenus,dataContext)`，参数分别是单元格按钮信息，当前行数据。自定义函数不要写括号，例如:`setShowMenu="fnSetShowMenu"`。在javascript中，`function fnSetShowMenu(operateMenus,dataContext){if(dataContext.test == 1){if(operateMenus.id == 1){return true;}else{return true}}}` 即在test == 1条件下，operateMenus.id等于1时显示，其余不显示'%>
<%--@doc--%>
<%--media --%>
var c_${id} = {};
c_${id}.id = "${id}";
c_${id}.field = "${id}";
c_${id}.name = "${name}";
c_${id}.operate = true;
<% if( null != width) {%>
var tempWidth = "${width}".replace("px","");
c_${id}.width = Number(tempWidth);
<% }else{%>
c_${id}.width = Number(140);
<%}%>
<% if( null != showNum) {%>
c_${id}.showNum = ${showNum};
<% }else{%>
c_${id}.showNum = 1;
<%}%>
<% if( null != showAll && "true".equals(showAll)) {%>
	c_${id}.showAll = true;
<% }else{%>
	c_${id}.showAll = false;
<%}%>
if (o.defaultEvent == null)
	o.defaultEvent = [];
var id_operate_${id}_handler_show = 'showGridItemOperate';
var id_operate_${id}_handler_hide = 'hideGridItemOperate';
if ('${showAll}' == 'true'){
	id_operate_${id}_handler_show = 'showGridItemOperateAll';
	id_operate_${id}_handler_hide = 'hideGridItemOperateAll';
}
<% if(setShowMenu != null && !"".equals(setShowMenu)){ %>
	c_${id}.setShowMenu = ${setShowMenu};
<% } %>
c_${id}.formatter = function(row, cell, reData, columnDef, dataContext){
	var operateMenus = c_${id}.operateMenus, arrMenu = [], operateMenusLength = operateMenus.length;
	arrMenu.push("<div class='slick-item-operate' row='"+row+"'>");
	if(operateMenus && operateMenusLength){
		c_${id}.showNum = c_${id}.showAll ? operateMenusLength : c_${id}.showNum
		if(c_${id}.showNum < operateMenusLength){
			var tempMenus = [];
            for(var i = 0;i<operateMenusLength;i++){
				var strMenu = "<span class='slick-item-operate-ele "+operateMenus[i].icon+"'  _index='"+i+"'>"+ operateMenus[i].name+"</span>";
				if(c_${id}.setShowMenu){
					if(c_${id}.setShowMenu(operateMenus[i],dataContext)){
						tempMenus.push(operateMenus[i]);
						if(tempMenus.length > c_${id}.showNum){ continue; }
						arrMenu.push(strMenu);
					}
				}else{
					arrMenu.push(strMenu);
					tempMenus = operateMenus;
					break;
				}
            }
            if(tempMenus.length>c_${id}.showNum){
                arrMenu.push("<span class='slick-item-operate-button'> 更多</span>");
            }
		} else {
			for(var i = 0;i<operateMenusLength;i++){
				var strMenu = "<span class='slick-item-operate-ele "+operateMenus[i].icon+"'  _index='"+i+"'>"+ operateMenus[i].name+"</span>";
				if(c_${id}.setShowMenu){
					if(c_${id}.setShowMenu(operateMenus[i],dataContext)){arrMenu.push(strMenu);}
				}else{
					arrMenu.push(strMenu);
				}
			}
		}
	}
	arrMenu.push("</div>");
	return arrMenu.join("");
}
c.push(c_${id});
<jsp:doBody/>