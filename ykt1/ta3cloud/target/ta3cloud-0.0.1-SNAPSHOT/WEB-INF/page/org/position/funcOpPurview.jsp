<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.yinhai.core.common.api.config.impl.SysConfig" %>

<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<html>
<head>
	<title>授权</title>
	<%@ include file="/ta/inc.jsp"%>
	<link rel="stylesheet" type="text/css" href="${basePath}table/style.css">
	<script type="text/javascript" src="${basePath}table/template.js"></script>
</head>
<style>
	.rowSelect{
		background-color: #ffffd5;
	}
	.fontClass{
		white-space: nowrap;
		text-align: center;
		line-height: 31px;
		margin-left: 10px;
	}
	.flexIcon{
		margin-top: -10px;
		line-height: 0;
		margin: 0;
		width: 16px;
		height: 16px;
		display: inline-block;
		vertical-align: middle;
		border: 0 none;
		cursor: pointer;
		outline: none;
		background-color: transparent;
		background-repeat: no-repeat;
		background-attachment: scroll;
		background-image: url(<%=facePath%>img/757d0a38.zTreeStandard.png);
		background-position: -180px -20px;
	}
	.iconClose{
		background-position: -74px -18px!important;
	}
	.iconOpen{
		background-position: -92px -54px!important;
	}
	.inputClass{
		position: relative;
		top: 5px;
	}
</style>
<body class="no-scrollbar no-padding">
<ta:box fit="true" cssStyle="padding:10px 10px 0px 10px;" >
	<ta:text id="positionid" display="false" ></ta:text>
	<ta:text id="positionType" display="false" ></ta:text>
	<ta:text id="userid" display="false" />
	<ta:box cols="5">
		<ta:selectInput id="syspath" key="系统管理"  span="2" onSelect="fnSyspath" onClear="fnSyspathClear" display="false"/>
		<ta:text id="search" key="功能名称"  span="2" onKeydown="fnKeydown(this)"/>
		<%--<ta:box id="searchBox" span="1">
            <span id="now" class="fontClass">第<span>0</span>条</span><span id="total" class="fontClass">共<span>0</span>条</span>
        </ta:box>--%>
		<ta:buttonGroup span="1" align="left">
			<ta:button id="searchBtn" key="搜索" onClick="fnSearch()" icon="icon-search" />
			<%--<ta:button id="prevBtn" key="前一个" onClick="fnPrev()" disabled="true"/>
                <ta:button id="latterBtn" key="后一个" onClick="fnLatter()" disabled="true"/>--%>
		</ta:buttonGroup>
	</ta:box>
	<ta:box fit="true" cssStyle="overflow:auto;" heightDiff="40" id="tableBox" span="5">
		<div id="permisssionTitle">
			<div class="permisssionTitle_item" >
				<div style="line-height: 30px; margin-left: 135px;font-weight:bold;">功能</div>
			</div>
			<div class="permisssionTitle_item" style="width:114px;border-left: 0;line-height: 30px; ">
					<span style="margin-left:27px; ">
						权限期限
					</span>
				<div style="float:right;position:relative;top:4px;right:2px;cursor:pointer" title="批量设置">
					<img onClick="fnBatchEffectiveTime()" src="${basePath}table/datepicker/datePicker.gif" width="16" height="22" align="absmiddle"  />
					<input id="batchEffectiveTime" style="display:none;"/>
				</div>
			</div>
			<div class="permisssionTitle_item" style="width:204px;border-left: 0;line-height: 30px; " id="dataItem">
					<span style="margin-left:70px; ">
						数据权限
					</span>
				<div style="float:right;right:2px;position:relative;top:5px;" class="selecticon" onclick="fnBatchYab139()" title="批量设置">
				</div>
			</div>
		</div>
		<table class="gridtable">
			<tbody id="pdrow" style="position:relative;">
			</tbody>
		</table>
	</ta:box>
	<ta:buttonGroup align="right" span="5">
		<ta:button key="保存[S]" hotKey="s" onClick="fnSave()"></ta:button>
		<ta:button key="关闭[X]" hotKey="x" onClick="fnCancle()"></ta:button>
	</ta:buttonGroup>
</ta:box>
<ta:boxComponent id="searchComponent" height="150px" width="300px" arrowPosition="vertical">
	<ta:datagrid id="menusTable" fit="true" forceFitColumns="true" haveSn="true" border="true" onRowClick="fnRowClick">
		<ta:datagridItem id="menuid" key="菜单id"  hiddenColumn="true" />
		<ta:datagridItem id="menuname" key="菜单名称" showDetailed="true" width="70"/>
		<ta:datagridItem id="menunamepath" key="组织路径" showDetailed="true" width="200"/>
	</ta:datagrid>
