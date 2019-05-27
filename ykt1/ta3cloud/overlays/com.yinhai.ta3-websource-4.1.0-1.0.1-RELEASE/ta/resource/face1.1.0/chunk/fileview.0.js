webpackJsonp([0],{

/***/ 193:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

/**
 * panel表单常用方法,调用方式为Base.xxx();
 * @module Base
 * @class panel
 * @static
 */
(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(194)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {
    __webpack_require__(195);
    $.extend(true, window, {
        Base: {
            FilePreview: core()
        }
    });

    function core() {
        var officeLib = ["txt", "ppt", "doc", "docx", "xlsx", "xls", "pdf"];
        var imgType = ["jpg", "png"];
        var aviType = ["mp4", "avi"];

        var $viewContainer, $viewTopBar, $viewContext, $viewBottomBar, $viewLeftControl, $viewRightControl, $viewControlBar, $viewControlInfo, $viewDownload, $viewRotate, $viewZoom;
        var listIntros, intro, index;
        var options = {};

        function initPreviewFile(param) {
            param = eval('(' + param + ')');
            listIntros = param.listIntros;
            index = param.index;
            intro = param.listIntros[index];
            $.extend(options, intro); //加载浏览配置信息
            previewFile();
        }

        function previewFile() {

            //预览面板
            $viewContainer = $("<div class='preview-view-Container'></div>");
            createShadeMask(intro);
            $viewTopBar = createViewTopBar(intro);
            $viewContext = createViewContext(intro);
            $viewBottomBar = createViewBottomBar();
            createViewControl();
            $viewContainer.appendTo($("body"));
        }

        function reLoadPreview(toIntro) {
            buildViewContext($viewContext, toIntro);
        }

        function createShadeMask() {
            //蒙层
            var $viewMask = $("<div class='shade-mask'></div>");
            $viewMask.appendTo($viewContainer);
            return $viewMask;
        }

        function createViewTopBar() {
            //顶部工具条
            var $viewTopBar = $("<div class='view-topBar'></div>");
            buildViewTopBar($viewTopBar, intro);
            $viewTopBar.appendTo($viewContainer);
            return $viewTopBar;
        }

        function buildViewTopBar($viewTopBar, intro) {
            $viewTopBar.empty();
            var $viewOpt = $("<div class='view-topOpt'></div>");
            var $viewClose = $("<div class='view-close'><span class='faceIcon icon-close'></span></div>");

            $viewClose.on("click", function () {
                $viewContainer.remove();
            });

            $viewClose.appendTo($viewOpt);
            $viewOpt.appendTo($viewTopBar);
        }

        function createViewContext() {
            //内容面板
            var $viewContext = $("<div class='view-context'></div>");
            buildViewContext($viewContext, intro);
            $viewContext.appendTo($viewContainer);
            return $viewContext;
        }

        function buildViewContext($viewContext, intro) {
            $viewContext.empty();

            //内容面板
            var $viewHead = $("<div class='view-head'></div>");
            var $viewCenter = $("<div class='view-center'></div>");

            if ($.inArray(intro.fileType, imgType) > -1) {

                //图片
                var $imgView = $("<img class='view-img' src='" + buildSrc(intro) + "'/>");
                $imgView.appendTo($viewCenter);
            } else if ($.inArray(intro.fileType, aviType) > -1) {
                //视频
                $viewHead.hide();
                if ("mp4" == intro.fileType) {
                    var $video = $("<video class='view-media' height='" + intro.mediaHeight + "' width='" + intro.mediaWidth + "' controls='controls' preload='preload'><source src='" + buildSrc(intro) + "'></source></video>");
                    $video.appendTo($viewCenter);
                } else {
                    var $video = $("<div class='view-media'></div>");
                    $video.media({ height: intro.mediaHeight, width: intro.mediaWidth, src: buildSrc(intro) });
                    $video.appendTo($viewCenter);
                }
            } else {
                //office
                $viewHead.hide();
                var $office = $("<div class='view-office'></div>");
                if (intro.previewOfficeMode == 'pdf' || intro.fileType == 'pdf') {
                    var $iframe = $("<iframe src='" + (Base.globvar.facePath || '') + "support/pdfjs/web/viewer.html?" + buildSrc(intro, true) + "&isdownLoad=false&isprint=false&targetType=pdf'></iframe>");
                } else {
                    var $iframe = $("<iframe src='" + buildSrc(intro, false) + "&targetType=html'></iframe>");
                }
                $iframe.appendTo($office);
                $office.appendTo($viewCenter);
            }

            $viewHead.appendTo($viewContext);
            $viewCenter.appendTo($viewContext);
        }

        function createViewBottomBar() {
            if (!options.viewWithThumbnail) {
                return;
            }
            var $viewBottomBar = $("<div class='view-bottom'></div>");

            $viewContainer.addClass("view-mode-showThumbnail");

            var $thumbnailEleContaner = $("<ul class='view-thumbnail-ul'></ul>");
            for (var i = 0; i < listIntros.length; i++) {
                var fileIntro = listIntros[i];

                if (fileIntro.isUploadEle) continue;

                var $thumbnailEle = $("<li class='view-thumbnail-li' _index='" + i + "'></li>");
                if ($.inArray(fileIntro.fileType, imgType) > -1) {
                    $thumbnailEle.append("<img title='" + fileIntro.fileName + "' src='" + buildSrc(fileIntro) + "'/>");
                } else {
                    $thumbnailEle.append("<span title='" + fileIntro.fileName + "' class='not-img'>缩略图预览失败</span>");
                }

                $thumbnailEle.on("click", function () {
                    reloadViewContextEvent($(this).attr("_index"));
                });

                if (i == index) {
                    $thumbnailEle.addClass("active");
                }
                $thumbnailEle.appendTo($thumbnailEleContaner);
            }
            $thumbnailEleContaner.appendTo($viewBottomBar);

            $viewBottomBar.appendTo($viewContainer);

            $(window).on("resize", function () {
                calculateBarElePosition($(".active", $viewBottomBar).attr("_index"));
            });
            return $viewBottomBar;
        }

        function createViewControl() {
            if (options.showFileBarMode == 'simpleBar') {
                //向左向右按钮
                $viewLeftControl = $("<div class='view-control-left' '><span></span></div>");
                $viewRightControl = $("<div class='view-control-right' '><span></span></div>");
                initControlStep(index);

                $viewLeftControl.on("click", function () {
                    var id = index;
                    var prefId = $(this).attr("_index");
                    if (id == prefId) alert("没有上一个文件了");
                    reloadViewContextEvent(prefId);
                });
                $viewRightControl.on("click", function () {
                    var id = index;
                    var nextId = $(this).attr("_index");
                    if (id == nextId) alert("没有下一个文件了");
                    reloadViewContextEvent(nextId);
                });

                $viewLeftControl.appendTo($viewContainer);
                $viewRightControl.appendTo($viewContainer);
            } else {
                //创建操作bar
                $viewControlBar = $("<div class='view-control-bar'></div>");
                var $viewDelimiter1 = $("<span class='view-control-bar-delimiter'></span>");
                var $viewDelimiter2 = $("<span class='view-control-bar-delimiter'></span>");
                $viewControlInfo = $("<span>" + intro.fileName + "</span>");
                var $viewControlBarTop = $("<div class='view-control-top' '></span></div>");
                var $viewControlBarBottom = $("<div class='view-control-bottom' '></div>");
                $viewLeftControl = $("<div class='view-control-bar-left' '><span></span></div>");
                $viewRightControl = $("<div class='view-control-bar-right' '><span></span></div>");
                $viewDownload = $("<div class='view-control-bar-download'><span></span></div>");
                $viewRotate = $("<div class='view-control-bar-rotate'><span></span></div>");
                $viewZoom = $("<div class='view-control-bar-fangda'><span></span></div>");

                //事件绑定
                //左右切换事件绑定
                initControlStep(index);
                $viewLeftControl.on("click", function () {
                    var id = index;
                    var prefId = $(this).attr("_index");
                    if (id == prefId) alert("没有上一个文件了");
                    reloadViewContextEvent(prefId);
                });
                $viewRightControl.on("click", function () {
                    var id = index;
                    var nextId = $(this).attr("_index");
                    if (id == nextId) alert("没有下一个文件了");
                    reloadViewContextEvent(nextId);
                });
                //图片旋转事件绑定
                initRotateState(index);
                //缩放事件绑定
                initZoomState(index);
                //下载事件绑定
                initDownloadState(index);

                $viewControlInfo.appendTo($viewControlBarTop);
                $viewControlBarTop.appendTo($viewControlBar);
                $viewLeftControl.appendTo($viewControlBarBottom);
                $viewRightControl.appendTo($viewControlBarBottom);
                $viewDelimiter1.appendTo($viewControlBarBottom);
                $viewRotate.appendTo($viewControlBarBottom);
                $viewZoom.appendTo($viewControlBarBottom);
                $viewDelimiter2.appendTo($viewControlBarBottom);
                $viewDownload.appendTo($viewControlBarBottom);
                $viewControlBarBottom.appendTo($viewControlBar);
                $viewControlBar.appendTo($viewContainer);

                //controlBar 添加动画行为
                $viewControlBar.animate({ opacity: 0 }, 3000);
                $viewControlBar.on("mouseenter", function () {
                    $viewControlBar.stop().animate({ opacity: 1 }, "fast");
                });
                $viewControlBar.on("mouseleave", function () {
                    $viewControlBar.animate({ opacity: 0 }, 3000);
                });
            }
        }

        /**
         * 预览切换事件
         * @param idx
         */
        function reloadViewContextEvent(idx) {
            goShowContext(idx);
            //更新左右操作按钮
            initControlStep(idx);
            //更新文件相应信息
            if ($viewControlInfo) $viewControlInfo.text(intro.fileName);
            //更新旋转按钮状态
            if ($viewRotate) initRotateState(idx);
            //更新缩放按钮状态
            if ($viewZoom) initZoomState(idx);
            //更新下载按钮状态
            if ($viewDownload) initDownloadState(idx);
            //展示工具条
            if ($viewControlBar) $viewControlBar.stop().animate({ opacity: 1 }, "fast").animate({ opacity: 0 }, 3000);
            //底部缩略框
            if ($viewBottomBar) activeBottomEleByIndex(idx);
        }

        function initControlStep(i) {
            var step = getStep(i);
            $viewLeftControl.attr("_index", step.pref);
            $viewRightControl.attr("_index", step.next);
        }

        function getStep(i) {
            i = Number(i);
            var pref, next;
            if (i == 0) {
                pref = i;
                next = i + 1;
            } else if (i == listIntros.length - 1) {
                pref = i - 1;
                next = i;
            } else {
                pref = i - 1;
                next = i + 1;
            }
            return {
                pref: pref,
                next: next
            };
        }

        function initRotateState(idx) {
            if ($viewRotate) {
                //只有图片支持旋转
                if ($.inArray(listIntros[idx].fileType, imgType) > -1) {
                    $viewRotate.removeClass("view-control-bar-disable");
                    $viewRotate.on("click", function () {
                        var img = $(".view-img", $viewContext);
                        if (img.is(".rotate90")) {
                            img.removeClass("rotate90");
                            img.addClass("rotate180");
                        } else if (img.is(".rotate180")) {
                            img.removeClass("rotate180");
                            img.addClass("rotate270");
                        } else if (img.is(".rotate270")) {
                            img.removeClass("rotate270");
                        } else {
                            img.addClass("rotate90");
                        }
                    });
                } else {
                    $viewRotate.addClass("view-control-bar-disable");
                }
            }
        }

        function initZoomState(idx) {
            if ($viewZoom) {
                //视屏上自带放大，比我们实现的好
                if ($.inArray(listIntros[idx].fileType, aviType) < 0) {
                    $viewZoom.removeClass("view-control-bar-disable");
                    $viewZoom.on("click", function () {
                        if ($(this).is(".view-control-bar-suoxiao")) {
                            $viewContext.width("70%");
                            $viewZoom.removeClass();
                            $viewZoom.addClass("view-control-bar-fangda");
                        } else {
                            $viewContext.width("auto");
                            $viewZoom.removeClass();
                            $viewZoom.addClass("view-control-bar-suoxiao");
                        }
                    });
                } else {
                    $viewZoom.addClass("view-control-bar-disable");
                }
            }
        }
        function initDownloadState(idx) {
            if ($viewDownload) {
                //如果有beforeDownloadFun，代表需要根据业务逻辑决定是否下载文件
                if (listIntros[idx].isDownload && !listIntros[idx].beforeDownloadFun) {
                    $viewDownload.removeClass("view-control-bar-disable");
                    $viewDownload.on("click", function () {
                        downloadFile(listIntros[idx]);
                    });
                } else {
                    $viewDownload.addClass("view-control-bar-disable");
                    $viewDownload.off("click");
                }
            }
        }

        function activeBottomEleByIndex(idx) {
            $(".view-thumbnail-li", $viewBottomBar).removeClass("active");
            $(".view-thumbnail-li[_index=" + idx + "]", $viewBottomBar).addClass("active");

            calculateBarElePosition(idx);
        }

        function calculateBarElePosition(idx) {
            var browser = {
                width: document.body.clientWidth,
                height: document.body.clientHeight
            };
            var position = $(".view-thumbnail-li[_index=" + idx + "]", $viewBottomBar).offset();
            var halfwidth = browser.width / 2;
            $viewBottomBar.animate({ scrollLeft: $viewBottomBar.scrollLeft() + (position.left - halfwidth) }, 1000);
        }

        function goShowContext(idx) {
            index = idx;
            intro = listIntros[index];
            buildViewContext($viewContext, intro);
        }

        function showViewContextMessage($Container, message) {
            var $message = $("<div class='view-message'></div>");
            $message.appendTo($Container);
        }

        function toUniformCase(type) {
            return type ? type.toLowerCase() : "unknown";
        }

        // var fireEvent = function(element,event){
        //     if (document.createEventObject){
        //         // IE浏览器支持fireEvent方法
        //         var evt = document.createEventObject();
        //         return element.fireEvent('on'+event,evt)
        //     }
        //     else{
        //         // 其他标准浏览器使用dispatchEvent方法
        //         // 创建event的对象实例。
        //         var evt = document.createEvent( 'HTMLEvents' );
        //         // 3个参数：事件类型，是否冒泡，是否阻止浏览器的默认行为
        //         evt.initEvent(event, true, false);
        //         return !element.dispatchEvent(evt);
        //     }
        // };

        function downloadFile(data) {
            if (isLinkUrl(data)) {
                var sysPath = data.sysPath || '';
                var aLink = document.createElement('a');
                aLink.download = data.fileName;
                aLink.href = sysPath + (data.downloadUrl || data.src);
                aLink.target = "_blank";
                aLink.click();
            } else {
                var $from = $("<form/>").attr("method", "post").attr("display", "none").appendTo("body").attr("action", buildSrc(data, false, false)).submit().remove();
            }
        }

        function isLinkUrl(data) {
            var linkType = [].concat(imgType);
            linkType.push("txt");
            var url = data.downloadUrl || data.src;
            return linkType.indexOf(data.fileType) > -1 && url.endsWithIn(linkType);
        }

        /**
         *
         * @param data
         * @param isParam 是否只构造参数
         * @param isPreview 是否预览
         * @return {string}
         */
        function buildSrc(data, isParam, isPreview) {
            var sysPath = data.sysPath;
            isPreview = isPreview === false ? false : true;
            var src = isPreview ? data.src : data.downloadUrl || data.src;
            var url = "";

            if (sysPath) url += sysPath;
            if (url.length > 0 && !url.endsWith("/")) url += "/";

            var _src = "";
            if (src.startsWith("/")) {
                _src = src.substring(1, src.length);
            } else {
                _src = src;
            }

            url += _src;
            if (isParam === true) {
                return "fileUrl=" + url + "&fileId=" + data.fileId + "&fileType=" + data.fileType + "&fileName=" + encodeURIComponent(data.fileName) + "&isPreview=" + isPreview + "&previewOfficeMode=" + data.previewOfficeMode;
            } else {
                return url + "?fileId=" + data.fileId + "&fileType=" + data.fileType + "&fileName=" + encodeURIComponent(data.fileName) + "&isPreview=" + isPreview + "&previewOfficeMode=" + data.previewOfficeMode;
            }
        }

        return {
            initPreviewFile: initPreviewFile,
            downloadFile: downloadFile,
            buildSrc: buildSrc,
            toUniformCase: toUniformCase
        };
    }
});

/***/ }),

