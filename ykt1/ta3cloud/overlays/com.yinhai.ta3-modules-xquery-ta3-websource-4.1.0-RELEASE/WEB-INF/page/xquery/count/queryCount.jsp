<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>查询统计</title>
    <%@ include file="/ta/inc.jsp" %>
    <link rel="stylesheet" type="text/css" id="queryCountSkin" href="${basePath}css/<%=faceSkin%>/queryCount.css" />
    <script type="text/javascript">
        var skin = Base.globvar.FaceSkin;
        webFaceSkin.apply(queryCountSkin,"${basePath}css/",skin,"/queryCount");
    </script>
    <script src="${basePath}js/echarts-all.js" type="text/javascript"></script>
</head>
<body class="no-scrollbar" style="padding:0;">
<ta:pageloading/>
<ta:box layout="border" layoutCfg="{rightWidth:500}">
    <ta:box position="center" height="100%">
        <ta:text id="jctj" display="false"></ta:text>
        <ta:text id="menuid" display="false"></ta:text>
        <ta:text id="themeid" display="false"></ta:text>
        <ta:text id="planname" display="false"></ta:text>
        <ta:text id="themetable" display="false"></ta:text>
        <ta:text id="datasourceid" display="false"></ta:text>
        <ta:panel id="chartsIdPanel" key="图标统计" fit="true" cssStyle="display:none;">
            <div id='chartsId' style="display:none;"></div>
        </ta:panel>
        <ta:box height="50%" id="resultBox">
            <ta:panel key="统计查询（鼠标点击统计值，可反查明细）" fit="true">
                <ta:datagrid id="queryResultDgd" forceFitColumns="true" selectType="checkbox" fit="true">
                    <ta:datagridItem id="tjsjts" sortable="true" key="<span style=color:red;float:left>请先输入统计条件，选择统计项，统计指标，然后再点击“统计”按钮进行统计。</span>" />
                    <ta:dataGridToolPaging url="userDefinedQueryController!queryPage.do" pageSize="5" showExcel="false" submitIds="xml,datasourceid"/>
                </ta:datagrid>
                <ta:text id="xml" display="false"/>
                <ta:text id="xmlDetail" display="false"/>
            </ta:panel>
        </ta:box>
        <ta:box height="50%" id="deailInfoBox">
            <ta:panel key="统计明细" fit="true">
                <ta:datagrid id="deailInfoDgd" forceFitColumns="true" selectType="checkbox" fit="true">
                    <ta:dataGridToolPaging url="userDefinedQueryController!queryDetail.do"  pageSize="5" showExcel="false" submitIds="xmlDetail,datasourceid"/>
                </ta:datagrid>
            </ta:panel>
        </ta:box>

        <!-- 点击数字时生成带参表单html -->
        <div id="detailInfoParasId"></div>
    </ta:box>
    <ta:box position="right" key="条件设置" id="editConfigBox">
        <ta:box cols="2">
            <ta:selectInput id="planid" key="当前统计方案" hiddenValue="planid" displayValue="planname" onSelect="callOutPlan" columnWidth="0.75"/>
            <span class='faceIcon icon-delete' onclick="fnDeletePlan()" style="cursor: pointer;color: red;display: inline-block;margin: 9px;"></span>
            <ta:button key="新增方案" size="small" onClick="fnAddPlan()"></ta:button>
        </ta:box>
        <ta:box fit="true">
            <ta:box height="75%">
                <ta:box height="60%">
                    <ta:panel key="统计条件"
                              headerButton='[{"id":"btn1_1","name":"增加组","click":"addConditionGroup()"}]' fit="true">
                        <div id="gruops_id">
                            <c:if test="${!empty orsMap}">
                                <c:forEach items="${orsMap}" varStatus="table_st" var ="m">
                                    <table id="datagrid_query_id"  width="100%" align="center" cellpadding="2" cellspacing="0" border="0">
                                        <tbody>
                                        <tr id="datagrid_title_id">
                                            <td style="width:60px;">
                                                操作
                                            </td>
                                            <td style="width:80px;">
                                                项目名称
                                            </td>
                                            <td style="width:80px;">
                                                运算符
                                            </td>
                                            <td style="width:45%">
                                                内容
                                            </td>
                                        </tr>
                                        <c:forEach items="${m.value}" var = "and1" varStatus="tr_st">
                                            <c:set var="_and" value="${and1}"></c:set>
                                            <tr>
                                                <td style="width:60px;">
                                                    <a href="javascript:void(0);" class="datagrid_dele_tr" onclick="deleteTr(this)">删除</a>
                                                </td>
                                                <td style="width:80px;">
                                                    <select  name="cxxm" style="width:97%;" onchange="getFieldRela(this)">
                                                        <option value=''>请选择</option>
                                                        <c:forEach items="${_and.fieldList}" var = "item" varStatus="st">
                                                            <option value='${item.fieldid}'  filed='${item.fieldname}'
                                                                    <c:if test="${item.fieldid == _and.fieldid}">
                                                                        selected="selected"
                                                                    </c:if> >
                                                                    ${item.fieldcomment}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                                <td style="width:80px;">
                                                    <select name="gxysf" style="width:97%;">
                                                        <c:forEach items="${_and.fieldRelaList}" var = "item" varStatus="st">
                                                            <option value='${item.fieldrelation}'
                                                                    <c:if test="${item.fieldrelation == _and.fieldrelation}">selected="selected"</c:if> >
                                                                    ${item.fieldrelation_desc}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                                <td id="nr_td_id" style="text-align: left;padding-left: 5px;width: 45%">
					   <span id='nrz_span_id' style='width:98%;display:inline;'>
					    <!-- 代码值平铺 -->
					    <c:if test="${_and.fielddisplaytype == '21'}">
                            <c:forEach items="${_and.codeList }" var ="item" varStatus="st">
                                <input name='nrz_checkbox' type='checkbox' value="${item.codeValue }"
                                <c:if test="${item.checked == 1}">checked="checked"</c:if>/>&nbsp;${item.codeDESC}&nbsp;&nbsp;&nbsp;&nbsp;
                            </c:forEach>
                        </c:if>
                           <!-- 文本框 -->
					    <c:if test="${_and.fielddisplaytype == '11'}">
                            <input name='nrz' type='text' style='width: 250px;' value="${_and.inputvalue }" />
                        </c:if>
                           <!-- 日期 -->
					    <c:if test="${_and.fielddisplaytype == '13' }">
                            <input  name='nrz' type='text'  value="${_and.inputvalue }" onfocus=WdatePicker({position:{top:6,left:-9},isShowWeek:false,dateFmt:'yyyy-MM-dd'}) class='Wdate' maxlength='10'/>
                        </c:if>
                           <!-- 年月 -->
					    <c:if test="${_and.fielddisplaytype =='12'}">
                            <input name='nrz' type='text'  value="${_and.inputvalue }" onfocus=WdatePicker({position:{top:6,left:-9},isShowWeek:false,dateFmt:'yyyy-MM'}) class='Wdate' maxlength='10'/>
                        </c:if>
                           <!-- 数字 -->
					    <c:if test="${_and.fielddisplaytype =='14' }">
                            <input name='nrz' type='text' style='width: 250px;' value="${_and.inputvalue }" />
                        </c:if>
                           <!-- 树 -->
					    <c:if test="${_and.fielddisplaytype =='22' }">
                            <c:set var="treeId" value="treeData_${table_st.index}_${tr_st.index}" ></c:set>
                            <div style='width:250px;position: relative;left: 0px;top: 0px;height: 20px;'>
				               <input name='nrz' id='nrz_"${treeId}"' type='hidden'/>
		                       <span class='faceIcon icon-arrow_down selectTreeIcon' style='margin-top:2px;position: absolute;right: 10px;' onclick='showMenu(this)' title='点击展开下拉树'></span>
		                       <span class='faceIcon icon-close selectTreeIcon' style='margin-top:2px;position: absolute;right: 33px;'  onclick="fnClear(this,'${treeId}')" title='清除'></span>
		                       <input type='text' id='nrz_key_${treeId}' style='width: 250px;' readonly='true' title=''/></div>
                            <div name='menuContent' style='display:none; position: absolute;z-index:1000;width:300px;height:350px;background: #fff;border:#D1D1D1 1px solid;overflow:auto;'>
		                       <input type='text' name='queyName'  style='width:150px;margin-left:5px;margin-top:5px;'/>
		                       <a href='javascript:void(0);' ><font size='2' style='cursor: pointer;margin-left:5px' onclick=fnQueryData(this,"${treeId }")>查询</font></a>&nbsp;&nbsp;
							   <div style='margin-top:5px;height:319.5px;width:299px'>
						       <ul id='${treeId}' name='treeData' class='ztree' style='margin-top:0;'></ul></div></div>
                            <script type="text/javascript">
					            var chekedTreeData = ${_and.checkedTreeJson};
                                $(document).ready(function(){
                                        $.fn.zTree.init($('#${treeId }'),setting,${_and.treeJson});
                                        var treeObj = $.fn.zTree.getZTreeObj('${treeId}');
                                        $.each(chekedTreeData,function(sn,__o){
                                            var node = treeObj.getNodesByParam("id",__o.codeValue, null);
                                            treeObj.checkNode(node[0],true,true);
                                        });
                                });
                                //另提解决文本框延迟问题
                                var ids = '',idnames='';
                                $.each(chekedTreeData,function(sn,__o){
                                    ids +=  __o.codeValue + ';';
                                    idnames += __o.codeDESC + ';';
                                });
                                $('#nrz_${treeId}').val(ids);
                                $('#nrz_key_${treeId}').attr('title',idnames).val(idnames);
					          </script>
                        </c:if>

					     <input name='datatype' value="${_and.fielddisplaytype }" type='hidden'/>
					   </span>
                        <span id="nr_item_select_id" style="display:none;"></span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td style="width:30px;text-align: left;" colspan="4">
                                                <ta:button key="增加条件" onClick="addCondition(this)" />
                                                <ta:button key="删除该条件组" onClick="deleteCondition(this)"/>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty orsMap }">
                            <table id="datagrid_query_id"  width="100%" align="center" cellpadding="2" cellspacing="0" border="0">
                                <tbody>
                                <tr id="datagrid_title_id">
                                    <td style="width:60px;">
                                        操作
                                    </td>
                                    <td style="width:80px;">
                                        项目名称
                                    </td>
                                    <td style="width:80px;">
                                        运算符
                                    </td>
                                    <td style="width: 45%">
                                        内容
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="width:60px;">
                                        <a href="javascript:void(0);" class="datagrid_dele_tr" onclick="deleteTr(this)">删除</a>
                                    </td>
                                    <td  style="width:80px;">
                                        <select  name="cxxm" style="width:97%;" onchange="getFieldRela(this)">
                                            <option value=''>请选择</option>
                                            <c:forEach items="${queryFieldList }" var ="item">
                                                <option value="${item.fieldid}" filed="${item.fieldname}">
                                                        ${item.fieldcomment}
                                                </option>
                                            </c:forEach>

                                        </select>
                                    </td>
                                    <td  style="width:80px;">
                                        <select  name="gxysf" style="width:97%;">
                                            <option value=''>请选择</option>
                                        </select>
                                    </td>
                                    <td id='nr_td_id' style="text-align: left;padding-left: 5px;width: 45%">
		   <span id='nrz_span_id' style='display:inline;width:98%;'>
		     <input type="text" name='nrz' style="width: 250px;"/>
		   </span>
                                        <span id='nr_item_select_id' style='display:none;'></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="width:30px;text-align: left;" colspan="4">
                                        <ta:button key="增加条件" size="small" onClick="addCondition(this)" />
                                        <ta:button key="删除该条件组" size="small" onClick="deleteCondition(this)" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            </c:if>
                        </div>
                    </ta:panel>
                </ta:box>
                <ta:box height="40%">
                    <ta:panel key="统计指标" fit="true" headerButton='[{"id":"btn1_1","name":"统计项","click":"fnConditionSet()"}]' >
                        <div style="height:158px;width:100%;overflow:auto;">
                            <table id="datagrid_query_id" width="100%" align="center" cellpadding="2" cellspacing="0" border="0">
                                <tbody>
                                <tr id="datagrid_title_id">
                                    <td style="width:50px;">
                                        操作
                                    </td>
                                    <td style="width:250px;">
                                        项目名称
                                    </td>
                                    <td style="width: 45%">
                                        统计值
                                    </td>
                                </tr>
                                <c:if test="${!empty tjlxRows}">
                                    <c:forEach items="${tjlxRows}" var="item_row" varStatus="st" >
                                        <tr>
                                            <td style="width:50px;">
                                                <a href="javascript:void(0);" class="datagrid_dele_tr" onclick="deleteTjzbhsTr(this)">删除</a>
                                            </td>
                                            <td style="width:250px;">
                                                <select  name="tjzb" style="width:97%;" onchange="getCountway(this)">
                                                    <option value=''>请选择</option>
                                                    <c:forEach items="${item_row.fieldsList}" var="item" varStatus="st">
                                                        <option value='${item.fieldid}' <c:if test="${item.fieldid == item_row.fieldid}">selected="selected"</c:if>
                                                                filed='${item.fieldname}' dbtype='${item.fieldtype}' datatype='${item.fielddisplaytype}'>
                                                                ${item.fieldcomment}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td style="width:45%">
                                                <select  name="tjzbhs" style="width:97%;">
                                                    <c:forEach items="${item_row.countsList}" var="item" varStatus="st">
                                                        <option value='${item.countway}'
                                                                <c:if test="${item.countway == item_row.countway}"> selected="selected"</c:if>>
                                                                ${item.countway_desc}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty tjlxRows}">
                                    <tr>
                                        <td style="width:50px;">
                                            <a href="javascript:void(0);" class="datagrid_dele_tr" onclick="deleteTjzbhsTr(this)">删除</a>
                                        </td>
                                        <td style="width:250px;">
                                            <select  name="tjzb" style="width:97%;" onchange="getCountway(this)">
                                                <option value=''>请选择</option>
                                                <c:forEach items="${countFieldList}" var="item" >
                                                    <option value='${item.fieldid}'  filed='${item.fieldname}' dbtype='${item.fieldtype}' datatype='${item.fielddisplaytype}'>
                                                            ${item.fieldcomment}
                                                    </option>
                                                </c:forEach>
                                            </select>

                                        </td>
                                        <td style="width: 45%">
                                            <select  name="tjzbhs" style="width:97%;">
                                                <option value=''>请选择</option>
                                            </select>
                                        </td>
                                    </tr>
                                </c:if>
                                <td  style="width:30px;text-align: left;" colspan="3">
                                    <ta:button key="增加统计指标" size="small" onClick="addTjzbhsTr(this)" />
                                </td>
                                </tbody>
                            </table>
                        </div>
                    </ta:panel>
                </ta:box>
            </ta:box>
            <ta:box height="25%">
                <ta:radiogroup id="showTypes" cols="4" cssStyle="margin-top:10px;margin-left:20px;">
                    <ta:radio id="rdGrid" key="表格" value="1"></ta:radio>
                    <ta:radio id="rdZhu" key="柱状图" value="2"></ta:radio>
                    <ta:radio id="rdBing" key="饼图" value="3"></ta:radio>
                    <ta:radio id="rdZhe" key="折线图" value="4"></ta:radio>
                </ta:radiogroup>
                <ta:buttonGroup align="center" cssStyle="margin-top:20px;">
                    <ta:button key="统计" space="true" size="large" onClick="fnQuery()"/>
                    <ta:button key="保存统计方案" onClick="fnSavePlan()" size="large"/>
                </ta:buttonGroup>
            </ta:box>

        </ta:box>
    </ta:box>
