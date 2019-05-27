<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>日志分析</title>
	<%@ include file="/ta/inc.jsp"%>
</head>
<body >
<ta:pageloading/>
<ta:panel cols="6" key="条件">
	<ta:box cols="2" span="5" id="info">
		<ta:date id="start" key="开始时间"  value="2016-06-10" required="true"  showSelectPanel="true" bpopTipPosition="bottom"/>
		<ta:date id="end" key="结束时间"  value="2016-07-10" required="true" showSelectPanel="true" bpopTipPosition="bottom"/>
		<%--<ta:selectInput id="sqltype" key="SQL类型" data="[{'id':'1','name':'查询类型'},{'id':'2','name':'删除/修改类型'},{'id':'3','name':'全部类型'}]" required="true" selectFirstValue="true" onSelect="fnSelectSQLType"/>--%>
		<%--<ta:selectInput id="analysistype" key="分析类型" data="[{'id':'1','name':'最大执行时间'},{'id':'2','name':'平均执行时间'},{'id':'3','name':'最大影响条数'},{'id':'4','name':'平均影响条数'}]"  required="true" onSelect="fnSelectAnalysisType" selectFirstValue="true"/>--%>
	</ta:box>
	<ta:buttonGroup align="right">
		<ta:button key="查询" onClick="fnClick()"/>
	</ta:buttonGroup>
</ta:panel>
<ta:tabs fit="true">
	<ta:tab key="查询类SQL">
		<ta:tabs fit="true" >
			<ta:tab key="最大执行时间Top10">
				<ta:datagrid id="resultMax11" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="executetime" key="执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均执行时间Top10">
				<ta:datagrid id="resultAvg12" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfExecuteTime" key="平均执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="最大影响条数Top10">
				<ta:datagrid id="resultMax13" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="effectcount" key="影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均影响条数Top10">
				<ta:datagrid id="resultAvg14" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfEffectCount"  key="平均影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
		</ta:tabs>
	</ta:tab>
	<ta:tab key="删除/修改类SQL">
		<ta:tabs fit="true" >
			<ta:tab key="最大执行时间Top10">
				<ta:datagrid id="resultMax21" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="executetime" key="执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均执行时间Top10">
				<ta:datagrid id="resultAvg22" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfExecuteTime" key="平均执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="最大影响条数Top10">
				<ta:datagrid id="resultMax23" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="effectcount" key="影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均影响条数Top10">
				<ta:datagrid id="resultAvg24" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfEffectCount"  key="平均影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
		</ta:tabs>
	</ta:tab>
	<ta:tab key="全部类型SQL">
		<ta:tabs fit="true" >
			<ta:tab key="最大执行时间Top10">
				<ta:datagrid id="resultMax31" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="executetime" key="执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均执行时间Top10">
				<ta:datagrid id="resultAvg32" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfExecuteTime" key="平均执行时间(ms)" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="最大影响条数Top10">
				<ta:datagrid id="resultMax33" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
					<ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="effectcount" key="影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
			<ta:tab key="平均影响条数Top10">
				<ta:datagrid id="resultAvg34" fit="true" forceFitColumns="true" haveSn="true">
					<ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
					<ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
					<ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
					<ta:datagridItem id="avgOfEffectCount"  key="平均影响条数" showDetailed="true" dataAlign="right"/>
				</ta:datagrid>
			</ta:tab>
		</ta:tabs>
	</ta:tab>
</ta:tabs>
<%-- <ta:panel key="结果"  fit="true" >
    <ta:datagrid id="resultMax" fit="true" forceFitColumns="true" haveSn="true">
            <ta:datagridItem id="sqlid" key="配置文件中的SQLId" width="130"  showDetailed="true"/>
            <ta:datagridItem id="excutesql" key="执行的SQL" width="200" showDetailed="true"/>
            <ta:datagridItem id="parameters" key="传入参数信息" showDetailed="true"/>
            <ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
            <ta:datagridItem id="effectcount" key="影响条数" showDetailed="true" dataAlign="right"/>
            <ta:datagridItem id="executetime" key="执行时间(ms)" showDetailed="true" dataAlign="right"/>
    </ta:datagrid>
    <ta:datagrid id="resultAvg" fit="true" forceFitColumns="true" haveSn="true">
            <ta:datagridItem id="executesql"   key="执行的SQL" width="200" showDetailed="true"/>
            <ta:datagridItem id="sqltype" key="SQL类型" showDetailed="true" />
            <ta:datagridItem id="count" key="统计条数" showDetailed="true" dataAlign="right"/>
            <ta:datagridItem id="avgOfEffectCount"  key="平均影响条数" showDetailed="true" dataAlign="right"/>
            <ta:datagridItem id="avgOfExecuteTime" key="平均执行时间(ms)" showDetailed="true" dataAlign="right"/>
    </ta:datagrid>
</ta:panel> --%>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
// 		Base.hideObj("resultAvg");
// 		$("#resultAvg").height($("#resultMax").height());
    });
    function fnClick(){
        Base.submit("info","logAnalysisAction!Analysis.do");
    }
    function  fnSelectAnalysisType(key,value){
        if(value==1 || value ==3){//1,3查询最大
            Base.hideObj("resultAvg");
            Base.showObj("resultMax");
            $("#resultMax").height($("#resultAvg").height());
            Base.getObj("resultMax").resizeAndRender();
            Base.clearGridData("resultMax");
            Base.clearGridData("resultAvg");
        }else if(value==2 || value ==4){//查询平均
            Base.hideObj("resultMax");
            Base.showObj("resultAvg");
            $("#resultAvg").height($("#resultMax").height());
            Base.getObj("resultAvg").resizeAndRender();
            Base.clearGridData("resultMax");
            Base.clearGridData("resultAvg");
            if(value==2){//2是时间
                Base.setGridColumnHidden("resultAvg","avgOfEffectCount");
                Base.setGridColumnShow("resultAvg","avgOfExecuteTime");
            }else if(value==4){//4是条数
                Base.setGridColumnHidden("resultAvg","avgOfExecuteTime");
                Base.setGridColumnShow("resultAvg","avgOfEffectCount");
            }
        }
    }
    function fnSelectSQLType(key,value){
        Base.hideObj("resultAvg");
        Base.showObj("resultMax");
        $("#resultMax").height($("#resultAvg").height());
        Base.getObj("resultMax").resizeAndRender();
        Base.clearGridData("resultMax");
        Base.clearGridData("resultAvg");
        Base.setValue("analysistype","1");
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>