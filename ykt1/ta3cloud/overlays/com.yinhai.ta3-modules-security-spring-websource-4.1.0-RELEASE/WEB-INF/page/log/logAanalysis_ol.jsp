<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>

<ta:box fit="true">
    <ta:box cols="5" id="box_ol">
        <ta:date id="taDate" key="查询日期" showSelectPanel="true"></ta:date>
        <ta:date id="taStartTime" key="开始时间" time="true" showSelectPanel="true"></ta:date>
        <ta:date id="taEndTime" key="结束时间" time="true" showSelectPanel="true"></ta:date>
        <ta:button key="查询" onClick="fnTaQuery_ol()"></ta:button>
        <ta:box span="3" cols="4">
            <%--<ta:number id="taStartHours_ol" key="起始时点" max="23" min="0" labelWidth="80" display="false"/>
            <ta:number id="taEndHours_ol" key="结束时点" max="23" min="0" labelWidth="80" display="false"/>
            --%>
            <ta:buttonGroup align="left">

            </ta:buttonGroup>
        </ta:box>
    </ta:box>
    <ta:box id="taLoganalysis_ol" cssStyle="height:300px;padding:0px 0px;margin:0px 30px;"></ta:box>

    <ta:panel key="当前在线人员登录信息" fit="true">
        <ta:datagrid id="grid_ol" haveSn="true" snWidth="40" forceFitColumns="true" fit="true">
            <ta:datagridItem id="logid" hiddenColumn="true"/>
            <ta:datagridItem id="userid" key="用户ID" dataAlign="center" width="80"/>
            <ta:datagridItem id="username" key="姓名" dataAlign="center"/>
            <ta:datagridItem id="logintime" key="登录时间" dataAlign="center" width="120"/>
            <ta:datagridItem id="clientip" key="客户端ip" dataAlign="center"/>
            <ta:datagridItem id="clientsystem" key="客户端系统" dataAlign="center"/>
            <ta:datagridItem id="clientbrowser" key="客户端浏览器" dataAlign="center"/>
            <ta:datagridItem id="clientscreensize" key="客户端分辨率" dataAlign="center"/>
        </ta:datagrid>
    </ta:panel>
