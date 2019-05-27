<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.ta3.web.vo.ResultBean"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.text.SimpleDateFormat"%>
<%@tag import="java.util.Calendar"%>
<%@tag import="java.util.Date"%>
<%@tag import="java.util.Random"%>

<%--@doc--%>
<%@tag description='日期或日期时间框' display-name='date' %>
<%@attribute description='组件id，页面唯一' name='id' type='java.lang.String' %>
<%@attribute description='设置layout为column布局的时候自定义占用宽度百分比，可设置值为0-1之间的小数，如:0.1' name='columnWidth' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top：10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='组件的label标签' name='key' type='java.lang.String' %>
<%@attribute description='当该组件被父容器作为column方式布局的时候，设置span表明当前组件需要占用多少列' name='span' type='java.lang.String' %>
<%@attribute description='设置label的宽度,不加px' name='labelWidth' type='java.lang.String' %>
<%@attribute description='必输提示文本' name='toolTip' type='java.lang.String' %>
<%@attribute description='组件的name属性，一般可以不设置，系统会根据id自动生成类似dto[‘id’]这样的名称，如果你自己设置的了name属性，那么将以您设置的为准如果你没有以dto方式设置，后台将不能通过dto来获取数据' name='name' type='java.lang.String' %>
<%@attribute description='组件页面初始化的时候的默认值' name='value' type='java.lang.String' %>
<%@attribute description='设置是否必输' name='required' type='java.lang.String' %>
<%@attribute description='设置是否显示，默认为显示：true' name='display' type='java.lang.String' %>
<%@attribute description='是否显示时分秒' name='datetime' type='java.lang.String' %>
<%@attribute description='设置是否只读' name='readOnly' type='java.lang.String' %>
<%@attribute description='设置日期最大值,须符合 yyyy-MM-dd HH:mm:ss 格式' name='max' type='java.lang.String' %>
<%@attribute description='设置日期最小值,须符合 yyyy-MM-dd HH:mm:ss 格式' name='min' type='java.lang.String' %>
<%@attribute description='设置日期参照值（注意:两个日期的日期格式必须相同），不能大于参照日期的值' name='maxDateRef' type='java.lang.String' %>
<%@attribute description='设置日期参照值（注意:两个日期的日期格式必须相同），不能小于参照日期的值' name='minDateRef' type='java.lang.String' %>
<%@attribute description='设置页面初始化的时候改组件不可用，同时表单提交时不会传值到后台' name='disabled' type='java.lang.String' %>
<%@attribute description='日期框点击事件，例如:onClick="fnClick()"' name='onClick' type='java.lang.String' %>
<%@attribute description='日期框change事件' name='onChange' type='java.lang.String' %>
<%@attribute description='通过日期面板改变日期change事件，例如pchanged="fnDpChg"' name='pchanged' type='java.lang.String' %>
<%@attribute description='onFocus' name='onFocus' type='java.lang.String' %>
<%@attribute description='onBlur' name='onBlur' type='java.lang.String' %>
<%@attribute description='true/false。默认false,设置是否显示选择面板' name='showSelectPanel' type='java.lang.String' %>
<%@attribute description='年月日期格式，true/false。YYYY-MM' name='dateMonth' type='java.lang.String' %>
<%@attribute description='年日期格式，true/false。YYYY' name='dateYear' type='java.lang.String' %>
<%@attribute description='期号格式,true/false。YYYYMM' name='issue' type='java.lang.String' %>
<%@attribute description='时间格式,true/false。HH:mm' name='time' type='java.lang.String' %>
<%@attribute description='显示为季度格式,true/false。YYYY年XX季度' name='season' type='java.lang.String' %>
<%@attribute description='自定义日期格式,注意，该格式必须符合 yyyy MM dd HH mm ss 标准' name='dateFormat' type='java.lang.String' %>
<%@attribute description='单独设置input元素的css样式,例如:cssInput="font-size:20px;color:red"' name='cssInput' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本' name='bpopTipMsg' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定宽度，默认自适应大小' name='bpopTipWidth' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的固定高度，默认自适应大小' name='bpopTipHeight' type='java.lang.String' %>
<%@attribute description='鼠标移过输入对象pop提示文本框的默认位置{top,left,right,bottom}，默认top' name='bpopTipPosition' type='java.lang.String' %>
<%@attribute description='是否聚焦时显示选择面板，默认为true' name='isFocusShowPanel' type='java.lang.String' %>
<%@attribute description='left/right,验证时间,left表示不能大于当前时间，right表示不能小于当前时间' name='validNowTime' type='java.lang.String' %>
<%@attribute description='label样式' name='labelStyle' type='java.lang.String' %>
<%@attribute description='显示毫秒' name='dateFulltime' type='java.lang.String' %>
<%@attribute description='不显示秒' name='dateNoSecond' type='java.lang.String' %>
<%@attribute description='允许使用方向键在日期面板中移动选择日期，默认false' name='enableKeyboard' type='java.lang.String' %>
<%@attribute description='显示输入框提示图标，内容自定义。例如textHelp="默认显示在左下角"' name='textHelp' type='java.lang.String' %>
<%@attribute description='textHelp宽度，默认200。例如textHelpWidth="200"' name='textHelpWidth' type='java.lang.String' %>
<%@attribute description='textHelp位置{topLeft,topRight,bottomLeft,bottomRight}，默认bottomLeft。例如textHelpPosition="bottomRight"' name='textHelpPosition' type='java.lang.String' %>
<%--@doc--%>
<%

    if(null != validNowTime && "left".equals(validNowTime)){
        Calendar calendar = Calendar.getInstance();
        Date date= calendar.getTime();
        SimpleDateFormat sf = null;
        if(null != dateFormat){
            sf=new SimpleDateFormat(dateFormat);
            max = sf.format(date);
        }else if("true".equals(datetime)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            max = sf.format(date);
        }else if("true".equals(dateFulltime)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            max = sf.format(date);
        }else if("true".equals(dateNoSecond)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
            max = sf.format(date);
        }else if("true".equals(dateMonth)){
            sf=new SimpleDateFormat("yyyy-MM");
            max = sf.format(date);
        }else if("true".equals(issue)){
            sf=new SimpleDateFormat("yyyyMM");
            max = sf.format(date);
        }else if("true".equals(dateYear)){
            sf=new SimpleDateFormat("yyyy");
            max = sf.format(date);
        }else if("true".equals(time)){
            sf=new SimpleDateFormat("HH:mm");
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
        }else if("true".equals(datetime)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            min = sf.format(date);
        }else if("true".equals(dateFulltime)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            min = sf.format(date);
        }else if("true".equals(dateNoSecond)){
            sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
            min = sf.format(date);
        }else if("true".equals(dateMonth)){
            sf=new SimpleDateFormat("yyyy-MM");
            min = sf.format(date);
        }else if("true".equals(dateYear)){
            sf=new SimpleDateFormat("yyyy");
            min = sf.format(date);
        }else if ("true".equals(issue)) {
            sf=new SimpleDateFormat("yyyyMM");
            min = sf.format(date);
        }else if("true".equals(time)){
            sf=new SimpleDateFormat("HH:mm");
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
        dateType = "dailyTime";
        validType = "{type:'dailyTime',param:['" + min + "','"+ max + "']}";
    }else if("true".equals(season)){
        dateType = "season";
        validType = "{type:'season',param:['" + min + "','"+ max + "']}";
    }else{
        dateType = "date";
        validType = "{type:'date',param:['" + min + "','"+ max + "']}";
    }

    /**
     * min、max、validateNowTime、maxDateRef 、 minDateRef 都是涉及validate 的，
     */
    if(null != minDateRef || null != maxDateRef){
        if(null == minDateRef)
        {
            minDateRef = "";
        }else{
            min = "#F{$dp.$D('"+minDateRef+"')}";
        }
        if(null == maxDateRef)
        {
            maxDateRef = "";
        }else{
            max = "#F{$dp.$D('"+maxDateRef+"')}";
        }
        if(validType == null){
            validType = "{type:'dateRef',param:['" + minDateRef + "','"+ maxDateRef + "','"+dateType+"']}";
        }else{
            validType += ",{type:'dateRef',param:['" + minDateRef + "','"+ maxDateRef + "','"+dateType+"']}";
        }
    }

    if(validType != null){
        validType = "[" +  validType + "]";
    }


    if ((this.id == null || this.id.length() == 0)) {
        int nextInt = new Random().nextInt();
        nextInt = nextInt == Integer.MIN_VALUE ? Integer.MAX_VALUE : Math
                .abs(nextInt);
        this.id = "tadate_" + String.valueOf(nextInt);
    }

    if(name == null || "".equals(name)){
        this.name = "dto['"+this.id+"']";
    }

    //优先 查找resultBean
    ResultBean resultBean = (ResultBean)TagUtil.getResultBean();
    if(resultBean != null){
        Object v = resultBean.getFieldData(this.id)==null?null:resultBean.getFieldData(this.id);
        if(v !=null && !"".equals(v)){
            this.value= v.toString();
        }
    }
    //查找request
    if(value != null && !"".equals(value) && request.getAttribute(this.id) != null){
        value = request.getAttribute(this.id).toString();
    }
    //查找session
    if(value != null && !"".equals(value) && request.getSession().getAttribute(this.id) != null){
        value = request.getSession().getAttribute(this.id).toString();
    }
    if(value != null && !"".equals(value)){
        jspContext.setAttribute("value", this.value);
    }
    if(value != null && !"".equals(value)){
        value = value.replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
    String inputStyle="date-input ";
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
        inputStyle += " dailyTimefield";
    }else if("true".equals(season)){
        inputStyle += " seasonfield";
    }else {
        inputStyle += " datefield";
    }

    if(onChange != null && "true".equals(showSelectPanel)){
        //处理showSelectPanel=true时，onChange事件重复触发的问题
        onChange += ";$dp.cal.oldValue=$dp.el[$dp.elProp];";
    }

    //isFocusShowPanel 默认 true
    if(isFocusShowPanel == null){
        isFocusShowPanel = "false";
    }

%>

<%@include file="../columnhead.tag" %>

<div
        class="date-layout-Container <%if(cssClass !=null){%> <%=cssClass%> <%}%>"
        style="<%if(cssStyle !=null){%> <%=cssStyle%>; <%}%> <%if("false".equals(display) || "none".equals(display)){%> display:none; <%}%>"
        <% if(columnWidth!=null){%> columnWidth="${columnWidth}" <%}%>
        <% if(span!=null){%> span="${span}"<%}%>
        <% if(toolTip != null){%> toolTip = "${toolTip}"<%} %>
>
    <% if(key!=null && !"".equals(key.trim())){%>
    <label for="<%=id %>" class="date-label"
           style="<% if (null != labelStyle) {%> <%=labelStyle%>; <%} %> <%if (labelWidth != null){%>width:<%=labelWidth%>px;"<%}%>"
    >
    ${key}
    </label>
    <%} %>

    <div class="date-input-Container"

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
            <% if(null == dateFormat){ %>
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
                <%} else if (null != dateNoSecond){%>
                   maxlength="16"
                <%} else if (null != season){%>
                   maxlength="9"
                <%} else { %>
                   maxlength="10"
                <%}%>
            <% } %>
            <% if (null != onClick) {%>
               onClick="${onClick}"
            <%}%>
            <% if (null != onChange) {%>
               onChange="<%=onChange%>"
            <%}%>
            <% if (null != cssInput) {%>
               style="${cssInput}"
            <%}%>
               autocomplete="off" disableautocomplete
        >
        <span class="faceIcon validateIcon"></span>
        <span class="faceIcon icon-date dateIcon"></span>
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
                var oldval;
                if(!dateFmt){
                    <% if (null != datetime){%>
                    dateFmt = 'yyyy-MM-dd HH:mm:ss';
                    <% }else if (null != dateMonth){%>
                    dateFmt = 'yyyy-MM';
                    <% }else if (null != dateNoSecond){%>
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


                function pchangeing(){
                    oldval = document.getElementById("<%=id%>").value;
                }
                //面板改变事件，处理选择面板丢失焦点后不能触发onchange事件
                function pchanged(){
                    if ("<%=showSelectPanel%>" == "true") {
                        setTimeout(function () {
                            if ($dp && $dp.dd && $dp.dd.style.display == "none") {
                                <% if (null != pchanged){%>
                                var fn = eval(${pchanged});
                                if(typeof fn =='function')fn();
                                <% } %>
                            }

                            if(['yyyy','yyyyMM','yyyy-MM'].indexOf(dateFmt) > -1){
                                document.getElementById("<%=id%>").focus();
                                $dp.cal.oldValue = oldval;
                                $dp.el[$dp.elProp] =  document.getElementById("<%=id%>").value;
                            }
                        },0)
                    }
                }

                //日期组件事件补充控制onchange,onblur
                document.getElementById("<%=id%>").onfocus = function(){
                    <% if (null != onFocus) {%>
                    ${onFocus}
                    <%}%>
                }
                document.getElementById("<%=id%>").onblur = function(){
                    if ("<%=showSelectPanel%>" == "true"){
                        if ($dp &&  $dp.dd && $dp.dd.style.display == "none") {
                            if ($dp.cal.oldValue != $dp.el[$dp.elProp] && $dp.el.onchange) {
                                $dp.el.onchange();
                            }
                            <% if (null != onBlur) {%>
                            ${onBlur}
                            <%}%>
                        }
                    }else{
                        <% if (null != onBlur) {%>
                        ${onBlur}
                        <%}%>
                    }
                }
                //处理输入框onchange事件不触发的情况 不太明白valueEdited的作用
                /*                    document.getElementById("<%=id%>").onkeydown = function(e){
                 setTimeout(function(){
                 $dp.valueEdited = 0;
                 }, 0);
                 }*/
                //change by xp
                if(Ta.core.TaUIManager.getCmp("<%=id%>") != null ){
                    return;
                }
                var options={
                    <% if (null != showSelectPanel){%>
                    showSelectPanel : <%=showSelectPanel%>,
                    <%}%>
                    <% if (null != isFocusShowPanel){%>
                    isFocusShowPanel : <%=isFocusShowPanel%>,
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
                    <%if (value != null) {%>
                    value : "<%=value%>",
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
                    <% if(validType!=null){%>
                    validType:<%=validType%>
                    <%}%>
                };
                var position = {top:0,left:0};
                position.top=3;
                position.left=-9;
                //WdatePicker({
                options.params={
                    position:position,//liys,新皮肤修改后，日期控件的位置调整
                    isShowWeek:false,
                    el:'${id}'
                    ,ychanged:pchanged
                    ,Mchanged:pchanged
                    ,dchanged:pchanged
                    ,Hchanged:pchanged
                    ,mchanged:pchanged
                    ,schanged:pchanged

                    ,ychanging:pchangeing
                    ,Mchanging:pchangeing
                    ,dchanging:pchangeing
                    ,Hchanging:pchangeing
                    ,mchanging:pchangeing
                    ,schanging:pchangeing
                    <% if (null != enableKeyboard && "true".equals(enableKeyboard)){%>
                    ,enableKeyboard:true
                    <% }%>
                    ,dateFmt:dateFmt

                    <% if (null != min && "" != min) {%>
                    ,minDate:"<%=min%>"
                    <%}%>
                    <% if (null != max && "" != max) {%>
                    ,maxDate:"<%=max%>"
                    <%}%>
                };

                var taDate = new TaDate("<%=id%>",options);
                Ta.core.TaUIManager.register("<%=id%>",taDate);
            });
    }));
</script>