</ta:boxComponent>
</body>
</html>
<script id="perviewTmpl" type="text/html">
	{{each list as value index}}
	<tr style="position:relative;">
		<td   style="{{if value.perview=="checked"}}background:rgb(182, 237, 182);{{/if}}display:none;">{{#value.menuid}}</td>
		{{if value.isleaf=="1"}}
		<td class="permissionmenu" >{{#value.nbsp}}<span class="flexIcon" ></span><input id="{{#value.menuid}}" class="inputClass" syspath="{{#value.syspath}}"  pmenuid="{{#value.pmenuid}}" menunamepath="{{#value.menunamepath}}" menuidpath="{{#value.menuidpath}}" isLeaf="{{#value.isleaf}}" type="checkbox" {{#value.perview}} menuname="{{#value.menuname}}" onclick="pclick(this);"/>{{#value.menuname}}</td>
		{{/if}}
		{{if value.isleaf=="0"}}
		<td class="permissionmenu" >{{#value.nbsp}}<span class="flexIcon iconOpen" onclick="fnFlex(this)"></span><input id="{{#value.menuid}}" class="inputClass" syspath="{{#value.syspath}}" pmenuid="{{#value.pmenuid}}" menunamepath="{{#value.menunamepath}}" menuidpath="{{#value.menuidpath}}" isLeaf="{{#value.isleaf}}" type="checkbox" {{#value.perview}} menuname="{{#value.menuname}}" onclick="pclick(this);"/>{{#value.menuname}}</td>
		{{/if}}

		<td style="min-width:110px;">
			<span id="outtime_{{#value.menuid}}">
			{{if value.effecttime}}
				{{#value.effecttime}}
			{{/if}}
			</span>
			{{if value.perview=="checked"}}
			<img onClick="fnCreateWd('{{#value.menuid}}','{{#value.menuidpath}}');" src="../../table/datepicker/datePicker.gif" width="16" height="22" align="absmiddle" style="cursor:pointer;position:relative;float:right;" />
			{{/if}}
		</td>
		<td class="dp">
			<span id="dp_{{#value.menuid}}">
					{{#value.dp}}
			</span>

			{{if value.perview=="checked"}}
			{{if value.hasdp=="true"}}
			<div id="seldep_{{#value.menuid}}" class="selecticon" onclick="showdpselect('{{#value.menuid}}')"></div>
			{{/if}}
			{{/if}}
		</td>
		<td id="menuidpath_{{#value.menuid}}" style="display:none;">{{#value.menuidpath}}</td>
		<input id="hasdp_{{#value.menuid}}" type="hidden" disabled value="{{#value.hasdp}}"/>
	</tr>
	{{/each}}
</script>
<script id="datePickerTmpl" type="text/html">
	<img onClick="fnCreateWd('{{#menuid}}','{{#menuidpath}}');" src="../../table/datepicker/datePicker.gif" width="16" height="22" align="absmiddle" style="cursor:pointer;position:relative;float:right;" />
</script>
<script id="dpPickerTmpl" type="text/html">
	<div id="seldep_{{#menuid}}" class="selecticon"onclick="showdpselect('{{#menuid}}')"></div>
</script>
<script type="text/javascript">

    function fnCreateWd(id,menuidpath) {
        WdatePicker({lang:'zh_CN',el:'outtime_' + id,dateFmt:'yyyy-MM-dd',doubleCalendar:true,onpicked:function(dp){
            var menuidpath = window.__menuidpath;
            $("#pdrow :checkbox[menuidpath^='"+menuidpath+"']").each(function(){
                setWdate(this.id,dp.cal.getNewDateStr(),null,$(this).attr("menuidpath")===menuidpath);
            });

        },onclearing:function(dp){
            var menuidpath = window.__menuidpath;
            //清空子节点
            $("#pdrow :checkbox[menuidpath^='"+menuidpath+"']").each(function(){
                setWdate(this.id,"");
            });
        }
        });
        window.__menuidpath=menuidpath;
    }


    String.prototype.trim = function() {
        return jQuery.trim(this);
    };
    Array.prototype.isInArray = function(o) {
        for(var i = 0 ; i < this.length ; i++){
            if(this[i] == o) {
                return true;
            }
        }
        return false;
    }
    Array.prototype.deleteTarget = function(o) {//add by zzb
        for(var i = 0 ; i < this.length ; i++){
            if(this[i] == o) {
                this.splice(i,1);
            }
        }
    }
    Array.prototype.checkRepeatPush = function(o){
        var flage = false;//判断当前数组里面是否存在o 默认不存在
        for(var i = 0 ; i < this.length ; i++){
            if(this[i] == o) {
                flage = true
                break;
            }
        }
        if(!flage){
            this.push(o);
        }
    }
    function pclick(o){
        var $c = $(o);
        var menuid=$c.attr("id");
        var pmenuid=$c.attr("pmenuid");
        var menuidpath=$c.attr("menuidpath");
        var a_menuidpath = menuidpath.split("/");
        //如果是选中
        if($(o).is(":checked")){
            //勾选所有父亲
            for(var i=0;i<(a_menuidpath.length-1);i++){
                //如果不是原始勾选的数据，则放入新勾选的数据中
                if(!soruceChecked.isInArray(a_menuidpath[i])) {
                    newChecked.checkRepeatPush(a_menuidpath[i]);
                }
                if(cancleChecked.isInArray(a_menuidpath[i])) {
                    cancleChecked.deleteTarget(a_menuidpath[i]);
                }
                $("#"+a_menuidpath[i])[0].checked=true;
                //执行选中所要做的操作
                ponChecked(a_menuidpath[i],$("#"+a_menuidpath[i]).attr("menuidpath"));
            }
            //勾选所有儿子
            $("#pdrow :checkbox[menuidpath^='"+menuidpath+"']").each(function(){
                //如果不是原始勾选的数据，则放入新勾选的数据中
                if(!soruceChecked.isInArray(this.id)) {
                    newChecked.checkRepeatPush(this.id);
                }
                if(cancleChecked.isInArray(this.id)) {
                    cancleChecked.deleteTarget(this.id);
                }
                this.checked = true;
                ponChecked(this.id,$(this).attr("menuidpath"));
            });

        }else{
            //如果是取消
            //取消所有儿子
            $("#pdrow :checkbox[menuidpath^='"+menuidpath+"']").each(function(){
                this.checked = false;
                //如果是原始勾选的数据，则放入取消的数据中
                if(soruceChecked.isInArray(this.id)) {
                    cancleChecked.checkRepeatPush(this.id);
                }
                if(newChecked.isInArray(this.id)) {
                    newChecked.deleteTarget(this.id);
                }
                ponNoChecked(this.id);
            });
            //取消所有父亲
            calparents(menuid,pmenuid);
        }
    }
    function ponNoChecked(menuid){
        var $tdmenuidpath = $("#dp_"+menuid);
        var $outtime = $("#outtime_"+menuid);

        $tdmenuidpath.empty();
        $outtime.empty()
        $tdmenuidpath.next().remove();
        $outtime.next().remove();
    }
    function ponChecked(menuid,menuidpath){

        var $tdmenuidpath = $("#dp_"+menuid);
        var $outtime = $("#outtime_"+menuid);

        //如果期限为空，并且时间选择图标还未显示出来，则创建时间选择图标
        if($outtime.text().trim()=="" && $outtime.parent().find("img").length==0){
            var ht = template('datePickerTmpl', {"menuid":menuid,"menuidpath":menuidpath});
            $outtime.parent().append(ht);
        }
        //如果启用了数据区，并且当前显示的内容为空，就设置默认数据区、创建选择面板和表单
        if($("#hasdp_"+menuid).val()=="true" && $tdmenuidpath.text().trim()==""){
            if(!document.getElementById("seldep_"+menuid)){
                var ht = template('dpPickerTmpl', {"menuid":menuid});
                $("#dp_"+menuid).text(CURDP);
                $tdmenuidpath.parent().append(ht);
                //TODO 如果有启动数据区，则创建隐藏表单
            }else{
                $("#dp_"+menuid).text(CURDP);
            }
        }


    }
    function calparents(menuid,pmenuid){
        //根节点id写死的
        if(menuid=="1"){
            $("#1")[0].checked=false;
            //如果是原始勾选的数据，则放入取消的数据中
            if(soruceChecked.isInArray(1)) {
                cancleChecked.checkRepeatPush(1);
            }
            if(newChecked.isInArray(1)) {
                newChecked.deleteTarget(1);
            }
            ponNoChecked(1);
            return;
        }
        //所有兄弟都没选中的
        if($("#pdrow :checkbox[pmenuid='"+pmenuid+"']:checked").not($("#1")).length == 0){
            var $p = $("#pdrow :checkbox[id='"+pmenuid+"']");
            //如果是原始勾选的数据，则放入取消的数据中
            if(soruceChecked.isInArray($p.attr("id"))) {
                cancleChecked.checkRepeatPush($p.attr("id"));
            }
            if(newChecked.isInArray($p.attr("id"))) {
                newChecked.deleteTarget($p.attr("id"));
            }
            $p[0].checked=false;
            ponNoChecked($p.attr("id"));
            if($p.attr("id")=="1"){
                //$("#0")[0].checked=false;
                return;
            }
            calparents($p.attr("id"),$p.attr("pmenuid"));
        }
    }
    var sourceParam = {};
    function showdpselect(menuid){

        var pos = $("#seldep_"+menuid).parent().position();
        var top = pos.top+30;
        var left = pos.left;
        var $yab139panel = $("#selectDownYab139Panel");
        if($yab139panel.length == 0) {
            $("#pdrow").append("<div id=\"selectDownYab139Panel\" _menuid=\""+menuid+"\"></div>");
            $("#selectDownYab139Panel").css({"top":top,"left":left}).show();
            Base.submit("","positionUserMgAction!queryDefaultAndAdminYab139s.do",{"dto['positionid']":Base.getValue("positionid"),"dto['menuid']":menuid},null,null,function(data){
                yab139AllList = data.fieldData.yab139AllList;
                if(yab139AllList) {
                    var yab139List = yab139AllList.yab139List;//本身具有的数据区
                    var defaultYab139List = yab139AllList.defaultYab139List;//默认数据区
                    var adminList = yab139AllList.adminList;//管理员所能管理的数据区
                    $("#selectDownYab139Panel").append("<div id=\"defaultYab139\"><div id=\"defaultYab139_title\">默认数据区</div></div>")
                    if(defaultYab139List && defaultYab139List.length > 0) {//如果被授权岗位所在经办机构已经分配了默认数据区，则展示默认数据区
                        for(var i = 0 ; i < defaultYab139List.length; i++) {
                            $("#defaultYab139").append("<div class=\"yab139_item\"><input id=\"default_"+defaultYab139List[i].codeValue+"\" type=\"checkbox\" value=\""+defaultYab139List[i].codeValue+"\" disabled=\"disabled\"  _name=\""+defaultYab139List[i].codeDESC+"\"/><label for=\"default_"+defaultYab139List[i].codeValue+"\">"+defaultYab139List[i].codeDESC+"</label></div>");
                        }
                    }
                    $("#selectDownYab139Panel").append("<div id=\"adminYab139\"><div id=\"adminYab139_title\">可分配数据区</div></div>")
                    if(adminList && adminList.length > 0) {//如果管理员所能管理的数据区存在默认数据区，则在可分配数据区不再展示默认数据区的数据
                        for(var i = 0 ; i < adminList.length; i++) {
                            if($("#default_"+adminList[i].codeValue) && $("#default_"+adminList[i].codeValue).length > 0) {
                                $("#default_"+adminList[i].codeValue).removeAttr("disabled");
                            }else{
                                $("#adminYab139").append("<div class=\"yab139_item\"><input id=\"admin_"+adminList[i].codeValue+"\" type=\"checkbox\" value=\""+adminList[i].codeValue+"\" _name=\""+adminList[i].codeDESC+"\"/><label for=\"admin_"+adminList[i].codeValue+"\" >"+adminList[i].codeDESC+"</label></div>");
                            }
                        }
                    }
                    if(yab139List && yab139List.length > 0) {//勾选已经存在的数据
                        var sourceYab139 = [];
                        for(var i = 0 ; i < yab139List.length; i++) {
                            var default_yab139 = $("#default_"+yab139List[i].codeValue);
                            var admin_yab139 = $("#admin_"+yab139List[i].codeValue);
                            if(default_yab139 && default_yab139.length > 0) {
                                default_yab139[0].checked = true;
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                            }else if(admin_yab139 && admin_yab139.length > 0){
                                admin_yab139[0].checked = true;
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                            }
                        }
                        sourceParam[menuid] = sourceYab139;
                    }else{
                        //TODO  默认里面选中
                        Base.submit("","positionUserMgAction!queryAdminDefault.do",{"dto['positionid']":Base.getValue("positionid")},null,null,function(data){
                            var sourceYab139 = [];
                            var yab139AdminDefaultList = data.fieldData.list;
                            for(var i = 0 ; i < yab139AdminDefaultList.length; i++) {
                                var default_yab139 = $("#default_"+yab139AdminDefaultList[i].codeValue);
                                if(default_yab139 && default_yab139.length > 0) {
                                    default_yab139[0].checked = true;
                                    sourceYab139.checkRepeatPush(yab139AdminDefaultList[i].codeValue);
                                }
                            }
                            sourceParam[menuid] = sourceYab139;
                        });
                    }
                }
                $("#selectDownYab139Panel").append("<button id=\"tabutton_save\" class=\"sexybutton_163\" type=\"button\" onclick=\"fnSaveYab139()\" style=\"left:85px;top:3px;\"><span class=\"button_span isok\">保存</span></button>");
                $("#selectDownYab139Panel").append("<button id=\"tabutton_delete\" class=\"sexybutton_163\" type=\"button\"  onclick=\"fnCancleYab139()\" style=\"left:85px;top:3px;\"><span class=\"button_span\">取消</span></button>");
            });
        }else{
            $("#selectDownYab139Panel input:checked").each(function(){
                this.checked = false;
            });
            var yab139input = $("#yab139_"+menuid);
            if(yab139input && yab139input.length > 0) {
                if(yab139input.val() != "") {
                    var yab139arr = yab139input.val().split(",");
                    if(yab139arr.length > 0){
                        for(var i = 0 ; i < yab139arr.length ; i++) {
                            var default_yab139 = $("#default_"+yab139arr[i]);
                            var admin_yab139 = $("#admin_"+yab139arr[i]);
                            if(default_yab139 && default_yab139.length > 0) {
                                default_yab139[0].checked = true;
                            }else if(admin_yab139 && admin_yab139.length > 0){
                                admin_yab139[0].checked = true;
                            }
                        }
                    }
                }
            }else{
                Base.submit("","positionUserMgAction!queryYab139List.do",{"dto['positionid']":Base.getValue("positionid"),"dto['menuid']":menuid},null,null,function(data){
                    var yab139List = data.fieldData.yab139List;
                    if(yab139List && yab139List.length > 0) {
                        var sourceYab139 = [];
                        for(var i = 0 ; i < yab139List.length; i++) {
                            var default_yab139 = $("#default_"+yab139List[i].codeValue);
                            var admin_yab139 = $("#admin_"+yab139List[i].codeValue);
                            if(default_yab139 && default_yab139.length > 0) {
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                                default_yab139[0].checked = true;
                            }else if(admin_yab139 && admin_yab139.length > 0){
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                                admin_yab139[0].checked = true;
                            }
                        }
                        sourceParam[menuid] = sourceYab139;
                    } else{
                        //TODO  默认里面选中
                        Base.submit("","positionUserMgAction!queryAdminDefault.do",{"dto['positionid']":Base.getValue("positionid")},null,null,function(data){
                            var sourceYab139 = [];
                            var yab139AdminDefaultList = data.fieldData.list;
                            for(var i = 0 ; i < yab139AdminDefaultList.length; i++) {
                                var default_yab139 = $("#default_"+yab139AdminDefaultList[i].codeValue);
                                if(default_yab139 && default_yab139.length > 0) {
                                    default_yab139[0].checked = true;
                                    sourceYab139.checkRepeatPush(yab139AdminDefaultList[i].codeValue);
                                }
                            }
                            sourceParam[menuid] = sourceYab139;
                        });
                    }
                });
            }
            $yab139panel.attr("_menuid",menuid).css({"top":top,"left":left}).show();
        }
    }

    /**
     * @param menuid 标识目标
     * @param value 设置值
     * @param sucCallback 成功回调
     * @param isAlert 是否弹出权限校验信息
     */
    function setWdate(menuid,value,sucCallback,isAlert){
        var e=arguments.callee.caller.arguments[0]||event; //若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
        if (e && e.stopPropagation) {
            e.stopPropagation();
        } else if (window.event) {
            window.event.cancelBubble = true;
        }
        if($("#"+menuid)[0].checked==false) {
            if(isAlert)alert("该行功能还未被授权，不能设置时限！");
            return false;
        }
        //执行表单创建
        var $h_effecttime = $("#h_effecttime_"+menuid);
        if($h_effecttime.length>0){//已经创建过
            $h_effecttime.val(value);
        }else{
            $("<input type=\"hidden\" class=\"outtime\" id=\"h_effecttime_"+menuid+"\" name=\"dto['h_effecttime_"+menuid+"']\" value=\""+value+"\"/>").appendTo($("#"+menuid).parent().parent());
        }

        $("#outtime_"+menuid).html(value);
        if(typeof sucCallback == "function")sucCallback();

        return true;
    }


    var testdata = {"list":[]};
    var CURDP ="";
    var soruceChecked=[],cancleChecked=[],newChecked=[],allChecked=[];
    $(document).ready(function () {
        $("body").taLayout();
        if (typeof require == "function")
            require(["datetimeMask"], function(){});
        Base.submit("","positionUserMgAction!queryPermissionsYab139s.do",{"dto['positionid']":Base.getValue("positionid")},null,null,function(data){
            testdata.list = data.fieldData.list;
            CURDP = data.fieldData.yab139s;
            var ht = template('perviewTmpl', testdata);
            $("#pdrow").html(ht);
            $("#pdrow .permissionmenu input:checked").each(function(){
                soruceChecked.checkRepeatPush(this.id);
            });
        });
    });
    function fnSave(){
        var outtime = [];
        var $outtimes = $("#pdrow input.outtime");
        if($outtimes.length > 0) {
            for(var i = 0 ; i < $outtimes.length ; i++) {
                outtime.checkRepeatPush($outtimes[i].id.substring(13));
            }
        }
        $("#pdrow .permissionmenu input:checked").each(function(){
            allChecked.checkRepeatPush(this.id);
        });
        //aolei add
        var str = "";
        for (var i = 0; i < allChecked.length; i++) {
            str += "{\"id\":\"" + allChecked[i] + "\",\"checked\":" + "true" + "},";
        }
        for (var j = 0; j < cancleChecked.length; j++) {
            str += "{\"id\":\"" + cancleChecked[j] + "\",\"checked\":" + "false" + "},";
        }
        str = "[" + str.substr(0, str.length - 1) + "]";
        var param = {};
        param["dto['positionType']"] = Base.getValue("positionType");
        param["dto['positionid']"] = Base.getValue("positionid");
        param["dto['userid']"] = Base.getValue("userid");
        param["dto['allChecked']"] = Ta.util.obj2string(allChecked);
        param["dto['cancleChecked']"] = Ta.util.obj2string(cancleChecked);
        param["dto['newChecked']"] = Ta.util.obj2string(newChecked);
        param["dto['outtime']"] = Ta.util.obj2string(outtime);
        param["dto['yab139Cancle']"] = Ta.util.obj2string(yab139Cancle);
        param["dto['addAndCancelMenuidsStr']"] = str;

        Base.submit("tableBox","positionUserMgAction!saveRoleScopeAclOperate.do",param,null,null,function(){
            parent.Base.msgTopTip("保存成功！");
            var type = Base.getValue("positionType");
            if(type == 2){
                parent.Base.submit("","positionUserMgAction!queryPerMission.do",{'userid':Base.getValue("userid")},null,null,function(){
                    //parent.enableUserBtn();
                });
            }else if(type == 1){
                parent.Base.submit("","positionUserMgAction!queryPosMission.do",{'pos_positionid':Base.getValue("positionid")},null,null,function(){
                    //parent.enablePosBtn();
                });
            }
            parent.Base.closeWindow("opPermission");
        });
    }
    function fnCancle(){
        Base.confirm("关闭窗口将取消一切操作，确定关闭？",function(yes){
            if(yes) {
                parent.Base.closeWindow("opPermission");
            }
        });
    }
    var yab139Cancle = [];
    function fnSaveYab139(){
        var names = "";
        var yab139ids = "";
        $("#selectDownYab139Panel input:checked").each(function(){
            names += $(this).attr("_name")+",";
            yab139ids += $(this).val() + ",";
        });
        if("," == names.charAt(names.length - 1)) {
            names = names.substring(0,names.length - 1);
        }
        if("," == yab139ids.charAt(yab139ids.length - 1)) {
            yab139ids = yab139ids.substring(0,yab139ids.length - 1);
        }
        var _menuid = $("#selectDownYab139Panel").attr("_menuid");
        var yab139arr = yab139ids.split(",");
        var cancleYab139 = "";
        if(yab139arr[0] != ""){
            if(sourceParam[_menuid]) {
                for(var i = 0 ; i < sourceParam[_menuid].length ; i++) {
                    if(!yab139arr.isInArray(sourceParam[_menuid][i])) {
                        cancleYab139 += sourceParam[_menuid][i];
                        if(i < sourceParam[_menuid].length - 1) {
                            cancleYab139 += ",";
                        }
                    }
                }
            }
        }
        var yab139param = {};
        if(cancleYab139.length != 0){
            var flag = false;
            yab139param[_menuid] = Ta.util.obj2string(cancleYab139);
            for(var i = 0 ; i < yab139Cancle.length; i++) {
                for(var k in yab139Cancle[i]){
                    if(k == _menuid){
                        yab139Cancle[i] = yab139param;
                        flag = true;
                        break;
                    }
                }
            }
            if(!flag){
                yab139Cancle.checkRepeatPush(yab139param);
            }
        }
        var inputYab139 = $("#yab139_"+_menuid);
        if(inputYab139 && inputYab139.length > 0) {
            inputYab139.val(yab139ids);
        }else{
            $("#"+_menuid).parent().parent().append("<input id=\"yab139_"+_menuid+"\" _id=\""+_menuid+"\" value=\""+yab139ids+"\" type=\"hidden\" name=\"dto['yab139_"+_menuid+"']\"/>");
        }
        $("#dp_"+_menuid).html(names);
        $("#selectDownYab139Panel").hide();
    }
    function fnCancleYab139(){
        $("#selectDownYab139Panel").hide();
    }
    function fnBatchEffectiveTime() {
        WdatePicker({lang:'zh_CN',el:'batchEffectiveTime',dateFmt:'yyyy-MM-dd',doubleCalendar:true
            ,
            onpicking:function(dp){
                $(".permissionmenu :checked").each(function(){
                    setWdate(this.id,dp.cal.getNewDateStr(),null,false);
                });
            },onclearing:function(dp,id,menuidpath){
                $(".permissionmenu :checked").each(function(){
                    setWdate(this.id,"");
                });
            }});
    }
    function fnBatchYab139() {
        var $yab139panel = $("#selectDownYab139Panel_batch");
        var position = $("#dataItem").position();
        var top = position.top + 43;
        var left = position.left;
        if($yab139panel.length == 0) {
            $("body").append("<div id=\"selectDownYab139Panel_batch\"></div>");
            $("#selectDownYab139Panel_batch").css({"top":top,"left":left,"z-index":1}).show();
            $("#selectDownYab139Panel_batch").append("<div id=\"defaultYab139_batch\"><div id=\"defaultYab139_title_batch\">默认数据区</div></div>");
            $("#selectDownYab139Panel_batch").append("<div id=\"adminYab139_batch\"><div id=\"adminYab139_title_batch\">可分配数据区</div></div>");
            Base.getJson("positionUserMgAction!queryDefaultAndAdminYab139s.do",{"dto['positionid']":Base.getValue("positionid"),"dto['menuid']":"-1"},function(data){
                yab139AllList = data.fieldData.yab139AllList;
                if(yab139AllList) {
                    var defaultYab139List = yab139AllList.defaultYab139List;//默认数据区
                    var adminList = yab139AllList.adminList;//管理员所能管理的数据区
                    if(defaultYab139List && defaultYab139List.length > 0) {//如果被授权岗位所在经办机构已经分配了默认数据区，则展示默认数据区
                        for(var i = 0 ; i < defaultYab139List.length; i++) {
                            $("#defaultYab139_batch").append("<div class=\"yab139_item\"><input id=\"batch_default_"+defaultYab139List[i].codeValue+"\" type=\"checkbox\" value=\""+defaultYab139List[i].codeValue+"\" disabled=\"disabled\"  _name=\""+defaultYab139List[i].codeDESC+"\"/><label for=\"batch_default_"+defaultYab139List[i].codeValue+"\">"+defaultYab139List[i].codeDESC+"</label></div>");
                        }
                    }
                    if(adminList && adminList.length > 0) {//如果管理员所能管理的数据区存在默认数据区，则在可分配数据区不再展示默认数据区的数据
                        for(var i = 0 ; i < adminList.length; i++) {
                            if($("#batch_default_"+adminList[i].codeValue) && $("#batch_default_"+adminList[i].codeValue).length > 0) {
                                $("#batch_default_"+adminList[i].codeValue).removeAttr("disabled");
                            }else{
                                $("#adminYab139_batch").append("<div class=\"yab139_item\"><input id=\"batch_admin_"+adminList[i].codeValue+"\" type=\"checkbox\" value=\""+adminList[i].codeValue+"\" _name=\""+adminList[i].codeDESC+"\"/><label for=\"batch_admin_"+adminList[i].codeValue+"\" >"+adminList[i].codeDESC+"</label></div>");
                            }
                        }
                    }
                }
                $("#selectDownYab139Panel_batch").append("<button  class=\"sexybutton_163\" type=\"button\" onclick=\"fnBatchSaveYab139()\" style=\"left:85px;top:3px;\"><span class=\"button_span isok\">保存</span></button>");
                $("#selectDownYab139Panel_batch").append("<button class=\"sexybutton_163\" type=\"button\"  onclick=\"fnBatchCancleYab139()\" style=\"left:85px;top:3px;\"><span class=\"button_span\">取消</span></button>");
            });
        }else{
            $yab139panel.css({"top":top,"left":left}).show();
        }
        $(".permissionmenu input:checked").each(function(){
            var menuid = this.id;
            if($("#hasdp_"+this.id).val() == "true"){
                Base.getJson("positionUserMgAction!queryYab139List.do",{"dto['positionid']":Base.getValue("positionid"),"dto['menuid']":menuid},function(data){
                    var yab139List = (data.fieldData == undefined ? [] : data.fieldData.yab139List);
                    if(yab139List && yab139List.length > 0) {//勾选已经存在的数据
                        var sourceYab139 = [];
                        for(var i = 0 ; i < yab139List.length; i++) {
                            var default_yab139 = $("#batch_default_"+yab139List[i].codeValue);
                            var admin_yab139 = $("#batch_admin_"+yab139List[i].codeValue);
                            if(default_yab139 && default_yab139.length > 0) {
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                            }else if(admin_yab139 && admin_yab139.length > 0){
                                sourceYab139.checkRepeatPush(yab139List[i].codeValue);
                            }
                        }
                        sourceParam[menuid] = sourceYab139;
                    }
                });
            }
        });
    }
    function fnBatchSaveYab139(){
        var names = "";
        var yab139ids = "";
        $("#selectDownYab139Panel_batch input:checked").each(function(){
            names += $(this).attr("_name")+",";
            yab139ids += $(this).val() + ",";
        });
        if("," == names.charAt(names.length - 1)) {
            names = names.substring(0,names.length - 1);
        }
        if("," == yab139ids.charAt(yab139ids.length - 1)) {
            yab139ids = yab139ids.substring(0,yab139ids.length - 1);
        }
        $(".permissionmenu input:checked").each(function(){
            if($("#hasdp_"+this.id).val() == "true"){
                var _menuid = this.id;
                var yab139arr = yab139ids.split(",");
                var cancleYab139 = "";
                if(yab139arr[0] != ""){
                    if(sourceParam[_menuid]) {
                        for(var i = 0 ; i < sourceParam[_menuid].length ; i++) {
                            if(!yab139arr.isInArray(sourceParam[_menuid][i])) {
                                cancleYab139 += sourceParam[_menuid][i];
                                if(i < sourceParam[_menuid].length - 1) {
                                    cancleYab139 += ",";
                                }
                            }
                        }
                    }
                }
                var yab139param = {};
                if(cancleYab139.length != 0){
                    var flag = false;
                    yab139param[_menuid] = Ta.util.obj2string(cancleYab139);
                    for(var i = 0 ; i < yab139Cancle.length; i++) {
                        for(var k in yab139Cancle[i]){
                            if(k == _menuid){
                                yab139Cancle[i] = yab139param;
                                flag = true;
                                break;
                            }
                        }
                    }
                    if(!flag){
                        yab139Cancle.checkRepeatPush(yab139param);
                    }
                }
                var inputYab139 = $("#yab139_"+_menuid);
                if(inputYab139 && inputYab139.length > 0) {
                    inputYab139.val(yab139ids);
                }else{
                    $("#"+_menuid).parent().parent().append("<input id=\"yab139_"+_menuid+"\" _id=\""+_menuid+"\" value=\""+yab139ids+"\" type=\"hidden\" name=\"dto['yab139_"+_menuid+"']\"/>");
                }
                $("#dp_"+_menuid).html(names);
            }
        });
        fnBatchCancleYab139();
    }
    function fnBatchCancleYab139(){
        $("#selectDownYab139Panel_batch").hide();
    }

    //搜索跳转对象
    var collect ={total:0,now:0,selects:[],key:"",syspath:""};
    function fnSearch(){
        var searchValue = Base.getValue("search").toLowerCase();
        var syspath = Base.getValue("syspath");
        if(searchValue ==null || searchValue==""){
            $("#pdrow").find(".permissionmenu").each(function(){
                $(this).parent().removeClass("rowSelect");
            });
            return;
        }
        collect.selects = [];
        collect.key = searchValue;
        $("#pdrow").find(".permissionmenu input").each(function(){
            $(this).parent().parent().removeClass("rowSelect");
            if($(this).attr("menuname").toLowerCase().indexOf(searchValue) >= 0 && ($(this).attr("syspath")== syspath || syspath == "") ){
                collect.selects.push($(this).parent().parent());
            }
        });
        var total = collect.selects.length;
        if(total != 0){
            collect.total = total;
            collect.now = 1;
            if( total == 1){
                scrollTarget();
            }else{
                var list = [];
                for(var i=0;i<collect.total;i++){
                    var map = {};
                    var $input = collect.selects[i].find(".permissionmenu input");
                    map.menuid = $input.attr("id");
                    map.menunamepath = $input.attr("menunamepath");
                    map.menuname= $input.attr("menuname");
                    list.push(map);
                }
                Base._setGridData("menusTable",list);
                Base.showBoxComponent("searchComponent",$("#search")[0]);
            }
        }else{
            collect.total = 0;
            collect.now = 0;
        }
    }
    /**
     * 滚动到目标位置
     */
    function scrollTarget(){
        collect.selects[collect.now-1].addClass("rowSelect");
        var $target = collect.selects[collect.now-1];
        if($target.is(":hidden")){
            parentOpen($target);
        }
        var position = $target.offset().top - $("#tableBox").offset().top - $("#permisssionTitle").height() + $("#tableBox").scrollTop();
        $("#tableBox").animate({scrollTop:position},100);
    }
    function parentOpen($obj){
        var pmenuid = $obj.find(".permissionmenu input").attr("pmenuid");
        childrenFlex(pmenuid,true);
        var $parent = $("#pdrow").find(".permissionmenu input[id="+pmenuid+"]").parent().parent();
        if($parent.is(":hidden")){
            parentOpen($parent);
        }
    }
    /**
     * 伸缩方法
     */
    function fnFlex(obj){
        var menuid = $(obj).parent().find("input")[0].id;
        if($(obj).hasClass("iconClose")){
            childrenFlex(menuid,true);
        }else if($(obj).hasClass("iconOpen")){
            childrenFlex(menuid,false);
        }
    }
    /**
     * 展开/关闭 子节点
     * @param menuid
     * @param flag
     */
    function childrenFlex(menuid,flag){
        if(!flag){
            $("#pdrow").find(".permissionmenu input[id="+menuid+"]").prev().removeClass("iconOpen").addClass("iconClose");
            $("#pdrow").find(".permissionmenu input[pmenuid="+menuid+"]").each(function(){
                $(this).parent().parent().hide();
                if(this.getAttribute("isleaf") == "0"){
                    childrenFlex(this.id,flag);
                }
            });
        }else{
            $("#pdrow").find(".permissionmenu input[id="+menuid+"]").prev().removeClass("iconClose").addClass("iconOpen");
            $("#pdrow").find(".permissionmenu input[pmenuid="+menuid+"]").each(function(){
                $(this).parent().parent().show();
                /*				if(this.getAttribute("isleaf") == "0"){
                                    childrenFlex(this.id,flag);
                                }*/
            });
        }
    }
    /**
     * 系统路径 选择过滤
     * @param key
     * @param value
     */
    function fnSyspath(key,value){
        $("#pdrow").find(".permissionmenu input[syspath="+value+"]").each(function(){
            $(this).parent().parent().show();
            var span=$(this).prev();
            if(span.hasClass("iconClose")){
                span.removeClass("iconClose").addClass("iconOpen");
            }
        });
        $("#pdrow").find(".permissionmenu input[syspath!="+value+"]").each(function(){
            $(this).parent().parent().hide();
            var span=$(this).prev();
            if(span.hasClass("iconOpen")){
                span.removeClass("iconOpen").addClass("iconClose");
            }
        });
        fnSearch();
        collect.syspath = value;
    }
    /**
     * 弹出表格 回填事件
     * @param e
     * @param data
     */
    function fnRowClick(e,data){
        for(var i=0;i<collect.total;i++){
            if(collect.selects[i].find(".permissionmenu input").attr("id") == data.menuid ){
                collect.now = i+1;
                continue;
            }
        }
        $("#searchComponent").hide();
        scrollTarget();
    }
    /**
     * 系统菜单 清除事件
     * @param key
     * @param value
     */
    function fnSyspathClear(key,value){
        $("#pdrow").find(".permissionmenu input").each(function(){
            $(this).parent().parent().show();
            var span=$(this).prev();
            if(span.hasClass("iconClose")){
                span.removeClass("iconClose").addClass("iconOpen");
            }
        });
    }
    /**
     * 功能名称 回车搜索
     * @param obj
     */
    function fnKeydown(obj){
        var e=arguments.callee.caller.arguments[0]||event; //若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
        if (e && e.stopPropagation) {
            e.stopPropagation();
        } else if (window.event) {
            window.event.cancelBubble = true;
        }
        if (e.keyCode == 13){
            fnSearch();
            e.preventDefault ? e.preventDefault() : (e.returnValue = false);
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp"%>