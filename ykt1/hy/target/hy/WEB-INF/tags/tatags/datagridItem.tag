<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="java.util.Random" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="com.yinhai.core.app.api.util.JSonFactory" %>

<%--@doc--%>
<%@tag description='datagrid列信息' display-name='datagridItem' %>
<%@attribute description='组件id匹配field' name='id' type='java.lang.String' %>
<%@attribute description='数据绑定field,默认与id相同' name='field' type='java.lang.String' %>
<%@attribute description='列宽度' name='width' type='java.lang.String' %>
<%@attribute description='是否支持排序' name='sortable' type='java.lang.String' %>
<%@attribute description='left/center/right,列标题对齐方式，默认left' name='align' type='java.lang.String' %>
<%@attribute description='列渲染回调函数,回掉函数默认传参function(row, cell, value, columnDef, dataContext),参数的意思分别是行号，列号，值，该列属性信息，当前行数据，自定义函数不要写括号，例如:formatter="fnFormatter",在javascript中，function fnFormatter(row, cell, value, columnDef, dataContext){var columnName = columnDef.name,aac003 = dataContext.aac003;return value;}' name='formatter' type='java.lang.String' %>
<%@attribute description='设置当前列为显示图标(字体图标)' name='icon' type='java.lang.String' %>
<%@attribute description='设置当前列字体图标样式,可以调整颜色和大小等' name='iconStyle' type='java.lang.String' %>
<%@attribute description='设置是否显示合计列的文字，设置为false时，全部不显示' name='tatalsTextShow' type='java.lang.String' %>
<%@attribute description='设置本列是否为后台转码' name='serverCvtCode' type='java.lang.String' %>
<%@attribute description='列点击事件,当单击此列时发生，默认传入参数data,e,分别为点击该单元格所在的行数据及事件，例如:click="fnClick",然后在javascript中，function fnClick(data,e){var row = data.row,cell = data.cell,aac003 = data.aac003}' name='click' type='java.lang.String' %>
<%@attribute description='设置列的码表转换' name='collection' type='java.lang.String' %>
<%@attribute description='设置列是否显示，默认为显示' name='hiddenColumn' type='java.lang.String' %>
<%@attribute description='设置列是否会被导出，默认为导出,当为隐藏列时,默认为不导出' name='exportColumn' type='java.lang.String' %>
<%@attribute description='设置列的数据类型:string,number,date,dateTime，dynamicSelect,默认String' name='dataType' type='java.lang.String' %>
<%@attribute description='列标题' name='key' type='java.lang.String' %>
<%@attribute description='left/center/right，数据对齐方式，默认left' name='dataAlign' type='java.lang.String' %>
<%@attribute description='设置统计方式，有avg(平均值)，sum(总和)，max(最大值)，min(最小值)' name='totals' type='java.lang.String' %>
<%@attribute description='是否当鼠标指上单元格时，在指针右下角显示此单元格的全部内容。常用于单元格内容过多，导致单元格无法完全显示全部信息的情况' name='showDetailed' type='java.lang.String' %>
<%@attribute description='手动设置Collection的值，当存在collection及collectionData时，优先选择collectionData' name='collectionData' type='java.lang.String' %>
<%@attribute description='true/false,默认false，获取选中行时，是否获取该列数据' name='asKey' type='java.lang.String' %>
<%@attribute description='表头背景颜色,例如headerBackgroundColor="#123456"' name='headerBackgroundColor' type='java.lang.String' %>
<%@attribute description='表头图标,例如headerIcon="icon-search"' name='headerIcon' type='java.lang.String' %>
<%@attribute description='表头图标的点击事件,表头定义的图标headerIcon时触发，默认传入参数data,e,分别为点击表头数据及事件，例如:headerIconClick="fnClick",然后在javascript中，function fnClick(data,e){var title = data.title}' name='headerIconClick' type='java.lang.String' %>
<%@attribute description='格式化统计信息,必须返回一个值,默认有个value参数,表示统计值.例如:totalsFormatter="fnTotalsFormatter",在js中,function fnTotalsFormatter(value){return value};' name='totalsFormatter' type='java.lang.String' %>
<%@attribute description='列宽,以最大显示字数显示,以中文为准.例如:maxChart="10",表示最多显示10个中文的宽度' name='maxChart' type='java.lang.String' %>
<%@attribute description='统计行数据对齐方式,left/center/right.例如:totalsAlign="left",默认left' name='totalsAlign' type='java.lang.String' %>
<%@attribute description='mediadata' name='mediaData' type='java.lang.String' %>
<%@attribute description='是否根据内容宽度来确定列宽度,默认每个英文默认8px,中文16px,该属性填写表格列最大宽度' name='perqWidthWithData' type='java.lang.String' %>
<%@attribute description='true/false,是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%@attribute description='表头点击事件,当单击此列时发生，默认传入参数data,e,分别为点击表头数据及事件，例如:headClick="fnClick",然后在javascript中，function fnClick(data,e){var title = data.title}' name='headClick' type='java.lang.String' %>
<%@attribute description='collection码表,date日期,default默认,number数字区域,tree树搜索 与showHeaderSeach联合使用' name='searchType' type='java.lang.String' %>
<%@attribute description='表头搜索弹出框的选项如果是tree那么必须需要nodesData或者url,比如"{nodesData:[{id:1,pId:0,name:"中国"},{id:11,pId:1,name:"四川"}],url:"testtree.do"}"' name='searchOptions' type='java.lang.String' %>
<%@attribute description='敏感信息类型，脱敏时使用,可选值,idcard,email,zipcode,telphone,mobile,ip' name='sensitiveFormatterType' type='java.lang.String' %>
<%@attribute description='自定义敏感信息类型，参数类型[{start:1,stop:4}，{start:7,stop:10}，...]' name='sensitiveFormatterRule' type='java.lang.String' %>
<%@attribute description='导出Excel的数据类型，可选值,string,number' name='expDataType' type='java.lang.String' %>
<%@attribute description='导出Excel的数据格式，expDataType非string时有效，可选值0、0.00、#,##0、#,##0.00、¥0.00、¥#,##0、¥#,##0.00、0.00%等' name='expDataFormat' type='java.lang.String' %>
<%@attribute description='当dataType为dynamicSelect时,列上返回实际码表选项值的回调函数,(row,columnDef,dataContext,collectionData)四个参数,分别为行号,列信息,行数据和码值集合数据,该函数必须返回码值的集合对象' name='dynamicSelectCallBack' type='java.lang.String' %>
<%--@doc--%>
<%
if (ValidateUtil.isEmpty(id)) {
	int nextInt = new Random().nextInt();
	nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
			.abs(nextInt);
	this.id = "tadatagriditem_" + String.valueOf(nextInt);
	jspContext.setAttribute("id", id);
}
if (field != null) {
	field = field;
} else if (id != null) {
	field = id;
}
String _grid_ = (String)jspContext.getAttribute("_grid_", PageContext.REQUEST_SCOPE);
if (_grid_ != null){
	jspContext.setAttribute("grid", id, PageContext.REQUEST_SCOPE);
}
//通过服务器获取前台转码collectionData
if(ValidateUtil.isNotEmpty(collection) && _grid_ != null && ( serverCvtCode == null || serverCvtCode =="false" )){
	if (collectionData == null) {
		String yab003 = null;

		if("true".equals(filterOrg)){
			UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
			if(userAccountInfo != null)
				yab003 = userAccountInfo.getPositionOrg().getYab003();
		}
		if(dataType=="dynamicSelect"){
			String[] keys = collection.split(",");
			Map map = new HashMap();
			for(int i =0 ;i<keys.length;i++){
				map.put(keys[i],CodeTableUtil.getCodeListJson(keys[i], yab003));
			}
			collectionData= JSonFactory.bean2json(map);
		}else{
			collectionData = CodeTableUtil.getCodeListJson(collection, yab003);
		}
		jspContext.setAttribute("collection" ,collection);
		jspContext.setAttribute("collectionData" ,collectionData);
	} else {
		jspContext.setAttribute("collection" ,collection);
    	jspContext.setAttribute("collectionData" ,collectionData);
    }
} else {
	if (collectionData != null) {
		collection = collectionData;		
		jspContext.setAttribute("collection" , "collectionData");
		jspContext.setAttribute("collectionData" ,collectionData);
	}
}
if (totals != null) {
	jspContext.setAttribute("totals", totals);
	if (totalsAlign != null) {
		jspContext.setAttribute("totalsAlign", totalsAlign);
	}
}
%>
var c_${id} = {};
c_${id}.id = "${id}";
c_${id}.name = "${key}";
c_${id}.exportColumn = true;
<% if( null != field) {%>
c_${id}.field = "<%=field %>";
<% }%>
<% if( null != hiddenColumn) {%>
	h.push(c_${id}.id);
	c_${id}.exportColumn = false;
<% }%>
<% if( null != exportColumn) {%>
c_${id}.exportColumn = ${exportColumn};
<% }%>
<% if( null != width) {%>
	var tempWidth = "${width}".replace("px","");
	c_${id}.width = Number(tempWidth);
<% }%>
<% if( null != maxChart) {%>
	var tempWidth = ${maxChart};
	c_${id}.width = (Number(tempWidth)+2) * 13;
<% }%>
<%if (null != perqWidthWithData){%>
c_${id}.perqWidthWithData = ${perqWidthWithData};
o.perqWidthWithData = true;	
<%}%>
<% if( null != sortable) {%>
c_${id}.sortable = ${sortable};
<% }%>
<% if( null != headerBackgroundColor) {%>
c_${id}.headerBackgroundColor = "${headerBackgroundColor}";
<% }%>
<% if( null != icon) {%>
c_${id}.icon = "${icon}";
<% }%>
<% if( null != headerIcon) {%>
c_${id}.headerIcon = "${headerIcon}";
<% }%>
<% if( null != sensitiveFormatterType || null != sensitiveFormatterRule) {%>
c_${id}.formatter = function(row, cell, value, columnDef, dataContext) {
	<% if(null != sensitiveFormatterType) {%>
		return Ta.util.dataSensitive.format("${sensitiveFormatterType}",value);
	<% }else{%>
		return Ta.util.dataSensitive.formatWithIndex(value,${sensitiveFormatterRule});
	<% }%>
}
<% }%>
<% if( null != formatter) {%>
c_${id}.formatter = ${formatter};
<% }%>
<% if( null != dynamicSelectCallBack) {%>
c_${id}.dynamicSelectCallBack = ${dynamicSelectCallBack};
<% }%>
<% if( null != formatter) {%>
c_${id}.selfFormatter=${formatter};//add by cy添加自身的formatter和默认的formatter区分开
<% }%>
<% if( null != collection) {%>
	<% if( null != serverCvtCode) {%>
		serverCvtCode_column = ${serverCvtCode};
	<% }%>
	if (serverCvtCode || serverCvtCode_column) {
		c_${id}.collection = '${collection}';
	}else {
             var data;
            <% if (null != collectionData) {%>
               data = <%=collectionData%>;
               data.column = "${id}";
               o.collectionsDataArrayObject.${id} = data;
            <% }%>
		c_${id}.formatter = function(row, cell, value, columnDef, dataContext) {
				var reData = value;
				<% if( null != collectionData) {%>
					<%if(dataType=="dynamicSelect"){	%>
						var data = columnDef.dynamicSelectCallBack(row,columnDef,dataContext,<%=collectionData%>);
					<% }else{%>
						data = <%=collectionData%>;
					<% }%>
					data.column = "${id}";
					o.collectionsDataArrayObject.${id} = data;
					for (var i = 0; i < data.length; i ++) {
						if (data[i].id == value) {
							reData = data[i].name;
						}
					}
				<% }%>
				<% if( null != formatter) {%>
					reData = ${formatter}(row, cell, reData, columnDef, dataContext);
				<% }%>
					return reData? reData: "";
		}



	}
<% }%>

