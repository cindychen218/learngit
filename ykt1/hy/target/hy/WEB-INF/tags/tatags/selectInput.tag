<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.alibaba.fastjson.JSONArray"%>
<%@tag import="com.yinhai.core.app.api.util.JSonFactory"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag" %>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Map"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='下拉框' display-name='selectInput' %>
<%@attribute description='设置组件id,页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='设置组件的name属性，一般可以不设置，系统会根据id自动生成类似dto["id"]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准，如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='设置组件的label描述,不支持html标签' name='key' type='java.lang.String' %>
<%@attribute description='添加label描述自定义宽度，如labelWidth="120"' name='labelWidth' type='java.lang.String' %>
<%@attribute description='添加label描述自定义样式，如labelStyle="font-size:12px;"' name='labelStyle' type='java.lang.String' %>
<%@attribute description='添加自定义样式class，如:cssClass="customClassName"' name='cssClass' type='java.lang.String' %>
<%@attribute description='添加自定义样式，如:cssStyle="padding-top：10px;"' name='cssStyle' type='java.lang.String' %>

<%@attribute description='设置组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='设置组件是否必输，默认false，设置后代小红星' name='required' type='java.lang.String' %>
<%@attribute description='设置组件只读,默认false' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置组件不可用，同时表单提交时不会传值到后台。默认false' name='disabled' type='java.lang.String' %>
<%@attribute description='设置组件是否显示，默认为显示:true' name='display' type='java.lang.String' %>

<%@attribute description='当父容器以column方式布局时，设置span表明当前组件需要占用多少列，如span=‘2’表示跨两列' name='span' type='java.lang.String' %>
<%@attribute description='当父容器以column方式布局时，自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1 表示占10%的宽度' name='columnWidth' type='java.lang.String' %>

<%@attribute description='添加自定义获取焦点事件' name='onFocus' type='java.lang.String' %>
<%@attribute description='添加自定义选择选项时事件，传函数定义，默认传入参数’描述‘数据，和’真实’数据，如onSelect="fnSelect",再在javascript中定义函数function fnSelect(key, value)' name='onSelect' type='java.lang.String' %>
<%@attribute description='添加自定义清除值回调函数 默认传入参数’描述‘数据，和’真实’数据,传入(key, value);' name='onClear' type='java.lang.String' %>
<%@attribute description='添加自定义值改变事件，传函数定义(不加括号)，默认传入参数’描述‘数据，和’真实’数据，如onChange="fnChange",再在javascript中定义函数function fnChange(key,value)' name='onChange' type='java.lang.String' %>

<%@attribute description='设置下拉数据，例如:[{"id":"xxx","name":"xxx","py":"xx"},{},{}]' name='data' type='java.lang.String' %>
<%@attribute description='设置码表的类型，如SEX' name='collection' type='java.lang.String' %>
<%@attribute description='设置层级下拉框码表的类型，如SEX' name='collectionTree' type='java.lang.String' %>
<%@attribute description='设置是否简要加载码值，true/false,默认false 加载完整码值，可针对始终不变的项目，用于优化页面加载速度' name='lightCode' type='java.lang.String' %>
<%@attribute description='设置过滤这些数据不显示，例如:filter="1,2,3"表示key为1,2,3的数据项不显示' name='filter' type='java.lang.String' %>
<%@attribute description='设置以某些字符串开头的字段不显示，比如:filterStartChar="a,b",表示以a或者b开始的字符串不显示' name='filterStartChar' type='java.lang.String' %>
<%@attribute description='设置加载过滤数据方式为反向过滤，影响collection、collectionTree、filter、filterStartChar属性，默认false' name='reverseFilter' type='java.lang.String' %>
<%@attribute description='设置码表加载是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%@attribute description='设置低于几个字符串的不显示，比如:fiterValueLengthMin="3",表示低于3个字符串不显示' name='fiterValueLengthMin' type='java.lang.String' %>
<%@attribute description='设置高于几个字符串的不显示，比如:fiterValueLengthMax="5",表示高于5个字符串不显示' name='fiterValueLengthMax' type='java.lang.String' %>
<%@attribute description='设置’描述‘来自于数据中的哪个字段，默认为name' name='displayValue' type='java.lang.String' %>
<%@attribute description='设置’key‘来自于数据中的哪个字段，默认为id' name='hiddenValue' type='java.lang.String' %>

