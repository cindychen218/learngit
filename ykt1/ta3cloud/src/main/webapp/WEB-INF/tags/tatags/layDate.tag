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
<%@tag description='日期或日期时间框' display-name='date' %>
<%@attribute description='组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='组件的label标签' name='key' type='java.lang.String' %>
<%@attribute description='设置label的宽度,不加px' name='labelWidth' type='java.lang.String' %>
<%@attribute description='label样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='必输提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto[‘id’]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='设置是否必输' name='required' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>
<%@attribute description='设置是否只读' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置日期最大值，须符合 yyyy-MM-dd HH:mm:ss 格式' name='max' type='java.lang.String' %>
<%@attribute description='设置日期最小值，须符合 yyyy-MM-dd HH:mm:ss 格式' name='min' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='日期框点击事件，例如:onClick="fnClick"' name='onClick' type='java.lang.String' %>
<%@attribute description='日期框change事件' name='onChange' type='java.lang.String' %>
<%@attribute description='日期框面板 select事件, 包括清空、现在、确认按钮' name='onSelect' type='java.lang.String' %>
<%@attribute description='onFocus' name='onFocus' type='java.lang.String' %>
<%@attribute description='onBlur' name='onBlur' type='java.lang.String' %>
<%@attribute description='日期格式，year、month、date、time、datetime。默认date' name='dateType' type='java.lang.String' %>
<%@attribute description='自定义日期格式,注意，该格式必须符合 yyyy MM dd HH mm ss 标准' name='dateFormat' type='java.lang.String' %>
<%@attribute description='单独设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='left/right,验证时间,left表示不能大于当前时间，right表示不能小于当前时间' name='validNowTime' type='java.lang.String' %>

<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%--@doc--%>
<%@attribute description='range,日期范围选择模式' name='isRange' type='java.lang.String' %>
<%@attribute description='自定义日期范围选择模式分隔符 ，默认 ~ ' name='rangeSeparator' type='java.lang.String' %>
<%@attribute description='是否显示公历节日' name='isShowCalendar' type='java.lang.String' %>
<%@attribute description='自定义日历标注，比如结婚纪念日？日程等？如{"0-0-15": "中旬"},标注每月15号为中旬' name='markCalendar' type='java.lang.String' %>

<%@attribute description='当该组件被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%

    if(null != validNowTime && "left".equals(validNowTime)){
        Calendar calendar = Calendar.getInstance();
        Date date= calendar.getTime();
        SimpleDateFormat sf = null;
        if(null != dateFormat){
            sf=new SimpleDateFormat(dateFormat);
            max = sf.format(date);
        }else if("datetime".equals(dateType)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            max = sf.format(date);
        }else if("month".equals(dateType)){
            sf=new SimpleDateFormat("yyyy-MM");
            max = sf.format(date);
        }else if("year".equals(dateType)){
            sf=new SimpleDateFormat("yyyy");
            max = sf.format(date);
        }else if("time".equals(dateType)){
            sf=new SimpleDateFormat("HH:mm:ss");
            max = sf.format(date);
        }else{
            sf=new SimpleDateFormat("yyyy-MM-dd");
            max = sf.format(date);
        }
    }
    if(null != validNowTime && "right".equals(validNowTime)){
        Calendar calendar = Calendar.getInstance();
        Date date = calendar.getTime();
        SimpleDateFormat sf = null;
        if(null != dateFormat){
            sf=new SimpleDateFormat(dateFormat);
            min = sf.format(date);
        }else if("datetime".equals(dateType)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            min = sf.format(date);
        }else if("month".equals(dateType)){
            sf=new SimpleDateFormat("yyyy-MM");
            min = sf.format(date);
        }else if("year".equals(dateType)){
            sf=new SimpleDateFormat("yyyy");
            min = sf.format(date);
        }else if("time".equals(dateType)){
            sf=new SimpleDateFormat("HH:mm:ss");
            min = sf.format(date);
        }else{
            sf=new SimpleDateFormat("yyyy-MM-dd");
            min = sf.format(date);
        }
    }


/*这里对validType作处理，如果有maxLength，则在validType中加上validType="length[max,min]"
 * 如果已经有了validType，则以指定的validType为准
 */
    if(null == min)
    {
        min = "";
    }
    if(null == max)
    {
        max = "";
    }
    String validType = null;
    if(null != dateFormat){
        validType = "{type:'customDate',param:['" + min + "','"+ max + "','"+dateFormat+"']}";
    }else if("datetime".equals(dateType)){
        validType = "{type:'datetime',param:['" + min + "','"+ max + "']}";
    }else if("month".equals(dateType)){
        validType = "{type:'dateMonth',param:['" + min + "','"+ max + "']}";
    }else if("year".equals(dateType)){
        validType = "{type:'dateYear',param:['" + min + "','"+ max + "']}";
    }else if("time".equals(dateType)){
        validType = "{type:'time',param:['" + min + "','"+ max + "']}";
    }else{
        validType = "{type:'date',param:['" + min + "','"+ max + "']}";
    }

    if(validType != null){
        validType = "[" +  validType + "]";
    }


    if ((this.id == null || this.id.length() == 0)) {
        int nextInt = new Random().nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        this.id = "taLayDate_" + String.valueOf(nextInt);
    }

    if(name == null || "".equals(name)){
        this.name = "dto['"+this.id+"']";
    }

    //优先 查找resultBean
    ResultBean resultBean = (ResultBean)TagUtil.getResultBean();
    if(resultBean != null){
        Object v = resultBean.getFieldData(this.id)==null?null:resultBean.getFieldData(this.id);
        if(v !=null && !"".equals(v)){
            if("true".equals(isRange)){
                this.value= JSonFactory.bean2json(v);
            }else{
                this.value= v.toString();
            }
        }
    }
    //查找request
    if(value != null && !"".equals(value) && request.getAttribute(this.id) != null){
        if("true".equals(isRange)){
            value = JSonFactory.bean2json(request.getAttribute(this.id));
        }else{
            value = request.getAttribute(this.id).toString();
        }
    }
    //查找session
    if(value != null && !"".equals(value) && request.getSession().getAttribute(this.id) != null){
        if("true".equals(isRange)){
            value = JSonFactory.bean2json(request.getSession().getAttribute(this.id));
        }else{
            value = request.getSession().getAttribute(this.id).toString();
        }
    }
    if(value != null && !"".equals(value)){
        jspContext.setAttribute("value", this.value);
    }


    String inputStyle="layDate-input ";
    if(null != dateFormat){
        inputStyle += " customDatefield";
    }else if("datetime".equals(dateType)){
        inputStyle += " datetimefield";
    }else if("month".equals(dateType)){
        inputStyle += " dateMonthfield";
    }else if("year".equals(dateType)){
        inputStyle += " dateYearfield";
    }else if("time".equals(dateType)){
        inputStyle += " timefield";
    }else {
        inputStyle += " datefield";
    }
