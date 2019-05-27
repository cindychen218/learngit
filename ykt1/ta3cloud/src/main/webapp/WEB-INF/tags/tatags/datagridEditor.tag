<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.modules.codetable.api.domain.vo.AppCodeVo"%>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.util.Iterator"%>
<%@tag import="java.util.List"%>
<%@ tag import="java.util.HashMap" %>

<%--@doc--%>
<%@tag description='单元格编辑器' display-name='datagridEditor' %>
<%@attribute description='设置编辑器类型,selectInput,text,date,dateTime,issue,number,bool,textArea,treeEditor,dynamicSelectInput。当设置成selectInput时，需要再设置collection属性' name='type' type='java.lang.String' %>
<%@attribute description='编辑器转码类型' name='collection' type='java.lang.String' %>
<%@attribute description='true/false,默认false。当type为date,dateTime,issue时，可设置是否弹出日期面板' name='showSelectPanel' type='java.lang.String' %>
<%@attribute description='编辑器自定义初始化数据,例如:data="[{’id‘:1,‘name’:‘aa’,’py‘:1},{’id‘:2,‘name’:‘bb’,‘py’:2}]"' name='data' type='java.lang.String' %>
<%@attribute description='editorData,编辑框中为下拉框时，为下拉框数据，参见下拉框data' name='editorData' type='java.lang.String' %>
<%@attribute description='editorOptions,编辑框配置,比如要配置type="tree" 的编辑框,那么editorOptions={url:"dataGridController!editorTree.do",data:[{id: 1, pId: 0, name: "中国"}, {id: 11, pId: 1, name: "四川"}]}' name='editorOptions' type='java.lang.String' %>

<%@attribute description='popMsg，提示信息' name='popMsg' type='java.lang.String' %>
<%@attribute description='change事件,默认传入参数data，value,分别表示该行数据，修改后的值.例如:onChange="fnChange",在javascript中，function fnChange(data,value) {var aac003 = data.aac003;alert(value)}' name='onChange' type='java.lang.String' %>
<%@attribute description='键盘事件,默认传入参数e,事件。例如:onKeydown="fnOnKeydown",在javascript中，function fnOnKeydown(e){alert(e.keyCode)}' name='onKeydown' type='java.lang.String' %>
<%@attribute description='键盘事件,默认传入参数e,事件。例如:onFocus="fnonFocus",在javascript中，function fnonFocus(e){}' name='onFocus' type='java.lang.String' %>
<%@attribute description='键盘事件,默认传入参数e,事件。例如:onKeyup="fnonKeyup",在javascript中，function fnonKeyup(e){}' name='onKeyup' type='java.lang.String' %>
<%@attribute description='true/false,默认false，获取选中行时，是否获取该列列信息' name='gridItemfn' type='java.lang.String' %>
<%@attribute description='true/false,默认false，获取选中行时，是否获取该列列数据' name='gridDatafn' type='java.lang.String' %>
<%@attribute description='true/false,默认false，获取选中行时，是否获取该列列参数信息' name='gridOptionfn' type='java.lang.String' %>