<%@attribute description='设置是否显示层级关系，默认false不显示，设置成ture表示显示，只有true的时候isMustLeaf,minLevel,maxLevel才生效' name='islevel' type='java.lang.String' %>
<%@attribute description='设置是否必须选择子节点，默认false，设置成true表示必须选择，必须设置islevel="true"' name='isMustLeaf' type='java.lang.String' %>
<%@attribute description='设置选择数据的最低层次，必须设置islevel="true"才有效' name='minLevel' type='java.lang.String' %>
<%@attribute description='设置选择数据的最高层次，必须设置islevel="true"才有效' name='maxLevel' type='java.lang.String' %>

<%@attribute description='设置是否显示刷新码表按钮' name='showRefresh' type='java.lang.String' %>
<%@attribute description='设置是否显示清除按钮X   true/false 默认显示true' name='showClear'  type='java.lang.String'%>

<%@attribute description='设置是否聚焦时显示选择面板，默认为true' name='isFocusShowPanel' type='java.lang.String' %>
<%@attribute description='设置是否只能选择,不能输入，默认可以输入false' name='selectOnly'  type='java.lang.String'%>
<%@attribute description='设置是否允许输入列表以外的数据，输入后key及value均为输入值，默认false' name='allowInputOtherText' type='java.lang.String' %>
<%@attribute description='设置部分value选项提前,如：2,3 ' name='advance' type='java.lang.String'%>
<%@attribute description='设置下拉列表是否显示Key值，默认false，设置为true时，下拉列中将显示为key:value的样式' name='showKey' type='java.lang.String' %>
<%@attribute description='设置输入框的显示值,key为显示key值,all显示"key:value"的值,默认为显示value值' name='showValue' type='java.lang.String' %>
<%@attribute description='设置’拼音过滤‘来自于数据中的哪个字段，默认为py' name='pyFilter' type='java.lang.String' %>
<%@attribute description='设置首数据项' name='clearData' type='java.lang.String' %>

<%@attribute description='设置是否默认选择第一项，默认false,表示不选择.当有value属性时,以value属性为准.此属性必须设置collection或者data属性' name='selectFirstValue' type='java.lang.String' %>
<%@attribute description='设置下拉框所占宽度百分比，例如:widthPercentage="150%",默认100%' name='widthPercentage' type='java.lang.String' %>
<%@attribute description='设置下拉面板宽度，如100px.默认和输入框一样长' name='selectPanelWidth' type='java.lang.String'%>
<%@attribute description='设置面板最大可见下拉列表条数，大于此条数则显示滚动条' name='maxVisibleRows' type='java.lang.String' %>
<%@attribute description='设置是否自动计算下拉选项扩展方向，默认为true' name='isAutoExtend' type='java.lang.String' %>

<%@attribute description='是否显示分页默认false' name='paging' type='java.lang.String' %>
<%@attribute description='在分页情况下分页的大小,默认为40' name='pageSize' type='java.lang.String' %>
<%@attribute description='在分页情况下是否显示总页数描述,默认false不显示' name='showSummary' type='java.lang.String' %>
<%@attribute description='在分页情况下分页条样式,有两种样式可选 input/links默认input' name='pageStyle' type='java.lang.String' %>
<%@attribute description='在分页情况下,分页条样式为link的时候最大显示的链接数,默认为5' name='maxPageLinks' type='java.lang.String' %>

<%@attribute description='添加鼠标移过输入对象提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大宽度，默认300' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的最大高度，默认500' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='设置鼠标移过输入对象提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='添加组件帮助说明信息。例如textHelp="该项选择性别，影响XXX计算"' name='textHelp' type='java.lang.String' %>

<%@attribute description='设置textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='设置textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%@attribute description='添加输入提示文字' name='placeholder' type='java.lang.String' %>
<%@attribute description='鼠标移过提示文本' name='toolTip' type='java.lang.String' %>

<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
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
			disabled = "true";
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}
%>

