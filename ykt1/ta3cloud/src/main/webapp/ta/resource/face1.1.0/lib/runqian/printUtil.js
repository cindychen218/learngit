(function(){
	var pu = window.PrintUtil = {};
	var setting = pu.setting = {"contextPath":""};
	/**
	 * reportTplName 报表模板名称
	 * jsonparam对象,示例:{yaz001:'123123213'}
	 */
	pu.pdfPrint = function(reportTplName, jsonparam, contextPath){
		if (!reportTplName || typeof reportTplName != "string"){
			alert("没有获取到报表模板名称,无法打印");
			return;
		}
		if (!setting.contextPath){
			setting.contextPath = contextPath;
		}
		//没有参数,不打印
		if (!jsonparam){
			alert("没有获取到报表参数,无法打印");
			return;
		}
		var paramStr = "?yaz903=" + reportTplName;
		for (var jsonKey in jsonparam){
			paramStr += "&" + jsonKey + "=" + jsonparam[jsonKey];
		}
		paramStr += "&r=" + Math.random();
		
		var pdfUrl = setting.contextPath + "/print/lodopPrintAction!pdfPrint.do" + paramStr;
		
		var newwin = window.open();//pdf打印窗口
		//窗口内容宽度
		var width = newwin.document.documentElement.clientWidth;
		width = width < 1366?1366:width;
		//窗口内容高度
		var height = newwin.document.documentElement.clientHeight;
		height = height < 673?673:height;
		
		//宽度高度偏移处理,防止产生滚动条
		width -= 40;
		height -= 20;
		
		//构造窗口内容(默认width=800,height=1050)
		var winStr = "<center><object id='pdfObj' name='pdfObj' classid='clsid:CA8A9780-280D-11CF-A24D-444553540000' width='"+width+"' height='"+height+"' border='0' style='border:0px solid red;'>";
		winStr += "<param name='_Version' value='65539'>";
		winStr += "<param name='_ExtentX' value='20108'>";
		winStr += "<param name='_ExtentY' value='10866'>";
		winStr += "<param name='_StockProps' value='0'>";
		winStr += "<param name='SRC' value='"+pdfUrl+"'>";
		winStr += "</object></center>";
		//重置窗口内容
		newwin.document.body.innerHTML = winStr;
		var obj = newwin.document.getElementById("pdfObj");
		obj.SetShowToolbar(true);//显示工具栏
	};
	//pdf打印回调函数
	pu.pdfPrintClk = function(){
		
	};
})();