</ta:box>
<script type="text/javascript">

	function fnTaQuery_ol() {
		//绘制用户时点在线统计图
		taLogAanalysisRun_ol();
	}

	//获取当前在线信息
	function taGetOnlineInfo() {
		var _id = '';
		var _url = '${basePath}security/loginLogAnalysisAction!getOnlineInfoNow.do';
		var _param = {};
		Base.submit(_id, _url, _param);
	}

	function taStatOnline() {
		window.taLogAanalysisRun_ol = run;

		//默认图样
		var defaultStyleType = 'line';
		var xInterval = 4;
		var time = {
			startTime: Base.getValue('taStartTime').split(':'),//['8','01'];
			endTime: Base.getValue('taEndTime').split(":")//['8','50'];
		}

		//run(defaultStyleType);

		function run(styleType) {
			time = {
				startTime: Base.getValue('taStartTime').split(':'),//['8','01'];
				endTime: Base.getValue('taEndTime').split(":")//['8','50'];
			}
			// srcipt标签式引入
			var myChart = echarts.init(document.getElementById('taLoganalysis_ol'));
			// 图表清空-------------------
			myChart.clear();

			// 过渡---------------------
			myChart.showLoading({
				text: '正在努力的读取数据中...',    //loading话术
			});

			// ajax getting data...............
			var param = {
				"dto['startTime']": Base.getValue('taStartTime'),
				"dto['endTime']": Base.getValue('taEndTime'),
				"dto['date']": Base.getValue('taDate')
			};
			var data = Base.getJson("${basePath}security/loginLogAnalysisAction!analysisOnlineNum.do", param);
			var seriesData = eval(data.fieldData.statResult);
			// ajax callback
			myChart.hideLoading();

			if(undefined == styleType || null == styleType){
				styleType = defaultStyleType;
			}



			// 图表使用-------------------
			var option = {
				title: {
					text: '时点在线用户人数统计',
					x: 'center',
					y: 'top'
				},
				legend: {                                   // 图例配置
					padding: 5,                             // 图例内边距，单位px，默认上下左右内边距为5
					itemGap: 10,                            // Legend各个item之间的间隔，横向布局时为水平间隔，纵向布局时为纵向间隔
					data: ['时点在线人数'],
					x: '80%',
					y: 'top',
				},
				tooltip: {                                  // 气泡提示配置
					//trigger: 'item',                        // 触发类型，默认数据触发，可选为：'axis'
					trigger: 'axis',                        // 触发类型，默认数据触发，可选为：'axis'
					formatter: '{a}<br/>{b}<br/>{c}人'
				},
				toolbox: {
					show: true,
					feature: {
						//mark : {show: true},
						//dataView : {show: true, readOnly: false},
						magicType: {show: true, type: ['line', 'bar']},
						restore: {show: true},
						saveAsImage: {show: true}
					}
				},
				xAxis: [                                    // 直角坐标系中横轴数组
					{
						type: 'category',                   // 坐标轴类型，横轴默认为类目轴，数值轴则参考yAxis说明
						data: getXdata(),
						splitLine: {show: false},
                        axisLabel: {
							interval: xInterval
						}
					}
				],
				grid: {
					x: 70,
					x2: 70,
					y2: 40,
				},
				yAxis: [                                    // 直角坐标系中纵轴数组
					{
						splitLine: {show: false},
						type: 'value',                      // 坐标轴类型，纵轴默认为数值轴，类目轴则参考xAxis说明
						//boundaryGap: [0.1, 0],            // 坐标轴两端空白策略，数组内数值代表百分比
						splitNumber: 4,                     // 数值轴用，分割段数，默认为5
						axisLabel: {
							formatter: '{value} 人'
						}
					}
				],
				series: [
					{
						name: '时点在线人数',                        // 系列名称
						type: styleType,                      // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
						showSymbol: false,
                        data: sortDataByHours(seriesData),
						markPoint: {
							data: [
								{type: 'max', name: '最大值'},
								{type: 'min', name: '最小值'}
							]
						},
						markLine: {
							data: [
								{type: 'average', name: '平均值'}
							]
						}
					}
				]
			};
			myChart.setOption(option);
			//重新获取当前在线人员登录信息
			taGetOnlineInfo();
		}

		//构造X轴
		function getXdata() {
            var start =time.startTime; //['8','01'];
			var end = time.endTime;//['8','50'];
			var start_hour = parseInt(start[0]);
			var start_minut = parseInt(start[1]);
			var end_hour = parseInt(end[0]);
			var end_minut = parseInt(end[1]);
			var rdata = [];
			do {
				rdata.push(formatXdata(start_hour, start_minut));
				if (start_hour == end_hour && start_minut == end_minut) {
					break;
				}
				if (start_minut < 59 && start_minut >= 0) {
					start_minut++;
				} else if (start_minut = 59) {
					start_hour++;
					start_minut = 0;
				} else {
					Base.alert("在线时点分析图表构造出错！");
					break;
				}
			} while (true);

			function formatXdata(start_hour, start_minut) {
				var tmp_hour = "" + start_hour;
				var tmp_minut = "" + start_minut;
				if (tmp_hour.length < 2)
					tmp_hour = "0" + tmp_hour;
				if (tmp_minut.length < 2)
					tmp_minut = "0" + tmp_minut;

				return tmp_hour + ":" + tmp_minut;
			}
			if(60 >= rdata.length){
				xInterval = 4;
			}else if(60 < rdata.length){
				xInterval = parseInt(rdata.length/10-1);
			}
            return rdata;
		}

		//构造、完善数据
		function sortDataByHours(data) {
			var start = time.startTime;
			var end = time.endTime;
			var start_hour = parseInt(start[0]);
			var start_minut = parseInt(start[1]);
			var end_hour = parseInt(end[0]);
			var end_minut = parseInt(end[1]);
			var rdata = [];

			var con = 0;
			do {
				var tmp_hour = "" + start_hour;
				var tmp_minut = "" + start_minut;
				if (tmp_hour.length < 2)
					tmp_hour = "0" + tmp_hour;
				if (tmp_minut.length < 2)
					tmp_minut = "0" + tmp_minut;
				var result_time = tmp_hour + ":" + tmp_minut;
				for (var i in data) {
					if (result_time == data[i].type)
						rdata.push(data[i].cout);
				}
				con++;
				if (rdata.length < con)
					rdata.push(0);
				if (start_hour === end_hour && start_minut === end_minut) {
					break;
				}
				if (start_minut < 59 && start_minut >= 0) {
					start_minut++;
				} else if (start_minut = 59) {
					start_hour++;
					start_minut = 0;
				} else {
					Base.alert("在线时点分析图表构造出错！");
					break;
				}
			}while (true);
			return rdata;
		}
	}
</script>