<%@attribute description='验证类型，如:require,url，email，ip，integer，number，maxLength,minLength,idcard，mobile，issue，chinese，zipcode，compare.可以多个验证同时验证
 格式//type 验证类型,//param ,传入参数比如maxLength传入参数param:["10"] 最大长度是10 ,如果有多个参数使用逗号隔开["10","20"]
 //msg:自定义验证失败提示信息,如果不写使用默认提示信息 msg:"自定义提示信息"
 validType=[{type:"url"},{type:"length",param:["0","10"]},{type:"email",msg:"自定义提示信息"},{type:"maxLength",param:[10],msg:"最大长度为10"},{type:"self",validateFn:"fnSelfValidate"]
  依次验证url,length,email,maxLength,自定义函数' name='validType' type='java.lang.String' %>
<%@attribute description='true/false,设置是否必输，默认false' name='required' type='java.lang.String' %>
<%@attribute description='必输的提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='max，最大值,当你输入的大于此值时，自动变为此最大值,这个属性只有编辑框类型为number的时候有用' name='max' type='java.lang.String' %>
<%@attribute description='min，最小值，当你输入的小于此值时，自动变为此最小值,这个属性只有编辑框类型为number的时候有用' name='min' type='java.lang.String' %>
<%@attribute description='precision，小数点位数，允许输入的小数位数,这个属性只有编辑框类型为number的时候有用' name='precision' type='java.lang.String' %>


<%@attribute description='是否启用延迟加载,true/false.默认为false' name='lazy' type='java.lang.String' %>
<%@attribute description='true/false,是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%@attribute description='true/false,type=selectInput时，设置是否允许输入列表以外的数据，输入后key及value均为输入值，默认false' name='allowInputOtherText' type='java.lang.String' %>

<%--下一个版本抛弃--%>
<%@attribute description='自定义验证,validType属性必须设置成self才会生效,validFunction为回调函数，例如validFunction=“fnSelfValidate”，在js中必须返回一个形如：{"message":"只能为数字","result":false}的json对象，message表示验证失败提示信息，result表示是否通过验证' name='validFunction' type='java.lang.String' %>
<%--@doc--%>

<%
try {
	PropertyDescriptor pd = new PropertyDescriptor("id", getParent().getClass());
	String gridItem = (String)pd.getReadMethod().invoke(getParent());
	if (gridItem != null){
		jspContext.setAttribute("gridItem", gridItem);
	}
} catch (Exception e){
	jspContext.setAttribute("gridItem", "");
}
%>
<%
	if(this.data == null && collection!=null && !"".equals(collection)){
	    String orgId = null;
		if("true".equals(filterOrg)){
			UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
			if(userAccountInfo != null)
				orgId = userAccountInfo.getPositionOrg().getYab003();
		}
	    if(type=="dynamicSelectInput"){
            String[] keys = collection.split(",");
            HashMap map = new HashMap();
            for(int i =0 ;i<keys.length;i++){
                map.put(keys[i],CodeTableUtil.getCodeListJson(keys[i], orgId));
            }
            String str= JSonFactory.bean2json(map);
            jspContext.setAttribute("data" ,str.toString());
        }else{
            List<AppCodeVo> codeList = CodeTableUtil.getCodeList(collection, orgId);
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (Iterator<AppCodeVo> i = codeList.iterator(); i.hasNext();) {
                AppCodeVo app = i.next();
                sb.append("{\"id\":\"" + JSonFactory.getJson(app.getCodeValue() ) + "\",");
                sb.append("\"name\":\"" + JSonFactory.getJson(app.getCodeDESC() ) + "\",");
                sb.append("\"py\":\"" + JSonFactory.getJson(app.getPy() ) );
                if (i.hasNext()) {
                    sb.append("\"},");
                } else sb.append("\"}");
            }
            sb.append("]");
            jspContext.setAttribute("data" ,sb.toString());
        }
	}
	if (data != null) {
		jspContext.setAttribute("data", data);
	}
%>
<% if ( null != type) { %>
		c_${gridItem}.editor = ${type};
		o.editable = true;
		<% if ( null !=collection) { %>
			var data_${gridItem} = ${data};
			c_${gridItem}.editordata = data_${gridItem};
			c_${gridItem}.formatter = SelectInputFormatter;
			c_${gridItem}.collection = null;
		<%}%>
		<% if ( null !=data) { %>
			var data_${gridItem} = ${data};
			c_${gridItem}.editordata = data_${gridItem};
			c_${gridItem}.formatter = SelectInputFormatter;
			c_${gridItem}.collection = null;
		<%}%>
        <%if(type=="dynamicSelectInput"){	%>
            c_${gridItem}.editor = dynamicSelectInput;
            c_${gridItem}.formatter = DynamicSelectInputFormatter;
        <%}%>
		
		<% if ( null !=gridDatafn) { %>
			c_${gridItem}.gridDatafn = ${gridDatafn};
		<%}%>
		<% if ( null !=gridItemfn) { %>
			c_${gridItem}.gridItemfn = ${gridItemfn};
		<%}%>
		<% if ( null !=editorOptions) { %>
		   c_${gridItem}.editorOptions = ${editorOptions};
  			c_${gridItem}.editordata = ${editorOptions};
			c_${gridItem}.formatter = SelectInputFormatter;
		<%}%>
		
		<% if ( null !=gridOptionfn) { %>
			c_${gridItem}.gridOptionfn = ${gridOptionfn};
		<%}%>
		
		<% if ( null !=onChange) { %>
			c_${gridItem}.onChange = ${onChange};
		<%}%>
		<% if ( null !=onKeydown) { %>
			c_${gridItem}.onKeydown = ${onKeydown};
		<%}%>
		<% if ( null !=onKeyup) { %>
			c_${gridItem}.onKeyup = ${onKeyup};
		<%}%>
		<% if ( null !=onFocus) { %>
			c_${gridItem}.onFocus = ${onFocus};
		<%}%>
		<% if ( null !=max) { %>
			c_${gridItem}.max = ${max};
		<%}%>
		<% if ( null !=min) { %>
			c_${gridItem}.min = ${min};
		<%}%>		
		<% if ( null !=popMsg) { %>
			c_${gridItem}.popMsg = "${popMsg}";
		<%}%>
		<% if ( null !=precision) { %>
			c_${gridItem}.precision = ${precision};
		<%}%>
		<% if ( null !=validType) { %>
			c_${gridItem}.validType = ${validType};
		<%}%>
		<% if ( null !=required) { %>
			c_${gridItem}.required = ${required};
		<%}%>
        <% if ( null !=toolTip) { %>
        c_${gridItem}.toolTip = "${toolTip}";
        <%}%>
		<% if ( null !=showSelectPanel) { %>
			c_${gridItem}.showSelectPanel = ${showSelectPanel};
		<%}%>
		<% if ( null !=allowInputOtherText) { %>
			c_${gridItem}.allowInputOtherText = ${allowInputOtherText};
		<%}%>
		
<%}%>
