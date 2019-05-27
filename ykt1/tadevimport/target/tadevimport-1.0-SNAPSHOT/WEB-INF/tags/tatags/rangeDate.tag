<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.ta3.web.vo.ResultBean"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.text.SimpleDateFormat"%>
<%@tag import="java.util.Calendar"%>
<%@tag import="java.util.Date"%>
<%@tag import="java.util.Random"%>
<%@ tag import="com.yinhai.core.app.api.util.JSonFactory" %>

<%--@doc--%>
<%@tag description='日期区间选择组件' display-name='rangeDate' %>
<%@attribute description='组件id，页面唯一' name='id' required='true' type='java.lang.String' %>
<%@attribute description='组件的label标题' name='key' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似开始时间dto[‘id_start’]、结束时间dto[‘id_end’]这样的名称。如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='true/false。默认false,设置是否显示选择面板' name='showSelectPanel' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='单独设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='当该组件被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='设置label的宽度,不加px' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label样式' name='labelStyle' type='java.lang.String' %>

<%@attribute description='true/false,设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>
<%@attribute description='true/false,设置是否必输，默认为：false' name='required' type='java.lang.String' %>
<%@attribute description='必输时的提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='true/false,设置为只读，默认为false' name='readOnly' type='java.lang.String' %>
<%@attribute description='true/false,设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台，默认为false' name='disabled' type='java.lang.String' %>
<%@attribute description='设置日期最大值' name='max' type='java.lang.String' %>
<%@attribute description='设置日期最小值' name='min' type='java.lang.String' %>

<%@attribute description='是否显示时分秒，true/false。yyyy-MM-dd HH:mm:ss' name='datetime' type='java.lang.String' %>
<%@attribute description='年月日期格式，true/false。YYYY-MM' name='dateMonth' type='java.lang.String' %>
<%@attribute description='年日期格式，true/false。YYYY' name='dateYear' type='java.lang.String' %>
<%@attribute description='期号格式,true/false。YYYYMM' name='issue' type='java.lang.String' %>
<%@attribute description='时间格式,true/false。HH:mm' name='time' type='java.lang.String' %>
<%@attribute description='显示为季度格式,true/false。YYYY年XX季度' name='season' type='java.lang.String' %>
<%@attribute description='自定义日期格式，注意，该格式必须符合 yyyy MM dd HH mm ss 标准' name='dateFormat' type='java.lang.String' %>
<%@attribute description='显示毫秒，true/false。' name='dateFulltime' type='java.lang.String' %>
<%@attribute description='不显示秒，true/false。' name='dateNoSecond' type='java.lang.String' %>
<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>