<%

	if (null != islevel && "true".equals(islevel)) {
		if (null != isMustLeaf && "true".equals(isMustLeaf)) {
			jspContext.setAttribute("isMustLeaf",isMustLeaf);
		}
	}
	final Random RANDOM = new Random();
	if (data == null) {
		//优先 查找resultBean
		IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
		if(resultBean != null){
			List val = resultBean.getSelectData()==null?null:resultBean.getSelectDataById(id);
//	    		Object val =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(id);
//	    		Object v =  resultBean.getFieldsData()==null?null:resultBean.getFieldsData().get(resultBean._SEL_ +id);
//	    		if(v !=null && !"".equals(v)){
//	    			if (v.toString().indexOf("[") >= 0 && v.toString().indexOf("]") > 0) {
//	    				data = v.toString();
//	    				if(val != null && !"".equals(val) && val.toString().indexOf("[") < 0){
//	    					value= val.toString();
//	    				}
//	    			}
//	    		}
			if(val != null && !"".equals(val) && val.toString().indexOf("[") == 0){
				data = JSonFactory.bean2json(val);
			}
		}
		// 查找request
		if ((value == null || "".equals(value))
				&& request.getAttribute(id) != null) {
			Object attribute = request.getAttribute(id);
			if (attribute instanceof List) {
				data = JSonFactory.bean2json(attribute);
			} else {
				value = request.getAttribute(id).toString();
			}
		}
		// 查找session
		if ((value == null || "".equals(value))
				&& request.getSession().getAttribute(id) != null) {
			Object attribute = request.getSession().getAttribute(id);
			if (attribute instanceof List) {
				data = JSonFactory.bean2json(attribute);
			} else {
				value = request.getSession().getAttribute(id)
						.toString();
			}
		}
		//
		if (data == null
				&& ((collection != null && !""
				.equals(collection)) || (collectionTree != null && !""
				.equals(collectionTree)))) {
			String orgId = null;
			if("true".equals(filterOrg)){
				UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
				if(userAccountInfo != null)
					orgId = userAccountInfo.getPositionOrg().getYab003();
			}
			StringBuilder sb = new StringBuilder();
			if (("true".equals(readOnly) || "true".equals(disabled))
					&& "true".equals(lightCode)
					&& collection != null
					&& !"".equals(collection)) {
				if (value != null && !"".equals(value)) {
					String desc = CodeTableUtil.getDesc(collection,
							value, orgId);
					sb.append("[");
					sb.append("{\"id\":\"").append(value).append("\",");
					sb.append("\"name\":\"").append(desc).append("\"}");
					sb.append("]");
				}
			} else {
//				String collectionKey = "collection-"+collection;
//				if(ValidateUtil.isEmpty(jspContext.findAttribute(collectionKey))){
//					jspContext.setAttribute(collectionKey, CodeTableUtil.getCodeListJson(collection, orgId));
//				}
//				sb.append(jspContext.getAttribute(collectionKey));

				sb.append(CodeTableUtil.getCodeListJson(collection, orgId));
			}

			data=sb.toString();
		}
		//
	}
	if (data != null) {
		// 当data非空,value为空,selectFirstValue="true"时,设置默认值.
		if (ValidateUtil.isEmpty(value)) {
			if (selectFirstValue != null && "true".equals(selectFirstValue) && !"[]".equals(data)) {
				JSONArray json2bean = JSonFactory.json2bean(
						data.toString(), JSONArray.class);
				if (json2bean.size() > 0) {
					Map map = (Map) json2bean.get(0);
					value = map.get("id").toString();
				}
			}
			IResultBean resultBean = (IResultBean) TagUtil
					.getResultBean();
			if (resultBean != null) {
				Object val = resultBean.getFieldsData() == null ? null
						: resultBean.getFieldsData().get(id);
				// 屏蔽原始字符串
				if (val != null && val.toString().indexOf("[") != 0) {
					value= val.toString();
				}
			}
		} else if (!ValidateUtil.isEmpty(value)) {
			//如果value有值selectFirstValue没有值,后台有传值过来那么覆盖value的值 add by cy
			if (selectFirstValue == null || "false".equals(selectFirstValue)) {
				IResultBean resultBean = (IResultBean) TagUtil
						.getResultBean();
				if (resultBean != null) {
					Object val = resultBean.getFieldsData() == null ? null
							: resultBean.getFieldsData().get(id);
					// 屏蔽原始字符串
					if (val != null && val.toString().indexOf("[") != 0) {
						value= val.toString();
					}
				}
			}
		}
	}

	if ((id == null || id.length() == 0)) {
		int nextInt = RANDOM.nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
				.abs(nextInt);
		id = "tatab_" + String.valueOf(nextInt);
		jspContext.setAttribute("id", id);
	}
