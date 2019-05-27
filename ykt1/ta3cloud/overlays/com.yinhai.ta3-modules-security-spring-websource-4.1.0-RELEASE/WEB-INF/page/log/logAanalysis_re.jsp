<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>

<ta:box fit="true">
    <ta:box cols="5" id="box_re">
        <ta:date id="taStartDate_re" key="开始日期" showSelectPanel="true"></ta:date>
        <ta:date id="taEndDate_re" key="结束日期" showSelectPanel="true" validNowTime="left" isFocusShowPanel="false"></ta:date>
        <ta:buttonGroup align="left">
            <ta:button key="查询" onClick="fnTaQuery_re()"></ta:button>
        </ta:buttonGroup>
    </ta:box>
    <table style="margin:0 auto;">
        <tr>
            <td valign="top">
                <ta:radiogroup id="statType" cssStyle="z-index:99;">
                    <ta:radio key="客户端系统版本分析"  id="ro_cs" value="1" onClick="fnTaQuery_re()" checked="true"/>
                    <ta:radio key="客户端分辨率分析" id="ro_css" value="2" onClick="fnTaQuery_re()"/>
                    <ta:radio key="客户端浏览器版本分析" id="ro_cb" value="3" onClick="fnTaQuery_re()"/>
                </ta:radiogroup>
                <div id="taLoganalysis_re" style="width:800px; height:300px;margin-top:-30px;margin-bottom:20px;"></div>
            </td>
        </tr>
    </table>
    <ta:datagrid id="gridInTime" forceFitColumns="true" fit="true" heightDiff="30">
        <ta:datagridItem id="typecs" key="客户端系统版本" dataAlign="center" width="150"/>
        <ta:datagridItem id="typecss" key="客户端分辨率" dataAlign="center" hiddenColumn="false" width="150"/>
        <ta:datagridItem id="typecb" key="客户端浏览器版本" dataAlign="center" hiddenColumn="false" width="150"/>
        <ta:datagridItem id="numday" key="24小时内" dataType="number" dataAlign="center" tatalsTextShow="true" totals="sum" click="fnTaClickGridDay" width="150"/>
        <ta:datagridItem id="numweek" key="1周内" dataType="number" dataAlign="center" tatalsTextShow="true" totals="sum" click="fnTaClickGridWeek" width="150"/>
        <ta:datagridItem id="nummonth" key="1月内" dataType="number" dataAlign="center" tatalsTextShow="true" totals="sum" click="fnTaClickGridMonth" width="150"/>
        <ta:datagridItem id="numyear" key="1年内" dataType="number" dataAlign="center" tatalsTextShow="true" totals="sum" click="fnTaClickGridYear" width="150"/>
        <ta:datagridItem id="numall" key="总计" dataType="number" dataAlign="center" tatalsTextShow="true" totals="sum" click="fnTaClickGridAll" width="180"/>
    </ta:datagrid>