<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%--@doc--%>
<%
	if ((this.id == null || this.id.length() == 0)) {
		int nextInt = new Random().nextInt();
		nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
				.abs(nextInt);
		this.id = "tarangedate_" + String.valueOf(nextInt);
	}

	String inputStyle="rangeDate-input-Container ";
	if(null != dateFormat){
		inputStyle += " customDatefield";
	}else if("true".equals(datetime)){
		inputStyle += " datetimefield";
	}else if("true".equals(dateFulltime)){
		inputStyle += " dateFulltimefield";
	}else if("true".equals(dateNoSecond)){
		inputStyle += " dateNoSecondfield";
	}else if("true".equals(dateMonth)){
		inputStyle += " dateMonthfield";
	}else if("true".equals(dateYear)){
		inputStyle += " dateYearfield";
	}else if("true".equals(issue)){
		inputStyle += " issuefield";
	}else if("true".equals(time)){
		inputStyle += " timefield";
	}else if("true".equals(season)){
		inputStyle += " seasonfield";
	}else{
		inputStyle += " datefield";
	}


	if(null == min)
	{
		min = "";
	}
	if(null == max)
	{
		max = "";
	}
	String validType = null;
	String dateType = "";
	if(null != dateFormat){
		dateType = "custom";
		validType = "{type:'customDate',param:['" + min + "','"+ max + "','"+dateFormat+"']}";
	}else if("true".equals(datetime)){
		dateType = "datetime";
		validType = "{type:'datetime',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(dateFulltime)){
		dateType = "dateFulltime";
		validType = "{type:'dateFulltime',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(dateNoSecond)){
		dateType = "dateNoSecond";
		validType = "{type:'dateNoSecond',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(dateMonth)){
		dateType = "dateMonth";
		validType = "{type:'dateMonth',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(dateYear)){
		dateType = "dateYear";
		validType = "{type:'dateYear',param:['" + min + "','"+ max + "']}";
	}else if ("true".equals(issue)) {
		dateType = "issue";
		validType = "{type:'issue',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(time)){
		dateType = "time";
		validType = "{type:'time',param:['" + min + "','"+ max + "']}";
	}else if("true".equals(season)){
		dateType = "season";
		validType = "{type:'season',param:['" + min + "','"+ max + "']}";
	}else{
		dateType = "date";
		validType = "{type:'date',param:['" + min + "','"+ max + "']}";
	}

	String validateTypeStart = null;
	String validateTypeEnd = null;
	if(validType == null){
		validateTypeStart = "{type:'dateRef',param:['','"+ id +"_end" + "','"+dateType+"']}";
		validateTypeEnd = "{type:'dateRef',param:['"+ id +"_start" + "','','"+dateType+"']}";
	}else{
		validateTypeStart = validType += ",{type:'dateRef',param:['','"+ id +"_end" + "','"+dateType+"']}";
		validateTypeEnd = validType += ",{type:'dateRef',param:['"+ id +"_start" + "','','"+dateType+"']}";
	}

	if(validateTypeStart != null){
		validateTypeStart = "[" +  validateTypeStart + "]";
	}
	if(validateTypeEnd != null){
		validateTypeEnd = "[" +  validateTypeEnd + "]";
	}


	//优先 查找resultBean
	ResultBean resultBean = (ResultBean)TagUtil.getResultBean();
	if(resultBean != null){
		Object v = resultBean.getFieldData(this.id)==null?null:resultBean.getFieldData(this.id);
		if(v !=null && !"".equals(v)){
			this.value= JSonFactory.bean2json(v);
		}
	}
	//查找request
	if(value != null && !"".equals(value) && request.getAttribute(this.id) != null){
		value = JSonFactory.bean2json(request.getAttribute(this.id));
	}
	//查找session
	if(value != null && !"".equals(value) && request.getSession().getAttribute(this.id) != null){
		value = JSonFactory.bean2json(request.getSession().getAttribute(this.id));
	}
	if(value != null && !"".equals(value)){
		jspContext.setAttribute("value", this.value);
	}

%>

<%@include file="../columnhead.tag" %>

<div
		class="rangeDate-layout-Container <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
		style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
		<% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
		<% if(span!=null){%> span="${span}"<%}%>
		<% if(toolTip != null){%> toolTip = "${toolTip}"<%} %>
>
	<% if(key!=null && !"".equals(key.trim())){%>
	<label for="<%=id%>_start" class="rangeDate-label"
		   style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;<%}%>"
	>
	${key}
	</label>
	<%} %>

	<div class="<%=inputStyle%>"
		<% if (null != labelWidth) {%>
	 	style="margin-left:<%=labelWidth%>px"
		<%}else if(null == key || "".equals(key.trim())) {%>
	 	style="margin-left:0px;"
		<%} %>
		<% if (null != id) {%>
	 	id="<%=id%>"
		<%}%>
	>
		<div class="rangeDate-input-box">
		<input type="text"
			<% if (null != id) {%>
			   id="<%=id%>_start"
			<%}%>
			<% if (name == null || "".equals(name)) {%>
			   name="dto['<%=id%>']"
			<%} else {%>
				name="<%=name%>"
			<%}%>
			   class="Wdate rangeDate-input"
			<% if (null != dateMonth){%>
			   maxlength= "7"
			<% } else if ( null != dateYear){%>
			   maxlength="4"
			<% } else if (null != issue){%>
			   maxlength="6"
			<% } else if (null != time){%>
			   maxlength="5"
			<% } else if (null != datetime){%>
			   maxlength="19"
			<% } else if (null != dateFulltime){%>
			   maxlength="23"
			<%} else { %>
			   maxlength="10"
			<%}%>
			<% if (null != cssInput) {%>
			   style="${cssInput}"
			<%}%>
			   autocomplete="off" disableautocomplete
		>
		<i class="rangeDate-separator">~</i>
		<input type="text"
			<% if (null != id) {%>
			   id="<%=id%>_end"
			<%}%>
			<% if (name == null || "".equals(name)) {%>
			   name="dto['<%=id%>']"
			<%} else {%>
			   name="<%=name%>"
			<%}%>
			   class="Wdate rangeDate-input"
			<% if (null != dateMonth){%>
			   maxlength= "7"
			<% } else if ( null != dateYear){%>
			   maxlength="4"
			<% } else if (null != issue){%>
			   maxlength="6"
			<% } else if (null != time){%>
			   maxlength="5"
			<% } else if (null != datetime){%>
			   maxlength="19"
			<% } else if (null != dateFulltime){%>
			   maxlength="23"
			<%} else { %>
			   maxlength="10"
			<%}%>
			<% if (null != cssInput) {%>
			   style="${cssInput}"
			<%}%>
			   autocomplete="off" disableautocomplete
		>
		</div>
		<div class="icon-Container">
			<span class="faceIcon validateIcon"></span>
			<span class="faceIcon icon-date dateIcon"></span>
		</div>
		<%if(textHelp != null){ %>
		<div class="faceIcon icon-help textHelp-layout-Container"></div>
		<%}%>
	</div>