%>
<%@include file="../columnhead.tag" %>
<div class="selectinput-layout-container <% if( cssClass != null ){ %> ${cssClass} <%} %>"
	 style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
	<% if( columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
	<% if( span != null ){ %> span="${span}"  <%}%>
	<% if( toolTip != null ){ %> title="${toolTip}"  <%}%>
>
	<%if (key != null && !"".equals(key.trim())) {%>
	<label for="${id}_desc" class="selectinput-label"
		   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
	>
		${key}
	</label>
	<%}%>

	<div class="selectinput-layout-input"
			<%if(labelWidth!=null && !"".equals(labelWidth)) {%>
		 style="margin-left:${labelWidth}px"
			<%}else if(null == key || "".equals(key.trim())){%>
		 style="margin-left:0px"
			<%} %>
	>
		<div id="${id}_div"></div>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container" id="textHelp_<%=id%>"></div>
		<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag" %>
<script type="text/javascript">

    (function(factory){
        if (typeof require === 'function') {
            require(["jquery","TaUIManager", "selectInput"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){
        Ta.core.TaUICreater.addUI( function(){
            var option = {};

            <%if(data!=null && !"".equals(data)) {%>
            option.data=<%=data%>;
            <%}%>
            <%if(id!=null && !"".equals(id)) {%>
            option.divId="${id}";
            <%}%>
            <%if(advance!=null && !"".equals(advance)) {%>
            option.advance="${advance}";
            <%}%>
            <%if(name!=null && !"".equals(name)) {%>
            option.name="${name}";
            <%}%>
            <%if(name==null||"".equals(name)) {%>
            option.name="dto['${id}']";
            <%}%>
            <%if(value!=null && !"".equals(value)) {%>
            option.value="<%=value%>";
            <%}%>
            <%if(placeholder!=null && !"".equals(placeholder)) {%>
            option.placeholder="${placeholder}";
            <%}%>
            <%if(clearData!=null && !"".equals(clearData)) {%>
            option.clearData="${clearData}";
            <%}%>
            <%if(collection!=null && !"".equals(collection)) {%>
            option.collection="${collection}";
            <%}%>
            <%if(collectionTree!=null && !"".equals(collectionTree)) {%>
            option.collectionTree="${collectionTree}";
            <%}%>
            <%if(allowInputOtherText!=null && !"".equals(allowInputOtherText)) {%>
            option.allowInputOtherText=${allowInputOtherText};
            <%}%>
            <%if("true".equals(required)) {%>
            option.required=${required};
            <%}%>
            <%if(showRefresh!=null && !"".equals(showRefresh)) {%>
            option.showRefresh="${showRefresh}";
            <%}%>
            <%if(filter!=null && !"".equals(filter)) {%>
            option.filter="${filter}";
            <%}%>
            <%if(filterOrg!=null && !"".equals(filterOrg)) {%>
            option.filterOrg="${filterOrg}";
            <%}%>
            <%if(reverseFilter!=null && !"".equals(reverseFilter)) {%>
            option.reverseFilter=${reverseFilter};
            <%}%>
            <%if(filterStartChar!=null && !"".equals(filterStartChar)) {%>
            option.filterStartChar="${filterStartChar}";
            <%}%>
            <%if(fiterValueLengthMin!=null) {%>
            option.fiterValueLengthMin=${fiterValueLengthMin};
            <%}%>
            <%if(fiterValueLengthMax!=null) {%>
            option.fiterValueLengthMax=${fiterValueLengthMax};
            <%}%>
            <%if(maxVisibleRows!=null && !"".equals(maxVisibleRows)) {%>
            option.maxVisibleRows="${maxVisibleRows}";
            <%}%>
            <%if(disabled!=null && !"".equals(disabled)) {%>
            option.disabled="${disabled}";
            <%}%>
            <%if(readOnly!=null && !"".equals(readOnly)) {%>
            option.readOnly = "${readOnly}";
            <%}%>
            <%if(selectOnly!=null && !"".equals(selectOnly)) {%>
            option.selectonly="${selectOnly}";
            <%}%>
            <%if(showKey!=null && !"".equals(showKey)) {%>
            option.showKey=${showKey};
            <%}%>
            <%if(selectPanelWidth!=null && !"".equals(selectPanelWidth)) {%>
            option.selectPanelWidth="${selectPanelWidth}";
            <%}%>
            <%if(onSelect!=null && !"".equals(onSelect)) {%>
            option.onSelect=${onSelect} ;
            <%}%>
            <%if(onChange!=null && !"".equals(onChange)) {%>
            option.onChange=${onChange} ;
            <%}%>
            <%if(onClear!=null && !"".equals(onClear)) {%>
            option.onClear=${onClear} ;
            <%}%>
            <%if(onFocus!=null && !"".equals(onFocus)) {%>
            option.onFocus=${onFocus} ;
            <%}%>
            <%if(displayValue!=null && !"".equals(displayValue)) {%>
            option.displayValue="${displayValue}";
            option.resultTemplate="{${displayValue}}";
            <%}%>
            <%if(hiddenValue!=null && !"".equals(hiddenValue)) {%>
            option.hiddenValue="${hiddenValue}";
            <%}%>
            <%if(pyFilter!=null && !"".equals(pyFilter)) {%>
            option.pyFilter="${pyFilter}";
            <%}%>
            <%if(isAutoExtend!=null && !"".equals(isAutoExtend)) {%>
            option.isAutoExtend=${isAutoExtend};
            <%}%>
            <%if(selectFirstValue!=null && !"".equals(selectFirstValue)) {%>
            option.selectFirstValue="${selectFirstValue}";
            <%}%>
            <%if(isFocusShowPanel!=null && !"".equals(isFocusShowPanel)) {%>
            option.isFocusShowPanel=${isFocusShowPanel};
            <%}%>
            <%if(widthPercentage!=null && !"".equals(widthPercentage)) {%>
            option.widthPercentage="${widthPercentage}";
            <%}%>
            <%if(isMustLeaf!=null && !"".equals(isMustLeaf)) {%>
            option.isMustLeaf="${isMustLeaf}";
            <%}%>
            <%if(minLevel!=null && !"".equals(minLevel)) {%>
            option.minLevel="${minLevel}";
            <%}%>
            <%if(maxLevel!=null && !"".equals(maxLevel)) {%>
            option.maxLevel="${maxLevel}";
            <%}%>
            <%if(islevel!=null && !"".equals(islevel)) {%>
            option.islevel="${islevel}";
            <%}%>
            <%if(showValue!=null && !"".equals(showValue)) {%>
            option.showValue="${showValue}";
            <%}%>
            <%if(showClear!=null && !"".equals(showClear)) {%>
            option.showClear="${showClear}";
            <%}%>
            <%if (textHelp != null) {%>
            option.textHelp = "${textHelp}";
            <%}%>
            <%if (textHelpWidth != null) {%>
            option.textHelpWidth = "${textHelpWidth}";
            <%}%>
            <%if (textHelpPosition != null) {%>
            option.textHelpPosition = "${textHelpPosition}";
            <%}%>
            <% if(bpopTipMsg!=null){%>
            option.bpopTipMsg = "${bpopTipMsg}";
            <%}%>
            <% if(bpopTipWidth!=null){%>
            option.bpopTipWidth = "${bpopTipWidth}";
            <%}%>
            <% if(bpopTipHeight!=null){%>
            option.bpopTipHeight = "${bpopTipHeight}";
            <%}%>
            <% if(bpopTipPosition!=null){%>
            option.bpopTipPosition = "${bpopTipPosition}";
            <%}%>
            <% if(toolTip!=null){%>
            option.toolTip = "${toolTip}";
            <%}%>
            option.paging=true;
            <% if(paging!=null && paging!=""){%>
            option.paging = ${paging};
            if(option.paging==true){
                option.paging={};
                <% if(pageSize!=null){%>
                option.paging.pageSize = ${pageSize};
                <%}%>
                <% if(showSummary!=null){%>
                option.paging.showSummary = ${showSummary};
                <%}%>
                <% if(pageStyle!=null){%>
                option.paging.style ="${pageStyle}";
                <%}%>
                <% if(maxPageLinks!=null){%>
                option.paging.maxPageLinks =${maxPageLinks};
                <%}%>
			}
            <%}%>

            Ta.core.TaUIManager.register("<%=id%>",new TaSelectInput("${id}",option));
        });
    }));
</script>
<jsp:doBody />


