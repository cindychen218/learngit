<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%">
<head>
    <title>调用链路分析结果</title>
    <%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar">
<ta:pageloading />
<ta:fieldset key="条件选择" id="conditions" cols="8">
    <ta:checkboxgroup>
        <ta:checkbox key="定时刷新" value="1" id="checkTimter" onClick="fnSelectTimter()"></ta:checkbox>
    </ta:checkboxgroup>
    <ta:box span="5">
        <ta:box id="timeSelect" columnWidth="1" cols="2">
            <ta:date id="start" key="开始时间" datetime="true" showSelectPanel="true" required="true" />
            <ta:date id="end" key="结束时间" datetime="true" showSelectPanel="true" required="true" />
        </ta:box>
        <ta:box id="timeLasted" columnWidth="1" cssStyle="display:none" cols="2">
            <ta:text id="lastedTime" validType='[{type:"integer"}]' labelWidth="180" key="最近时间长度/单位分钟" placeholder="整数,最好不超过10分钟" required="true" />
            <ta:selectInput id="timeInterval" key="时间间隔"
                            data='[{"id":"10","name":"十秒"},{"id":"20","name":"二十秒"},{"id":"30","name":"三十秒"},{"id":"60","name":"一分钟"},{"id":"300","name":"五分钟"},{"id":"600","name":"十分钟"},{"id":"1800","name":"三十分钟"},{"id":"3600","name":"一个小时"}]'
                            maxVisibleRows="5" required="true" />
        </ta:box>
    </ta:box>
    <ta:box span="2" cssStyle="text-align:right">
        <ta:button key="分析" id="queryNormal" onClick="fnQuery()" />
        <ta:button key="开始" id="queryInterval" onClick="fnQuery()" display="false" />
        <ta:button key="取消定时" id="cancleInterval" onClick="fnCancelQuery()" display="false" />
    </ta:box>
</ta:fieldset>
<ta:panel key="分析结果" fit="true">
    <ta:datagrid id="result" fit="true" haveSn="true"
                 forceFitColumns="true">
        <ta:datagridItem id="url" key="请求URL" showDetailed="true" width="200"
                         align="center" dataAlign="left" formatter="UrlFormatter" />
        <ta:datagridItem id="type" key="请求类型" showDetailed="true"
                         align="center" dataAlign="left" />
        <ta:datagridItem id="menuname" key="所属功能" showDetailed="true"
                         align="center" dataAlign="center" />
        <ta:datagridItem id="qps" showDetailed="true" key="QPS(次)"
                         align="center" dataAlign="center" formatter="QPSFormatter" />
        <ta:datagridItem id="qpsMax" showDetailed="true" key="QPS峰值(次)"
                         align="center" dataAlign="center" formatter="QPSFormatter" />
        <ta:datagridItem id="serverAddrOfMaxQps" showDetailed="true"
                         width="160" key="平均QPS最大的SERVER" align="center" dataAlign="center" />
        <ta:datagridItem id="avgExecuteTime" showDetailed="true" key="平均耗时"
                         align="center" dataAlign="center" formatter="MsFormatter" />
        <ta:datagridItem id="maxExecuteTime" showDetailed="true" key="最高耗时"
                         align="center" dataAlign="center" formatter="MsFormatter" />
        <ta:datagridItem id="percentOfExecuteTime" showDetailed="true"
                         key="总耗时%" align="center" dataAlign="center" />
        <ta:datagridItem id="percentOfErrorTime" showDetailed="true"
                         key="出错率%" align="center" dataAlign="center" />
    </ta:datagrid>