/***/ 194:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(jQuery) {

/*
 * jQuery Media Plugin for converting elements into rich media content.
 *
 * Examples and documentation at: http://malsup.com/jquery/media/
 * Copyright (c) 2007-2010 M. Alsup
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * @author: M. Alsup
 * @version: 0.99 (05-JUN-2013)
 * @requires jQuery v1.1.2 or later
 * $Id: jquery.media.js 2460 2007-07-23 02:53:15Z malsup $
 *
 * Supported Media Players:
 *	- Flash
 *	- Quicktime
 *	- Real Player
 *	- Silverlight
 *	- Windows Media Player
 *	- iframe
 *
 * Supported Media Formats:
 *	 Any types supported by the above players, such as:
 *	 Video: asf, avi, flv, mov, mpg, mpeg, mp4, qt, smil, swf, wmv, 3g2, 3gp
 *	 Audio: aif, aac, au, gsm, mid, midi, mov, mp3, m4a, snd, rm, wav, wma
 *	 Other: bmp, html, pdf, psd, qif, qtif, qti, tif, tiff, xaml
 *
 * Thanks to Mark Hicken and Brent Pedersen for helping me debug this on the Mac!
 * Thanks to Dan Rossi for numerous bug reports and code bits!
 * Thanks to Skye Giordano for several great suggestions!
 * Thanks to Richard Connamacher for excellent improvements to the non-IE behavior!
 */
/*global SWFObject alert Sys */
/*jshint forin:false */
;(function ($) {
	"use strict";

	var mode = document.documentMode || 0;
	var msie = /MSIE/.test(navigator.userAgent);
	var lameIE = msie && (/MSIE (6|7|8)\.0/.test(navigator.userAgent) || mode < 9);

	/**
  * Chainable method for converting elements into rich media.
  *
  * @param options
  * @param callback fn invoked for each matched element before conversion
  * @param callback fn invoked for each matched element after conversion
  */
	$.fn.media = function (options, f1, f2) {
		if (options == 'undo') {
			return this.each(function () {
				var $this = $(this);
				var html = $this.data('media.origHTML');
				if (html) $this.replaceWith(html);
			});
		}

		return this.each(function () {
			if (typeof options == 'function') {
				f2 = f1;
				f1 = options;
				options = {};
			}
			var o = getSettings(this, options);
			// pre-conversion callback, passes original element and fully populated options
			if (typeof f1 == 'function') f1(this, o);

			var r = getTypesRegExp();
			var m = r.exec(o.src.toLowerCase()) || [''];
			var fn;

			if (o.type) m[0] = o.type;else m.shift();

			for (var i = 0; i < m.length; i++) {
				fn = m[i].toLowerCase();
				if (isDigit(fn[0])) fn = 'fn' + fn; // fns can't begin with numbers
				if (!$.fn.media[fn]) continue; // unrecognized media type
				// normalize autoplay settings
				var player = $.fn.media[fn + '_player'];
				if (!o.params) o.params = {};
				if (player) {
					var num = player.autoplayAttr == 'autostart';
					o.params[player.autoplayAttr || 'autoplay'] = num ? o.autoplay ? 1 : 0 : o.autoplay ? true : false;
				}
				var $div = $.fn.media[fn](this, o);

				$div.css('backgroundColor', o.bgColor).width(o.width);

				if (o.canUndo) {
					var $temp = $('<div></div>').append(this);
					$div.data('media.origHTML', $temp.html()); // store original markup
				}

				// post-conversion callback, passes original element, new div element and fully populated options
				if (typeof f2 == 'function') f2(this, $div[0], o, player.name);
				break;
			}
		});
	};

	/**
  * Non-chainable method for adding or changing file format / player mapping
  * @name mapFormat
  * @param String format File format extension (ie: mov, wav, mp3)
  * @param String player Player name to use for the format (one of: flash, quicktime, realplayer, winmedia, silverlight or iframe
  */
	$.fn.media.mapFormat = function (format, player) {
		if (!format || !player || !$.fn.media.defaults.players[player]) return; // invalid
		format = format.toLowerCase();
		if (isDigit(format[0])) format = 'fn' + format;
		$.fn.media[format] = $.fn.media[player];
		$.fn.media[format + '_player'] = $.fn.media.defaults.players[player];
	};

	// global defautls; override as needed
	$.fn.media.defaults = {
		standards: true, // use object tags only (no embeds for non-IE browsers)
		canUndo: true, // tells plugin to store the original markup so it can be reverted via: $(sel).mediaUndo()
		width: 400,
		height: 400,
		autoplay: 0, // normalized cross-player setting
		bgColor: '#ffffff', // background color
		params: { wmode: 'transparent' }, // added to object element as param elements; added to embed element as attrs
		attrs: {}, // added to object and embed elements as attrs
		flvKeyName: 'file', // key used for object src param (thanks to Andrea Ercolino)
		flashvars: {}, // added to flash content as flashvars param/attr
		flashVersion: '7', // required flash version
		expressInstaller: null, // src for express installer

		// default flash video and mp3 player (@see: http://jeroenwijering.com/?item=Flash_Media_Player)
		flvPlayer: 'mediaplayer.swf',
		mp3Player: 'mediaplayer.swf',

		// @see http://msdn2.microsoft.com/en-us/library/bb412401.aspx
		silverlight: {
			inplaceInstallPrompt: 'true', // display in-place install prompt?
			isWindowless: 'true', // windowless mode (false for wrapping markup)
			framerate: '24', // maximum framerate
			version: '0.9', // Silverlight version
			onError: null, // onError callback
			onLoad: null, // onLoad callback
			initParams: null, // object init params
			userContext: null // callback arg passed to the load callback
		}
	};

	// Media Players; think twice before overriding
	$.fn.media.defaults.players = {
		flash: {
			name: 'flash',
			title: 'Flash',
			types: 'flv,mp3,swf',
			mimetype: 'application/x-shockwave-flash',
			pluginspage: 'http://www.adobe.com/go/getflashplayer',
			ieAttrs: {
				classid: 'clsid:d27cdb6e-ae6d-11cf-96b8-444553540000',
				type: 'application/x-oleobject',
				codebase: 'http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=' + $.fn.media.defaults.flashVersion
			}
		},
		quicktime: {
			name: 'quicktime',
			title: 'QuickTime',
			mimetype: 'video/quicktime',
			pluginspage: 'http://www.apple.com/quicktime/download/',
			types: 'aif,aiff,aac,au,bmp,gsm,mov,mid,midi,mpg,mpeg,m4a,psd,qt,qtif,qif,qti,snd,tif,tiff,wav,3g2,3gp',
			ieAttrs: {
				classid: 'clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B',
				codebase: 'http://www.apple.com/qtactivex/qtplugin.cab'
			}
		},
		realplayer: {
			name: 'real',
			title: 'RealPlayer',
			types: 'ra,ram,rm,rpm,rv,smi,smil',
			mimetype: 'audio/x-pn-realaudio-plugin',
			pluginspage: 'http://www.real.com/player/',
			autoplayAttr: 'autostart',
			ieAttrs: {
				classid: 'clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA'
			}
		},
		winmedia: {
			name: 'winmedia',
			title: 'Windows Media',
			types: 'asx,asf,avi,wma,wmv',
			mimetype: isFirefoxWMPPluginInstalled() ? 'application/x-ms-wmp' : 'application/x-mplayer2',
			pluginspage: 'http://www.microsoft.com/Windows/MediaPlayer/',
			autoplayAttr: 'autostart',
			oUrl: 'url',
			ieAttrs: {
				classid: 'clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6',
				type: 'application/x-oleobject'
			}
		},
		// special cases
		img: {
			name: 'img',
			title: 'Image',
			types: 'gif,png,jpg'
		},
		iframe: {
			name: 'iframe',
			types: 'html,pdf'
		},
		silverlight: {
			name: 'silverlight',
			types: 'xaml'
		}
	};

	//
	//	everything below here is private
	//


	// detection script for FF WMP plugin (http://www.therossman.org/experiments/wmp_play.html)
	// (hat tip to Mark Ross for this script)
	function isFirefoxWMPPluginInstalled() {
		var plugs = navigator.plugins || [];
		for (var i = 0; i < plugs.length; i++) {
			var plugin = plugs[i];
			if (plugin['filename'] == 'np-mswmp.dll') return true;
		}
		return false;
	}

	var counter = 1;

	for (var player in $.fn.media.defaults.players) {
		var types = $.fn.media.defaults.players[player].types;
		$.each(types.split(','), function (i, o) {
			if (isDigit(o[0])) o = 'fn' + o;
			$.fn.media[o] = $.fn.media[player] = getGenerator(player);
			$.fn.media[o + '_player'] = $.fn.media.defaults.players[player];
		});
	}

	function getTypesRegExp() {
		var types = '';
		for (var player in $.fn.media.defaults.players) {
			if (types.length) types += ',';
			types += $.fn.media.defaults.players[player].types;
		}
		return new RegExp('\\.(' + types.replace(/,/ig, '|') + ')\\b');
	}

	function getGenerator(player) {
		return function (el, options) {
			return generate(el, options, player);
		};
	}

	function isDigit(c) {
		return '0123456789'.indexOf(c) > -1;
	}

	// flatten all possible options: global defaults, meta, option obj
	function getSettings(el, options) {
		options = options || {};
		var a, n;
		var $el = $(el);
		var cls = el.className || '';
		// support metadata plugin (v1.0 and v2.0)
		var meta = $.metadata ? $el.metadata() : $.meta ? $el.data() : {};
		meta = meta || {};
		var w = meta.width || parseInt((cls.match(/\bw:(\d+)/) || [])[1] || 0, 10) || parseInt((cls.match(/\bwidth:(\d+)/) || [])[1] || 0, 10);
		var h = meta.height || parseInt((cls.match(/\bh:(\d+)/) || [])[1] || 0, 10) || parseInt((cls.match(/\bheight:(\d+)/) || [])[1] || 0, 10);

		if (w) meta.width = w;
		if (h) meta.height = h;
		if (cls) meta.cls = cls;

		// crank html5 style data attributes
		var dataName = 'data-';
		for (var i = 0; i < el.attributes.length; i++) {
			a = el.attributes[i], n = $.trim(a.name);
			var index = n.indexOf(dataName);
			if (index === 0) {
				n = n.substring(dataName.length);
				meta[n] = a.value;
			}
		}

		a = $.fn.media.defaults;
		var b = options;
		var c = meta;

		var p = { params: { bgColor: options.bgColor || $.fn.media.defaults.bgColor } };
		var opts = $.extend({}, a, b, c);
		$.each(['attrs', 'params', 'flashvars', 'silverlight'], function (i, o) {
			opts[o] = $.extend({}, p[o] || {}, a[o] || {}, b[o] || {}, c[o] || {});
		});

		if (typeof opts.caption == 'undefined') opts.caption = $el.text();

		// make sure we have a source!
		opts.src = opts.src || $el.attr('href') || $el.attr('src') || 'unknown';
		return opts;
	}

	//
	//	Flash Player
	//

	// generate flash using SWFObject library if possible
	$.fn.media.swf = function (el, opts) {
		var f, p;
		if (!window.SWFObject && !window.swfobject) {
			// roll our own
			if (opts.flashvars) {
				var a = [];
				for (f in opts.flashvars) {
					a.push(f + '=' + opts.flashvars[f]);
				}if (!opts.params) opts.params = {};
				opts.params.flashvars = a.join('&');
			}
			return generate(el, opts, 'flash');
		}

		var id = el.id ? ' id="' + el.id + '"' : '';
		var cls = opts.cls ? ' class="' + opts.cls + '"' : '';
		var $div = $('<div' + id + cls + '>');

		// swfobject v2+
		if (window.swfobject) {
			$(el).after($div).appendTo($div);
			if (!el.id) el.id = 'movie_player_' + counter++;

			// replace el with swfobject content
			window.swfobject.embedSWF(opts.src, el.id, opts.width, opts.height, opts.flashVersion, opts.expressInstaller, opts.flashvars, opts.params, opts.attrs);
		}
		// swfobject < v2
		else {
				$(el).after($div).remove();
				var so = new SWFObject(opts.src, 'movie_player_' + counter++, opts.width, opts.height, opts.flashVersion, opts.bgColor);
				if (opts.expressInstaller) so.useExpressInstall(opts.expressInstaller);

				for (p in opts.params) {
					if (p != 'bgColor') so.addParam(p, opts.params[p]);
				}for (f in opts.flashvars) {
					so.addVariable(f, opts.flashvars[f]);
				}so.write($div[0]);
			}

		if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
		return $div;
	};

	// map flv and mp3 files to the swf player by default
	$.fn.media.flv = $.fn.media.mp3 = function (el, opts) {
		var src = opts.src;
		var player = /\.mp3\b/i.test(src) ? opts.mp3Player : opts.flvPlayer;
		var key = opts.flvKeyName;
		src = encodeURIComponent(src);
		opts.src = player;
		opts.src = opts.src + '?' + key + '=' + src;
		var srcObj = {};
		srcObj[key] = src;
		opts.flashvars = $.extend({}, srcObj, opts.flashvars);
		return $.fn.media.swf(el, opts);
	};

	//
	//	Silverlight
	//
	$.fn.media.xaml = function (el, opts) {
		if (!window.Sys || !window.Sys.Silverlight) {
			if ($.fn.media.xaml.warning) return;
			$.fn.media.xaml.warning = 1;
			alert('You must include the Silverlight.js script.');
			return;
		}

		var props = {
			width: opts.width,
			height: opts.height,
			background: opts.bgColor,
			inplaceInstallPrompt: opts.silverlight.inplaceInstallPrompt,
			isWindowless: opts.silverlight.isWindowless,
			framerate: opts.silverlight.framerate,
			version: opts.silverlight.version
		};
		var events = {
			onError: opts.silverlight.onError,
			onLoad: opts.silverlight.onLoad
		};

		var id1 = el.id ? ' id="' + el.id + '"' : '';
		var id2 = opts.id || 'AG' + counter++;
		// convert element to div
		var cls = opts.cls ? ' class="' + opts.cls + '"' : '';
		var $div = $('<div' + id1 + cls + '>');
		$(el).after($div).remove();

		Sys.Silverlight.createObjectEx({
			source: opts.src,
			initParams: opts.silverlight.initParams,
			userContext: opts.silverlight.userContext,
			id: id2,
			parentElement: $div[0],
			properties: props,
			events: events
		});

		if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
		return $div;
	};

	//
	// generate object/embed markup
	//
	function generate(el, opts, player) {
		var $el = $(el);
		var o = $.fn.media.defaults.players[player];
		var a, key, v;

		if (player == 'iframe') {
			o = $('<iframe' + ' width="' + opts.width + '" height="' + opts.height + '" >');
			o.attr('src', opts.src);
			o.css('backgroundColor', o.bgColor);
		} else if (player == 'img') {
			o = $('<img>');
			o.attr('src', opts.src);
			if (opts.width) o.attr('width', opts.width);
			if (opts.height) o.attr('height', opts.height);
			o.css('backgroundColor', o.bgColor);
		} else if (lameIE) {
			a = ['<object width="' + opts.width + '" height="' + opts.height + '" '];
			for (key in opts.attrs) {
				a.push(key + '="' + opts.attrs[key] + '" ');
			}for (key in o.ieAttrs || {}) {
				v = o.ieAttrs[key];
				if (key == 'codebase' && window.location.protocol == 'https:') v = v.replace('http', 'https');
				a.push(key + '="' + v + '" ');
			}
			a.push('></ob' + 'ject' + '>');
			var p = ['<param name="' + (o.oUrl || 'src') + '" value="' + opts.src + '">'];
			for (key in opts.params) {
				p.push('<param name="' + key + '" value="' + opts.params[key] + '">');
			}o = document.createElement(a.join(''));
			for (var i = 0; i < p.length; i++) {
				o.appendChild(document.createElement(p[i]));
			}
		} else if (opts.standards) {
			// Rewritten to be standards compliant by Richard Connamacher
			a = ['<object type="' + o.mimetype + '" width="' + opts.width + '" height="' + opts.height + '"'];
			if (opts.src) a.push(' data="' + opts.src + '" ');
			if (msie) {
				for (key in o.ieAttrs || {}) {
					v = o.ieAttrs[key];
					if (key == 'codebase' && window.location.protocol == 'https:') v = v.replace('http', 'https');
					a.push(key + '="' + v + '" ');
				}
			}
			a.push('>');
			a.push('<param name="' + (o.oUrl || 'src') + '" value="' + opts.src + '">');
			for (key in opts.params) {
				if (key == 'wmode' && player != 'flash') // FF3/Quicktime borks on wmode
					continue;
				a.push('<param name="' + key + '" value="' + opts.params[key] + '">');
			}
			// Alternate HTML
			a.push('<div><p><strong>' + o.title + ' Required</strong></p><p>' + o.title + ' is required to view this media. <a href="' + o.pluginspage + '">Download Here</a>.</p></div>');
			a.push('</ob' + 'ject' + '>');
		} else {
			a = ['<embed width="' + opts.width + '" height="' + opts.height + '" style="display:block"'];
			if (opts.src) a.push(' src="' + opts.src + '" ');
			for (key in opts.attrs) {
				a.push(key + '="' + opts.attrs[key] + '" ');
			}for (key in o.eAttrs || {}) {
				a.push(key + '="' + o.eAttrs[key] + '" ');
			}for (key in opts.params) {
				if (key == 'wmode' && player != 'flash') // FF3/Quicktime borks on wmode
					continue;
				a.push(key + '="' + opts.params[key] + '" ');
			}
			a.push('></em' + 'bed' + '>');
		}
		// convert element to div
		var id = el.id ? ' id="' + el.id + '"' : '';
		var cls = opts.cls ? ' class="' + opts.cls + '"' : '';
		var $div = $('<div' + id + cls + '>');
		$el.after($div).remove();
		if (lameIE || player == 'iframe' || player == 'img') $div.append(o);else $div.html(a.join(''));

		if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
		return $div;
	}
})(jQuery);
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0)))