%>

<%@include file="../columnhead.tag" %>

<div
        class="layDate-layout-Container <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
        style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
        <% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
        <% if(span!=null){%> span="${span}"<%}%>
        <% if(toolTip != null){%> toolTip = "${toolTip}"<%} %>
>
    <% if(key!=null && !"".equals(key.trim())){%>
    <label for="<%=id %>" class="layDate-label"
           style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
    >
    ${key}
    </label>
    <%} %>

    <div class="layDate-input-Container"

            <% if (null != labelWidth) {%>
         style="margin-left:<%=labelWidth%>px"
            <%}else if(null == key || "".equals(key.trim())) {%>
         style="margin-left:0px;"
            <%} %>
    >
        <input type="text"
            <% if (null != id) {%>
               id="<%=id%>"
            <%}%>
            <% if (null != name) {%>
               name="<%=name%>"
            <%}%>
               class="Wdate <%=inputStyle%>"
            <%if(null == dateFormat){%>
                <% if ("month".equals(dateType)){%>
                   maxlength= "7"
                <% } else if ( "year".equals(dateType)){%>
                   maxlength="4"
                <% } else if ("time".equals(dateType)){%>
                   maxlength="8"
                <% } else if ("datetime".equals(dateType)){%>
                   maxlength="19"
                <% } else { %>
                   maxlength="10"
                <%}%>
            <%}%>

            <% if (null != cssInput) {%>
               style="${cssInput}"
            <%}%>
               autocomplete="off" disableautocomplete
        >
        <span class="faceIcon validateIcon"></span>
        <span id="<%=id%>_dateIcon" class="faceIcon icon-date dateIcon"></span>
        <%if(textHelp != null){ %>
        <div class="faceIcon icon-help textHelp-layout-Container"></div>
        <%}%>
    </div>
</div>
<%@include file="../columnfoot.tag" %>

<script type="text/javascript">
    (function(factory){
        if (typeof require === 'function') {
            require(["jquery", "TaUIManager", "layDate"], factory);
        } else {
            factory(jQuery);
        }
    }(function($){

        Ta.core.TaUICreater.addUI(
            function(){

                var options={
                    name:"<%=name%>",
                    <%if (textHelp != null) {%>
                    textHelp : "${textHelp}",
                    <%}%>
                    <%if (textHelpWidth != null) {%>
                    textHelpWidth : "${textHelpWidth}",
                    <%}%>
                    <%if (textHelpPosition != null) {%>
                    textHelpPosition : "${textHelpPosition}",
                    <%}%>
                    <%if ("true".equals(isRange)) {%>
                        <%if (value != null) {%>
                        value : <%=value%>,
                        <%}%>
                    <%}else{%>
                        <%if (value != null) {%>
                        value : "<%=value%>",
                        <%}%>
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
                    <%if(onClick!=null){%>
                    onClick: ${onClick},
                    <%}%>
                    <% if(onChange!=null){%>
                    onChange: ${onChange},
                    <%}%>
                    <% if(onBlur!=null){%>
                    onBlur: ${onBlur},
                    <%}%>
                    <% if(onFocus!=null){%>
                    onFocus: ${onFocus},
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
                    <% if(validType!=null){%>
                    validType:<%=validType%>
                    <%}%>
                };
                options.params={
                    <% if (null != dateType) {%>
                    type:"<%=dateType%>",
                    <% }%>
                    <% if (null != dateFormat) {%>
                    format:"<%=dateFormat%>",
                    <%}%>
                    <% if ("true".equals(isRange)) {%>
                        <% if (null != rangeSeparator) {%>
                            range:"<%=rangeSeparator%>",
                        <%}else{%>
                            range:"-",
                        <%}%>
                    <%}%>
                    <% if (null != min && "" != min) {%>
                    min:"<%=min%>",
                    <%}%>
                    <% if (null != max && "" != max) {%>
                    max:"<%=max%>",
                    <%}%>
                    <% if (null != onSelect && "" != onSelect) {%>
                    done:<%=onSelect%>,
                    <%}%>
                    <%if (markCalendar != null) {%>
                    mark : <%=markCalendar%>,
                    <%}%>
                    <% if (null != isShowCalendar && "" != isShowCalendar) {%>
                    calendar:<%=isShowCalendar%>,
                    <%}%>

                };

                var taDate = new TaLayDate("<%=id%>",options);
                Ta.core.TaUIManager.register("<%=id%>",taDate);
            });
    }));
</script>