</ta:panel>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function() {
        $("body").taLayout();
        fnInit();
    });
    function fnInit(){
        var gridResultObj = Base.getObj("result");
        var resultDataView = gridResultObj.getDataView();
        resultDataView.setFilter(urlCheckFilter);
        gridResultObj.onClick.subscribe(function (e, args) {
            if ($(e.target).hasClass("toggle")) {
                var item = resultDataView.getItem(args.row);
                if (item) {
                    if (!item._collapsed) {
                        item._collapsed = true;
                    } else {
                        item._collapsed = false;
                    }
                    resultDataView.updateItem(item.id, item);
                }
                e.stopImmediatePropagation();
            }
        });


        // wire up model events to drive the grid
        resultDataView.onRowCountChanged.subscribe(function (e, args) {
            gridResultObj.updateRowCount();
            gridResultObj.render();
        });

        resultDataView.onRowsChanged.subscribe(function (e, args) {
            gridResultObj.invalidateRows(args.rows);
            gridResultObj.render();
        });
    }

    function fnSelectTimter(){
        var timer = Base.getValue("checkTimter");
        if(1==timer){//定时查询
            Base.hideObj("timeSelect,queryNormal");
            Base.showObj("timeLasted,queryInterval,cancleInterval");
        }
        else{
            Base.showObj("timeSelect,queryNormal");
            Base.hideObj("timeLasted,queryInterval,cancleInterval");
        }
    }

    var cycleTimer;
    function fnQuery(){
        var timer = Base.getValue("checkTimter");
        if(timer==1){//定时刷新
            var sc = Base.getValue("timeInterval")*1000;
            cycleTimer = setInterval(function(){
                    Base.submit("lastedTime","<%=basePath%>sysapp/log/stackChainAction!getAsyncBigDataByLastedTime.do",{},null,null,function(data){
                        var ls = data.lists.result.list;
                        var lsIn = data.lists.result.list;
                        for(var i = 0 ; i < ls.length ; i++){
                            var deal = ls[i];
                            var parent = deal.parent;
                            if(parent != null){
                                for(var j = 0 ; j < lsIn.length ; j++){
                                    if(lsIn[j].id ==parent &&lsIn[j].__id___ !=deal.__id___){
                                        deal.parent =lsIn[j].__id___;
                                        break;
                                    }
                                }
                            }
                            ls[i] = deal;
                        }

                        for(var i = 0 ; i < ls.length ; i ++ ){
                            ls[i].id = ls[i].__id___;
                        }
                        Base._setGridData("result",ls);
                    });
                }
                ,sc
            );
        }
        else{
            var dateStart = new Date(Base.getValue("start").replace(/-/g,"/")).getTime();
            var dateEnd = new Date(Base.getValue("end").replace(/-/g,"/")).getTime();
            if(dateEnd - dateStart <= 0){
                Base.msgTopTip("结束时间必须大于开始时间");
                return
            }
            else if((dateEnd - dateStart)> 1000 * 60 *10){
                Base.confirm("你选择的时间段大于十分钟,后台处理时间比较长,是否继续?",function(yes){
                    if(yes){
                        Base.submit("timeSelect","<%=basePath%>sysapp/log/stackChainAction!getAsyncBigDataByFixTime.do",{},null,null,function(data){
                            var ls = data.lists.result.list;
                            var lsIn = data.lists.result.list;
                            for(var i = 0 ; i < ls.length ; i++){
                                var deal = ls[i];
                                var parent = deal.parent;
                                if(parent != null){
                                    for(var j = 0 ; j < lsIn.length ; j++){
                                        if(lsIn[j].id ==parent &&lsIn[j].__id___ !=deal.__id___){
                                            deal.parent =lsIn[j].__id___;
                                            break;
                                        }
                                    }
                                }
                                ls[i] = deal;
                            }

                            for(var i = 0 ; i < ls.length ; i ++ ){
                                ls[i].id = ls[i].__id___;
                            }
                            Base._setGridData("result",ls);
                        });
                    }
                })
            }
            else{
                Base.submit("timeSelect","<%=basePath%>sysapp/log/stackChainAction!getAsyncBigDataByFixTime.do",
                    {},
                    null,
                    null,
                    function(data) {

                        var ls = data.lists.result.list;
                        var lsIn = data.lists.result.list;
                        for (var i = 0; i < ls.length; i++) {
                            var deal = ls[i];
                            var parent = deal.parent;
                            if (parent != null) {
                                for (var j = 0; j < lsIn.length; j++) {
                                    if (lsIn[j].id == parent
                                        && lsIn[j].__id___ != deal.__id___) {
                                        deal.parent = lsIn[j].__id___;
                                        break;
                                    }
                                }
                            }
                            ls[i] = deal;
                        }

                        for (var i = 0; i < ls.length; i++) {
                            ls[i].id = ls[i].__id___;
                        }
                        Base._setGridData("result", ls);
                    });
            }
        }
    };
    function MsFormatter(row, cell, value, columnDef, dataContext) {
        return value.substr(0, 5) + "ms"
    }
    function QPSFormatter(row, cell, value, columnDef, dataContext) {
        if (dataContext.type != "action") {
            return "";
        } else {
            return value;
        }
    }
    function fnCancelQuery() {
        window.clearInterval(cycleTimer);
    }
    function UrlFormatter(row, cell, value, columnDef, dataContext) {
        value = value.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(
            />/g, "&gt;");
        var indent = 0;
        if (dataContext.type == "action") {
            indent = 0;
        } else if (dataContext.type == "service") {
            indent = 1;
        } else if (dataContext.type == "sql") {
            indent = 2;
        }
        var spacer = "<span style='display:inline-block;height:1px;width:"
            + (15 * indent) + "px'></span>";
        var resultData = Base.getObj("result").getDataView().getItems();

        if (resultData[row + 1] && resultData[row + 1].indent &&  resultData[row + 1].indent > resultData[row].indent) {
            if (dataContext._collapsed) {
                return spacer + " <span class='toggle expand faceIcon icon-dbArrow_down'></span>&nbsp;"
                    + value;
            } else {
                return spacer + " <span class='toggle collapse faceIcon icon-dbArrow_up'></span>&nbsp;"
                    + value;
            }
        } else {
            return spacer + " <span class='toggle'></span>&nbsp;" + value;
        }
    }

    function urlCheckFilter(item) {
        var filterData = Base.getObj("result").getDataByDataView();
        if (item.parent != null) {
            var parent = filterData[item.parent];

            while (parent) {
                if (parent._collapsed) {
                    return false;
                }

                parent = filterData[parent.parent];
            }
        }
        return true;
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>