/***/ }),

/***/ 195:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 503:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(5), __webpack_require__(36), __webpack_require__(193), __webpack_require__(33)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {
    __webpack_require__(531);
    $.extend(true, window, {
        TaFileView: TaFileView
    });
    function TaFileView(fileviewId, options) {
        options = $.extend({
            showFileMode: "simple",
            showFileBarMode: "boxBar",
            isShowMiniView: true,
            isUpload: true,
            isRemove: true,
            isPreview: true,
            isDownload: true,
            uploadFun: null,
            beforeRemoveFun: null,
            beforeDownloadFun: null,
            clearFun: null,
            eleWidth: 100,
            datas: [],
            viewWithThumbnail: false

        }, options || {});

        var defaultEle = {
            previewOfficeMode: "pdf",
            fileId: null,
            fileName: null,
            fileSize: null,
            fileDesc: null,
            fileType: undefined,
            sysPath: Base.globvar.basePath,
            src: null,
            downloadUrl: null,
            mediaHeight: 400,
            mediaWidth: 600
        };
        var uploadEle = {
            fileId: "filedUpload",
            isUploadEle: true,
            fileType: "upload",
            fileName: "文件上传"
            //组件核心部件

        };var $layoutContainer = $("#" + fileviewId);
        var $uploadEle;

        var officeLib = ["txt", "ppt", "doc", "docx", "xlsx", "xls", "pdf"];
        var imgType = ["jpg", "png"];
        var aviType = ["mp4", "avi"];

        var $viewContainer;

        function init() {
            switch (options.showFileMode) {
                case 'simple':
                    $layoutContainer.addClass("fileviewGroup-mode-tb");break;
                case 'list':
                    $layoutContainer.addClass("fileviewGroup-mode-lr");break;
                case 'simpleList':
                    $layoutContainer.addClass("fileviewGroup-mode-lr-simple");break;
            }

            if (options.isUpload) {
                options.datas = options.datas || [];
                options.datas.push(uploadEle);
            }

            for (var i = 0; i < options.datas.length; i++) {
                var $eleBox = createViewElementBox();
                createViewElement($eleBox, options.datas, i);
                $eleBox.appendTo($layoutContainer);

                if (options.datas[i].isUploadEle) $uploadEle = $eleBox;
            }

            styleCorrection($layoutContainer);
        } // end init

        function styleCorrection($scope) {
            //样式矫正
            if (options.showFileMode == 'simple' && options.eleWidth != 100) {
                if ($scope.hasClass("view-ele-box")) {
                    $scope.css("width", options.eleWidth + "px");
                } else {
                    $(".view-ele-box", $scope).css("width", options.eleWidth + "px");
                }

                $(".fileview-img", $scope).css("height", options.eleWidth * 0.5 + "px");
                $(".fileview-img>span", $scope).css("fontSize", options.eleWidth * 0.38 + "px");
                if (options.eleWidth < 100) {
                    $(".img-opt-box", $scope).css("height", "20px");
                    $(".img-opt-box>div>span", $scope).css("fontSize", "10px");
                } else if (options.eleWidth > 300) {
                    $(".img-opt-box", $scope).css("height", "50px");
                    $(".img-opt-box>div>span", $scope).css("fontSize", "40px");
                }
            }
        }

        function createViewElementBox() {
            var $eleBox = $("<div class='view-ele-box'></div>");

            return $eleBox;
        }

        function createViewElement($eleBox, datas, _index) {
            var _options = $.extend({}, options);
            _options.datas = null; //处理重复引用
            var data = datas[_index] = $.extend({}, defaultEle, datas[_index] || {}, _options);
            if (typeof data.fileId == 'undefined' || data.fileId == null) data.fileId = "fileId" + _index;

            var $eleLayoutContainer = $("<div _field=" + data.fileId + " class='fileview-layout-Container'></div>");
            switch (options.showFileMode) {
                case 'simple':
                    $eleLayoutContainer.addClass("fileview-mode-tb");break;
                case 'list':
                    $eleLayoutContainer.addClass("fileview-mode-lr");break;
                case 'simpleList':
                    $eleLayoutContainer.addClass("fileview-mode-lr-simple");break;
            }

            var $eleImgBox = $("<div class='fileview-img'></div>");
            if (options.isShowMiniView && options.showFileMode == 'simple' && $.inArray(data.fileType, imgType) > -1) {
                var $eleImg = $("<img class='preview-view-imgspan'></img>");
                var image = new Image();
                image.src = Base.FilePreview.buildSrc(data);
                image.onload = function () {
                    $eleImg.attr("src", image.src);
                };
            } else {
                var $eleImg = $("<span class='preview-view-imgspan'></span>");

                if ($.inArray(data.fileType, officeLib) > -1 || $.inArray(data.fileType, imgType) > -1 || $.inArray(data.fileType, aviType) > -1 || "upload" == data.fileType) {
                    $eleImg.addClass("type-" + data.fileType);
                } else {
                    $eleImg.addClass("type-unknown");
                }
            }

            $eleImg.appendTo($eleImgBox);

            if (!data.isUploadEle && options.showFileMode == 'simple' && (data.isDownload || data.isRemove)) {
                var $eleImgOptBox = $("<div class='img-opt-box'></div>");

                if (data.isDownload) {
                    var $eleDownloadBox = $("<div class='download-box'></div>");
                    var $eleDownload = $("<span class='download'></span>");
                    $eleDownload.appendTo($eleDownloadBox);
                    $eleDownloadBox.appendTo($eleImgOptBox);

                    $eleDownload.on("click", function (e) {
                        downloadFile(data);
                    });
                }

                if (data.isRemove) {
                    var $eleRemoveBox = $("<div class='remove-box'></div>");
                    var $eleRemove = $("<span class='remove'></span>");
                    $eleRemove.appendTo($eleRemoveBox);
                    $eleRemoveBox.appendTo($eleImgOptBox);

                    $eleRemove.on("click", function (e) {
                        removeFile($(this), data.fileId);
                    });
                }

                $eleImgOptBox.appendTo($eleImgBox);

                $eleImgBox.on("mouseenter", function () {
                    $eleImgOptBox.stop().fadeIn();
                }).on("mouseleave", function () {
                    $eleImgOptBox.stop().fadeOut();
                });

                $eleImgOptBox.on("click", function (e) {
                    if (e.preventDefault) e.preventDefault();
                    if (e.stopPropagation) e.stopPropagation();
                    e.cancelBubble = true;
                    e.returnValue = false;
                });
            }

            var $eleDescBox = $("<div class='fileview-desc-Container'></div>");
            var $eleDescMessageBox = $("<div class='fileview-desc'></div>");
            var $eleName = $("<span class='name'></span>");
            $eleName.text(data.fileName);
            $eleName.attr("title", data.fileName);
            $eleName.appendTo($eleDescMessageBox);
            if (!data.isUploadEle) {
                if (options.showFileMode != 'simple' && data.fileSize) {
                    var $eleSize = $("<span class='size'></span>");
                    $eleSize.text("（" + data.fileSize + "）");
                    $eleSize.attr("title", "文件大小：" + data.fileSize);
                    $eleSize.appendTo($eleDescMessageBox);
                }
            }

            $eleDescMessageBox.appendTo($eleDescBox);

            if (!data.isUploadEle) {
                if (options.showFileMode != 'simple') {
                    var $eleDescOptBox = $("<div class='fileview-opt'></div>");
                    //暂不展示预览按钮，双击展示即可
                    if (data.isPreview && false) {
                        var $elePreview = $(" <a href='#' class='preview'>预览</a>");
                        $elePreview.appendTo($eleDescOptBox);
                        $elePreview.on("click", function () {});
                    }
                    if (data.isDownload) {
                        var $eleDownload = $(" <a href='#' class='download'>下载</a>");
                        $eleDownload.appendTo($eleDescOptBox);
                        $eleDownload.on("click", function () {
                            downloadFile(data);
                        });
                    }
                    if (data.isRemove) {
                        var $eleRemove = $(" <a href='#' class='remove'>删除</a>");
                        $eleRemove.appendTo($eleDescOptBox);
                        $eleRemove.on("click", function () {
                            removeFile($(this), data.fileId);
                        });
                    }

                    $eleDescOptBox.appendTo($eleDescBox);
                    $eleDescOptBox.on("click", function (e) {
                        if (e.preventDefault) e.preventDefault();
                        if (e.stopPropagation) e.stopPropagation();
                        e.cancelBubble = true;
                        e.returnValue = false;
                    });
                }
            }

            var $eleClearBox = $("<div style='clear: both'></div>");

            if (!data.isUploadEle) {
                if (data.isPreview) {
                    $($eleLayoutContainer, $elePreview).on("click", function (e) {
                        if ($.inArray(data.fileType, officeLib) < 0 && $.inArray(data.fileType, imgType) < 0 && $.inArray(data.fileType, aviType) < 0) {
                            alert("未知的文件类型，暂不支持预览！");
                            return;
                        }
                        if (!data.src) {
                            alert("预览失败，未获取到文件路径！");
                            return;
                        }
                        previewFile(data);
                    });
                }
            } else {
                $eleLayoutContainer.on("click", function (e) {
                    if (options.uploadFun) eval(options.uploadFun)(addFile);
                });
            }

            $eleImgBox.appendTo($eleLayoutContainer);
            $eleDescBox.appendTo($eleLayoutContainer);
            $eleClearBox.appendTo($eleLayoutContainer);
            $eleLayoutContainer.appendTo($eleBox);
        }

        /**
         * 声明组件状态
         * @param isInit 是否是组件初始化
         * @private
         */
        function _declarationState(isInit) {}

        /**
         * 获取分组信息
         * @return {*|Array}
         */
        function getPreviewPanelParam() {
            return {};
        }
        function previewFile(data) {
            var datas = options.datas;
            var _index = 0;
            var listIntros = [];
            for (var i = 0; i < datas.length; i++) {
                if (datas[i].fileId == data.fileId) {
                    _index = i;
                }
                if (datas[i].isUploadEle) continue;
                listIntros.push(cloneObject(datas[i]));
            }
            var param = {
                listIntros: listIntros,
                index: _index
            };
            window.sendPostMessage(window.top, "Base.FilePreview.initPreviewFile", Ta.util.obj2string(param));
        }

        function cloneObject(obj) {
            var copy = {};
            for (var _i in obj) {
                if (typeof obj[_i] == 'function') {
                    copy[_i] = obj[_i].name;
                    continue;
                }
                copy[_i] = obj[_i];
            }
            return copy;
        }

        function showViewContextMessage($Container, message) {
            var $message = $("<div class='view-message'></div>");
            $message.appendTo($Container);
        }

        function setVisible(isVisiable, isHold) {
            if (isVisiable) {
                $layoutContainer.show().css('visibility', 'visible');
            } else {
                if (isHold) {
                    $layoutContainer.css('visibility', 'hidden');
                } else {
                    $layoutContainer.hide();
                }
            }
        }

        function addFile(data) {
            $uploadEle.hide();
            options.datas.splice(options.datas.length - 1, 0, data);
            var $eleBox = createViewElementBox();
            $eleBox.hide();
            createViewElement($eleBox, options.datas, options.datas.length - 2);
            $eleBox.insertBefore($uploadEle);
            styleCorrection($eleBox);
            $eleBox.fadeIn(400, function () {
                $uploadEle.show();
            });
        }

        function removeFile($ele, id) {
            var data = {};
            for (var i = 0; i < options.datas.length; i++) {
                if (options.datas[i].fileId == id) {
                    data = options.datas[i];
                    var bool = true;
                    if (options.beforeRemoveFun) bool = eval(options.beforeRemoveFun)(data);
                    if (!bool) break;

                    $ele = $ele.parents(".view-ele-box");
                    $ele.off("click");
                    $ele.fadeOut(400, function () {
                        $ele.remove();
                        options.datas.splice(i, 1);
                    });
                    break;
                }
            }
        }

        function removeFileById(id) {
            var $ele = $(".fileview-layout-Container[_field=" + id + "]", $layoutContainer).eq(0);
            removeFile($ele, id);
        }

        function downloadFile(data) {
            var bool = true;
            if (options.beforeDownloadFun) bool = eval(options.beforeDownloadFun)(data);
            if (!bool) return;

            Base.FilePreview.downloadFile(data);
        }

        function downloadFIleById(id) {
            for (var i = 0; i < options.datas.length; i++) {
                if (options.datas[i].fileId == id) {
                    downloadFile(options.datas[i]);
                }
            }
        }

        function getDatas() {
            return options.datas;
        }

        function setDatas(datas) {
            if (typeof datas == 'string') datas = eval(datas);
            if (!$.isArray(datas)) return;
            $layoutContainer.empty();
            options.datas = [].concat(datas || []);;
            init();
        }

        function clear() {
            $layoutContainer.empty();
            options.datas = [];
            init();
            if (options.clearFun) eval(options.clearFun)();
        }

        function getValue() {
            var datas = getDatas();
            for (var i = 0; i < datas.length; i++) {
                if (datas[i].fileId == uploadEle.fileId) {
                    datas.splice(i, 1);
                }
            }
            return datas;
        }

        function setValue(datas) {
            datas = $.isArray(datas) ? datas : [];
            setDatas(datas);
        }

        init(); // 调初始化方法

        $.extend(this, { // 为this对象
            "cmptype": 'TaFileview', // 将方法注册为公共方法
            "version": "1.1.0",
            "setVisible": setVisible,
            "getDatas": getDatas,
            "setDatas": setDatas,
            "setValue": setValue,
            "getValue": getValue,
            "clear": clear,
            "addFile": addFile,
            "downloadFIleById": downloadFIleById,
            "removeFileById": removeFileById
        });
    }

    //继承父类
    TaFileView.prototype = new TaFieldComponent();
    TaFileView.prototype.constructor = TaFileView;
    return TaFileView;
});

/***/ }),

/***/ 531:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});