</div>
<%@include file="../columnfoot.tag" %>

<script type="text/javascript">
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery", "TaUIManager", "date"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){

        Ta.core.TaUICreater.addUI(
            function(){
                var dateFmt;
                <% if(dateFormat != null) { %>
                dateFmt = "<%=dateFormat%>";
                <% } %>
                if(!dateFmt){
                    <% if (null != datetime){%>
                    dateFmt = 'yyyy-MM-dd HH:mm:ss';
                    <% } else if (null != dateMonth){%>
                    dateFmt = 'yyyy-MM';
                    <% } else if (null != dateNoSecond){%>
                    dateFmt = 'yyyy-MM-dd HH:mm';
                    <% } else if (null != dateYear){%>
                    dateFmt = 'yyyy';
                    <% } else if (null != dateFulltime){%>
                    dateFmt = 'yyyy-MM-dd HH:mm:ss.SSS';
                    <% } else if (null != issue){%>
                    dateFmt = 'yyyyMM';
                    <% } else if (null != time){%>
                    dateFmt = 'HH:mm';
                    <% } else if (null != season){%>
                    dateFmt = 'yyyy年MM季度';
                    <% } else { %>
                    dateFmt = 'yyyy-MM-dd';
                    <%}%>
                }

                if(Ta.core.TaUIManager.getCmp("<%=id%>") != null ){
                    return;
                }
                var options={
                    <% if (null != showSelectPanel){%>
                    showSelectPanel : <%=showSelectPanel%>,
                    <%}%>
                    <% if( season != null){%>
                    season : <%=season%>,
                    <%}%>
                    <%if (textHelp != null) {%>
                    textHelp : "${textHelp}",
                    <%}%>
                    <%if (textHelpWidth != null) {%>
                    textHelpWidth : "${textHelpWidth}",
                    <%}%>
                    <%if (textHelpPosition != null) {%>
                    textHelpPosition : "${textHelpPosition}",
                    <%}%>
					<%if (value != null){%>
                    value : <%=value%>,
					<%}%>
                    <%if (readOnly != null) {%>
                    readOnly : <%=readOnly%>,
                    <%}%>
                    <%if (disabled != null) {%>
                    disabled : <%=disabled%>,
                    <%}%>
                    <% if(required!=null){%>
                    required:${required},
                    <%}%>
                    <% if(toolTip!=null){%>
                    toolTip:"${toolTip}",
                    <%}%>
                    <% if(bpopTipMsg!=null){%>
                    bpopTipMsg:"${bpopTipMsg}",
                    <%}%>
                    <% if(bpopTipWidth!=null){%>
                    bpopTipWidth:"${bpopTipWidth}",
                    <%}%>
                    <% if(bpopTipHeight!=null){%>
                    bpopTipHeight:"${bpopTipHeight}",
                    <%}%>
                    <% if(bpopTipPosition!=null){%>
                    bpopTipPosition:"${bpopTipPosition}",
                    <%}%>
                    <% if(validateTypeStart!=null){%>
                    validateTypeStart:<%=validateTypeStart%>,
                    <%}%>
                    <% if(validateTypeEnd!=null){%>
                    validateTypeEnd:<%=validateTypeEnd%>,
                    <%}%>
                    <% if(max!=null){%>
                    max:"<%=max%>",
                    <%}%>
                    <% if(min!=null){%>
                    min:"<%=min%>",
                    <%}%>
                    dateType:"<%=dateType%>"
                };
                var position = {};
                position.top=3;
                position.left=-9;
                options.params={
                    position:position,
                    isShowWeek:false,
					dateFmt:dateFmt
                };
                Ta.core.TaUIManager.register("<%=id%>",new TaRangeDate("<%=id%>",options));
            });
    }));
</script>