</ta:box>

<ta:boxComponent id="editFieldGroup" height="166px" width="300px" arrowPosition="vertical">
    <div id="groupItems_id_box" class="tafieldset_163">
        <div id="groupByItemsId">
            <c:forEach items="${fieldList}" var ="item" >
                <div>
                    <input type="checkbox"  name="tjxm" datatype="${item.fielddisplaytype}"  fname="${item.fieldcomment}"  fieldid="${item.fieldid}" value="${item.fieldname}"
                    <c:if test="${item.fieldisgroup == 1 }">
                        checked="checked"
                    </c:if> />
                        ${item.fieldcomment}
                </div>
            </c:forEach>

        </div>
        <div style="clear:both"></div>
    </div>
</ta:boxComponent>
<ta:form id="tform"></ta:form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $("body").taLayout();
    });
    //点击编辑统计项
    function fnConditionSet(){
        var target=event.srcElement?event.srcElement:event.target;
        Base.showBoxComponent("editFieldGroup",target);
//        Base.submit("","orgUserMgAction!toEditUser.do",{"dto['userid']":data.userid})
    }
    //增加条件查询
    function addCondition(_this){
        var trs = $(_this).parent().parent().parent().find("tr");
        var cloneTr = trs.eq(1).clone();
        var tds = cloneTr.find("td");
        var ops = tds.eq(1).find("option");
        ops.eq(0).attr("selected","selected").siblings().removeAttr("selected");
        tds.eq(2).html("<select id='gxys_id' name='gxysf' style='width:97%;'><option value=''>请选择</option></select>");

        var str =  "<span id='nrz_span_id' style='display:inline;width:98%;'>"
        str += "<input type='text' style='width: 250px;'/>"
        str += "</span>";
        str += "<span id='nr_item_select_id' style='display:none;'></span>";
        tds.eq(3).html(str);

        $(trs.eq(trs.length-1)).before(cloneTr);
    }
    //增加或者条件组
    function addConditionGroup(){
        var tabales = $("#gruops_id").find("table");
        var first_table = tabales.eq(0).clone();
        var trs = first_table.find("tr");
        $.each(trs,function(i,_o){
            if(i==0 || i==1 || i== trs.length-1){
                if(i==1){
                    var tds = $(_o).find("td");
                    tds.eq(2).html("<select id='gxys_id' name='gxysf' style='width:97%;'><option value=''>请选择</option></select>");
                    var str =  "<span id='nrz_span_id' style='display:inline;width:98%;'>"
                    str += "<input type='text' style='width: 250px;'/>"
                    str += "</span>";

                    str += "<span id='nr_item_select_id' style='display:none;'></span>";

                    tds.eq(3).html(str);
                }
                return ;
            }
            _o.remove();
        });
        tabales.eq(tabales.length-1).after(first_table);
    }
    var queryConditionXml; //存放查询条件的xml
    var setting = {//ztree配置
        view:{
            showIcon:true,
            showLine:true==false?false:true,
            showTitle:true,
            expandSpeed:"fast",
            selectedMulti:false,
            autoCancelSelected:false
        },
        check:{
            enable: true,
            chkboxType: {"Y":"", "N":""}
        },
        data: {
            simpleData: {
                enable:true,
                idKey: "id",
                pIdKey: "pid",
                rootPId: ""
            }
        },
        callback: {onCheck: onTreeCheck}
    } ;
    //获取关系和内容
    function getFieldRela(_this){
        Base.submit("","userDefinedQueryController!getFieldRela.do",{'dto.fieldid':_this.value},null,null,function(data){
            var _tds = $(_this).parent().parent().find("td");
            //内容
            var nr_td_o = _tds.eq(3);nr_td_o.html('');
            var  _map = data.fieldData.addFieldVo;str = "";//内空HTML
            if(_map){
                str += "<span id='nrz_span_id' style='display:inline;width:98%;'>";
                var fielddisplaytype = _map.fielddisplaytype;
                if(fielddisplaytype=='21'){//代码值平铺
                    var codes = data.fieldData.codeList;
                    if(codes){
                        $.each(codes,function(key,__o){
                            str += "<div title='"+__o.codeDESC+"'><input id='nr_id' name='nrz_checkbox' type='checkbox'  value='"+__o.codeValue+"'/>&nbsp;"+__o.codeDESC+"</div>";
                        });
                    }
                }else if(fielddisplaytype=='11'){//文本框
                    str +=  "<input name='nrz' type='text' style='width: 250px;'/>";
                }else if(fielddisplaytype=='13'){//日期
                    str +=  "<input  name='nrz' type='text'  onfocus=WdatePicker({position:{top:6,left:-9},isShowWeek:false,dateFmt:'yyyy-MM-dd'}); class='Wdate' maxlength='10'/>";
                }else if(fielddisplaytype=='12'){//年月
                    str += "<input name='nrz' type='text'  onfocus=WdatePicker({position:{top:6,left:-9},isShowWeek:false,dateFmt:'yyyy-MM'}); class='Wdate' maxlength='10'/>";
                }else if(fielddisplaytype=='14'){//数字
                    str += "<input name='nrz' type='text' style='width: 250px;'/>";
                }else if(fielddisplaytype=='22'){//树
                    var tr_index  = nr_td_o.parent().index();
                    var tab_index  = nr_td_o.parent().parent().parent().index();
                    var treeId = "treeData_"+tab_index+"_" + (tr_index - 1);

                    str += "<div style='width:250px;position: relative;left: 0px;top: 0px;height: 20px;'><input name='nrz' type='hidden' />"
                        +"<span class='faceIcon icon-arrow_down selectTreeIcon' style='margin-top:2px;position: absolute;right: 10px;' onclick='showMenu(this)' title='点击展开下拉树'></span>"
                        +"<span class='faceIcon icon-close selectTreeIcon' style='margin-top:2px;position: absolute;right: 33px;'  onclick='fnClear(this,\""+treeId+"\")' title='清除'></span>"
                        +"<input type='text' style='width: 250px;' readonly='true' title=''/></div>"
                        +"<div name='menuContent' style='display:none; position: absolute;z-index:1000;width:255px;height:350px;background: #fff;border:#D1D1D1 1px solid;overflow:hidden;'>"
                        +"<input type='text' name='queyName' id='queyName' style='width:150px;margin-left:5px;margin-top:5px;'/>"
                        +"<a href='javascript:void(0);' ><font size='2' style='cursor: pointer;margin-left:5px' onclick=fnQueryData(this,\'"+treeId+"\')>查询</font></a>&nbsp;&nbsp;"
                        +"<div style='margin-top:5px;height:319.5px;width:100%'>"
                        +"<ul id='"+treeId+"' name='treeData' class='ztree' style='margin-top:0;'></ul></div></div>";
                }
                str += "<input name='datatype' value='"+_map.fielddisplaytype+"' type='hidden'/>";//数据类型(便于生成xml)
                str += "</span>";

                str += "<span id='nr_item_select_id' style='display:none;'></span>";

                nr_td_o.append(str);
                if (fielddisplaytype=='22'){
                    $.fn.zTree.init($("#"+treeId), setting, eval(data.fieldData.codeList));
                }
            }
            //关系生成
            var _gxList = data.fieldData.fieldRelaList;
            if(_gxList){
                var _o = _tds.eq(2).children(':first');_o.empty();
                for(var i=0; i< _gxList.length; i++) {
                    var option = $("<option>").text(_gxList[i].fieldrelation_desc).val(_gxList[i].fieldrelation);
                    _o.append(option);
                }
            }
        },null);
    }
    //下拉树方法
    function fnClear(obj,treeId){
        $(obj).next().val("");
        $(obj).prev().prev().val("");
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        var nodes = treeObj.getCheckedNodes(true);
        if(nodes && nodes.length > 0 ){
            for(var i = 0;i<nodes.length;i++ ){
                treeObj.checkNode(nodes[i], false,true,false);
            }
        }
    }
    //展示下拉树
    function showMenu(obj) {
        var obj1 = $(obj).next().next();
        var objOffset = obj1.offset();
        var obj2 = $(obj).parent().next();
        $(obj2).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }
    function hideMenu() {
        $("[name='menuContent']").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.name == "menuContent" || $(event.target).parents("[name='menuContent']").length>0)) {
            hideMenu();
        }
    }
    //下拉树查询
    function fnQueryData(_this,treeId){
        var queyName = $(_this).parent().prev().val()||'';
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        var nodes = treeObj.getNodesByParamFuzzy("name", queyName, null);
        if(nodes){
            treeObj.selectNode(nodes[0]);
            queryResu = nodes;
            i = 0;
        }
    }
    //下拉树选中
    function onTreeCheck(event, treeId, treeNode){
        if(treeNode){
            var _treeId = treeNode.id;
            var _treeName = treeNode.name;
            var inputs  = $("#"+treeId).parent().parent().prev().find("input");
            var _val =  inputs.eq(0);
            var _val1 = _val.val();
            var _key =  inputs.eq(1);
            var _key1 =  _key.val();
            var _key0 = "";
            if(treeNode.checked){
                _val.val(_val1+_treeId+";");
                _key.val(_key1+_treeName+";");

            }else{
                var _val2 = _val1.replace(_treeId+";","");
                var _key2 = _key1.replace(_treeName+";","");
                _val.val(_val2);
                _key.val(_key2);
            }
            _key.attr('title',_key.val());

        }
    }
    //删除tr条件
    function deleteTr(_this){
        var tr_length = $(_this).parent().parent().parent().find("tr").length;
        if(tr_length == 3){
            Base.alert("不能删除，必需设置一项查询条件！","warn");
            return ;
        }
        $(_this).parent().parent().remove();
    }
    //删除或者条件组
    function deleteCondition(_this){
        var gruops_length = $("#gruops_id").find("table").length;
        if(gruops_length == 1){
            Base.alert("不能删除，必需设置一组条件！");
            return ;
        }
        $(_this).parent().parent().parent().parent().remove();
    }
    //增加统计指标行
    function addTjzbhsTr(_this){
        var trs = $(_this).parent().parent().parent().find("tr");
        var cloneTr = trs.eq(1).clone();
        var tds = cloneTr.find("td");
        var ops = tds.eq(1).find("option");
        ops.eq(0).attr("selected","selected").siblings().removeAttr("selected");
        tds.eq(2).html("<select id='gxys_id' name='tjzbhs' style='width:97%;'><option value=''>请选择</option></select>");
        $(trs.eq(trs.length-1)).before(cloneTr);
    }
    //获取项目支持运算
    function getCountway(_this){
        if(_this.value==''){
            var _o = _tds.eq(2).children(':first');_o.empty();
            return ;
        }
        Base.submit("","userDefinedQueryController!getCountway.do",{'dto.fieldid':_this.value},null,null,function(data){
            var _tds = $(_this).parent().parent().find("td");
            var  countwayList = data.fieldData.countwayList;
            if(countwayList){
                var _o = _tds.eq(2).children(':first');_o.empty();
                for(var i=0; i< countwayList.length; i++) {
                    var option = $("<option>").text(countwayList[i].countway_desc).val(countwayList[i].countway);
                    _o.append(option);
                }
            }
        },null);
    }
    //删除统计指标行
    function deleteTjzbhsTr(_this){
        var tr_length = $(_this).parent().parent().parent().find("tr").length;
        if(tr_length == 3){
            Base.alert("不能删除，必需有一项统计指标项！");
            return ;
        }
        $(_this).parent().parent().remove();
    }
    //查询字段（统计）
    function fnQueryFileds(){
        //分组字段
        var xml = "<group_field>";
        $.each($("input[name='tjxm']:checked"),function(sn,_o){
            _o = $(_o);
            xml += "<field  name=\""+ _o.attr('fname')||'';
            xml += "\" id=\"" + _o.attr('value')||'';
            xml += "\" sn=\"" + ++sn;
            xml += "\" fieldid=\"" + _o.attr('fieldid')||'';
            xml += "\" datatype=\"" + _o.attr('datatype')||'';
            xml += "\"/>";
        });
        xml += "</group_field>";
        xml += "<function_field>";

        //统计函数字段
        var _tjzbhs = $("select[name='tjzbhs']"),fieldids = [];//统计函数,已生成的项目
        $.each($("select[name='tjzb']"),function(sn,_o){//统计指标
            _o = $(_o);
            var fieldid = $(_o).val()||'';
            if(fieldid != '' && $.inArray(fieldid, fieldids) == -1){//项目编号不能为空、未生成过的项目
                fieldids.push(fieldid);
                var _select = $(_tjzbhs[sn]);
                var tjfs = _select.val();
                var _option = $(_o).find("option:selected");
                var id= _option.attr('filed');
                var datatype= _option.attr('datatype');
                var dbtype= _option.attr('dbtype');
                var name = $.trim($(_o).find("option:selected").text()) + "：" + $.trim(_select.find("option:selected").text());
                if(tjfs !='' && tjfs !=null){//统计方式不能为空
                    xml += "<field  name=\"" + name ||'';
                    xml += "\" id=\"" + id||'';
                    xml += "\" sn=\"" + ++sn;
                    xml += "\" fieldid=\"" + fieldid||'';
                    //xml += "\" datatype=\"" + datatype||'';//加上会影响生成统计列数据
                    xml += "\" dbtype=\"" + dbtype||'';       //字段数据库的类型
                    xml += "\" tjfs=\"" + tjfs||'';
                    xml += "\"/>";
                }
            }
        });
        xml += "</function_field>";
        return xml;
    }
    //条件组 or（统计）
    function fnQueryOrs(){
        var xml = "";
        $.each($("#gruops_id > table"),function(sn,_o){//条件组 ors
            var sn_local = 0;//手动设置排序号
            xml += "<or sn=\"" + ++sn + "\"><ands>";
            var gxysfs = $(_o).find("[name='gxysf']");//关系运算符
            var datatypes = $(_o).find("[name='datatype']");//数据类型
            $.each($(_o).find("[name='cxxm']"),function(sn,_o){//查询项目
                var cxxm = $(_o).val() || '';
                var gxysf_o  = $(gxysfs[sn]);
                if(cxxm != '' && (gxysf_o.val() || '') != ''){//项目！=空 且 关系运算！=空
                    var value = '', datatype = $(datatypes[sn]).val() || '';//内容值、数据类型
                    var id= $(_o).find("option:selected").attr('filed'); //字段名称
                    if(datatype == '11' || datatype == '12' || datatype == '13' || datatype == '14'){//文本框、年月、日期、数字
                        value = $(_o).parent().parent().find("[name='nrz']").val()||'';//查找当前行 内容值
                    }else if(datatype=='21'){//代码值平铺
                        $.each($(_o).parent().parent().find("[name='nrz_checkbox']:checked"),function(sn,_o){//找到平铺 内容值
                            if(sn == 0){
                                value += "'" + $(_o).attr('value') + "'";
                            }else{
                                value += ",'" + $(_o).attr('value') + "'";
                            }
                        });

                    }else if(datatype=='22'){//树
                        value = $(_o).parent().parent().find("[name='nrz']").val()||'';//查找当前行 内容值
                        if(value != ''){
                            var v_a = value.split(';');
                            value = '';
                            $.each(v_a,function(sn,_v){
                                if(sn == 0){
                                    value += "'" + _v + "'";
                                }else{
                                    if(_v != '')
                                        value += ",'" + _v + "'";
                                }
                            });
                        }
                    }
                    var curTr = $(_o).parent().parent();
                        if(value != ''){//固定值 且 值不能为空
                            xml += "<and id=\"" + id ||'';
                            xml += "\" sn=\"" + ++sn_local;
                            xml += "\" fieldid=\"" + cxxm||'';
                            xml += "\" gxysf=\"" + gxysf_o.val()||'';
                            xml += "\" value=\"" + value||'';
                            xml += "\" datatype=\"" + datatype||'';
                            xml += "\"/>";
                        }
                }
            });
            xml += "</ands></or>";
        });
        return xml;
    }
    var tbtjPageSize = 500;//设置图表最多统计查询500条数据
    function fnQuery(){
        var planid = Base.getValue('planid')||'';//方案流水号
        var planname = Base.getValue('planname')||'';//方案名称
        var menuid = Base.getValue('menuid')||'';//菜单id
        var themeid = Base.getValue('themeid')||'';//themeid
        var jctj = Base.getValue('jctj')||'';//基础条件
        var themetable = Base.getValue('themetable')||'';//主题表或视图
        var xml  = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        xml += "<scheme menuid=\"" + menuid + "\" themeid=\"" + themeid + "\"    themetable=\"" + themetable + "\"  jctj=\"" + jctj + "\" planid=\"" + planid + "\" planname=\"" + planname + "\">";
        xml += "<statistics_query>";
        xml += "<fields>";
        xml += fnQueryFileds();
        xml += "</fields>";
        xml += "<where>";
        xml += "<ors>";
        queryConditionXml = fnQueryOrs();//全局存放(解决查看明细数据前修改查询条件--数据变化)
        xml += queryConditionXml;
        xml += "</ors>";
        xml += "</where>";
        xml += "</statistics_query>";
        xml += "</scheme>";

        Base.setValue("xml",xml);

        var showType = $("input[name=\"dto[\'showTypes\']\"]:checked").val() || '0';
        if(showType == '2' || showType == '3' || showType == '4') {//图表类型
            //判断分组项及统计指标
            if(!fnValidXm()){return;}
            var _url = "userDefinedQueryController!queryPage.do";
            Base.submit("queryResultDgd,datasourceid",_url,{'dto.xml':xml,'gridInfo.queryResultDgd_start':0,'gridInfo.queryResultDgd_limit':tbtjPageSize},null,null,function(data){
                var _title = data.fieldData.fileds;         //title
                var _data  = data.fieldData.queryResultDgd; //数据
                $("#resultBox").hide();
                $("#deailInfoBox").hide();
                $("#chartsIdPanel").show();
                $('#chartsId').attr("style","width:100%;height:300px;").show();
                var myChart = echarts.init(document.getElementById('chartsId'));
                var option = null;
                if(showType == '2'){//柱状图
                    var tb_data_title = [],tb_data_value = [],title_key='',value_key='',collectionData='',tjlx='',count=0;
                    if(_title && _title.length == 2){
                        title_key = _title[0]['id'];//分类key
                        value_key = _title[1]['id'];//值key
                        collectionData = _title[0]['collectionData'];//码列表
                        if(collectionData){
                            collectionData = eval(collectionData);
                        }
                        if(_data && _data.length >0){
                            for(var i=0; i<_data.length; i++){
                                tb_data_title.push(fnGetCodeDesc(collectionData,_data[i][title_key]));
                                count += Number(_data[i][value_key]);
                                tb_data_value.push(_data[i][value_key]);
                            }
                        }
                    }
                    tjlx = [_title[1]['name'].split('：')[0]] + "(总数:"+ count +")"   ;//统计指标
                    option = {tooltip: {},
                        color: ['#3398DB'],
                        legend: {data:[tjlx]},
                        xAxis: {data: tb_data_title},
                        yAxis: {},
                        series: [{type: 'bar',data: tb_data_value}]
                    };
                }else if(showType == '3'){//饼图
                    var tb_data = [],title_key='',value_key='',collectionData='',tjlx='',count=0,tbxm_title = [];
                    if(_title && _title.length == 2){
                        title_key = _title[0]['id'];//分类key
                        value_key = _title[1]['id'];//值key
                        collectionData = _title[0]['collectionData'];//码列表
                        if(collectionData){
                            collectionData = eval(collectionData);
                        }

                        tjlx = _title[1]['name'].split('：')[0];//统计指标

                        if(_data && _data.length >0){
                            for(var i=0; i<_data.length; i++){
                                var tbTitle = fnGetCodeDesc(collectionData,_data[i][title_key]);
                                tbxm_title.push(tbTitle);
                                tb_data.push({'value':_data[i][value_key],'name':tbTitle});
                            }
                        }
                    }
                    option = {
                        tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
                        legend: {left: 'left',data: tbxm_title},
                        series : [{name: tjlx,type: 'pie',radius : '55%',center: ['50%', '60%'],data:tb_data}]
                    };

                }else if(showType == '4'){//线图

                    var tb_data_title = [],tb_data_value = [],title_key='',value_key='',collectionData='',count=0,tjlx='';
                    if(_title && _title.length == 2){
                        title_key = _title[0]['id'];//分类key
                        value_key = _title[1]['id'];//值key
                        collectionData = _title[0]['collectionData'];//码列表
                        if(collectionData){
                            collectionData = eval(collectionData);
                        }
                        if(_data && _data.length >0){
                            for(var i=0; i<_data.length; i++){
                                tb_data_title.push(fnGetCodeDesc(collectionData,_data[i][title_key]));
                                count += Number(_data[i][value_key]);
                                tb_data_value.push(_data[i][value_key]);
                            }
                        }
                    }
                    tjlx = _title[1]['name'].split('：')[0];//统计指标
                    option = {
                        tooltip: {trigger: 'axis'},
                        legend: {data: [tjlx],y:"top"},
                        //工具箱配置
                        /**
                         toolbox: {
                                show : true,
                                feature : {
                                    mark : {show: true}, // 辅助线标志，上图icon左数1/2/3，分别是启用，删除上一条，删除全部
                                    dataView : {show: true, readOnly: false},// 数据视图，上图icon左数8，打开数据视图
                                    magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},// 图表类型切换，当前仅支持直角系下的折线图、柱状图转换，上图icon左数6/7，分别是切换折线图，切换柱形图
                                    restore : {show: true}, // 还原，复位原始图表，上图icon左数9，还原
                                    saveAsImage : {show: true} // 保存为图片，上图icon左数10，保存
                                }
                            },
                         **/
                        calculable: true,
                        xAxis: [{type: 'category',data: tb_data_title}],
                        yAxis: [{type: 'value',splitArea: {show: true}}],
                        series:[{name: tjlx,type: 'line',data: tb_data_value}]};
                }
                myChart.setOption(option);

        },null);

        }else {//默认表格显示
            $("#chartsId").hide(); $("#chartsIdPanel").hide();
            $("#resultBox").show();
            $("#deailInfoBox").show();
            var _url = "userDefinedQueryController!queryPage.do";
            Base.clearGridDirty("queryResultDgd");
            Base.submit("queryResultDgd,datasourceid",_url,{'dto.xml':xml},null,null,function(data){
                fnGenerateStatisticalDataGridTitle("queryResultDgd",data);      //生成title
                var grid = Ta.core.TaUIManager.getCmp("queryResultDgd");

                //分页数据处理
                var _pager = grid.getPager();
                _pager.setStatus((data.fieldData.datacount||0));
                _pager.setPagerUrl(_url);
                if(_pager.setExeQueryFn){
                    _pager.setExeQueryFn(fnQuery);
                }

                //设置datagrid数据
                if(grid){
                    var dataView = grid.getDataView();
                    grid.clearDirtyWidthOutPager();
                    var dataObj = {
                        total:data.fieldData.datacount,
                        list:data.fieldData.queryResultDgd
                    }
                    dataView.setItems(dataObj || {});
                    dataView.refresh();
                    grid.refreshGrid();
                }
            },null);
        }

    }
    //生成详细信息datagrid title
    function fnGenerateStatisticalDataGridTitle(datagirdId,data){
        var grid = Ta.core.TaUIManager.getCmp(datagirdId),columns = [];
        columns.push(grid.getColumns()[0]);
        $.each(data.fieldData.fileds || {},function(sn,_o){
            if(_o){
                var titleName = _o.name,filedName = _o.id;
                if(filedName){//生成统计数红色titile
                    if(filedName.indexOf('_FN') != -1){
                        titleName = "<font color=red>" + titleName + "</font>";
                    };
                }
                var _filed = {'name':titleName, 'field':filedName,'id':filedName,'dataAlign':'center','sortable':true,'possation':++sn};
                if(_o.datatype && _o.datatype != ''){
                    if(Number(_o.datatype) == 12){//年月
                        _filed.formatter = function(row,cell,value,columnDef,dataContext){
                            value = value||'';
                            if(value != ''){
                                var strs = value.split('-');
                                value = strs[0] + '-' + strs[1]
                            }
                            return value;
                        }
                    }else if(Number(_o.datatype) == 13){//日期
                        _filed.formatter = function(row,cell,value,columnDef,dataContext){
                            value = value||'';
                            if(value != ''){
                                var strs = value.split('-');
                                value = strs[0] + '-' + strs[1]+ '-' + strs[2]
                            }
                            return value;
                        }
                        _filed.dataType  = "date";
                    }else if(Number(_o.datatype) == 14){//数字
                        _filed.dataType  = "number";
                    }else if(Number(_o.datatype) == 21 || Number(_o.datatype) == 22 ){//代码值平铺,树,datagrid
                        _filed.formatter = function(row,cell,value,columnDef,dataContext){
                            var reData = value,data = eval(_o.collectionData),o = {};
                            data.column = filedName;
                            o.collectionsDataArrayObject = {};
                            o.collectionsDataArrayObject[filedName] = data;
                            for(var i = 0; i < data.length; i ++){
                                if(data[i].id == value) {
                                    reData = data[i].name;
                                }
                            }
                            return reData ? reData : "";
                        }
                        _filed.showDetailed  = true;
                    }
                }else{//统计列渲染(数字超链接)
                    _filed.formatter = function(row,cell,value,columnDef,dataContext){
                        dataContext = JSON.stringify(dataContext).replaceAll("\"","'");
                        if(value != 'null' && value !=null){
                            var _id = columnDef.field;
                            if(filedName.indexOf('_FN') != -1){
                                value = "<a href=\"javascript:void(0)\" onclick=\"fnGenerateDetailInfoParasHtml("+ dataContext +")\">" + value + "</a>";
                            }
                        }else{
                            return '';
                        }
                        return value;
                    }
                }
                columns.push(_filed);
            }
        });
        grid.setColumns(columns);
    }
    //生成详细信息带的参数表单数据(点击数字查询用)
    function fnGenerateDetailInfoParasHtml(_o){
        var parasHtml = $('#detailInfoParasId');parasHtml.html('');
        for(var attr in _o){
            if(attr.indexOf('_FN') == -1 && attr != '__id___' && attr != 'MYROWNUM' && attr != '_row_'){//排除统计函数、datagrid行号、分页用的行标识
                parasHtml.html(parasHtml.html() + "<input type='hidden' name='statistical_paras' filed='"+ attr +"' value='"+ _o[attr] +"'/>");
            }
        }
        fnQueryDetailInfo();//执行详细信息查询
    }
    //点击数字查看详细信息
    function fnQueryDetailInfo(){
        var xml = getDetailInfoXml();
        var _url = "userDefinedQueryController!queryDetail.do";
        Base.clearGridDirty("deailInfoDgd");
        Base.submit("deailInfoDgd,datasourceid",_url,{'dto.xmlDetail':xml},null,null,function(data){
            this.fnGenerateDetailDataGridTitle("deailInfoDgd",data);      //生成title
            var grid = Ta.core.TaUIManager.getCmp("deailInfoDgd");

            //分页数据处理
            var _pager = grid.getPager();
            _pager.setStatus((data.fieldData.datacount||0));
            _pager.setPagerUrl(_url);
            if(_pager.setExeQueryFn){
                _pager.setExeQueryFn(fnQueryDetailInfo);
            }

            //设置datagrid数据
            if (grid){
                var dataView = grid.getDataView();
                grid.clearDirtyWidthOutPager();
                var dataObj = {
                    total:data.fieldData.datacount,
                    list:data.fieldData.deailInfoDgd
                }
                dataView.setItems(dataObj || {});
                dataView.refresh();
                grid.refreshGrid();
            }

        },null);
//        $("#deailInfoDgd").show();//显示详细信息面板
    }
    //获取点击数字后的xml || 关闭显示字段设置窗口 || 关闭排序字段设置窗口
    function getDetailInfoXml(){
        var planid = Base.getValue('planid')||'';//方案流水号
        var planname = Base.getValue('planname')||'';//方案名称
        var menuid = Base.getValue('menuid')||'';//菜单id
        var themeid = Base.getValue('themeid')||'';//主题id
        var jctj = Base.getValue('jctj')||'';//基础条件
        var themetable = Base.getValue('themetable')||'';//主题表或视图
        var xml  = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        xml += "<scheme menuid=\"" + menuid + "\" themeid=\"" + themeid + "\"    themetable=\"" + themetable + "\"  jctj=\"" + jctj + "\" planid=\"" + planid + "\" planname=\"" + planname + "\">";
        xml += "<statistics_query>";
        xml += "<fields>";
        xml += "</fields>";
        xml += "<where>";
        xml += "<ands>";
        xml += fnQueryAnds();//点击数字参数
        xml += "</ands>";
        xml += "<ors>";
        if(queryConditionXml){//有数据直接拼(防止修改查询条件)
            xml += queryConditionXml;
        }else{
            xml += fnQueryOrs();
        }
        xml += "</ors>";
        xml += "</where>";
//        xml += fnQueryOrders();//排序xml
        xml += "</statistics_query>";
        xml += "</scheme>";
        Base.setValue("xmlDetail", xml);
        return xml;
    }
    //生成详细信息datagrid title
    function fnGenerateDetailDataGridTitle(datagirdId,data){
        var grid = Ta.core.TaUIManager.getCmp(datagirdId),columns = [];
        var ___id = grid.getColumns()[0];___id['sn'] = 0;columns.push(___id);
        $.each(data.fieldData.fileds || {},function(sn,_o){
            if(_o){
                var titleName = _o.name,filedName = _o.id;
                    var _filed = {'name':titleName, 'field':filedName,'id':filedName,'dataAlign':'center','possation':++sn};
                    if(_o.datatype && _o.datatype != ''){
                        if(Number(_o.datatype) == 12){//年月
                            _filed.formatter = function(row,cell,value,columnDef,dataContext){
                                value = value||'';
                                if(value != ''){
                                    var strs = value.split('-');
                                    value = strs[0] + '-' + strs[1];
                                }
                                return value;
                            }
                        }else if(Number(_o.datatype) == 13){//日期
                            _filed.dataType  = "date";
                        }else if(Number(_o.datatype) == 14){//数字
                            _filed.dataType  = "number";
                        }else if(Number(_o.datatype) == 21 || Number(_o.datatype) == 22){//代码值平铺,树
                            _filed.formatter = function(row,cell,value,columnDef,dataContext){
                                var reData = value,data = eval(_o.collectionData),o = {};
                                data.column = filedName;
                                o.collectionsDataArrayObject = {};
                                o.collectionsDataArrayObject[filedName] = data;
                                for(var i = 0; i < data.length; i ++){
                                    if(data[i].id == value) {
                                        reData = data[i].name;
                                    }
                                }
                                return reData ? reData : "";
                            }
                            _filed.showDetailed  = true;
                        }

                    }
                    columns.push(_filed);
            }
        });
        grid.setColumns(columns);
    }
    //获取点击数字带的参数xml(点击数字查询用)
    function fnQueryAnds(){
        var xml = "";
        $.each($("input[name='statistical_paras']"),function(sn,_o){
            xml += "<and id=\"" + $(_o).attr('filed')||'';
            xml += "\" sn=\"" + ++sn;
            xml += "\" value=\"" + $(_o).attr('value')||'';
            xml += "\"/>";
        });
        return xml;
    }
    //验证选择项目(针对图表统计)
    function fnValidXm(){
        //分组字段
        var _tjxms  = $("input[name='tjxm']:checked");
        if(_tjxms.length == 0){
            Base.alert('必需选择一项【分组项】进行图表统计');
            return false;
        }else if(_tjxms.length >= 2){
            Base.alert('只能选择一项【分组项】进行图表统计');
            return false;
        }

        //统计函数字段
        var _tjzbhs = $("select[name='tjzbhs']");//统计函数
        var _count = 0;
        $.each($("select[name='tjzb']"),function(sn,_o){//统计指标
            _o = $(_o);
            var planid = $(_o).val()||'';
            if(planid != ''){
                var _select = $(_tjzbhs[sn]);
                var tjfs = _select.val()||'';
                if(tjfs !=''){
                    _count ++ ;
                }
            }
        });
        if(_count == 0){
            Base.alert("必需选择一项”统计指标“进行图表统计");
            return false;
        }else if(_count >= 2){
            Base.alert("只能选择一项【统计指标】进行图表统计");
            return false;
        }
        return true;
    }
    //根据码值获取码中文
    function fnGetCodeDesc(c,v){
        if(c && c.length>0){
            for(var i = 0; i < c.length; i++){
                if(c[i].id == v){
                    v = c[i].name;
                }
            }
        }
        return (v == null ? "其它" : v);
    }
    /*************************************统计方案部分****************************************/
    function fnSavePlan(){
        var planid = Base.getValue("planid");
        //如果存在planid则是更新操作
        if(planid){
            Base.confirm("确认要更新当前统计方案吗?",function(yes){
                if(yes) {
                    var menuid = Base.getValue("menuid");
                    var xml = getSaveDataXml();
                    Base.submit("datasourceid","userDefinedQueryController!savePlan.do", {
                        'dto.planname': Base.getValue("planid_desc"),
                        'dto.xml': xml,
                        'dto.menuid': menuid,
                        'dto.planid':planid
                    }, null, null, function (data) {

                    });
                }
            });
        }else{
            Base.prompt("保存方案的名称", function (yes, value) {
                if (yes) {
                    var planname = value;
                    if (!planname) {
                        Base.alert("统计方案名称不能为空", "warn");
                        return;
                    }
                    if (planname.length > 50) {
                        Base.alert("统计方案名称太长", "warn");
                        return;
                    }
                    var menuid = Base.getValue("menuid");
                    var xml = getSaveDataXml();
                    Base.submit("datasourceid","userDefinedQueryController!savePlan.do", {
                        'dto.planname': planname,
                        'dto.xml': xml,
                        'dto.menuid': menuid
                    }, null, null, function (data) {

                    });
                }
            }, null);
        }
    }
    //获取保存数据的xml
    function getSaveDataXml(){
        var planid = Base.getValue('planid')||'';//方案流水号
        var planname = Base.getValue('planname')||'';//方案名称
        var menuid = Base.getValue('menuid')||'';//菜单id
        var themeid = Base.getValue('themeid')||'';//主题id
        var jctj = Base.getValue('jctj')||'';//基础条件
        var themetable = Base.getValue('themetable')||'';//主题表或视图
        var xml  = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        xml += "<scheme menuid=\"" + menuid + "\" themeid=\"" + themeid + "\"   themetable=\"" + themetable + "\"  jctj=\"" + jctj + "\" planid=\"" + planid + "\" planname=\"" + planname + "\">";
        xml += "<statistics_query>";
        xml += "<fields>";
        xml += fnQueryFileds();
        xml += "</fields>";
        xml += "<where>";
        xml += "<ands>";
        xml += "</ands>";
        xml += "<ors>";
        xml += fnQueryOrs();
        xml += "</ors>";
        xml += "</where>";
        xml += "</statistics_query>";
        xml += "</scheme>";
        return xml;
    }
    function callOutPlan(){
        Base.submitForm("tform",null,null,"userDefinedQueryController.do",{"dto.planid":Base.getValue("planid")});
    }
    
    function fnAddPlan() {
        Base.submitForm("tform",null,null,"userDefinedQueryController.do");
    }
    
    function fnDeletePlan(){
        var planid = Base.getValue("planid");
        if(planid){
            Base.confirm("确认要删除当前统计方案吗?",function(yes){
                if(yes) {
                    Base.submit("planid","userDefinedQueryController!delPlan.do",null,null,null,function(){
                        Base.alert("删除成功!","success",function(){
                            Base.submitForm("tform",null,null,"userDefinedQueryController.do");
                        });
                    });
                }
            });
        }else{
            Base.alert("当前没有统计方案!","warn");
        }
    }
</script>
<%@ include file="/ta/incfooter.jsp" %>