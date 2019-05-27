/**
 * pdf.js 扩展  add by xp
 */
function webViewerExtLoad() {
    //**支持控制下载和打印按钮
    var queryString = document.location.search.substring(1);
    var parts = queryString.split('&');
    var params = Object.create(null);
    for (var i = 0, ii = parts.length; i < ii; ++i) {
        var param = parts[i].split('=');
        var key = param[0].toLowerCase();
        var value = param.length > 1 ? param[1] : null;
        params[decodeURIComponent(key)] = decodeURIComponent(value);
    }

    if(!params.file){
        //NOTE 上面转了小写
        var fileUrl = params.fileurl;
        var fileName = params.filename;
        var fileId = params.fileid;
        var fileType = params.filetype;
        var isPreview = params.ispreview;
        var previewOfficeMode = params.previewofficemode;
        setTimeout(function () {
            //NOTE 需要先将PDF默认的加载的文件配置去调，不然就得加长此处代码执行等待时间
            PDFViewerApplication.close();
            PDFViewerApplication.open(fileUrl+"?fileName="+fileName+"&fileId="+fileId+"&fileType="+fileType+"&isPreview="+isPreview+"&previewOfficeMode="+previewOfficeMode);
        },0)
    }

    var isDownload = params.isdownload?eval(params.isdownload):true;
    var isPrint = params.isprint?eval(params.isprint):true;



    if(!isDownload){
        PDFViewerApplication.appConfig.toolbar.download.setAttribute('hidden', 'true');
        PDFViewerApplication.appConfig.secondaryToolbar.downloadButton.setAttribute('hidden', 'true');
    }
    if(!isPrint){
        PDFViewerApplication.appConfig.toolbar.print.setAttribute('hidden', 'true');
        PDFViewerApplication.appConfig.secondaryToolbar.printButton.setAttribute('hidden', 'true');
    }

    PDFViewerApplication.appConfig.toolbar.openFile.setAttribute('hidden', 'true');
    PDFViewerApplication.appConfig.secondaryToolbar.openFileButton.setAttribute('hidden', 'true');
}
if (document.readyState === 'interactive' || document.readyState === 'complete') {
    webViewerExtLoad();
} else {
    document.addEventListener('DOMContentLoaded', webViewerExtLoad, true);
}