<% if( null != click) {%>
c_${id}.click  = ${click};
<% }%>
<% if( null != headClick) {%>
c_${id}.headClick  = ${headClick};
<% }%>
<% if( null != headerIconClick) {%>
c_${id}.headerIconClick  = ${headerIconClick};
<% }%>
<% if( null != dataType) {%>
c_${id}.dataType  = "${dataType}";
<% }%>
<% if( null != align) {%>
c_${id}.align  = "${align}";
<% }%>
<% if( null != dataAlign) {%>
c_${id}.dataAlign  = "${dataAlign}";
<% }%>
<% if( null != showDetailed) {%>
c_${id}.showDetailed  = ${showDetailed};
<% }%>
<% if( null != asKey) {%>
c_${id}.propertyKey  = ${asKey};
<% }%>
<% if( null != totalsFormatter) {%>
c_${id}.totalsFormatter  = ${totalsFormatter};
<% }%>
<% if( null != searchType) {%>
c_${id}.searchType  = "${searchType}";
<% }%>
<% if( null != searchOptions) {%>
c_${id}.searchOptions  = ${searchOptions};
<% }%>
<% if( null != iconStyle) {%>
c_${id}.iconStyle  = "${iconStyle}";
<% }%>
<%--<% if( null != collectionData) {%>--%>
<%--c_${id}.collectionData  = ${collectionData};//add by cy m每列的collecttiondata 记录下来 方便过滤--%>
<%--<% }%>--%>
<% if( null != totalsAlign) {%>
c_${id}.totalsAlign  = "${totalsAlign}";
<% }%>
<% if( null != expDataType) {%>
c_${id}.expDataType  = "${expDataType}";
<% }%>
<% if( null != expDataFormat) {%>
c_${id}.expDataFormat  = "${expDataFormat}";
<% }%>
<% if( null != totals) {%>
	o.groupingBy = "_onlyTotals";
	o.hasTotals=true;
	c_${id}.totals = "${totals}"; 
	c_${id}.groupTotalsFormatter  = function(totals, columnDef) {
			var text = "";
			<% if( null != tatalsTextShow) {%>
				var tatalsTextShow = ${tatalsTextShow};
			<% } else { %>
				var tatalsTextShow = true;
			<% }%>
			if (tatalsTextShow == true) {
				if ("${totals}" == "avg") { 
					text = "平均:";
				}  else if ("${totals}" == "sum") { 
					text = "合计:";
				}  else if ("${totals}" == "max") {
					text = "最大:";
				}  else if ("${totals}" == "min")  { 
					text = "最小:";
				}
			}
			return text + totals.${totals}[columnDef.field] ;
	};
<% }%>
<jsp:doBody/>
c.push(c_${id});