</ta:box>
<script type="text/javascript">
    function fnTaQuery_re() {
        //绘制用户客户端系统版本统计图
        taLogAanalysisRun_cs();
        //绘制用户客户端分辨率统计图
        taLogAanalysisRun_css();
        //绘制用户客户端浏览器版本统计图
        taLogAanalysisRun_cb();

    }

    //按固定时段展示数据
    function getAnalysisInfoInTime(){
        var statType = Base.getValue("statType");
        switch(statType){
            case '1':
                Base.setGridColumnHidden('gridInTime', 'typecss');
                Base.setGridColumnHidden('gridInTime', 'typecb');
                Base.setGridColumnShow('gridInTime', 'typecs');
                break;
            case '2':
                Base.setGridColumnHidden('gridInTime', 'typecs');
                Base.setGridColumnHidden('gridInTime', 'typecb');
                Base.setGridColumnShow('gridInTime', 'typecss');
                break;
            case '3':
                Base.setGridColumnHidden('gridInTime', 'typecs');
                Base.setGridColumnHidden('gridInTime', 'typecss');
                Base.setGridColumnShow('gridInTime', 'typecb');
                break;
        };

        Base.clearGridData('gridInTime');
        var _id = '';
        var _url = '${basePath}security/loginLogAnalysisAction!getAnalysisInfoInTime.do';
        var _param = {"dto['statType']":statType};
        Base.submit(_id, _url, _param);
    }

    //天内查询
    function fnTaClickGridDay(data,e){
        taClickGridTimeComm('day',data,data.numday);
    }
    //周内查询
    function fnTaClickGridWeek(data,e){
        taClickGridTimeComm('week',data,data.numweek);
    }
    //月内查询
    function fnTaClickGridMonth(data,e){
        taClickGridTimeComm('month',data,data.nummonth);
    }
    //年内查询
    function fnTaClickGridYear(data,e){
        taClickGridTimeComm('year',data,data.numyear);
    }
    //总计内查询
    function fnTaClickGridAll(data,e){
        taClickGridTimeComm('all',data,data.numall);
    }
    //表格查询公共代码部分提取
    function taClickGridTimeComm(gridColumnType,data,value){
        if(value<=0)
            return;
        var desc= '';
        if(gridColumnType == 'day'){
            desc = '24小时内';
        }else if(gridColumnType == 'week'){
            desc = '1周内';
        }else if(gridColumnType == 'month'){
            desc = '1月内';
        }else if(gridColumnType == 'year'){
            desc = '1年内';
        }else if(gridColumnType == 'all'){
            desc = '总计';
        }

        var statType = Base.getValue('statType');
        if(statType == '1'){
            var _id = 're_edit';
            var _title = "<label style='color:red; font-size:16px;'>" + data.typecs + '&nbsp;' + desc + "</label>&nbsp;用户登录环境查询";
            var _url = '${basePath}security/loginLogAnalysisAction!toReEdit.do';
            var _param = {'dto.statType':statType, 'dto.gridColumnType':gridColumnType, 'dto.gridRowType':encodeURI(data.typecs)};
            var _w = 1000;
            var _h = 550;
            var _load = null;
            var _close = null;
            var _iframe = true;
        }
        if(statType == '2'){
            var _id = 're_edit';
            var _title = "<label style='color:red; font-size:16px;'>" + data.typecss + '&nbsp;' + desc + "</label>&nbsp;用户登录环境查询";
            var _url = '${basePath}security/loginLogAnalysisAction!toReEdit.do';
            var _param = {'dto.statType':statType, 'dto.gridColumnType':gridColumnType, 'dto.gridRowType':encodeURI(data.typecss)};
            var _w = 1000;
            var _h = 550;
            var _load = null;
            var _close = null;
            var _iframe = true;
        }
        if(statType == '3'){
            var _id = 're_edit';
            var _title = "<label style='color:red; font-size:16px;'>" + data.typecb + '&nbsp;' + desc + "</label>&nbsp;用户登录环境查询";
            var _url = '${basePath}security/loginLogAnalysisAction!toReEdit.do';
            var _param = {'dto.statType':statType, 'dto.gridColumnType':gridColumnType, 'dto.gridRowType':encodeURI(data.typecb)};
            var _w = 1000;
            var _h = 550;
            var _load = null;
            var _close = null;
            var _iframe = true;
        }
        Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
    }

    //图形点击查询
    function taClickGraphics_re(data){
        var _id = 're_edit';
        var _title = "<label style='color:red; font-size:16px;'>" + data.name + "</label>&nbsp;用户登录环境查询";
        var _url = '${basePath}security/loginLogAnalysisAction!toReEdit.do';
        var _param = {'dto.statType':Base.getValue('statType'),
            'dto.gridRowType':encodeURI(data.name),
            'dto.startDate':Base.getValue('taStartDate_re'),
            'dto.endDate':Base.getValue('taEndDate_re')};
        var _w = 1000;
        var _h = 550;
        var _load = null;
        var _close = null;
        var _iframe = true;
        Base.openWindow(_id, _title, _url, _param, _w, _h, _load, _close, _iframe);
    }

    function taNewOption(title,dataType,seriesData,styleType){
        // 图表使用-------------------
        return {
            title:{
                text:title,
                x:'center',
                y:'top'
            },
            legend: {                                   // 图例配置
                orient : 'vertical',
                x : 'left',
                y:'120',
                data: dataType
            },
            tooltip: {                                  // 气泡提示配置
                trigger: 'item',                        // 触发类型，默认数据触发，可选为：'axis'
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            toolbox: {
                y:'bottom',
                show : true,
                feature : {
                    //mark : {show: true},
                    //dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '50%'
                                /* 		                        ,funnelAlign: 'left',
                                                                max: 1548 */
                            }
                        }
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            /*             calculable : true, 不要饼图周围的线圈，取消饼图可拖拽的功能*/
            series: [{
                name:title,
                type:styleType,
                radius : '70%',
                center: ['50%', '60%'],
                data:seriesData
            }]
        };
    }

    function taStatClientSys(){
        window.taLogAanalysisRun_cs = run;
        var defaultStyleType = 'pie';
       // run(defaultStyleType);

        function run(styleType){
            if(!$('#ro_cs')[0].checked){
                return;
            }

            // srcipt标签式引入
            var myChart = echarts.init(document.getElementById('taLoganalysis_re'));
            // 图表清空-------------------
            myChart.clear();

            // 过渡---------------------
            myChart.showLoading({
                text: '正在努力的读取数据中...',    //loading话术
            });

            // ajax getting data...............
            var param = {
                "dto['startDate']":Base.getValue('taStartDate_re'),
                "dto['endDate']":Base.getValue('taEndDate_re')
            };
            var data = Base.getJson("${basePath}security/loginLogAnalysisAction!analysisClientSystem.do",param);
            var seriesData = eval(data.fieldData.statResult);

            if(!seriesData || seriesData.length < 1)
                return;

            // ajax callback
            myChart.hideLoading();

            (styleType) || (styleType = defaultStyleType);

            var title = "客户端系统版本统计";
            var dataType = taGetDataType(seriesData);
            var seriesData = taGetSeriesData(seriesData);

            var option = taNewOption(title,dataType,seriesData,styleType);
            myChart.setOption(option);
            myChart.on('click', taClickGraphics_re);
            //按固定时间点展示统计数据
            getAnalysisInfoInTime();
        }
    }

    function taStatClientScreen(){
        window.taLogAanalysisRun_css = run;
        var defaultStyleType = 'pie';
        //run(defaultStyleType);

        function run(styleType){
            if(!$('#ro_css')[0].checked){
                return;
            }

            // srcipt标签式引入
            var myChart = echarts.init(document.getElementById('taLoganalysis_re'));
            // 图表清空-------------------
            myChart.clear();

            // 过渡---------------------
            myChart.showLoading({
                text: '正在努力的读取数据中...',    //loading话术
            });

            // ajax getting data...............
            var param = {
                "dto['startDate']":Base.getValue('taStartDate_re'),
                "dto['endDate']":Base.getValue('taEndDate_re')
            };
            var data = Base.getJson("${basePath}security/loginLogAnalysisAction!analysisClientScreen.do",param);
            var seriesData = eval(data.fieldData.statResult);

            if(!seriesData || seriesData.length < 1)
                return;

            // ajax callback
            myChart.hideLoading();

            (styleType) || (styleType = defaultStyleType);
            var title = "客户端分辨率统计";
            var dataType = taGetDataType(seriesData);
            var seriesData = taGetSeriesData(seriesData);

            var option = taNewOption(title,dataType,seriesData,styleType);
            myChart.setOption(option);
            myChart.on('click', taClickGraphics_re);
            //按固定时间点展示统计数据
            getAnalysisInfoInTime();
        }
    }

    function taStatClientBrowser(){
        window.taLogAanalysisRun_cb = run;
        var defaultStyleType = 'pie';
       // run(defaultStyleType);

        function run(styleType){
            if(!$('#ro_cb')[0].checked){
                return;
            }

            // srcipt标签式引入
            var myChart = echarts.init(document.getElementById('taLoganalysis_re'));
            // 图表清空-------------------
            myChart.clear();

            // 过渡---------------------
            myChart.showLoading({
                text: '正在努力的读取数据中...',    //loading话术
            });

            // ajax getting data...............
            var param = {
                "dto['startDate']":Base.getValue('taStartDate_re'),
                "dto['endDate']":Base.getValue('taEndDate_re')
            };
            var data = Base.getJson("${basePath}security/loginLogAnalysisAction!analysisClientBrowser.do",param);
            var seriesData = eval(data.fieldData.statResult);

            if(!seriesData || seriesData.length < 1)
                return;

            // ajax callback
            myChart.hideLoading();

            (styleType) || (styleType = defaultStyleType);
            var title = "客户端浏览器版本统计";
            var dataType = taGetDataType(seriesData);
            var seriesData = taGetSeriesData(seriesData);

            var option = taNewOption(title,dataType,seriesData,styleType);
            myChart.setOption(option);
            myChart.on('click', taClickGraphics_re);
            //按固定时间点展示统计数据
            getAnalysisInfoInTime();
        }
    }

    //构造类目
    function taGetDataType(data){
        var rdata = [];
        for(var i in data){
            rdata.push(data[i].type);
        }
        return rdata;
    }

    //构造数据
    function taGetSeriesData(data){
        var rdata = [];
        for(var i in data){
            rdata.push({'name':data[i].type,'value':data[i].cout});
        }
        return rdata;
    }

</script>
