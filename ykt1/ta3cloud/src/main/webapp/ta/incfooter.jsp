<%@page import="com.yinhai.core.app.api.util.TagUtil"%>
<%@page import="com.yinhai.core.app.api.web.resultbaen.IFieldOperation"%>
<%@page import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@include file="incfooterTopEvent.jsp"%>
<script type="text/javascript">
$(function() {
    $(document).keydown(function (e) {
        // 屏蔽回退键盘
        var target = e.srcElement || e.target;
        if ((e.keyCode == 8) && target && ((target.type != "text"
                && target.type != "textarea" && !$(target).attr("contenteditable")
                && target.type != "password") || target.readOnly || target.disabled)) {
            e.keyCode = 0;
            e.cancelBubble = true;
            e.returnValue = false;

            // e.stopPropagation works in Firefox.
            if (e.stopPropagation) {
                e.stopPropagation();
                e.preventDefault();
            }
        }
        var isie = (document.all) ? true : false;
        var key;
        var srcobj;
        if (isie) {
            key = e.keyCode;
            srcobj = e.srcElement;
        } else {
            key = e.which;
            srcobj = e.target;
        }
        if (srcobj == null)srcobj = e.target;
        if (key == null) key = e.which;
        if (key == 13 && srcobj.type != 'button' && srcobj.type != 'submit'
                && srcobj.type != 'reset' && srcobj.type != 'textarea'
                && srcobj.type != '') {
            Base._goNextFormField(srcobj.id);
            return false;
        }

    });
    setTimeout(function () {
        <%
IResultBean resultBean = TagUtil.getResultBean();
if(resultBean != null){
	if(resultBean.getOperations() != null){
		Map<String, List<String>> listMap = resultBean.getOperations();
		for (String fieldId : listMap.keySet()){
		    for (String operation: listMap.get(fieldId)){
		        if (operation.equals(IFieldOperation.READONLY)){
                    out.println("Base.setReadOnly('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.DISABLED)){
                    out.println("Base.setDisabled('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.ENABLE)){
                    out.println("Base.setEnable('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.HIDE)){
                    out.println("Base.hideObj('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.SHOW)){
                    out.println("Base.showObj('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.UNVISIBLE)){
                    out.println("Base.hideObj('"+ fieldId +"', true);");
		        } else if (operation.equals(IFieldOperation.RESETFORM)){
                    out.println("Base.resetData('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.REQUIRED)){
                    out.println("Base.setRequired('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.DISREQUIRED)){
                    out.println("Base.setDisRequired('"+ fieldId +"');");
		        } else if (operation.equals(IFieldOperation.SELECT_TAB)){
                    out.println("Base.activeTab('"+fieldId+"');");
		        }
		    }
		}
	}
	//有msg
	if(resultBean.getMessage()!=null){
		out.println("var focus = null;");
		if(resultBean.getFocus()!=null){
			out.println("focus = function(_fieldId){return function(){Base.focus(_fieldId,100);}}('"+resultBean.getFocus()+"');");
		}
		if(resultBean.getMessageType() != null){
			out.println("Base.alert('"+resultBean.getMessage()+"','"+resultBean.getMessageType()+"',focus)");
		}else{
			out.println("Base.alert('"+resultBean.getMessage()+"',null,focus)");
		}
	}
	//没有msg，但是有focus
	if(resultBean.getMessage()==null && resultBean.getFocus()!=null){
		out.println("Base.focus('"+resultBean.getFocus()+"',50);");
	}
	//有topMsg
// 	if(rb.getTopTipMsg() != null){
// 		TopMsg t = rb.getTopTipMsg();
// 		out.println("Base.msgTopTip('"+t.getTopMsg()+"',"+t.getTime()+","+t.getWidth()+","+t.getHeight()+")");
// 	}else if(rb.getTopMsg() != null && rb.getTopTipMsg() == null){
// 		out.println("Base.msgTopTip('"+rb.getTopMsg()+"')");
// 	}
}
%>
        $("#pageloading").remove();
    }, 1);
})
</script>