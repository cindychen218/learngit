/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 202);
/******/ })
/************************************************************************/
/******/ ({

/***/ 0:
/***/ (function(module, exports) {

module.exports = window.$;

/***/ }),

/***/ 13:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(jQuery, $) {

/**
 * 浏览器支持
 * @module jqueryExt
 * @depends jquery
 */
jQuery.browser = {};
jQuery.browser.mozilla = /firefox/.test(navigator.userAgent.toLowerCase());
jQuery.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
jQuery.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
jQuery.browser.msie11 = /rv:11.0/.test(navigator.userAgent.toLowerCase());
jQuery.browser.msie = /msie/.test(navigator.userAgent.toLowerCase()) || jQuery.browser.msie11;
/**
 * 表单提交扩展
 * @module jqueryExt
 * @depends jquery,base
 */
jQuery.fn.extend({
	taserialize: function taserialize(isIncludeNullFields) {
		return jQuery.param(this.taserializeArray(isIncludeNullFields));
	},
	taserializeArray: function taserializeArray(isIncludeNullFields) {
		if (typeof isIncludeNullFields == "undefined" ? Base.globvar.commitNullField === false : isIncludeNullFields === false) //默认提交空参数
			return this.map(function () {
				//如果是输入对象本身
				var isInput = this.tagName && (this.tagName.toLowerCase() == 'input' || this.tagName == "TEXTAREA") ? true : false;
				return this.elements ? jQuery.makeArray(this.elements) : jQuery.makeArray(isInput ? this : $(this).find(':input').get());
			}).filter(function () {
				return this.name && !this.disabled && (this.checked || /^(?:select|textarea)/i.test(this.nodeName) || /^(?:color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i.test(this.type));
			}).map(function (i, elem) {
				var val = jQuery(this).val();
				return val == null || typeof val == 'string' && val.trim() == '' ? null : jQuery.isArray(val) ? jQuery.map(val, function (val, i) {
					return { name: elem.name, value: val.trim().replace(/\r?\n/g, "\r\n") };
				}) : { name: elem.name, value: val.trim().replace(/\r?\n/g, "\r\n") };
			}).get();else return this.map(function () {
			//如果是输入对象本身
			var isInput = this.tagName && (this.tagName.toLowerCase() == 'input' || this.tagName == "TEXTAREA") ? true : false;
			return this.elements ? jQuery.makeArray(this.elements) : jQuery.makeArray(isInput ? this : $(this).find(':input').get());
		}).filter(function () {
			return this.name && !this.disabled && (this.checked || /^(?:select|textarea)/i.test(this.nodeName) || /^(?:color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i.test(this.type));
		}).get();
	}
});
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0), __webpack_require__(0)))

/***/ }),

/***/ 202:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


window.Base = window.Base || {};
//window  依赖crossDomain

__webpack_require__(61);
__webpack_require__(55);
__webpack_require__(203);
__webpack_require__(37);
__webpack_require__(22);

/***/ }),

/***/ 203:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(5)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		Ta: {
			"core": core()
		}
	});

	function core() {
		return {
			"TaUICreater": TaUICreater(),
			"TaUIManager": TaUIManager()
		};
	}

	function TaUIManager() {
		var uis = new Ta.util.Map();
		function register(id, uiObj) {
			if (this.getCmp(id)) {
				alert(Base.I18n.getLangText("taface.module.tauimanager.register.id", id)); //国际化修改，原内容："注意:TaUIManager 里已经注册有id为['+id+']的对象"
			}
			uis.put(id, uiObj);
		}
		/**
   * 获取对象
   */
		function getCmp(id) {
			return uis.get(id);
		}
		/**
   * 移除注册的对象
   */
		function unregister(id) {
			return uis.remove(id);
		}
		/**
   * 所有组件的id
   */
		function keys() {
			return uis.keys();
		}

		function removeObjInCantainer($contaner) {
			var ids = uis.keys();
			if (ids) {
				for (var i = 0; i < ids.length; i++) {
					var _obj = $("#" + ids[i], $contaner)[0];
					if (_obj) {
						var _tempObj = uis.get(ids[i]); //lins 20120821
						if (_tempObj.cmptype == "datagrid") _tempObj.destroy(); //lins 20120821 添加表格销毁
						this.unregister(ids[i]);
					}
				}
			}
		}
		return {
			"register": register,
			"getCmp": getCmp,
			"unregister": unregister,
			"keys": keys,
			"removeObjInCantainer": removeObjInCantainer
		};
	};

	/**
  * 用户标签生成的组件创建代码添加到这个里面去，然后框架在talayout执行后统一调用create方法。
  *标签生成的组件大致如下：
  *
  *Ta.core.TaUICreater.addUI(function(){
  *	var columns = [];
  *  //.......
  *	var grid = new SlickGrid("#mygrid",columns,options);
  *	TaUIManager.register(grid);
  *});
  */
	function TaUICreater() {
		var uiForCreate = [];

		function addUI(fn) {

			if (uiForCreate) uiForCreate.push(fn);
		}
		function removeAllUI() {}
		function create() {
			if (uiForCreate) {
				// for (var i = 0; i < uiForCreate.length; i++){
				// 	if(uiForCreate[i]){
				// 		uiForCreate[i]();
				// 		uiForCreate[i] = null;
				// 	}
				// }
				//change by chenyao  从外层向内层渲染
				for (var i = uiForCreate.length - 1; i >= 0; i--) {
					if (uiForCreate[i]) {
						uiForCreate[i]();
						uiForCreate[i] = null;
					}
				}
			}
		}

		return {
			"create": create,
			"removeAllUI": removeAllUI,
			"addUI": addUI
		};
	};
});

/***/ }),

/***/ 22:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

__webpack_require__(95);
(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(37), __webpack_require__(61), __webpack_require__(55)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {

	__webpack_require__(98);
	$.extend(true, window, {
		TaWindow: TaWindow
	});

	function TaWindow($windowId) {
		var defaults = {
			zIndex: 999999,
			draggable: true,
			resizable: true,
			modal: false,
			// window's property which difference from panel
			title: 'New Window',
			collapsible: true,
			minimizable: true,
			maximizable: true,
			closable: true,
			closed: false
		};
		function taWindow(options, param) {
			if (typeof options == 'string') {
				switch (options) {
					case 'options':
						return $.data($windowId[0], 'window').options;
					case 'window':
						return $.data($windowId[0], 'window').window;
					case 'setTitle':
						return $windowId.each(function () {
							//						$(this).ta3panel('setTitle', param);
							new TaPanel($(this)).ta3panel('setTitle', param);
						});
					case 'open':
						return $windowId.each(function () {
							//						$(this).ta3panel('open', param);
							new TaPanel($(this)).ta3panel('open', param);
						});
					case 'close':
						return $windowId.each(function () {
							//						$(this).ta3panel('close', param);
							new TaPanel($(this)).ta3panel('close', param);
						});
					case 'destroy':
						return $windowId.each(function () {
							//						$(this).ta3panel('destroy', param);
							new TaPanel($(this)).ta3panel('destroy', param);
						});
					case 'refresh':
						return $windowId.each(function () {
							//						$(this).ta3panel('refresh');
							new TaPanel($(this)).ta3panel('refresh');
						});
					case 'resize':
						return $windowId.each(function () {
							//						$(this).ta3panel('resize', param);
							new TaPanel($(this)).ta3panel('resize', param);
						});
					case 'move':
						return $windowId.each(function () {
							//						$(this).ta3panel('move', param);
							new TaPanel($(this)).ta3panel('move', param);
						});
					case 'maximize':
						return $windowId.each(function () {
							//						$(this).ta3panel('maximize');
							new TaPanel($(this)).ta3panel('maximize');
						});
					case 'minimize':
						return $windowId.each(function () {
							//						$(this).ta3panel('minimize');
							new TaPanel($(this)).ta3panel('minimize');
						});
					case 'restore':
						return $windowId.each(function () {
							//						$(this).ta3panel('restore');
							new TaPanel($(this)).ta3panel('restore');
						});
					case 'collapse':
						return $windowId.each(function () {
							//						$(this).ta3panel('collapse', param);
							new TaPanel($(this)).ta3panel('collapse', param);
						});
					case 'expand':
						return $windowId.each(function () {
							//						$(this).ta3panel('expand', param);
							new TaPanel.ta3panel('expand', param);
						});
				}
			}

			options = options || {};
			return $windowId.each(function () {
				init(this, options);
				setProperties(this);
			});
		}

		function setSize(target, param) {
			//			$(target).ta3panel('resize');
			new TaPanel($(target)).ta3panel('resize');
		}

		/**
   * create and initialize window, the window is created based on panel component
   */
		function init(target, options) {
			var state = $.data(target, 'window');
			var opts;
			if (state) {
				opts = $.extend(state.opts, options);
			} else {
				var t = $(target);
				opts = $.extend({}, defaults, {
					title: t.attr('title'),
					collapsible: t.attr('collapsible') ? t.attr('collapsible') == 'true' : undefined,
					minimizable: t.attr('minimizable') ? t.attr('minimizable') == 'true' : undefined,
					maximizable: t.attr('maximizable') ? t.attr('maximizable') == 'true' : undefined,
					closable: t.attr('closable') ? t.attr('closable') == 'true' : undefined,
					closed: t.attr('closed') ? t.attr('closed') == 'true' : undefined,
					modal: t.attr('modal') ? t.attr('modal') == 'true' : undefined,
					//add by cy openwindow 添加最大最小宽高
					maxheight: undefined,
					minheight: undefined,
					maxwidth: undefined,
					minwidth: undefined
				}, options);
				//liys add 弹出框宽度增加百分比配置，兼容屏幕分辨率
				if (opts.width && isNaN(opts.width)) {
					if (opts.width.lastIndexOf("%") == opts.width.length - 1) {
						var tem = opts.width.substring(0, opts.width.length - 1);
						if (!isNaN(tem)) {
							tem = tem / 100;
						}
						opts.width = Math.ceil(getPageArea().width * tem);
						//add by cy 添加最大高度最大宽度,最小高度,最小宽度属性
						if (opts.maxwidth && opts.maxwidth > 0) {
							opts.width = opts.width > opts.maxwidth ? opts.maxwidth : opts.width;
						}
						if (opts.minWidth && opts.minWidth > 0) {
							opts.width = opts.width < opts.minWidth ? opts.minWidth : opts.width;
						}
					}
				}
				//liys add 弹出框高度增加百分比配置，兼容屏幕分辨率
				if (opts.height && isNaN(opts.height)) {
					if (opts.height.lastIndexOf("%") == opts.height.length - 1) {
						var tem = opts.height.substring(0, opts.height.length - 1);
						if (!isNaN(tem)) {
							tem = tem / 100;
						}
						opts.height = Math.ceil(getPageArea().height * tem);
						//add by cy 添加最大高度最大宽度,最小高度,最小宽度属性
						if (opts.maxheight && opts.maxheight > 0) {
							opts.height = opts.height > opts.maxheight ? opts.maxheight : opts.height;
						}
						if (opts.minheight && opts.minheight > 0) {
							opts.height = opts.height < opts.minheight ? opts.minheight : opts.height;
						}
					}
				}
				if (opts.border) {
					//add by cy
					opts.width = opts.width - 2;
					opts.height = opts.height - 2;
				}
				$(target).attr('title', '');
				state = $.data(target, 'window', {});
			}

			// create window
			//			var win = $(target).ta3panel($.extend({}, opts, {
			var win = new TaPanel($(target)).ta3panel($.extend({}, opts, {
				border: true,
				doSize: true, // size the panel, the property undefined in window component
				closed: true, // close the panel
				cls: 'window',
				headerCls: 'window-header',
				bodyCls: 'window-body',
				onBeforeDestroy: function onBeforeDestroy() {
					if (opts.onBeforeDestroy) {
						if (opts.onBeforeDestroy.call(target) == false) return false;
					}
					var state = $.data(target, 'window');
					if (state.mask) state.mask.remove();
				},
				onClose: function onClose() {
					var state = $.data(target, 'window');
					if (state.mask) state.mask.hide();

					if (opts.onClose) opts.onClose.call(target);
				},
				onOpen: function onOpen() {
					var state = $.data(target, 'window');
					var z_index = state.opts.zIndex || defaults.zIndex;
					if (state.mask) {
						state.mask.css({
							display: 'block',
							zIndex: z_index++
						});
					}
					state.window.css('z-index', z_index++);
					//					if (state.mask) state.mask.show();
					//add by cy 直接弹出tawindow框时表格不会重新布局导致页面混乱
					$(target).find(".datagrid").each(function () {
						$(this).triggerHandler("_resize");
					});

					if (opts.onOpen) opts.onOpen.call(target);
				},
				onResize: function onResize(width, height) {
					var state = $.data(target, 'window');
					if (opts.onResize) opts.onResize.call(target, width, height);
				},
				onMove: function onMove(left, top) {
					var state = $.data(target, 'window');
					if (opts.onMove) opts.onMove.call(target, left, top);
				},
				onMinimize: function onMinimize() {
					var state = $.data(target, 'window');
					if (state.mask) state.mask.hide();

					if (opts.onMinimize) opts.onMinimize.call(target);
				},
				onBeforeCollapse: function onBeforeCollapse() {
					if (opts.onBeforeCollapse) {
						if (opts.onBeforeCollapse.call(target) == false) return false;
					}
					var state = $.data(target, 'window');
				},
				onExpand: function onExpand() {
					var state = $.data(target, 'window');
					if (opts.onExpand) opts.onExpand.call(target);
				}
			}));

			var panel = new TaPanel(win);
			// save the window state
			//state.options = win.ta3panel('options');
			state.options = panel.ta3panel('options');
			state.opts = opts;
			//state.window = win.ta3panel('panel');
			state.window = panel.ta3panel('panel');

			// create mask
			if (state.mask) state.mask.remove();
			if (opts.modal == true) {
				state.mask = $('<div class="window-mask"></div>').appendTo('body');
				////modify by cy 蒙层显示优化,蒙层铺满body可以只通过css就可以控制
				state.mask.css({
					display: 'none'
				});
			}

			// if require center the window
			if (state.options.left == null) {
				var width = state.options.width;
				if (state.opts.border) {
					//add by cy
					width = width + 2;
				}
				if (isNaN(width)) {
					width = state.window.outerWidth(true);
				}
				state.options.left = ($(window).width() - width) / 2 + $(document).scrollLeft();
			}
			if (state.options.top == null) {
				var height = state.window.height();
				if (state.opts.border) {
					//add by cy
					height = height + 2;
				}
				if (isNaN(height)) {
					height = state.window.outerHeight(true);
				}
				state.options.top = ($(window).height() - height) / 2 + $(document).scrollTop();
			}

			win.each(function () {
				new TaPanel($(this)).ta3panel('move');
			});
			if (state.opts.closed == false) {
				win.each(function () {
					//					$(this).ta3panel('open');
					new TaPanel($(this)).ta3panel('open');
				});
			}
		}

		/**
   * set window drag and resize property
   */
		function setProperties(target) {
			var state = $.data(target, 'window');

			//state.window.draggable({
			new TaDraggable(state.window).draggable({
				handle: '>div.panel-header>div.panel-title',
				disabled: state.options.draggable == false,
				onStartDrag: function onStartDrag(e) {
					if (state.mask) state.mask.css('z-index', defaults.zIndex++);
					state.window.css('z-index', defaults.zIndex++);

					if (!state.proxy) {
						state.proxy = $('<div class="window-proxy"></div>').insertAfter(state.window);
					}
					state.proxy.css({
						display: 'none',
						zIndex: defaults.zIndex++,
						left: e.data.left,
						top: e.data.top,
						width: $.boxModel == true ? state.window.outerWidth(true) - (state.proxy.outerWidth(true) - state.proxy.width()) : state.window.outerWidth(true),
						height: $.boxModel == true ? state.window.outerHeight(true) - (state.proxy.outerHeight(true) - state.proxy.height()) : state.window.outerHeight(true)
					});
					setTimeout(function () {
						if (state.proxy) state.proxy.show();
					}, 500);
				},
				onDrag: function onDrag(e) {
					state.proxy.css({
						display: 'block',
						left: e.data.left,
						top: e.data.top
					});
					state.window.css({
						display: 'none'
					});

					return false;
				},
				onStopDrag: function onStopDrag(e) {
					if (e.data.left < 0) e.data.left = 0;
					if (e.data.top < 0) e.data.top = 0;
					if ($(window).height() - e.data.top < 30) e.data.top = $(window).height() - 30;
					if ($(window).width() - e.data.left < 60) e.data.left = $(window).width() - 60;
					state.options.left = e.data.left;
					state.options.top = e.data.top;
					//$(target).window('move');
					new TaWindow($(target)).window('move');
					state.proxy.remove();
					state.proxy = null;
					state.window.css({
						display: 'block'
					});
					//如果window被选中需要触发事件，要在这里添加
				}
			});

			//state.window.resizable({
			new TaResizable(state.window).resizable({
				disabled: state.options.resizable == false,
				onStartResize: function onStartResize(e) {
					if (!state.proxy) {
						state.proxy = $('<div class="window-proxy"></div>').insertAfter(state.window);
					}
					state.proxy.css({
						zIndex: defaults.zIndex++,
						left: e.data.left,
						top: e.data.top,
						width: $.boxModel == true ? e.data.width - (state.proxy.outerWidth(true) - state.proxy.width()) : e.data.width,
						height: $.boxModel == true ? e.data.height - (state.proxy.outerHeight(true) - state.proxy.height()) : e.data.height
					});
				},
				onResize: function onResize(e) {
					state.proxy.css({
						left: e.data.left,
						top: e.data.top,
						width: $.boxModel == true ? e.data.width - (state.proxy.outerWidth(true) - state.proxy.width()) : e.data.width,
						height: $.boxModel == true ? e.data.height - (state.proxy.outerHeight(true) - state.proxy.height()) : e.data.height
					});
					return false;
				},
				onStopResize: function onStopResize(e) {
					state.options.left = e.data.left;
					state.options.top = e.data.top;
					state.options.width = e.data.width;
					state.options.height = e.data.height;
					setSize(target);
					state.proxy.remove();
					state.proxy = null;
				}
			});
		}

		function getPageArea() {
			if (document.compatMode == 'BackCompat') {
				if (document.body.className.indexOf("no-scrollbar") < 0) {
					//判断body是否有滚动条  yanglq
					return {
						width: Math.max(document.body.scrollWidth, document.body.clientWidth),
						height: Math.max(document.body.scrollHeight, document.body.clientHeight)
					};
				} else {
					return {
						width: Math.max(document.body.offsetHeight, document.body.clientWidth),
						height: Math.max(document.body.offsetHeight, document.body.clientHeight)
					};
				}
			} else {
				if (document.body.className.indexOf("no-scrollbar") < 0) {
					return {
						width: Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth),
						height: Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight)
					};
				} else {
					return {
						width: Math.max(document.documentElement.offsetHeight, document.documentElement.clientWidth),
						height: Math.max(document.documentElement.offsetHeight, document.documentElement.clientHeight)
					};
				}
			}
		}

		// when window resize, reset the width and height of the window's mask
		//modify by cy 蒙层显示优化,蒙层铺满body可以只通过css就可以控制
		//$(window).resize(function(){
		//$('.window-mask').css({
		//	width: $(window).width(),
		//	height: $(window).height()
		//});
		//setTimeout(function(){
		//	$('.window-mask').css({
		//		width: getPageArea().width,
		//		height: getPageArea().height
		//	});
		//}, 50);
		//});
		$.extend(this, { // 为this对象
			"cmptype": 'window', // 将方法注册为公共方法
			"version": "3.13.0",
			"window": taWindow
		});
	}
	return TaWindow;
});

/***/ }),

/***/ 28:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(62)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {
    $.extend(true, window, {
        TaContainer: TaContainer,

        TaContainerSupport: {
            setReadOnly: taSetReadOnly,
            setEnable: taSetEnable,
            setVisible: taSetVisible,
            setRequired: taSetRequired,
            resetData: taResetData,
            clearData: taClearData,
            doValidate: taDoValidate,
            cleanValidateStyle: taCleanValidateStyle
        }
    });
    function TaContainer() {

        return {
            newSerialize: taSerialize

            // return $.extend(true, {
            //        newSerialize: taSerialize
            //    },window.TaContainerSupport);

        };function taSerialize(id, isIncludeNullFields) {
            var str = "";
            //children
            $("#" + id).find(":input").not(":button").not(".ComponentsSerialize").not($("div.datagrid").find(":input")).not("").each(function () {
                var id = this.getAttribute("realId") || this.id;
                if (id == "") return true;
                var obj = Base.getObj(id);
                if (obj == null) obj = this;
                if ("newSerialize" in obj) {
                    if (str == "") str += obj.newSerialize(this.id, isIncludeNullFields);else str += "&" + obj.newSerialize(this.id, isIncludeNullFields);
                } else {
                    if (str == "") str += $("#" + this.id).taserialize(isIncludeNullFields);else str += "&" + $("#" + this.id).taserialize(isIncludeNullFields);
                }
            });
            //datagrid
            $("#" + id).find("div.datagrid").each(function () {
                var obj = Base.getObj(this.id);
                if (str == "") str += obj.newSerialize(this.id, isIncludeNullFields);else str += "&" + obj.newSerialize(this.id, isIncludeNullFields);
            });
            return str;
        }
    }

    function taSetReadOnly(id, isReadOnly) {
        if (isReadOnly == null) isReadOnly = true;
        var $taObj = $("#" + id);
        if ($taObj) {
            var _doReadOnly = function _doReadOnly(obj) {
                $(obj).attr('readOnly', isReadOnly);
            };

            $taObj.attr('readOnly', isReadOnly);
            $taObj.find(":input[type!=hidden]").not(".datagrid :input").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj == null) {
                    _doReadOnly(this);
                } else if (obj.setReadOnly) {
                    obj.setReadOnly(isReadOnly);
                } else {
                    _doReadOnly(obj);
                }
            });
        }
    }
    function taSetEnable(id, enable) {
        if (enable == null) enable = true;
        var $taObj = $("#" + id);
        if ($taObj) {
            var _doEnable = function _doEnable(obj) {
                if (enable) {
                    $(obj).removeAttr('disabled');
                    $(obj).removeAttr('readOnly');
                    $(obj).show();
                } else {
                    $(obj).attr('disabled', 'disabled');
                }
            };

            if (enable) {
                $taObj.removeAttr('disabled');
                $taObj.removeAttr('readOnly');
                if (!$taObj.parent().hasClass("tabs-panels")) //yanglq 防止tab enable后，非当前页显示
                    $taObj.show();
            } else {
                //modify by xp 容器上不能放置disabled属性，IE下容器中的Input会继承容器的disabled属性,造成组件disabled行为异常
                //$taObj.attr('disabled','disabled');
                //$taObj.addClass('disabled');
            }
            $taObj.find(":input[type!=hidden],button").not(".datagrid :input").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj == null) {
                    _doEnable(this);
                } else if (obj.setEnable) {
                    if (obj.setReadOnly) obj.setReadOnly(!enable);
                    obj.setEnable(enable);
                } else {
                    _doEnable(obj);
                }
            });
        }
    }

    function taSetVisible(id, isVisiable, isHold) {
        var isShowObj = $("#" + id);
        if (isShowObj) {
            if (isVisiable) {
                isShowObj.show().css('visibility', 'visible');
            } else {
                if (isHold) {
                    isShowObj.css("visibility", "hidden");
                } else {
                    isShowObj.hide();
                }
            }
        }
    }

    function taSetRequired(id, isRequired) {
        var $taObj = $("#" + id);
        if ($taObj) {
            var _doRequired = function _doRequired(obj) {
                if (isRequired) {
                    $(obj).attr('required', 'required');
                } else {
                    $(obj).removeAttr('required');
                }
            };

            $taObj.find(":input[type!=hidden],.checkboxgroup-layout-Container,.radiogroup-layout-Container").not(".datagrid :input,:checkbox,:radio").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj == null) {
                    _doRequired(this);
                } else if (obj.cmptype && obj.setRequired) {
                    obj.setRequired(isRequired);
                } else {
                    _doRequired(obj);
                }
            });
        }
    }

    function taResetData(id) {
        var $taObj = $("#" + id);
        if ($taObj) {
            var _doReset = function _doReset(obj) {
                //解决chrome下隐藏的输入框defaultValue无效的问题
                if (obj.type != "hidden") {
                    obj.value = obj.defaultValue;
                    if (obj.type == "radio" || obj.type == "checkbox") obj.checked = obj.defaultChecked;
                } else {
                    if (navigator.userAgent.indexOf("Chrome") > -1) {
                        obj.value = '';
                    }
                }
            };

            $taObj.find(":input").not(".datagrid :input").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj == null) {
                    _doReset(this);
                } else if (obj.cmptype && obj.reset) {
                    obj.reset();
                } else {
                    _doReset(obj);
                }
            });
        }
    }

    function taClearData(id) {
        var $taObj = $("#" + id);
        if ($taObj) {
            var _doClear = function _doClear(obj) {
                if ($(obj).is(':radio') || $(obj).is(':checkbox')) {
                    $(obj).attr("checked", false);
                } else {
                    $(obj).val('');
                }
            };

            $taObj.find(":input").not(".datagrid :input").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj == null) {
                    _doClear(this);
                } else if (obj.cmptype && obj.setValue) {
                    obj.setValue('');
                } else {
                    _doClear(obj);
                }
            });
        }
    }

    function taDoValidate(id, isHiddenValid, isReadOnlyValid) {
        var $taObj = $("#" + id);
        isReadOnlyValid = isReadOnlyValid === false ? false : true;
        if ($taObj) {
            var validateResult = true;
            $taObj.find(":input[type!=hidden],.checkboxgroup-layout-Container,.radiogroup-layout-Container").not(".datagrid :input,:checkbox,:radio").each(function () {
                var a = this.getAttribute("realid") || this.id;
                var obj = Base.getObj(a);
                if (obj && obj.cmptype && obj.doValidate) {
                    if (typeof obj.getInput == "function") {
                        var input = obj.getInput();

                        if (input.attr('disabled') == true || input.attr('disabled') == 'disabled' || !isHiddenValid && input.is(':hidden') || input.attr('readOnly') == 'readonly' && !isReadOnlyValid) return true;
                    }
                    if (obj.cmptype == "tacheckboxGroup" && (!isHiddenValid && $("#" + a).is(':hidden') || !isReadOnlyValid && $("#" + a).find("input[type=checkbox]")[0].readOnly)) {
                        return true;
                    }
                    if (obj.doValidate() !== true && validateResult === true) {
                        validateResult = a;
                    }
                }
            });
            return validateResult;
        }
    }

    function taCleanValidateStyle(id) {
        var $taObj = $("#" + id);
        if ($taObj) {
            $taObj.find(":input").not(".datagrid :input").each(function () {
                var a = this.realId || this.id;
                var obj = Base.getObj(a);
                if (obj && obj.cmptype && obj.setValidateStyle) {
                    obj.setValidateStyle();
                }
            });
        }
        Bubble.hideInfo(); //清除泡泡
    }

    return TaContainer;
});

/***/ }),

/***/ 36:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(13)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {

    /**
     * 原代码，三板，modify by xp
     * 支持跨域请求函数调用
     * 支持请求结果回调
     */
    //初始化接收消息方法
    if (!window.postMessageListener) window.postMessageListener = function () {
        if (window.attachEvent) {
            window.attachEvent("onmessage", analysisPostMessage);
        } else {
            window.addEventListener("message", analysisPostMessage, true);
        }
    };

    //消息解析
    if (!window.analysisPostMessage) //放置多次声明，多次事件触发
        window.analysisPostMessage = function (e) {
            var obj = e.data; //消息字符串结构:消息头 分隔字符串 消息体
            //有消息分隔字符串的才解析,消息分隔字符串为:|cross-domain|
            if (typeof obj != "string" || obj.indexOf("|cross-domain|") == -1) {
                return;
            }
            var message = obj.split("|cross-domain|");
            var messageHead = message[0]; //消息头,暂无意义
            var messageBody = message[1]; //消息体,请求必须为json格式的字符串,反馈消息则为请求调用函数的结果的json格式字符串
            var callMessage = eval("(" + messageBody + ")");
            //如果是请求消息
            if (messageHead.indexOf("call") != -1) {
                try {
                    var callFun = eval(callMessage.callFun); //消息请求的函数
                    var arg = callMessage.arg || [];
                    if (typeof arg == "string") {
                        arg = arg.split(";");
                    }
                    if (!$.isArray(arg)) {
                        arg = [arg];
                    }
                    if (typeof callFun != "function") {
                        return;
                    } //请求的函数不存在
                    var resultArg = callFun.apply(callFun, arg); //请求执行
                    var callBack = callMessage.callBackFun; //是否反馈结果
                    if (callBack) {
                        sendPostMessage(e.source, callBack, resultArg);
                    }
                } catch (e) {}
            }
        };

    /**
     * 主动发送广播消息
     * target string（iframe控件的ID）/object（iframe window,eq:如果是想父页面发送消息,则传window.parent）
     * callFun string 要访问目标iframe的方法名
     * arg string 要访问目标iframe的方法的参数,用;隔开
     * callBackFun 消息反馈时调用的方法名
     */
    if (!window.sendPostMessage) window.sendPostMessage = function (target, callFun, arg, callBackFun) {
        try {
            var source;
            if (typeof target == "string") {
                source = document.getElementById(target).contentWindow;
            } else if ((typeof target === "undefined" ? "undefined" : _typeof(target)) == "object" && target != null) {
                source = target;
            } else {
                source = window.top;
            }
            var callMessage = {};
            callMessage["callFun"] = callFun;
            callMessage["arg"] = arg || "";
            callMessage["callBackFun"] = callBackFun;
            var msgStr = "call|cross-domain|" + Ta.util.obj2string(callMessage);
            source.postMessage(msgStr, "*");
        } catch (e) {}
    };
    //注册消息接收器
    postMessageListener();
});

/***/ }),

/***/ 37:
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;__webpack_require__(92);
__webpack_require__(93);
(function(factory){
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0),__webpack_require__(13),__webpack_require__(28)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
}(function($){

	__webpack_require__(94);
	$.extend(true, window, {
		TaPanel : TaPanel
	});

	function TaPanel($panelId){
		var defaults = {
			title: null,
			iconCls: null,
			width: 'auto',
			height: 'auto',
			left: null,
			top: null,
			cls: null,
			headerCls: null,
			bodyCls: null,
			style: {},
			cache: true,
			fit: false,
			border: true,
			doSize: true,	// true to set size and do layout
			noheader: false,
			content: null,	// the body content if specified

			collapsible: false,
			minimizable: false,
			maximizable: false,
			closable: false,
			collapsed: false,
			minimized: false,
			maximized: false,
			closed: false,

			// custom tools, every tool can contain two properties: iconCls and handler
			// iconCls is a icon CSS class
			// handler is a function, which will be run when tool button is clicked
			tools: [],

			href: null,
			loadingMessage: 'Loading...',
			onLoad: function(){},
			onBeforeOpen: function(){},
			onOpen: function(){},
			onBeforeClose: function(){},
			onClose: function(){},
			onBeforeDestroy: function(){},
			onDestroy: function(){},
			onResize: function(width,height){},
			onMove: function(left,top){},
			onMaximize: function(){},
			onRestore: function(){},
			onMinimize: function(){},
			onBeforeCollapse: function(){},
			onBeforeExpand: function(){},
			onCollapse: function(){},
			onExpand: function(){}
		};
		function ta3panel(options, param){
			if (typeof options == 'string'){
				switch(options){
					case 'options':
						return $.data($panelId[0], 'panel').options;
					case 'panel':
						return $.data($panelId[0], 'panel').panel;
					case 'header':
						return $.data($panelId[0], 'panel').panel.find('>div.panel-header');
					case 'body':
						return $.data($panelId[0], 'panel').panel.find('>div.panel-body');
					case 'setTitle':
						return $panelId.each(function(){
							setTitle(this, param);
						});
					case 'open':
						return $panelId.each(function(){
							openPanel(this, param);
						});
					case 'close':
						return $panelId.each(function(){
							closePanel(this, param);
						});
					case 'destroy':
						return $panelId.each(function(){
							destroyPanel(this, param);
						});
					case 'refresh':
						return $panelId.each(function(){
							$.data(this, 'panel').isLoaded = false;
							loadData(this);
						});
					case 'resize':
						return $panelId.each(function(){
							setSize(this, param);
						});
					case 'move':
						return $panelId.each(function(){
							movePanel(this, param);
						});
					case 'maximize':
						return this.each(function(){
							maximizePanel(this);
						});
					case 'minimize':
						return $panelId.each(function(){
							minimizePanel(this);
						});
					case 'restore':
						return $panelId.each(function(){
							restorePanel(this);
						});
					case 'collapse':
						return $panelId.each(function(){
							collapsePanel(this, param);	// param: boolean,indicate animate or not
						});
					case 'expand':
						return $panelId.each(function(){
							expandPanel(this, param);	// param: boolean,indicate animate or not
						});
				}
			}
			options = options || {};
			return $panelId.each(function(){
				var state = $.data(this, 'panel');
				var opts;
				if (state){
					opts = $.extend(state.options, options);
				} else {
					var t = $(this);
					opts = $.extend({}, defaults, {
						width: (parseInt(t.width()) || undefined),
						height: (parseInt(t.height()) || undefined),
						left: (parseInt(t.css('left')) || undefined),
						top: (parseInt(t.css('top')) || undefined),
						title: t.attr('title'),
						iconCls: t.attr('icon'),
						cls: t.attr('cls'),
						headerCls: t.attr('headerCls'),
						bodyCls: t.attr('bodyCls'),
						href: t.attr('href'),
						cache: (t.attr('cache') ? t.attr('cache') == 'true' : undefined),
						fit: (t.attr('fit') ? t.attr('fit') == 'true' : undefined),
						border: (t.attr('border') ? t.attr('border') == 'true' : undefined),
						noheader: (t.attr('noheader') ? t.attr('noheader') == 'true' : undefined),
						collapsible: (t.attr('collapsible') ? t.attr('collapsible') == 'true' : undefined),
						minimizable: (t.attr('minimizable') ? t.attr('minimizable') == 'true' : undefined),
						maximizable: (t.attr('maximizable') ? t.attr('maximizable') == 'true' : undefined),
						closable: (t.attr('closable') ? t.attr('closable') == 'true' : undefined),
						collapsed: (t.attr('collapsed') ? t.attr('collapsed') == 'true' : undefined),
						minimized: (t.attr('minimized') ? t.attr('minimized') == 'true' : undefined),
						maximized: (t.attr('maximized') ? t.attr('maximized') == 'true' : undefined),
						closed: (t.attr('closed') ? t.attr('closed') == 'true' : undefined)
					}, options);
					t.attr('title', '');
					state = $.data(this, 'panel', {
						options: opts,
						panel: wrapPanel(this),
						isLoaded: false
					});
				}

				if (opts.content){
					$(this).html(opts.content);
					if ($.parser){
						$.parser.parse(this);
					}
				}

				addHeader(this);
				setBorder(this);
//				loadData(this);

				if (opts.doSize == true){
					state.panel.css('display','block');
					setSize(this);
				}
				if (opts.closed == true){
					state.panel.hide();
				} else {
					openPanel(this);
				}
			});
		}
		function removeNode(node){
			node.each(function(){
				$(this).find("iframe").attr("src","").remove();//modify by xp 在删除元素前先清理重要元素，解决IE下弹出iframe导致焦点丢失的问题
				$(this).remove();
				if ($.browser.msie){
					this.outerHTML = '';
				}
			});
		}

		function setSize(target, param){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			var pheader = panel.find('>div.panel-header');
			var pbody = panel.find('>div.panel-body');

			if (param){
				if (param.width) opts.width = param.width;
				if (param.height) opts.height = param.height;
				if (param.left != null) opts.left = param.left;
				if (param.top != null) opts.top = param.top;
			}

			if (opts.fit == true){
				var p = panel.parent();
				opts.width = p.width();
				panel.hasClass("window") && (opts.width = p.outerWidth());//add by cy 在window的情况下父元素body有padding导致宽度计算不正确
				opts.height = p.height();
				opts.border && (opts.width=opts.width-2,opts.height=opts.height-2);//add by cy
			}

			panel.css({
				left: opts.left,
				top: opts.top
			});
			panel.css(opts.style);
			panel.addClass(opts.cls);
			pheader.addClass(opts.headerCls);
			pbody.addClass(opts.bodyCls);

			if (!isNaN(opts.width)){
				if ($.boxModel == true){
					panel.width(opts.width - (panel.outerWidth(true) - panel.width()));
					pheader.width(panel.width() - (pheader.outerWidth(true) - pheader.width()));
					pbody.width(panel.width() - (pbody.outerWidth(true) - pbody.width()));
				} else {
					panel.width(opts.width);
					pheader.width(panel.width());
					pbody.width(panel.width());
				}
			} else {
				panel.width('auto');
				pbody.width('auto');
			}
			if (!isNaN(opts.height)){
//				var height = opts.height - (panel.outerHeight()-panel.height()) - pheader.outerHeight();
//				if ($.boxModel == true){
//					height -= pbody.outerHeight() - pbody.height();
//				}
//				pbody.height(height);

				if ($.boxModel == true){
					panel.height(opts.height - (panel.outerHeight(true) - panel.height()));
					pbody.height(panel.height() - pheader.outerHeight(true) - (pbody.outerHeight(true) - pbody.height()));
				} else {
					panel.height(opts.height);
					pbody.height(panel.height() - pheader.outerHeight(true));
				}
			} else {
				pbody.height('auto');
			}
			panel.css('height', null);

			opts.onResize.apply(target, [opts.width, opts.height]);

			panel.find('>div.panel-body>div').triggerHandler('_resize');
		}

		function movePanel(target, param){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			if (param){
				if (param.left != null) opts.left = param.left;
				if (param.top != null) opts.top = param.top;
			}
			panel.css({
				left: opts.left,
				top: opts.top
			});
			opts.onMove.apply(target, [opts.left, opts.top]);
		}

		function wrapPanel(target){
			var panel = $(target).addClass('panel-body').wrap('<div class="panel panelnomargin"></div>').parent();
			panel.bind('_resize', function(){
				var opts = $.data(target, 'panel').options;
				if (opts.fit == true){
					setSize(target);
				}
				return false;
			});

			return panel;
		}

		function addHeader(target){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			removeNode(panel.find('>div.panel-header'));
			if (opts.title && !opts.noheader){
				var header = $('<div class="panel-header"><div class="panel-title">'+opts.title+'</div></div>').prependTo(panel);
				if (opts.iconCls){
					header.find('.panel-title').addClass('panel-with-icon');
					$('<div class="panel-icon"></div>').addClass(opts.iconCls).appendTo(header);
				}
				var tool = $('<div class="panel-tool"></div>').appendTo(header);
				if (opts.maximizable){
					$('<div class="panel-tool-max faceIcon icon-maximization" title="放大或缩小"></div>').appendTo(tool).bind('click', onMax);
				}
				if (opts.minimizable){
					$('<div class="panel-tool-min faceIcon icon-minimize" title="最小化"></div>').appendTo(tool).bind('click', onMin);
				}
				if (opts.closable){
					$('<div class="panel-tool-close faceIcon icon-close" title="关闭"></div>').appendTo(tool).bind('click', onClose);
				}
				if (opts.collapsible){
					$('<div class="panel-tool-collapse faceIcon icon-dbArrow_down" title="'+Base.I18n.getLangText("taface.module.panel.collapsible.title")+'"></div>').appendTo(tool).bind('click', onToggle);//国际化修改，原内容："收縮"
				}
				if (opts.tools){
					for(var i=opts.tools.length-1; i>=0; i--){
						var t = $('<div></div>').addClass(opts.tools[i].iconCls).appendTo(tool);
						if (opts.tools[i].handler){
							t.bind('click', eval(opts.tools[i].handler));
						}
					}
				}
				tool.find('div').hover(
					function(){$(this).addClass('panel-tool-over');},
					function(){$(this).removeClass('panel-tool-over');}
				);
				panel.find('>div.panel-body').removeClass('panel-body-noheader');
			} else {
				panel.find('>div.panel-body').addClass('panel-body-noheader');
			}

			function onToggle(){
				if ($(this).hasClass('icon-dbArrow_up')){
					expandPanel(target, true);
				} else {
					collapsePanel(target, true);
				}
				return false;
			}

			function onMin(){
                if ($(this).siblings(".panel-tool-collapse").hasClass("icon-dbArrow_up")){
                    expandPanel(target, true);
                }
                if ($(this).hasClass('icon-restore')){
                    restorePanel(target,true);
                } else {
                    minimizePanel(target);
                }
				return false;
			}

			function onMax(){
                if ($(this).siblings(".panel-tool-collapse").hasClass("icon-dbArrow_up")){
                    expandPanel(target, true);
                }
				if ($(this).hasClass('icon-restore')){
					restorePanel(target);
				} else {
					maximizePanel(target);
				}
				return false;
			}

			function onClose(){
				closePanel(target);
				return false;
			}
		}

		/**
		 * load content from remote site if the href attribute is defined
		 */
		function loadData(target){
			var state = $.data(target, 'panel');
			if (state.options.href && (!state.isLoaded || !state.options.cache)){
				state.isLoaded = false;
				var pbody = state.panel.find('>div.panel-body');
				pbody.html($('<div class="panel-loading"></div>').html(state.options.loadingMessage));
				pbody.load(state.options.href, null, function(){
					//lly add
					// if (typeof require === 'function') {
					// 	require(['domReady'], function (domReady) {
					// 		domReady(function () {
					// 			require(["taLayout"], function(){
					// 				$(pbody).taLayout();
					// 			})
					// 		});
					// 	});
					// } else {//  删除 by  cy 没有使用requirejs 模式了
						$(pbody).taLayout();
					// }
					state.options.onLoad.apply(target, arguments);
					state.isLoaded = true;
				});
			}
		}

		function openPanel(target, forceOpen){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;

			if (forceOpen != true){
				if (opts.onBeforeOpen.call(target) == false) return;
			}
			panel.show();
			opts.closed = false;
			opts.onOpen.call(target);

			if (opts.maximized == true) maximizePanel(target);
			if (opts.minimized == true) minimizePanel(target);
			if (opts.collapsed == true) collapsePanel(target);

			if (!opts.collapsed){
				loadData(target);
			}
		}

		function closePanel(target, forceClose){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;

			if (forceClose != true){
				if (opts.onBeforeClose.call(target) == false) return;
			}
			panel.hide();
			opts.closed = true;
			opts.onClose.call(target);
		}

		function destroyPanel(target, forceDestroy){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;

			if (forceDestroy != true){
				if (opts.onBeforeDestroy.call(target) == false) return;
			}
			removeNode(panel);
			opts.onDestroy.call(target);
		}

		function collapsePanel(target, animate){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			var body = panel.find('>div.panel-body');
            var header = panel.find('>div.panel-header');
            var tool = header.find('.panel-tool-collapse');
			if (tool.hasClass('icon-dbArrow_up'))return;
			body.stop(true, true);	// stop animation
			if (opts.onBeforeCollapse.call(target) == false) return;

            if(header.find(".panel-tool-max").hasClass("icon-restore")){
                $.data(target, 'panel').originalMax = {
                    width: opts.width,
                    height: opts.height,
                    fit: opts.fit
                };
            }else {
                $.data(target, 'panel').original = {
                    width: opts.width,
                    height: opts.height,
                    left: opts.left,
                    top: opts.top,
                    fit: opts.fit
                };
			}

			setSize(target,{width:opts.width,height:40});
			tool.addClass('icon-dbArrow_up').removeClass('icon-dbArrow_down');
			if (animate == true){
				body.slideUp('normal', function(){
					opts.collapsed = true;
					opts.onCollapse.call(target);
				});
			} else {
				body.hide();
				opts.collapsed = true;
				opts.onCollapse.call(target);
			}
		}

		function expandPanel(target, animate){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			var body = panel.find('>div.panel-body');
			var header = panel.find('>div.panel-header');
			var tool = header.find('.panel-tool-collapse');

			if (!tool.hasClass('icon-dbArrow_up')) return;
			body.stop(true, true);	// stop animation
			if (opts.onBeforeExpand.call(target) == false) return;
			tool.addClass('icon-dbArrow_down').removeClass('icon-dbArrow_up');

			if(header.find(".panel-tool-max").hasClass("icon-restore")){
                var original = $.data(target, 'panel').originalMax;
            }else {
                var original = $.data(target, 'panel').original;
            }

			opts.width = original.width;
			opts.height = original.height;
			opts.fit = original.fit;
			if (animate == true){
				body.slideDown('normal', function(){
					opts.collapsed = false;
					opts.onExpand.call(target);
					loadData(target);
					setSize(target);
				});
			} else {
				body.show();
				opts.collapsed = false;
				opts.onExpand.call(target);
				loadData(target);
				setSize(target);
			}
		}

		function maximizePanel(target){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			var header = panel.find('>div.panel-header');
			var toolMax = header.find('.panel-tool-max'),toolMin = header.find('.panel-tool-min');

			if (toolMax.hasClass('icon-restore')) return;
            toolMax.addClass('icon-restore').removeClass('icon-maximization');
            header.removeClass('header-minimize');

            if (toolMin.hasClass('icon-restore')){
                toolMin.addClass('icon-minimize').removeClass('icon-restore');
            }else {
                $.data(target, 'panel').original = {
                    width: opts.width,
                    height: opts.height,
                    left: opts.left,
                    top: opts.top,
                    fit: opts.fit
                };
			}

			opts.left = 0;
			opts.top = 0;
			opts.fit = true;
            opts.style = {
                "marginTop": 0
            };
			setSize(target);
			opts.minimized = false;
			opts.maximized = true;
			$('>div[fit=true],>form[fit=true]',panel.find('>div.panel-body')).triggerHandler('_resize');
			//针对window第一个为panel作为borderlayout的容器的
			$('>div div.l-layout',panel.find('>div.panel-body')).each(function(){
				$(this).triggerHandler('_resize');
			});
			opts.onMaximize.call(target);
		}

		function minimizePanel(target){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
            var header = panel.find('>div.panel-header');
            var toolMax = header.find('.panel-tool-max'),toolMin = header.find('.panel-tool-min');

            if (toolMin.hasClass('icon-restore')) return;
            toolMin.addClass('icon-restore').removeClass('icon-minimize');
            header.addClass('header-minimize');


            if (toolMax.hasClass('icon-restore')){
                toolMax.addClass('icon-maximization').removeClass('icon-restore');
            }else {
                $.data(target, 'panel').original = {
                    width: opts.width,
                    height: opts.height,
                    left: opts.left,
                    top: opts.top,
                    fit: opts.fit
                };
            }
            opts.width = 110;
            opts.height = 40;
            opts.left = 0;
            opts.top = "100%";
            opts.fit = false;
            opts.style = {
                "marginTop": -opts.height
            };
            setSize(target);
			opts.minimized = true;
			opts.maximized = false;
			$('>div[fit=true],>form[fit=true]',panel.find('>div.panel-body')).triggerHandler('_resize');
			//针对window第一个为panel作为borderlayout的容器的
			$('>div div.l-layout',panel.find('>div.panel-body')).each(function(){
				$(this).triggerHandler('_resize');
			});
			opts.onMinimize.call(target);
		}

		function restorePanel(target,Mini){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
            var header = panel.find('>div.panel-header');
            if(Mini){
                var tool = header.find('.panel-tool-min');
                header.removeClass('header-minimize');
                tool.addClass('icon-minimize');
            }else {
                var tool = header.find('.panel-tool-max');
                tool.addClass('icon-maximization');
            }

			if (!tool.hasClass('icon-restore')) return;

			panel.show();
			tool.removeClass('icon-restore');
			var original = $.data(target, 'panel').original;
			opts.width = original.width;
			opts.height = original.height;
			opts.left = original.left;
			opts.top = original.top;
			opts.fit = original.fit;
			setSize(target);
			opts.minimized = false;
			opts.maximized = false;
			$('>div[fit=true],>form[fit=true]',panel.find('>div.panel-body')).triggerHandler('_resize');
			//针对window第一个为panel作为borderlayout的容器的
			$('>div div.l-layout',panel.find('>div.panel-body')).each(function(){
				$(this).triggerHandler('_resize');
			});

			opts.onRestore.call(target);
		}

		function setBorder(target){
			var opts = $.data(target, 'panel').options;
			var panel = $.data(target, 'panel').panel;
			if (opts.border == true){
				panel.find('>div.panel-header').removeClass('panel-header-noborder');
				panel.find('>div.panel-body').removeClass('panel-body-noborder');
			} else {
				panel.find('>div.panel-header').addClass('panel-header-noborder');
				panel.find('>div.panel-body').addClass('panel-body-noborder');
			}
		}

		function setTitle(target, title){
			$.data(target, 'panel').options.title = title;
			$(target).panel('header').find('div.panel-title').html(title);
		}

		$(window).unbind('.panel').bind('resize.panel', function(){
			var layout = $('body.layout');
			if (layout.length){
				layout.layout('resize');
			} else {
				$('body>div.panel').triggerHandler('_resize');
			}
		});
		//init(); 调初始化方法
		$.extend(this, { // 为this对象
			"cmptype" : 'panel',// 将方法注册为公共方法
			"version" : "3.13.0",
			"panel": ta3panel,
			"ta3panel" : ta3panel//兼容以前注册到$.fn.panel = $.fn.ta3panel;
		});
	}
	TaPanel.prototype=new TaContainer();
	TaPanel.prototype.constructor = TaPanel;
	return TaPanel;
}));


/***/ }),

/***/ 5:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(jQuery) {var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

/**
 * Ta+3框架JS工具类，调用方式Ta.util.xxx();
 * @module Ta
 * @class util
 * @static
 */
(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(90)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	__webpack_require__(91);
	$.extend(true, window, {
		Ta: {
			util: util()
		}
	});
	function util() {
		/*针对string的扩展*/
		String.prototype.trim = function () {
			return $.trim(this);
		};
		String.prototype.replaceAll = function (s1, s2) {
			return this.replace(new RegExp(s1, "gm"), s2);
		};
		return {
			//map使用需呀new出来
			"Map": Map,
			"InputPositon": InputPositon(),
			"isDate": isDate,
			"isDateTime": isDateTime,
			"isTime": isTime,
			"getCurDate": getCurDate,
			"getCurDateMonth": getCurDateMonth,
			"getCurDateYear": getCurDateYear,
			"getCurDateTime": getCurDateTime,
			"getCurDateFullTime": getCurDateFullTime,
			"getCurQuarter": getCurQuarter,
			"StringToDate": StringToDate,
			"StringToDateWithFormat": StringToDateWithFormat,
			"dateDiff": dateDiff,
			"getCurIssue": getCurIssue,
			"obj2string": obj2string,
			"moneyFormat": moneyFormat,
			"cnMoneyFormat": cnMoneyFormat,
			"floatAdd": floatAdd,
			"dataSensitive": dataSensitive()
		};
	}
	/**
  * MAP对象，实现MAP功能 接口： size() 获取MAP元素个数 isEmpty() 判断MAP是否为空 clear() 删除MAP所有元素
  * put(key, value) 向MAP中增加元素（key, value) remove(key)
  * 删除指定KEY的元素，成功返回True，失败返回False get(key) 获取指定KEY的元素值VALUE，失败返回NULL
  * element(index) 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
  * containsKey(key) 判断MAP中是否含有指定KEY的元素 containsValue(value) 判断MAP中是否含有指定VALUE的元素
  * values() 获取MAP中所有VALUE的数组（ARRAY） keys() 获取MAP中所有KEY的数组（ARRAY） 例子： var map =
  * new Ta.util.Map(); map.put("key", "value"); var val = map.get("key")
  * @method Map
  */
	function Map() {
		var elements = [];
		// 获取MAP元素个数
		function size() {
			return elements.length;
		}
		// 判断MAP是否为空
		function isEmpty() {
			return elements.length < 1;
		}
		// 删除MAP所有元素
		function clear() {
			elements = [];
		}
		function put(_key, _value) {
			elements.push({
				key: _key,
				value: _value
			});
		}
		// 删除指定KEY的元素，成功返回True，失败返回False
		function remove(_key) {
			var bln = false;
			try {
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].key == _key) {
						elements.splice(i, 1);
						return true;
					}
				}
			} catch (e) {
				bln = false;
			}
			return bln;
		}
		// 获取指定KEY的元素值VALUE，失败返回NULL
		function get(_key) {
			try {
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].key == _key) {
						return elements[i].value;
					}
				}
			} catch (e) {
				return null;
			}
			return null;
		}
		// 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
		function element(_index) {
			if (_index < 0 || _index >= elements.length) {
				return null;
			}
			return elements[_index];
		}
		// 判断MAP中是否含有指定KEY的元素
		function containsKey(_key) {
			var bln = false;
			try {
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].key == _key) {
						bln = true;
					}
				}
			} catch (e) {
				bln = false;
			}
			return bln;
		}
		// 判断MAP中是否含有指定VALUE的元素
		function containsValue(_value) {
			var bln = false;
			try {
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].value == _value) {
						bln = true;
					}
				}
			} catch (e) {
				bln = false;
			}
			return bln;
		}
		// 获取MAP中所有VALUE的数组（ARRAY）
		function values() {
			var arr = [];
			for (var i = 0; i < elements.length; i++) {
				arr.push(elements[i].value);
			}
			return arr;
		}
		// 获取MAP中所有KEY的数组（ARRAY）
		function keys() {
			var arr = [];
			for (var i = 0; i < elements.length; i++) {
				arr.push(elements[i].key);
			}
			return arr;
		}

		return {
			"size": size,
			"isEmpty": isEmpty,
			"clear": clear,
			"put": put,
			"remove": remove,
			"get": get,
			"element": element,
			"containsKey": containsKey,
			"containsValue": containsValue,
			"values": values,
			"keys": keys
		};
	}
	//map end
	/**
  * 判断是否为日期格式。
  * @method isDate
  * @param {String} dateval 目标串
  */
	function isDate(dateval) {
		var arr = [];
		if (dateval.length != 10) return false;

		if (dateval.indexOf("-") != -1) {
			arr = dateval.toString().split("-");
		} else if (dateval.indexOf("/") != -1) {
			arr = dateval.toString().split("/");
		} else {
			return false;
		}
		if (arr.length != 3) return false;

		// var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
		// yyyy-mm-dd || yyyy/mm/dd
		if (arr[0].length == 4) {
			var date = new Date(arr[0], arr[1] - 1, arr[2]);
			if (date.getFullYear() == arr[0] && date.getMonth() == arr[1] - 1 && date.getDate() == arr[2]) {
				return true;
			}
		}
		return false;
	}
	/**
  * 判断是否为日期时间格式。
  * @method isDateTime
  * @param {String} dateval 目标串
  */
	function isDateTime(dateval) {
		if (dateval.length != 19) return false;
		var arr = dateval.split(' ');
		if (!Ta.util.isDate(arr[0])) {
			return false;
		}

		if (!Ta.util.isTime(arr[1])) {
			return false;
		}

		return true;
	}
	/**
  * 判断是否为时间格式。
  * @method isTime
  * @param {String} dateval 目标串
  */
	function isTime(dateval) {
		if (dateval.length != 8) return false;

		var timeReg = /^(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
		return timeReg.test(dateval);
		return true;
	}

	/**
  * 获取当前日期YYYY-MM-DD。
  * @method getCurDate
  */
	function getCurDate() {
		var d = new Date();
		var ret = d.getFullYear() + "-";
		ret += ("00" + (d.getMonth() + 1)).slice(-2) + "-";
		ret += ("00" + d.getDate()).slice(-2);
		return ret;
	}

	/**
  * 获取当前日期YYYY-MM。
  * @method getCurDateMonth
  */
	function getCurDateMonth() {
		var d = new Date();
		var ret = d.getFullYear() + "-";
		ret += ("00" + (d.getMonth() + 1)).slice(-2);
		return ret;
	}
	/**
  * 获取当前时间YYYY-MM-DD HH:MM:SS。
  * @method getCurDateTime
  */
	function getCurDateTime() {
		var d = new Date();
		var ret = d.getFullYear() + "-";
		ret += ("00" + (d.getMonth() + 1)).slice(-2) + "-";
		ret += ("00" + d.getDate()).slice(-2) + " ";
		ret += ("00" + d.getHours()).slice(-2) + ":";
		ret += ("00" + d.getMinutes()).slice(-2) + ":";
		ret += ("00" + d.getSeconds()).slice(-2);
		return ret;
	}
	/**
  * 获取当前时间YYYY-MM-DD HH:MM:SS.sss。
  * @method getCurDateFullTime
  */
	function getCurDateFullTime() {
		var d = new Date();
		var ret = d.getFullYear() + "-";
		ret += ("00" + (d.getMonth() + 1)).slice(-2) + "-";
		ret += ("00" + d.getDate()).slice(-2) + " ";
		ret += ("00" + d.getHours()).slice(-2) + ":";
		ret += ("00" + d.getMinutes()).slice(-2) + ":";
		ret += ("00" + d.getSeconds()).slice(-2) + ".";;
		ret += ("00" + d.getMilliseconds()).slice(-3);
		return ret;
	}
	/**
  * 获取当前季度YYYY年XX季度
  * @method getCurQuarter
  */
	function getCurQuarter() {
		var curDateMonth = getCurDateMonth();
		var ary = curDateMonth.split("-");
		var ret = ary[0] + '年';
		var month = new Number(ary[1]);
		if (month >= 1 && month <= 3) {
			ret += "01季度";
		} else if (month >= 4 && month <= 6) {
			ret += "02季度";
		} else if (month >= 7 && month <= 9) {
			ret += "03季度";
		} else if (month >= 10 && month <= 12) {
			ret += "04季度";
		}
		return ret;
	}
	/**
  * 获取当前期号YYYYMM。
  * @method getCurIssue
  */
	function getCurIssue() {
		var d = new Date();
		var ret = d.getFullYear();
		var month = d.getMonth() + 1;
		if (parseInt(month) < 10) {
			ret += "0" + month;
		} else {
			ret += "" + month;
		}
		return ret;
	}
	/**
  * 获取当前年份YYYY。
  * @method getCurDateYear
  */
	function getCurDateYear() {
		var d = new Date();
		var ret = d.getFullYear();
		return ret;
	}
	/**
  * 时间差计算 返回时间差
  * @method dateDiff
  * @author cy
  */
	function dateDiff(dtStart, dtEnd, strInterval) {

		if (typeof dtEnd == 'string') {
			dtEnd = StringToDate(dtEnd);
		}
		if (typeof dtStart == 'string') {
			dtStart = StringToDate(dtStart);
		}
		if (dtEnd && dtStart) {
			switch (strInterval) {
				case 's':
					return parseInt((dtEnd - dtStart) / 1000);
				case 'n':
					return parseInt((dtEnd - dtStart) / 60000);
				case 'h':
					return parseInt((dtEnd - dtStart) / 3600000);
				case 'd':
					return parseInt((dtEnd - dtStart) / 86400000);
				case 'w':
					return parseInt((dtEnd - dtStart) / (86400000 * 7));
				case 'M':
					return dtEnd.getMonth() + 1 + (dtEnd.getFullYear() - dtStart.getFullYear()) * 12 - (dtStart.getMonth() + 1);
				case 'y':
					return dtEnd.getFullYear() - dtStart.getFullYear();
				default:
					return parseInt((dtEnd - dtStart) / 1000);
			}
		}
		return false;
	}

	/**
  * 字符串转换成日期
  * @method StringToDate
  * @author cy
  */
	function StringToDate(value) {
		if (isDate(value) || isDateTime(value)) {
			value = value.replace(/\-/g, "/");
			var statedate = new Date(value);
			if (statedate != "Invalid Date") {
				return statedate;
			}
		}
		return false;
	}

	/**
  * 格式字符串转换成日期
  * @method StringToDateWithFormat
  * @author xiep
  */
	function StringToDateWithFormat(value, format) {
		var dateRule = [{
			variable: "y",
			length: 4,
			reg: /(yyyy|YYYY)/g
		}, {
			variable: "M",
			length: 2,
			reg: /(MM)/g
		}, {
			variable: "d",
			length: 2,
			reg: /(dd)/g
		}, {
			variable: "h",
			length: 2,
			reg: /(hh|HH)/g
		}, {
			variable: "m",
			length: 2,
			reg: /(mm)/g
		}, {
			variable: "s",
			length: 2,
			reg: /(ss)/g
		}];

		var now = new Date();
		var dateObj = {
			y: now.getFullYear(),
			M: now.getMonth() + 1, //月从0开始？
			d: "01",
			h: "00",
			m: "00",
			s: "00"
		};

		for (var i = 0; i < dateRule.length; i++) {

			if (dateRule[i].reg.test(format)) {
				dateObj[dateRule[i].variable] = value.substring(dateRule[i].reg.lastIndex - dateRule[i].length, dateRule[i].reg.lastIndex);
			}
		}
		//new Date IE11 不支持 new Date("2018-11-11 11:11:11")
		return new Date(dateObj.y + "/" + dateObj.M + "/" + dateObj.d + " " + dateObj.h + ":" + dateObj.m + ":" + dateObj.s);
	}

	function InputPositon() {
		var _style = {};
		function show(elem) {
			var p = getInputPositon(elem);
			var k = elem.value.replace(/[^\x00-\xff]/gmi, 'pp').length; // 将中文转换成pp后再计算长度
			// var k = $.trim(elem.value).length;//liys修改
			if (k == 0) return;
			var s = document.getElementById('__inputcharshow');
			if (!s) {
				var tmp = $('<div id="__inputcharshow" ></div>');
				tmp.appendTo('body');
				s = tmp[0];
			}
			if (p.bottom < 50) {
				if (/msie/.test(navigator.userAgent.toLowerCase())) {
					s.style.top = p.bottom - 20 + 'px';
					s.style.left = p.left + 16 + 'px';
				} else {
					s.style.top = p.bottom - 35 + 'px';
					s.style.left = p.left + 'px';
				}
			} else {
				if (/msie/.test(navigator.userAgent.toLowerCase())) {
					s.style.top = p.bottom + 30 + 'px';
					s.style.left = p.left + 16 + 'px';
				} else {
					s.style.top = p.bottom + 15 + 'px';
					s.style.left = p.left + 'px';
				}
			}
			s.style.display = 'block';
			if (typeof s.innerText == "undefined") s.textContent = k;else s.innerText = k;
		}

		function remove() {
			$("#__inputcharshow").remove();
		}
		/**
   * 获取当前window的top对象方法,放在单点登录跨域直接window.top的问题
   * */
		function getTop() {}
		/**
   * 获取输入光标在页面中的坐标
   * @method getInputPositon
   * @param {HTMLElement} elem
   *            输入框元素
   * @return {Object} 返回left和top,bottom
   */
		function getInputPositon(elem) {
			if (document.selection) {
				// IE Support
				elem.focus();
				// liys修改
				// 获取顶层id=header的元素
				var $topObj = top.$(".top-part");
				var top1 = $topObj.height(); // header高度
				// 获取顶层id=layout1的元素
				var $leftObj = top.$("#left-part");
				var $topPanel = $($leftObj.find('.left-top-part')[0]); // 顶部
				top1 = top1 + $topPanel.height();
				var $showleft = $($leftObj.find('.left-con-part ')[0]); // 左侧显示
				var left1 = $showleft.width();

				var Sel = document.selection.createRange();
				return {
					left: $(document).scrollLeft() + Sel.boundingLeft - left1,
					top: $(document).scrollTop() + Sel.boundingTop - top1,
					bottom: $(document).scrollTop() + Sel.boundingTop + Sel.boundingHeight - top1
					// left: Sel.boundingLeft,
					// top: Sel.boundingTop,
					// bottom: Sel.boundingTop + Sel.boundingHeight
				};
			} else {
				var cloneDiv = '{$clone_div}',
				    cloneLeft = '{$cloneLeft}',
				    cloneFocus = '{$cloneFocus}',
				    cloneRight = '{$cloneRight}';
				var none = '<span style="white-space:pre-wrap;"> </span>';
				var div = elem[cloneDiv] || document.createElement('div'),
				    focus = elem[cloneFocus] || document.createElement('span');
				var text = elem[cloneLeft] || document.createElement('span');
				var offset = _offset(elem),
				    index = _getFocus(elem),
				    focusOffset = {
					left: 0,
					top: 0
				};

				if (!elem[cloneDiv]) {
					elem[cloneDiv] = div, elem[cloneFocus] = focus;
					elem[cloneLeft] = text;
					div.appendChild(text);
					div.appendChild(focus);
					document.body.appendChild(div);
					focus.innerHTML = '|';
					focus.style.cssText = 'display:inline-block;width:0px;overflow:hidden;z-index:-100;word-wrap:break-word;word-break:break-all;';
					div.className = _cloneStyle(elem);
					div.style.cssText = 'visibility:hidden;display:inline-block;position:absolute;z-index:-100;word-wrap:break-word;word-break:break-all;overflow:hidden;';
				};
				div.style.left = _offset(elem).left + "px";
				div.style.top = _offset(elem).top + "px";
				var strTmp = elem.value.substring(0, index).replace(/</g, '<').replace(/>/g, '>').replace(/\n/g, '<br/>').replace(/\s/g, none);
				text.innerHTML = strTmp;

				focus.style.display = 'inline-block';
				try {
					focusOffset = _offset(focus);
				} catch (e) {};
				focus.style.display = 'none';
				return {
					left: focusOffset.left,
					top: focusOffset.top,
					bottom: focusOffset.bottom
				};
			}
		}

		// 克隆元素样式并返回类
		function _cloneStyle(elem, cache) {
			if (!cache && elem['${cloneName}']) return elem['${cloneName}'];
			var className,
			    name,
			    rstyle = /^(number|string)$/;
			var rname = /^(content|outline|outlineWidth)$/; // Opera: content;
			// IE8:outline &&
			var cssText = [],
			    sStyle = elem.style;

			for (name in sStyle) {
				if (!rname.test(name)) {
					var val = _getStyle(elem, name);
					if (val !== '' && rstyle.test(typeof val === "undefined" ? "undefined" : _typeof(val))) {
						// Firefox 4
						name = name.replace(/([A-Z])/g, "-$1").toLowerCase();
						cssText.push(name);
						cssText.push(':');
						cssText.push(val);
						cssText.push(';');
					};
				};
			};
			cssText = cssText.join('');
			elem['${cloneName}'] = className = 'clone' + new Date().getTime();
			_addHeadStyle('.' + className + '{' + cssText + '}');
			return className;
		}

		// 向页头插入样式
		function _addHeadStyle(content) {
			var style = _style[document];
			if (!style) {
				style = _style[document] = document.createElement('style');
				document.getElementsByTagName('head')[0].appendChild(style);
			};
			style.styleSheet && (style.styleSheet.cssText += content) || style.appendChild(document.createTextNode(content));
		}

		// 获取最终样式
		function _getStyle(elem, name) {
			if ('getComputedStyle' in window) {
				return getComputedStyle(elem, null)[name];
			} else {
				return elem.currentStyle[name];
			}
		}
		// 获取光标在文本框的位置
		/**
   * 获取光标在文本框的位置。
   * @method _getFocus
   * @private
   */
		function _getFocus(elem) {
			var index = 0;
			if (document.selection) {
				// IE Support
				elem.focus();
				var Sel = document.selection.createRange();
				if (elem.nodeName === 'TEXTAREA') {
					// textarea
					var Sel2 = Sel.duplicate();
					Sel2.moveToElementText(elem);
					var index = -1;
					while (Sel2.inRange(Sel)) {
						Sel2.moveStart('character');
						index++;
					}
					;
				} else if (elem.nodeName === 'INPUT') {
					// input
					Sel.moveStart('character', -elem.value.length);
					index = Sel.text.length;
				}
			} else if (elem.selectionStart || elem.selectionStart == '0') {
				// Firefox
				// support
				index = elem.selectionStart;
			}
			return index;
		}

		// 获取元素在页面中位置
		function _offset(elem) {
			var box = elem.getBoundingClientRect(),
			    doc = elem.ownerDocument,
			    body = doc.body,
			    docElem = doc.documentElement;
			var clientTop = docElem.clientTop || body.clientTop || 0,
			    clientLeft = docElem.clientLeft || body.clientLeft || 0;
			var top = box.top + (self.pageYOffset || docElem.scrollTop) - clientTop,
			    left = box.left + (self.pageXOffset || docElem.scrollLeft) - clientLeft;
			return {
				left: left,
				top: top,
				right: left + box.width,
				bottom: top + box.height
			};
		}

		return {
			"show": show,
			"remove": remove,
			"getInputPositon": getInputPositon,
			"_cloneStyle": _cloneStyle,
			"_addHeadStyle": _addHeadStyle,
			"_getStyle": _getStyle,
			"_getFocus": _getFocus,
			"_offset": _offset
		};
	}
	/**
  * 将json对象转换为string
  * @method obj2string
  * @param {Object} o json对象
  * @return {string}
  */
	function obj2string(o) {
		if (o == null || o == 'undefined') return null;
		var r = [];
		if (typeof o == "string") return o;

		if ((typeof o === "undefined" ? "undefined" : _typeof(o)) == "object") {
			if (!jQuery.isArray(o)) {
				for (var i in o) {
					if (typeof o[i] == 'string' || typeof o[i] == 'number') {
						if (o[i] != undefined) {
							// r.push("\""+ i + "\":\"" + o[i].toString().replace(/\"/g, "\\\"") + "\"");
							r.push("\"" + i + "\":\"" + o[i].toString().replace(/\\/g, "\\\\").replace(/\"/g, "\\\"") + "\"");
						} else {
							r.push("\"" + i + "\":null");
						}
					} else {
						r.push("\"" + i + "\":" + Ta.util.obj2string(o[i]));
					}
				}

				if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
					r.push("toString:" + o.toString.toString());
				}

				r = "{" + r.join() + "}";
			} else {
				for (var i = 0; i < o.length; i++) {
					r.push(Ta.util.obj2string(o[i]));
				}r = "[" + r.join() + "]";
			}
			return r;
		}
		return o.toString();
	}

	/**
  * 将数字转换为金额显示，每三位逗号隔开
  * @method moneyFormat
  * @param {Number} money 数字
  * @param {Number} decimal 小数位
  * @param {string} symbol 金额前缀，如￥或$
  */
	function moneyFormat(money, decimal, symbol) {
		if (!money || isNaN(money)) return "";
		var num = parseFloat(money);
		num = String(num.toFixed(decimal ? decimal : 0));
		var re = /(-?\d+)(\d{3})/;
		while (re.test(num)) {
			num = num.replace(re, "$1,$2");
		}
		return symbol ? symbol + num : num;
	}

	/**
  * 将数字转换为中文的金额
  * @method cnMoneyFormat
  * @param {Number} money 数字
  */
	function cnMoneyFormat(money) {
		var cnMoney = "零元整";
		var strOutput = "";
		var strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
		money += "00";
		var intPos = money.indexOf('.');
		if (intPos >= 0) {
			money = money.substring(0, intPos) + money.substr(intPos + 1, 2);
		}
		strUnit = strUnit.substr(strUnit.length - money.length);
		for (var i = 0; i < money.length; i++) {
			strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(money.substr(i, 1), 1) + strUnit.substr(i, 1);
		}
		cnMoney = strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元");
		return cnMoney;
	}
	/**
  * 计算两个浮点数相加的结果。
  * @method floatAdd
  * @param {Number} arg1 Number对象
  * @param {Number} arg2 Number对象
  * @return {Number}
  */
	function floatAdd(arg1, arg2) {
		var r1, r2, m;
		try {
			r1 = arg1.toString().split(".")[1].length;
		} catch (e) {
			r1 = 0;
		}
		try {
			r2 = arg2.toString().split(".")[1].length;
		} catch (e) {
			r2 = 0;
		}
		m = Math.pow(10, Math.max(r1, r2));
		return ((arg1 * m + arg2 * m) / m).toFixed(m.toString().length - 1);
	}

	/**
 * 敏感数据处理
  * @return {{format: *, formatWithNum: *}}
  */
	function dataSensitive() {
		var ruleLib = {
			name: {
				indexRule: [{ start: 2, stop: null }],
				reqRule: { srcReq: /^(\w{1})\w*$/, descReq: "$1*" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			idcard: {
				indexRule: [{ start: 4, stop: 14 }],
				reqRule: { srcReq: /^([\d]{3})\d{1,11}(\w*)$/, descReq: "$1********$2" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			date: {
				indexRule: [{ start: 6, stop: 7 }, { start: 9, stop: 10 }],
				reqRule: { srcReq: /^([\d]{4}-)(\w*)$/, descReq: "$1********" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			email: {
				reqRule: { srcReq: /^(\w+([-+.]\w+)*)@(\w+([-.]\w+)*\.\w+([-.]\w+)*)$/, descReq: "****@$3" },
				desensitization: function desensitization(value) {
					return formatWithReq(value, this.reqRule);
				}
			},
			zipcode: {
				indexRule: [{ start: 2, stop: null }],
				reqRule: { srcReq: /^([1-9])[0-9]{1,5}$/, descReq: "$1*****" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			telphone: {
				indexRule: [{ start: 6, stop: null }],
				reqRule: { srcReq: /^([0-9]{3,4})-\d*$/, descReq: "$1-********" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			mobile: {
				indexRule: [{ start: 4, stop: 7 }],
				reqRule: { srcReq: /^(1[3|4|5|7|8][0-9])\d{1,4}(\d*)$/, descReq: "$1****$2" },
				desensitization: function desensitization(value) {
					return formatWithIndex(value, this.indexRule);
				}
			},
			ip: {}
		};

		/**
   *
   * @param type
   * @param value
   * @param trueDigit  是否真实位数，默认true
   * @return {*}
   */
		function format(type, value) {
			if (typeof value == "undefined" || value == null) return "";
			value = value.toString();
			var rule = ruleLib[type];

			return rule.desensitization(value);
		}

		function formatWithReq(value, reqRule) {
			return value.replace(reqRule.srcReq, reqRule.descReq);
		}

		function formatWithIndex(value, indexRule) {
			if (typeof value == "undefined" || value == null) return "";
			value = value.toString();
			var valueLength = value.length;
			var values = value.split("");

			for (var j = 0; j < indexRule.length; j++) {
				var start = indexRule[j].start;
				var stop = indexRule[j].stop;

				if (valueLength < start) {
					continue;
				}

				start = start ? start - 1 : 0;
				stop = stop ? stop - 1 : values.length - 1;

				for (var i = start; i < valueLength && i <= stop; i++) {
					values.splice(i, 1, "*");
				}
			}

			return values.join("");
		}

		// function formatWithNum(value,start,end){
		// 	if(typeof value == "undefined" || value == null)return "";
		//     value = value.toString();
		//     var valueLength = value.length;
		//     if(valueLength < start){
		//         return value;
		//     }
		//
		//     var values = value.split("");
		//
		//     start = start?start-1:0;
		//     end = end?end-1:values.length-1;
		//
		//     for(var i = start;i<valueLength && i < end;i++){
		//         values.splice(i,1,"*");
		//     }
		//
		//     return values.join("");
		// }


		return {
			format: format,
			formatWithReq: formatWithReq,
			formatWithIndex: formatWithIndex
		};
	}
});
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0)))

/***/ }),

/***/ 54:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(jQuery) {var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

/**
 * ajax前后台数据交互方法，调用方式为Base.xxx();
 * @module Base
 * @class taajax
 * @static
 */
(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(5), __webpack_require__(22), __webpack_require__(36)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		Base: core()
	});

	__webpack_require__(96);

	function core() {

		return {
			_enableButtonLayout: _enableButtonLayout,
			showMask: showMask,
			hideMask: hideMask,
			getJson: getJson,
			submit: submit,
			submitForm: submitForm,
			loadValues: loadValues,
			_ajax: _ajax,
			_doSubmitIds: _doSubmitIds,
			_dealdata: _dealdata,
			compareOldData: compareOldData
			/**
    * 设置所有按钮所在面板是否可用
    * @method _enableButtonLayout
    * @private
    * @param {boolean} enable
    */
		};function _enableButtonLayout(enable) {
			if (enable) {
				$("div.panel-button,div.button-panel,div.panel-toolbar").each(function () {
					//$(this).attr('disabled','disabled');
					$("<div class='enableButtonLayout' style='top:" + $(this).offset().top + "px;left:" + $(this).offset().left + "px;height:" + $(this).outerHeight(true) + "px;width:" + $(this).outerWidth(true) + "px'></div>").appendTo($('body'));
				});
				Base.globvar.isSubmitNow = true;
			} else {
				Base.hideMask();
			}
		}
		/**
   * 让某一个面板出现半透明蒙层，提示：读取中
   * @method showMask
   * @param {String} id  面板的id，如果不传或null就是整个页面
   * @param {Boolean} showLoading  是否显示loading的图片和文字，默认为true，如果设置为false不显示图片和文字
   */
		function showMask(id, showLoading) {
			/*var height = $(window).height(),width = $(window).width(),top=0,left=0;*/
			var height = document.body.scrollHeight,
			    width = document.body.scrollWidth,
			    top = 0,
			    left = 0;
			var obj;
			if (id && (obj = document.getElementById(id))) {
				var $obj = $(obj);
				height = $obj.height();
				width = $obj.width();
				top = $obj.offset().top;
				left = $obj.offset().left;

				if ($obj.hasClass('panel') && $('>div.panel-header', $obj).length > 0) {
					top += $('>div.panel-header', $obj).outerHeight(true);
					height -= $('>div.panel-header', $obj).outerHeight(true);
				} else if (obj.tagName.toLowerCase() == 'fieldset') {
					top += 22;
					height -= 5;
					width += 18;
				}
			}
			var loadding = "";
			if (!(showLoading === false)) {
				//i18n:读取中...
				loadding = "<div style='left:" + ((width - left) / 2 - 20) + "px;top:" + ((height - top) / 2 + 10) + "px;width:60px;height:30px;opacity:1;position: absolute;font-size:12px'>" + Base.I18n.getLangText('taface.module.taajax.loading') + "</div>";
			}

			$("<div class='enableButtonLayout " + (showLoading === false ? "" : "loading") + "' style='top:" + top + "px;left:" + left + "px;height:" + height + "px;width:" + width + "px'>" + loadding + "</div>").appendTo($('body'));
		}
		/**
   * 隐藏蒙层
   * @method hideMask
   */
		function hideMask() {
			$("body >div.enableButtonLayout").remove();
			Base.globvar.isSubmitNow = false;
		}
		/**
   * 同步或异步到后台获取返回json格式的内容，默认同步执行
   * @method getJson
   * @param {String} url action地址
   * @param {Object} parameter 入参 json格式对象，例如:{"dto['aac001']":"1000001","dto['aac002']":"01"}
   * @param {Function} callback 返回成功后的回调，入参返回的为json对象和XMLHttpRequest对象，
   *							这里不需要success为true标志，只要后台成功返回json格式的数据都会回调,
   *							<br>例如：function(data){var dataArray = eval(data.fieldData.datalist);},
   *							<br>其中，data为后台返回的数据，datalist是你在action中绑定的id(setData('datalist',obj)),
   *							<br>dataArray是一个数组,访问方式为：dataArray[1].aac003.
   *							<br>注意:action中也可以setList('grid1',list),但不建议在此使用。
   *
   * @param {boolean} async 设置是否异步，默认为false同步
   * @return 返回的json对象
   <br>1.当action中以setData('','')返回时，此对象的调用方式和callback里的方式一样
   <br>2.当action中以writeJsonToClient(obj)返回时，此对象为一个数组。
   */
		function getJson(url, parameter, callback, async, isJsonp) {
			var ret;
			url = url.indexOf('?') == -1 ? url + "?_r=" + Math.random() : url + "&_r=" + Math.random();
			url += "&___businessId=" + Base.globvar.currentMenuId;
			Base._ajax({
				url: url,
				"type": 'POST',
				data: parameter,
				success: function success(data) {
					if ((typeof data === "undefined" ? "undefined" : _typeof(data)) == "object" && !$.isArray(data) && !$.isEmptyObject(data) && typeof data != "string") {
						var tempData = data.fieldData,
						    newData = {};
						for (var i in tempData) {
							if (i.indexOf("_sel_") == 0) {
								newData[i.substring(5)] = tempData[i];
							} else {
								newData[i] = tempData[i];
							}
						}
						data.fieldData = newData;
					}
					ret = data;
					if (typeof callback == "function") {
						callback(data);
					}
				},
				async: async === true ? true : false,
				//dataType:'json'
				dataType: isJsonp == "true" ? 'jsonp' : 'json' //aolei change 2016-12-16 跨域访问支持
			});
			return ret;
		}
		/**
   * 异步提交表单，action必须返回JSON或者null，此方法不能用于页面跳转，通常用于返回表格数据
   * <br>能够自动校验表单
   * <br>能够对后台返回的json进行自动处理。
   * <br> 处理如下：
   * <br>  1、有消息自动提示（根据不同类型提示不同类型的提示框）
   * <br>  2、如果有返回自由格式的内容自动给页面对应的输入对象赋值
   * <br>  3、如果有列表的值，自动给所有列表更新列表内容
   * <br>  4、如果有对表单输入对象或按钮的控制内容，自动根据数据进行控制
   * <br>  5、如果有校验不通过的自动设置不通过的输入对象为校验失败的样式，同时第一个元素获取焦点。
   * <br>  6、如果有设置焦点的数据，自动给数据对应的对象获取焦点。
   * @method submit
   * @param {String} submitIds  需要传递到后台的对象id或容器id,多个id可以用”,“隔开
   * @param {String} url 提交的地址
   * @param {Object/String} parameter 入参 json格式对象，例如:{"dto['aac001']":"1000001","dto['aac002']":"01"}
   * @param {Function} onSubmit 提交前手动检查，如果返回false将不再提交,必须返回true或false
   * @param {Boolean} autoValidate 默认true 是否自动调用Base.validateForm对ids对象进行校验，如果校验失败将不再提交
   * @param {Function} succCallback callback 返回业务成功后的回调，入参返回的为json对象和XMLHttpRequest对象
   <br>例如：function(data){alert(data.lists.grid2.list[0].aac003)}，
   <br>其中data为返回的json数据，grid2是在action中绑定的id(setList('grid2',list))，通常是jsp中datagrid的id.
   * @param {Function} failCallback  业务失败回调，入参返回的为json对象和XMLHttpRequest对象
   * @param {Boolean} isHiddenValid 隐藏框是否验证，默认false 不验证
   * @param {Boolean} isReadOnlyValid 只读框是否验证，默认true 要验证
   */
		function submit(submitIds, url, parameter, onSubmit, autoValidate, _succCallback, _failCallback, isIncludeNullFields, token, isJsonp, isHiddenValid, isReadOnlyValid) {
			if (token == null) token = true;
			autoValidate = autoValidate === false ? false : true;
			isHiddenValid = isHiddenValid === true ? true : false;
			isReadOnlyValid = isReadOnlyValid === false ? false : true;
			if (onSubmit && !onSubmit() || autoValidate && !Base.validateData(submitIds, true, isHiddenValid, isReadOnlyValid)) {
				Base.hideMask();
				return false;
			}
			//在300毫秒以内不显示蒙层
			Base._enableButtonLayout(false);
			var showMaskTime = setTimeout(function () {
				Base.showMask("body");
			}, 300);
			submitIds = submitIds ? submitIds : "";
			var aids = submitIds.split(',');

			var queryStr = _doSubmitIds(aids, parameter, isIncludeNullFields, token);
			//控制参数异常时取消请求
			if (queryStr === false) {
				clearTimeout(showMaskTime);
				Base.hideMask();
				return false;
			}
			//			if(false){//如果是文件上传
			//				var form = Base.getObj(submitIds);
			//				if(aids.length==1 && form && form.tagName=='FORM'){
			//					$(form).attr('action',url);
			//					$(form).attr("enctype","multipart/form-data");
			//					form.submit();
			//				}else{
			//					if(Base.globvar.developMode)alert('文件上传只能传入唯一的form元素id');
			//				}
			//			}else{

			//Base.getHandleStatus
			//根据ids拼接传递的条件字符串
			if (queryStr == "") {
				queryStr += "___businessId=" + Base.globvar.currentMenuId;
			} else {
				queryStr += "&___businessId=" + Base.globvar.currentMenuId;
			}
			Base._ajax({
				"url": url,
				"data": queryStr,
				"succCallback": function succCallback(data, dataType) {
					//data.replaceAll("%0D%0A","\r\n");
					clearTimeout(showMaskTime);
					Base._dealdata(data);
					Base.hideMask();
					if (_succCallback) _succCallback(data, dataType);
					Base._enableButtonLayout(false);
				},
				"failCallback": function failCallback(data, dataType) {
					//data.replaceAll("%0D%0A","\r\n");
					clearTimeout(showMaskTime);
					Base._dealdata(data);
					Base.hideMask();
					if (_failCallback) _failCallback(data, dataType);
					Base._enableButtonLayout(false);
				},
				"type": 'POST'
				//,
				//"async":(async===false?false:true)

				//,"dataType":"json"
				, "dataType": isJsonp == true ? "jsonp" : "json" //aolei change 2016-12-16 跨域访问支持
			});
			//			}
		}
		/**
   * 同步提交form。
   * 主要用途，表单提交后要刷新整个页面或跳转到其他页面的时候以及需要使用文件上传功能的时候使用
   * @method submitForm
   * @param {String} formId form表单的id ,<b>必传</b>
   * @param {Function} onSubmit 提交前执行的函数，如果返回false就不在继续提交表单
   * @param {Boolean} autoValidate 是否对表单进行自动校验，默认为true。
   * @param {String} url 提交的url,如果不传，请在form标签里面的aciton属性填写。
   * @param {String} parameter 参数json格式{"dto['aac001']":"1000001","dto['aac002']":"01"}。
   * @param {Boolean} isHiddenValid 隐藏框是否验证，默认false 不验证
   * @param {Boolean} isReadOnlyValid 只读框是否验证，默认true 要验证
   */
		function submitForm(formId, onSubmit, autoValidate, url, parameter, isHiddenValid, isReadOnlyValid) {
			Base.showMask();
			autoValidate = autoValidate === false ? false : true;
			isHiddenValid = isHiddenValid === true ? true : false;
			isReadOnlyValid = isReadOnlyValid === false ? false : true;
			//2017-3-16 lanyc修改  显式声明form
			var form = null;
			if (formId) {
				form = document.getElementById(formId);
			} else {
				alert(Base.I18n.getLangText('taface.module.taajax.checkInfo.formidisnull')); //i18n:传入formId为空
				return false;
			}
			if (!form) {
				alert(Base.I18n.getLangText('taface.module.taajax.checkInfo.formisnotexist')); //i18n:找不到需要提交的form元素
				return false;
			}
			if (onSubmit && !onSubmit() || autoValidate && !Base.validateData(formId, true, isHiddenValid, isReadOnlyValid)) {
				Base.hideMask();
				return false;
			}
			if (parameter) {
				url += "?" + jQuery.param(parameter);
			}
			if (url.indexOf('?') == -1) {
				url += "?___businessId=" + Base.globvar.currentMenuId;
			} else {
				url += "&___businessId=" + Base.globvar.currentMenuId;
			}
			//2017-3-16 lanyc修改  增加var修饰符
			var $form = $(form);
			if (url) {
				//ie8不识别form.action
				$form.attr("action", url);
			}
			$("div.datagrid").each(function () {
				var gridId = $(this).attr('id');
				if (!document.getElementById(gridId + '_selected')) {
					$form.append("<input type=\"hidden\" id=\"" + gridId + "_selected\" name=\"gridInfo['" + gridId + "_selected']\"/>");
					document.getElementById(gridId + '_selected').value = Ta.util.obj2string(Base.getGridSelectedRows(gridId));
				} else {
					document.getElementById(gridId + '_selected').value = Ta.util.obj2string(Base.getGridSelectedRows(gridId));
				}

				if (!document.getElementById(gridId + '_modified')) $form.append("<input type=\"hidden\" id=\"" + gridId + "_modified\" name=\"gridInfo['" + gridId + "_modified']\" value=\"" + Ta.util.obj2string(Base.getGridModifiedRows(gridId)) + "\"/>");else document.getElementById(gridId + '_modified').value = Ta.util.obj2string(Base.getGridModifiedRows(gridId));
				if (!document.getElementById(gridId + '_removed')) $form.append("<input type=\"hidden\" id=\"" + gridId + "_removed\" name=\"gridInfo['" + gridId + "_removed']\" value=\"" + Ta.util.obj2string(Base.getGridRemovedRows(gridId)) + "\"/>");else document.getElementById(gridId + '_removed').value = Ta.util.obj2string(Base.getGridRemovedRows(gridId));

				if (!document.getElementById(gridId + '_added')) $form.append("<input type=\"hidden\" id=\"" + gridId + "_added\" name=\"gridInfo['" + gridId + "_added']\" value=\"" + Ta.util.obj2string(Base.getGridAddedRows(gridId)) + "\"/>");else document.getElementById(gridId + '_added').value = Ta.util.obj2string(Base.getGridAddedRows(gridId));
			});
			//			var $tempSubmit = null;
			//			if ($("#__submitkey__").val() != undefined) {
			//				var $form = $(form);
			//				var value = $("#__submitkey__").val();
			//				$tempSubmit = $("<input type=\"hidden\" " + "value=\"" + value + "\"" + "name=\"__submitkey__\"/>");
			//				$form.append($tempSubmit);
			//			}
			form.submit();

			//			if ($tempSubmit != null) {
			//				$tempSubmit.remove();
			//			}
		}
		/**
   * 根据某些输入表单的值获取页面数据
   * 对返回数据的处理如submitform。
   * @method loadValues
   * @private
   * @param {String/Array} submitids 指定作为参数的输入对象的id或name，如果多个请传入输入,如:["aac001","aac002"]
   * 								   框架会自动获取这些输入对象的值作为参数传递过去。 可以为空。
   * @param {Object} parameter 手工传入参数 json格式对象，例如:{"dto['aac001']":"1000001","dto['aac002']":"01"}
   * @param {Function} succCallback 返回业务成功后的回调，入参返回的为json对象和XMLHttpRequest对象
   * @param {Function} failCallbackak  业务失败或系统异常失败回调，入参XMLHttpRequest对象
   * @param {boolean} async async 设置是否异步，默认为true
   * @deprecated
   */
		function loadValues(submitids, url, parameter, succCallback, failCallback, async) {}

		/**
   * 异步或同步交互
   * options["succCallback"] 返回的数据里面有success=true  被调用
   * options["failCallback"] 返回的数据里面有success=false  被调用
   * 其他配置选项与jQuery.ajax一样
   * @param {object} options jQuery.ajax的配置项
   */
		//var tempajax = $.ajax;
		function _ajax(options) {

			//			url,parameter,succCallback,failCallback,type,async
			var _options = options;
			if (!_options["url"]) {
				throw Base.I18n.getLangText('taface.module.taajax.checkInfo.urlisnull'); //i18n:必须传入URL参数.
			}
			//将url中的中文转换成utf-8
			_options["url"] = encodeURI(_options["url"]);
			var error = false; //http错误
			var _data = null,
			    dataType = ""; //返回的数据
			var succCallback = options["succCallback"],
			    failCallback = options["failCallback"];
			delete _options["succCallback"];
			delete _options["failCallback"];

			_options["complete"] = function (_XMLHTTPRequest, textStatus) {
				Base._enableButtonLayout(false);
				if (_XMLHTTPRequest && _XMLHTTPRequest.getResponseHeader) {
					if (_XMLHTTPRequest.getResponseHeader('__timeout')) {
						alert(Base.I18n.getLangText('taface.module.taajax.account.__timeout')); //i18n:操作提示：会话已经超时，请重新登录！
						sendPostMessage(window.top, "logout");
						return;
					}
					if (_XMLHTTPRequest.getResponseHeader('__forbidden')) {
						Base.alert(Base.I18n.getLangText('taface.module.taajax.account.__forbidden', this.url)); //i18n:帐号在其他地方登录，您已被迫下线！
						return;
					}
					if (_XMLHTTPRequest.getResponseHeader('__exception')) {
						Base._dealdata(eval("(" + _XMLHTTPRequest.responseText + ")"));
						return;
					}
					if (_XMLHTTPRequest.getResponseHeader('__samelogin')) {
						alert(Base.I18n.getLangText('taface.module.taajax.account.__samelogin')); //i18n:系统访问权限提示：你目前没有权限访问：xxx
						top.location.href = 'index.jsp?randId=' + parseInt(1000 * Math.random());
						return;
					}
				}
				if (error) {
					//异常
					/*if(textStatus==="parsererror"){//jquery解析错误
      alert(['返回的数据格式不满足json格式，解析错误:\n',_data].join(','));
      }else{
      alert(['执行发生异常,可能网络连接失败'].join(','))
      }*/
					var data = {};
					try {
						data = JSON.parse(_data);
					} catch (err) {}
					var msg = data.msg;
					var developMode = Base.globvar.developMode;
					if (developMode) {
						if (data.errorDetail) {
							//详细信息 查看详情
							var flag = Base.globvar.isOpenErrorDetail;
							if ("true" == flag) {
								msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\">[" + Base.I18n.getLangText('taface.module.taajax.errorInfo.viewdetail') + "]</a></div><div id='_expwinerrmsg' style='display:none'><hr>" + data.errorDetail + "</div>";
							} else {
								msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\"></div>";
							}
						}
					}
					if (msg) Base.alert(msg, 'error');
				} else {
					if (_data) {
						if (_data.success || typeof _data === 'string') {
							//业务成功success==true或返回的是字符串
							if (succCallback) succCallback.call(this, _data, dataType);
						} else if (_data.success != undefined && _data.success.toString().toLowerCase() == "false") {
							//业务失败
							if (failCallback) failCallback.call(this, _data, dataType);
						} else {//TODO 其他类型的返回

						}
					}
				}
			};
			var success = _options["success"];
			_options["success"] = success ? function (data, statusText) {
				_data = data;
				success(data, statusText);
			} : function (data, statusText) {
				_data = data;
			};
			_options["error"] = function (_XMLHTTPRequest, errmsg, exception) {
				//errmsg需要处理timeout/parseerror情况
				//其他异常不特殊告诉，直接显示
				_data = _XMLHTTPRequest.responseText;
				error = true;
			};
			_options["dataFilter"] = function (data, type) {
				dataType = type;
				return data;
			};
			_options["beforeSend"] = function (_XMLHTTPRequest) {
				//确保post的时候不会乱码
				_XMLHTTPRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
				return true;
			};
			if (_options["dataType"] == "jsonp") {
				_options["jsonp"] = "callbackparam";
				_options["jsonpCallback"] = "jsonpCallback";
			}
			jQuery.ajax(_options);
			//tempajax(_options);
		}
		////////////提取方法
		function _doSubmitIds(aids, parameter, isIncludeNullFields, token) {
			var queryStr = "";
			for (var i = 0; i < aids.length - 1; i++) {
				if (aids[i] == null || aids[i] == '') continue;
				for (var j = i + 1; j < aids.length; j++) {
					//对ids进行校验，不能父子嵌套
					if (aids[j] == null || aids[j] == '') continue;
					if (i != j) {
						//找到其他对象
						if ($("#" + aids[i]).has($("#" + aids[j])).length > 0) {
							alert(Base.I18n.getLangText('taface.module.general.checkInfo.IdMutexCheck', aids[j], aids[i])); //i18n:aids[j]+"对象在"+aids[i]+"对象里面，指定提交的元素id不能有包含与被包含关系
							return false;
						}
						if ($("#" + aids[j]).has($("#" + aids[i])).length > 0) {
							alert(Base.I18n.getLangText('taface.module.general.checkInfo.IdMutexCheck', aids[i], aids[j])); //i18n:aids[i]+"对象在"+aids[j]+"对象里面，指定提交的元素id不能有包含与被包含关系
							return false;
						}
					}
				}
			}
			if (aids) {
				for (var i = 0; i < aids.length; i++) {
					if (aids[i] == null || aids[i] == '') continue;
					var obj = Base.getObj(aids[i]);
					if (obj == undefined) continue;
					if ("newSerialize" in obj) {
						if (queryStr == "") queryStr += obj.newSerialize(aids[i], isIncludeNullFields);else queryStr += "&" + obj.newSerialize(aids[i], isIncludeNullFields);
					} else {

						//modify by xp 处理表格分页信息重复提交的问题;需要处理自己；需要不处理type=hidden 输入框，该类型输入框由组件自己实现newSerialize 实现
						$("#" + aids[i]).find(":input").add("#" + aids[i] + ":input").not(".ComponentsSerialize").not(":button").not(".datagrid :input").not("").each(function () {
							if (this.id == "") return true; //跳到下一个循环
							var obj = null;
							if (this.getAttribute("realId")) {
								//change by cy 使用realid判定是否是有隐藏框等
								obj = Base.getObj(this.getAttribute("realId"));
							} else {
								obj = Base.getObj(this.id);
							}
							if (obj == null) obj = this;
							if ("newSerialize" in obj) {
								if (queryStr == "") queryStr += obj.newSerialize(this.id, isIncludeNullFields);else queryStr += "&" + obj.newSerialize(this.id, isIncludeNullFields);
							} else {
								if (queryStr == "") queryStr += $("#" + this.id).taserialize(isIncludeNullFields);else queryStr += "&" + $("#" + this.id).taserialize(isIncludeNullFields);
							}
						});

						//add by xp  处理panel、box等未注册容器...提交时，无表格变动信息的问题
						//datagrid add modify edit delete...
						$(obj).find("div.datagrid").each(function () {
							var _obj = Base.getObj(this.id);
							if (queryStr == "") queryStr += _obj.newSerialize(this.id, isIncludeNullFields);else queryStr += "&" + _obj.newSerialize(this.id, isIncludeNullFields);
						});
					}
				}
			}
			//传表格隐藏信息（主要是分页信息）
			$("div.datagrid").each(function () {
				var _flag = true;
				for (var i = 0; i < aids.length; i++) {
					if (aids[i] && aids[i] != '') {
						if ($("#" + aids[i]).is($(this)) || $("#" + aids[i]).has($(this)).length > 0) {
							_flag = false;
						}
					} else {
						continue;
					}
				}
				//不在adis包含的datagrid
				if (_flag) {
					if (queryStr == "") queryStr = $("input:hidden[name^=gridInfo]", $(this)).taserialize(isIncludeNullFields);else queryStr += "&" + $("input:hidden[name^=gridInfo]", $(this)).taserialize(isIncludeNullFields);
				}
			});
			if (document._dataSubmitStore && document._dataSubmitStore.length > 0) {
				parameter = $.extend(parameter, document._dataSubmitStore[0]);
			}
			//对queryStr处理
			var parameterOld = Base.compareOldData(aids);
			parameter = $.extend(parameter, parameterOld);
			if (parameter) {
				if (queryStr == "") {
					queryStr = jQuery.param(parameter);
				} else {
					queryStr += "&" + jQuery.param(parameter);
				}
			}
			return queryStr;
		}

		function _dealdata(data) {
			//只有json格式的时候才处理
			if ((typeof data === "undefined" ? "undefined" : _typeof(data)) != "object") return;

			//优先处理selectData,modify by zzb
			if (data.selectData) {
				var _lists = data.selectData;
				for (var list in _lists) {
					Base.setSelectInputData(list, _lists[list]);
				}
			}
			//有fieldData数据的时候
			if (data.fieldData) {
				//					var params = {},newData = data.fieldData;
				//					for(var i in newData){
				//						if(i.indexOf("_sel_") == 0){
				//							params[i.substring(5)] = newData[i];
				//						}else{
				//							params[i] = newData[i];
				//						}
				//					}
				Base.setValue(data.fieldData);
				//data.fieldData = params;
			}
			//有validateErrors数据
			if (data.validateErrors) {
				var focus = null,
				    _errors = data.validateErrors;
				for (var fieldId in _errors) {
					if (!focus) focus = fieldId;
					Base.setValidateStyle(fieldId, { message: _errors[fieldId] }, false);
				}
				//如果后台没有设置focus，并且有validateErrors数据的时候就把焦点置于第一个错误的地方
				if (focus && !data.focus) {
					data.focus = focus;
				}
			}
			//有lists数据
			if (data.lists) {
				var _lists = data.lists;
				for (var list in _lists) {
					if (list == "_dataSubmitStore") document._dataSubmitStore = _lists[list];
					if (list == "_oldValueObj") document._oldValueObj = _lists[list]['list'];
					Base._setGridData(list, _lists[list]);
				}
			}

			//有operation数据
			if (data.operation) {
				var _operation = data.operation;
				for (var key in _operation) {
					var types = _operation[key];
					for (var i = 0; i < types.length; i++) {
						var type = types[i];
						switch (type) {
							case 'readonly':
								Base.setReadOnly(key);
								break;
							case 'enable':
								Base.setEnable(key);
								break;
							case 'disabled':
								Base.setDisabled(key);
								break;
							case 'focus':
								Base.selectTab(key);
								break;
							case 'hide':
								Base.hideObj(key);
								break;
							case 'show':
								Base.showObj(key);
								break;
							case 'unvisible':
								Base.hideObj(key, true);
								break;
							case 'resetForm':
								Base.resetData(key);
								break;
							case 'required':
								Base.setRequired(key);
								break;
							case 'disrequired':
								Base.setDisRequired(key);
								break;
						}
					}
				}
				/*for(var i=0;i<_operation.length;i++){
     var op = _operation[i];
     switch(op.type){
     case 'readonly':
     Base.setReadOnly(op.ids);
     break;
     case 'enable':
     Base.setEnable(op.ids);
     break;
     case 'disabled':
     Base.setDisabled(op.ids);
     break;
     case 'select_tab':
     Base.selectTab(op.ids);
     break;
     case 'hide':
     Base.hideObj(op.ids);
     break;
     case 'show':
     Base.showObj(op.ids);
     break;
     case 'unvisible':
     Base.hideObj(op.ids,true);
     break;
     case 'resetForm':
     Base.resetForm(op.ids[0]);
     break;
     case 'required':
     Base.setRequired(op.ids);
     break;
     case 'disrequired':
     Base.setDisRequired(op.ids);
     break;
     }
     }*/
			}
			//有msg
			if (data.msg) {
				var focus = null;
				if (data.focus) {
					focus = function (_fieldId) {
						return function () {
							Base.focus(_fieldId, 100);
						};
					}(data.focus);
				}
				/*var msg = data.msg;
     var developMode = Base.globvar.developMode;
     if(developMode){
     if(data.errorDetail){
     //							msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"$('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body').window({width:600,height:400,title:'详细信息'})\">[查看详细]</a></div><div id='_expwinerrmsg' style='display:none'><hr>"+data.errorDetail+"</div>";
     //aolei modify window 调用方式变了
     msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:'详细信息'})\">[查看详细]</a></div><div id='_expwinerrmsg' style='display:none'><hr>"+data.errorDetail+"</div>";
     }
     }
     Base.alert(msg,data.success?'success':'error',focus);*/
				// 将异步异常的处理逻辑全部放到_options["complete"] 中的error中去
			}
			//jsonp异常处理
			if (data.jsonperror) {
				var msg = data.msg;
				var developMode = Base.globvar.developMode;
				if (developMode) {
					if (data.errorDetail) {
						//详细信息 查看详情
						var flag = Base.globvar.isOpenErrorDetail;
						if ("true" == flag) {
							msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\">[" + Base.I18n.getLangText('taface.module.taajax.errorInfo.viewdetail') + "]</a></div><div id='_expwinerrmsg' style='display:none'><hr>" + data.errorDetail + "</div>";
						} else {
							msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\"></div>";
						}
					}
				}
				if (msg) Base.alert(msg, 'error');
			}
			if (data.resultMessage) {
				var focus = null;
				if (data.focus) {
					focus = function (_fieldId) {
						return function () {
							Base.focus(_fieldId, 100);
						};
					}(data.focus);
				}
				var msg = data.resultMessage.message;
				if (data.errorDetail) {
					//						msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"$('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body').window({width:600,height:400,title:'详细信息'})\">[查看详细]</a></div><div id='_expwinerrmsg' style='display:none'><hr>"+data.errorDetail+"</div>";
					//aolei modify window 调用方式变了
					var flag = Base.globvar.isOpenErrorDetail;
					if ("true" == flag) {
						msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\">[" + Base.I18n.getLangText('taface.module.taajax.errorInfo.viewdetail') + "]</a></div><div id='_expwinerrmsg' style='display:none'><hr>" + data.errorDetail + "</div>";
					} else {
						msg += "&nbsp;&nbsp;&nbsp;<div><a onClick=\"new TaWindow ($('<div style=overflow:auto>'+$('#_expwinerrmsg').html()+'</div>').appendTo('body')).window({width:600,height:400,title:Base.I18n.getLangText('taface.module.taajax.errorInfo.detail')})\"></div>";
					}
					//i18n:详细信息 查看详情
				}
				Base.alert(msg, data.resultMessage.messageType, focus);
			}
			//没有msg，但是有focus
			if (!data.msg && data.focus) {
				Base.focus(data.focus, 50);
			}
			//有topMsg
			if (data.topTipMsg) {
				var topTip = data.topTipMsg;
				Base.msgTopTip(topTip.topMsg, topTip.time, topTip.width, topTip.height);
			} else if (data.topMsg && !data.topTipMsg) {
				Base.msgTopTip(data.topMsg);
			}
		}

		function compareOldData(ids) {
			var submitparam = {};

			if (document._oldValueObj && document._oldValueObj.length > 0) {
				var oldArray = document._oldValueObj;
				for (var i = 0; i < oldArray.length; i++) {
					for (var j = 0; j < ids.length; j++) {
						var $obj = $("#" + ids);
						if (ids[j] == oldArray[i].__id) {
							if ($obj.val() != oldArray[i]["ovDto['" + oldArray[i].__id + "']"]) {
								submitparam = $.extend(submitparam, oldArray[i]);
							}
						} else if ($obj.has(oldArray[i].__id)) {
							if ($("#" + oldArray[i].__id).val() != oldArray[i]["ovDto['" + oldArray[i].__id + "']"]) {
								submitparam = $.extend(submitparam, oldArray[i]);
							}
						}
					}
				}
			} else {
				return {};
			}
			delete submitparam.__id;
			return submitparam;
		}
	}
});
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0)))

/***/ }),

/***/ 55:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		TaResizable: TaResizable
	});

	function TaResizable($resizableId) {
		var defaults = {
			disabled: false,
			handles: 'n, e, s, w, ne, se, sw, nw, all',
			minWidth: 10,
			minHeight: 10,
			maxWidth: 10000, //$(document).width(),
			maxHeight: 10000, //$(document).height(),
			edge: 5,
			onStartResize: function onStartResize(e) {},
			onResize: function onResize(e) {},
			onStopResize: function onStopResize(e) {}
		};

		function resizable(options) {
			function resize(e) {
				var resizeData = e.data;
				var options = $.data(resizeData.target, 'resizable').options;
				if (resizeData.dir.indexOf('e') != -1) {
					var width = resizeData.startWidth + e.pageX - resizeData.startX;
					width = Math.min(Math.max(width, options.minWidth), options.maxWidth);
					resizeData.width = width;
				}
				if (resizeData.dir.indexOf('s') != -1) {
					var height = resizeData.startHeight + e.pageY - resizeData.startY;
					height = Math.min(Math.max(height, options.minHeight), options.maxHeight);
					resizeData.height = height;
				}
				if (resizeData.dir.indexOf('w') != -1) {
					resizeData.width = resizeData.startWidth - e.pageX + resizeData.startX;
					if (resizeData.width >= options.minWidth && resizeData.width <= options.maxWidth) {
						resizeData.left = resizeData.startLeft + e.pageX - resizeData.startX;
					}
				}
				if (resizeData.dir.indexOf('n') != -1) {
					resizeData.height = resizeData.startHeight - e.pageY + resizeData.startY;
					if (resizeData.height >= options.minHeight && resizeData.height <= options.maxHeight) {
						resizeData.top = resizeData.startTop + e.pageY - resizeData.startY;
					}
				}
			}

			function applySize(e) {
				var resizeData = e.data;
				var target = resizeData.target;
				if (document.compatMode == 'CSS1Compat') {
					//$.boxModel == true
					$(target).css({
						width: resizeData.width - resizeData.deltaWidth,
						height: resizeData.height - resizeData.deltaHeight,
						left: resizeData.left,
						top: resizeData.top
					});
				} else {
					$(target).css({
						width: resizeData.width,
						height: resizeData.height,
						left: resizeData.left,
						top: resizeData.top
					});
				}
			}

			function doDown(e) {
				$.data(e.data.target, 'resizable').options.onStartResize.call(e.data.target, e);
				return false;
			}

			function doMove(e) {
				resize(e);
				if ($.data(e.data.target, 'resizable').options.onResize.call(e.data.target, e) != false) {
					applySize(e);
				}
				return false;
			}

			function doUp(e) {
				resize(e);
				applySize(e);
				$(document).unbind('.resizable');
				$.data(e.data.target, 'resizable').options.onStopResize.call(e.data.target, e);
				return false;
			}

			return $resizableId.each(function () {
				var opts = null;
				var state = $.data(this, 'resizable');
				if (state) {
					$(this).unbind('.resizable');
					opts = $.extend(state.options, options || {});
				} else {
					opts = $.extend({}, defaults, options || {});
				}

				if (opts.disabled == true) {
					return;
				}

				$.data(this, 'resizable', {
					options: opts
				});

				var target = this;

				// bind mouse event using namespace resizable
				$(this).bind('mousemove.resizable', onMouseMove).bind('mousedown.resizable', onMouseDown);

				function onMouseMove(e) {
					var dir = getDirection(e);
					if (dir == '') {
						$(target).css('cursor', 'default');
					} else {
						$(target).css('cursor', dir + '-resize');
					}
				}

				function onMouseDown(e) {
					var dir = getDirection(e);
					if (dir == '') return;

					var data = {
						target: this,
						dir: dir,
						startLeft: getCssValue('left'),
						startTop: getCssValue('top'),
						left: getCssValue('left'),
						top: getCssValue('top'),
						startX: e.pageX,
						startY: e.pageY,
						startWidth: $(target).outerWidth(true),
						startHeight: $(target).outerHeight(true),
						width: $(target).outerWidth(true),
						height: $(target).outerHeight(true),
						deltaWidth: $(target).outerWidth(true) - $(target).width(),
						deltaHeight: $(target).outerHeight(true) - $(target).height()
					};
					$(document).bind('mousedown.resizable', data, doDown);
					$(document).bind('mousemove.resizable', data, doMove);
					$(document).bind('mouseup.resizable', data, doUp);
				}

				// get the resize direction
				function getDirection(e) {
					var dir = '';
					var offset = $(target).offset();
					var width = $(target).outerWidth(true);
					var height = $(target).outerHeight(true);
					var edge = opts.edge;
					if (e.pageY > offset.top && e.pageY < offset.top + edge) {
						dir += 'n';
					} else if (e.pageY < offset.top + height && e.pageY > offset.top + height - edge) {
						dir += 's';
					}
					if (e.pageX > offset.left && e.pageX < offset.left + edge) {
						dir += 'w';
					} else if (e.pageX < offset.left + width && e.pageX > offset.left + width - edge) {
						dir += 'e';
					}

					var handles = opts.handles.split(',');
					for (var i = 0; i < handles.length; i++) {
						var handle = handles[i].replace(/(^\s*)|(\s*$)/g, '');
						if (handle == 'all' || handle == dir) {
							return dir;
						}
					}
					return '';
				}

				function getCssValue(css) {
					var val = parseInt($(target).css(css));
					if (isNaN(val)) {
						return 0;
					} else {
						return val;
					}
				}
			});
		}

		//init(); 调初始化方法
		$.extend(this, { // 为this对象
			"cmptype": 'resizable', // 将方法注册为公共方法
			"version": "3.13.0",
			"resizable": resizable
		});
	}
	return TaResizable;
});

/***/ }),

/***/ 60:
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;
(function(factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [ __webpack_require__(0) ], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
}(function($) {
	$.extend(true, window, {
		TaFit : TaFit
	});

	function TaFit($fitId){
		var defaults = {
			fit : false,
			heightDiff : 0
		};
		function tauifitheight(options, param){
			options = options || {};
			return $fitId.each(function() {
				var opts;
				opts = $.extend({}, defaults, {
					fit : ($(this).attr('fit') == 'true' ? true : false),
					heightDiff : ($(this).attr('heightDiff') || 0),
					minWidth : ($(this).attr('minWidth') || 'auto')
				}, options);
				$.data(this, 'fitheight', opts);
				if (opts.fit) {
					fitForm(this);
					var $form = $(this);
					$form.bind('_resize', function(e) {
						fitForm(this);
					});
					if (this.parentNode.tagName.toLowerCase() == 'body') {
						$(window).unbind('.tauifitheight').bind(
							'resize.tauifitheight', function() {
								$form.triggerHandler('_resize');
							});
					}
				}
			});
		}

        /**
		 * 获取布局参数 margin\padding\border\top\left
         * @param selector
         * @param type
         * @returns {Number}
         */
		function getComputedParam(selector,type){
			var h = $(selector).css(type);
			if(h == "auto" || h == "medium")h=0;//兼容处理 IE8 下 margin:auto 时  css 返回auto ;无border 时 css 返回 medium 的情况
            h = parseInt(h);//暂时parseInt 实际框架计算多有地方应该都是parseFloat
            return isNaN(h)?0:h;//NAN 判断处理其他未考虑到的情况（该处理方式不对，应该是将相应规则完善）
		}
		/**
		 * 撑满父容器
		 */
		function fitForm(target) {
			var $form = $(target);
			// XXX 判断容器类型
			var formType = "default";
			if ($form.hasClass('panel') && !$form.hasClass('window')) {
				formType = "panel";
			} else if ($form.hasClass('tabs-container')) {
				formType = "tabs";
			}else if($form.hasClass('verticalTabs')){
				formType = "v_tabs";
			}else if($form.hasClass("search-panel")){
                formType = "search-panel";
            }
			var $formparent = $form.parent();
			h = $formparent.height();
			if ($formparent[0].tagName.toLowerCase() == "body") {
				h = $(window).height();
				h -= getComputedParam('body','paddingBottom');
				h -= getComputedParam('body','marginBottom');
                h -= getComputedParam('body','borderBottomWidth');
				h -= $form.offset().top;
				$form.height(h)
				if (formType == "panel") {
					h -= getComputedParam($form,"marginBottom");
				}
			} else if ($formparent.hasClass('window-body')) {
				var windowTop = $form.offsetParent().offset().top;//change by cy 解决window弹出框内部高度错误
				if(formType == "tabs"){
					h -= ($form.offset().top - windowTop -28);
				}else{
					h -= ($form.offset().top - windowTop);//change by cy
				}
				if (formType == "panel") {
					h += getComputedParam($form,'marginTop');
				}
			} else {
				if (($formparent.css('position') == 'relative'&& formType != "panel")|| $formparent.css('position') == 'absolute') {
					h -= ( $form.offset().top - $formparent.offset().top ) - getComputedParam($formparent,'paddingTop');
					if ($formparent.parent()[0].tagName.toLowerCase() == "body") {
						if(formType == "tabs"){
							h-= getComputedParam('body','paddingTop');
						}
					}
				} else {
					var pall = $form.prevAll(':visible').not('#pageloading,.ez-fl.ez-negmx[fit=true]');//modify by cy 修复同级panel 第二个panel高度错误问题
					if (pall.length > 0) {
						pall.each(function() {
							h -= $(this).outerHeight(true);
						});
					}
					if(formType == "tabs"){
						h -= getComputedParam($formparent,'marginTop');
						h -= getComputedParam($formparent,'marginBottom');
					}

					if (formType == "panel") {
						h -= getComputedParam($form,'marginTop');
						h -= getComputedParam($form,'marginBottom');
					}
					//panel下tabs fit=true 时 多减了padding 暂时注释  change by zhouhy
					//if(formType == "tabs"){
					//	h -= getComputedParam($formparent,'paddingBottom');
					//	h -= getComputedParam($formparent,'paddingTop');
					//}
				}
				if(formType == "default"){
					h -= getComputedParam($formparent,'marginTop');
					h -= getComputedParam($formparent,'marginBottom');
				}
			}
			if (formType == "panel") {
				var $fitContent = $(">div.panel-body", $form);
				if ($fitContent.length == 0) {
					$fitContent = $form;
				} else {
					$fitContent = $($fitContent[0]);
				}
				h -= getComputedParam($fitContent,'paddingTop');
				h -= getComputedParam($fitContent,'paddingBottom');
				h -= getComputedParam($fitContent,'border-top-width');//add by cy 减去上下边框
				h -= getComputedParam($fitContent,'border-bottom-width');

				var hh_ = $(">div.panel-header", $form).outerHeight(true);
				var headerHeight = hh_ ? hh_ : 0;
				var bp_ = $(">div.panel-button", $form).outerHeight(true);
				var bpHeight = bp_ ? bp_  : 0;//change by cy
				var pt_ = $(">div.panel-toolbar", $form).outerHeight(true);
				var ptHeight = pt_ ? pt_ : 0;
				var opts = $.data(target, 'panel');
				h -= opts.heightDiff;
				h -= 1;// 去除边框
				var minHeight = Number($(target).attr('minHeight'));
				if (h - headerHeight - bpHeight - ptHeight < minHeight) {
					$fitContent.height(minHeight - headerHeight - bpHeight- ptHeight);
				} else{
					$fitContent.height(h - headerHeight - bpHeight - ptHeight);
				}
				$('>div:visible[fit=true],>div[fit=true] ,>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]', $fitContent).each(function(){$(this).triggerHandler('_resize');});
				if ($fitContent.hasClass('l-layout'))
					$fitContent.triggerHandler('_resize');// panel直接作为border布局
			} else if(formType == "tabs"){
				h -= getComputedParam($form,'marginBottom');
				var header = $('>div.tabs-header', $form);
				var panels = $('>div.tabs-panels', $form);
				var opts = $.data(target, 'tabs').options;
				h -= header.outerHeight(true);
				h -= opts.heightDiff;
				//tabs里面下边框,所以-1
				panels.outerHeight(h);
				$('>div',panels).each(function(){
					var $this = $(this);
					$this.height(h - getComputedParam($this.parent(), 'paddingTop') - getComputedParam($this.parent(), 'paddingBottom')-1);
					if($this.is(':visible')){
						$.data(this, 'fitstatus', {fit:true});
					}else{
						$.data(this, 'fitstatus', {fit:false});
					}
				});
				//XXX 处理border布局
				$('>div.l-layout:visible',panels).each(function(){$(this).triggerHandler('_resize');});
				$('>div:visible[fit=true],>div:visible>div[fit=true],>div:visible>form[fit=true],>div:visible>div.grid[height],>div:visible>div.ez-fl>div.grid[height]', panels).each(function(){$(this).triggerHandler('_resize');});
				//add by  chenyao  解决初始化的时候嵌套tabs出现滚动条的问问题
				$form.tauitabs("setScrollers");

			}else if(formType=="v_tabs"){//add by chenyao  纵向tab布局
                h -= getComputedParam($form,'paddingTop');
                h -= getComputedParam($form,'paddingBottom');

                h -= getComputedParam($form,'marginBottom');
                h -= getComputedParam($form,'borderTopWidth');
                h -= getComputedParam($form,'borderBottomWidth');
                var opts = $.data(target, 'fitheight');
                h -= opts.heightDiff;
                $form.height(h);
				var v_tb=$form.find(">.v-con>div>div");
				$('>div:visible[fit=true],>div:visible>div[fit=true], >div:visible>form[fit=true],>div:visible>div.grid[height],>div:visible>div.ez-fl>div.grid[height],.tabs-container[fit=true]', v_tb).each(function(){$(this).triggerHandler('_resize');});
			}else if(formType=="search-panel"){
                h -= getComputedParam($form,'paddingTop');
                h -= getComputedParam($form,'paddingBottom');

                h -= getComputedParam($form,'marginBottom');
                h -= getComputedParam($form,'borderTopWidth');
                h -= getComputedParam($form,'borderBottomWidth');
                var opts = $.data(target, 'fitheight');
                h -= opts.heightDiff;
                $form.height(h);
                var header = $('>div.search-insert-con', $form);
                var panel  = $('>div.search-list-con', $form);
                panel.outerHeight(h-header.outerHeight(true));
                $('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]', panel).each(function(){$(this).triggerHandler('_resize');});

            }else {
				h -= getComputedParam($form,'paddingTop');
				h -= getComputedParam($form,'paddingBottom');

				h -= getComputedParam($form,'marginBottom');
				h -= getComputedParam($form,'borderTopWidth');
				h -= getComputedParam($form,'borderBottomWidth');
				var opts = $.data(target, 'fitheight');
				h -= opts.heightDiff;
				$form.height(h);
				if (opts.minWidth != 'auto') {
					if ($form.parent().width() < opts.minWidth) {
						$form.width(opts.minWidth);
					} else {
						$form.width('auto');
					}
				}
				$('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]', $form).each(function(){$(this).triggerHandler('_resize');});
			}
		}

		//init(); 调初始化方法
		$.extend(this, { // 为this对象
			"cmptype" : 'fit',// 将方法注册为公共方法
			"version" : "3.13.0",
			"tauifitheight": tauifitheight,
			"fitForm":fitForm
		});
	}
	return TaFit;
}));

/***/ }),

/***/ 61:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		TaDraggable: TaDraggable
	});

	function TaDraggable($draggableId) {
		var defaults = {
			proxy: null, // 'clone' or a function that will create the proxy object, 
			// the function has the source parameter that indicate the source object dragged.
			revert: false,
			cursor: 'move',
			deltaX: null,
			deltaY: null,
			handle: null,
			disabled: false,
			edge: 0,
			axis: null, // v or h
			onStartDrag: function onStartDrag(e) {},
			onDrag: function onDrag(e) {},
			onStopDrag: function onStopDrag(e) {}
		};

		function draggable(options) {
			if (typeof options == 'string') {
				switch (options) {
					case 'options':
						return $.data($draggableId[0], 'draggable').options;
					case 'proxy':
						return $.data($draggableId[0], 'draggable').proxy;
					case 'enable':
						return $draggableId.each(function () {
							$(this).draggable({ disabled: false });
						});
					case 'disable':
						return $draggableId.each(function () {
							$(this).draggable({ disabled: true });
						});
				}
			}

			return $draggableId.each(function () {
				//				$(this).css('position','absolute');

				var opts;
				var state = $.data(this, 'draggable');
				if (state) {
					state.handle.unbind('.draggable');
					opts = $.extend(state.options, options);
				} else {
					opts = $.extend({}, defaults, options || {});
				}

				if (opts.disabled == true) {
					$(this).css('cursor', 'default');
					return;
				}

				var handle = null;
				if (typeof opts.handle == 'undefined' || opts.handle == null) {
					handle = $(this);
				} else {
					handle = typeof opts.handle == 'string' ? $(opts.handle, this) : handle;
				}
				$.data(this, 'draggable', {
					options: opts,
					handle: handle
				});

				// bind mouse event using event namespace draggable
				if (handle) {
					handle.bind('mousedown.draggable', { target: this }, onMouseDown);
					handle.bind('mousemove.draggable', { target: this }, onMouseMove);
				}

				function onMouseDown(e) {
					if (checkArea(e) == false) return;

					var position = $(e.data.target).position();
					var data = {
						startPosition: $(e.data.target).css('position'),
						startLeft: position.left,
						startTop: position.top,
						left: position.left,
						top: position.top,
						startX: e.pageX,
						startY: e.pageY,
						target: e.data.target,
						parent: $(e.data.target).parent()[0]
					};

					$(document).bind('mousedown.draggable', data, doDown);
					$(document).bind('mousemove.draggable', data, doMove);
					$(document).bind('mouseup.draggable', data, doUp);
				}

				function onMouseMove(e) {
					if (checkArea(e)) {
						$(this).css('cursor', opts.cursor);
					} else {
						$(this).css('cursor', 'default');
					}
				}

				// check if the handle can be dragged
				function checkArea(e) {
					var offset = $(handle).offset();
					var width = $(handle).outerWidth(true);
					var height = $(handle).outerHeight(true);
					var t = e.pageY - offset.top;
					var r = offset.left + width - e.pageX;
					var b = offset.top + height - e.pageY;
					var l = e.pageX - offset.left;

					return Math.min(t, r, b, l) > opts.edge;
				}
			});
		}
		function drag(e) {
			var opts = $.data(e.data.target, 'draggable').options;

			var dragData = e.data;
			var left = dragData.startLeft + e.pageX - dragData.startX;
			var top = dragData.startTop + e.pageY - dragData.startY;

			if (opts.deltaX != null && opts.deltaX != undefined) {
				left = e.pageX + opts.deltaX;
			}
			if (opts.deltaY != null && opts.deltaY != undefined) {
				top = e.pageY + opts.deltaY;
			}

			if (e.data.parnet != document.body) {
				if ($.boxModel == true) {
					left += $(e.data.parent).scrollLeft();
					top += $(e.data.parent).scrollTop();
				}
			}

			if (opts.axis == 'h') {
				dragData.left = left;
			} else if (opts.axis == 'v') {
				dragData.top = top;
			} else {
				dragData.left = left;
				dragData.top = top;
			}
		}

		function applyDrag(e) {
			var opts = $.data(e.data.target, 'draggable').options;
			var proxy = $.data(e.data.target, 'draggable').proxy;
			if (proxy) {
				proxy.css('cursor', opts.cursor);
			} else {
				proxy = $(e.data.target);
				$.data(e.data.target, 'draggable').handle.css('cursor', opts.cursor);
			}
			proxy.css({
				left: e.data.left,
				top: e.data.top
			});
		}

		function doDown(e) {
			var opts = $.data(e.data.target, 'draggable').options;

			var droppables = $('.droppable').filter(function () {
				return e.data.target != this;
			}).filter(function () {
				var accept = $.data(this, 'droppable').options.accept;
				if (accept) {
					return $(accept).filter(function () {
						return this == e.data.target;
					}).length > 0;
				} else {
					return true;
				}
			});
			$.data(e.data.target, 'draggable').droppables = droppables;

			var proxy = $.data(e.data.target, 'draggable').proxy;
			if (!proxy) {
				if (opts.proxy) {
					if (opts.proxy == 'clone') {
						proxy = $(e.data.target).clone().insertAfter(e.data.target);
					} else {
						proxy = opts.proxy.call(e.data.target, e.data.target);
					}
					$.data(e.data.target, 'draggable').proxy = proxy;
				} else {
					proxy = $(e.data.target);
				}
			}

			proxy.css('position', 'absolute');
			drag(e);
			applyDrag(e);

			opts.onStartDrag.call(e.data.target, e);
			return false;
		}

		function doMove(e) {

			drag(e);
			if ($.data(e.data.target, 'draggable').options.onDrag.call(e.data.target, e) != false) {
				applyDrag(e);
			}

			var source = e.data.target;
			$.data(e.data.target, 'draggable').droppables.each(function () {
				var dropObj = $(this);
				var p2 = $(this).offset();
				if (e.pageX > p2.left && e.pageX < p2.left + dropObj.outerWidth(true) && e.pageY > p2.top && e.pageY < p2.top + dropObj.outerHeight(true)) {
					if (!this.entered) {
						$(this).trigger('_dragenter', [source]);
						this.entered = true;
					}
					$(this).trigger('_dragover', [source]);
				} else {
					if (this.entered) {
						$(this).trigger('_dragleave', [source]);
						this.entered = false;
					}
				}
			});

			return false;
		}

		function doUp(e) {
			drag(e);

			var proxy = $.data(e.data.target, 'draggable').proxy;
			var opts = $.data(e.data.target, 'draggable').options;
			if (opts.revert) {
				if (checkDrop() == true) {
					removeProxy();
					$(e.data.target).css({
						position: e.data.startPosition,
						left: e.data.startLeft,
						top: e.data.startTop
					});
				} else {
					if (proxy) {
						proxy.animate({
							left: e.data.startLeft,
							top: e.data.startTop
						}, function () {
							removeProxy();
						});
					} else {
						$(e.data.target).animate({
							left: e.data.startLeft,
							top: e.data.startTop
						}, function () {
							$(e.data.target).css('position', e.data.startPosition);
						});
					}
				}
			} else {
				$(e.data.target).css({
					position: 'absolute',
					left: e.data.left,
					top: e.data.top
				});
				removeProxy();
				checkDrop();
			}

			opts.onStopDrag.call(e.data.target, e);

			function removeProxy() {
				if (proxy) {
					proxy.remove();
				}
				$.data(e.data.target, 'draggable').proxy = null;
			}

			function checkDrop() {
				var dropped = false;
				$.data(e.data.target, 'draggable').droppables.each(function () {
					var dropObj = $(this);
					var p2 = $(this).offset();
					if (e.pageX > p2.left && e.pageX < p2.left + dropObj.outerWidth(true) && e.pageY > p2.top && e.pageY < p2.top + dropObj.outerHeight(true)) {
						if (opts.revert) {
							$(e.data.target).css({
								position: e.data.startPosition,
								left: e.data.startLeft,
								top: e.data.startTop
							});
						}
						$(this).trigger('_drop', [e.data.target]);
						dropped = true;
						this.entered = false;
					}
				});
				return dropped;
			}

			$(document).unbind('.draggable');
			return false;
		}

		$.extend(this, { // 为this对象
			"cmptype": 'draggable', // 将方法注册为公共方法
			"version": "3.13.0",
			"draggable": draggable
		});
	}

	return TaDraggable;
});

/***/ }),

/***/ 62:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)); //依赖
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		TaComponent: TaComponent
	});
	function TaComponent(id, options) {//构造方法
	}
	return TaComponent;
});

/***/ }),

/***/ 71:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(22), __webpack_require__(37)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {

	$.extend(true, window, {
		TaDialog: TaDialog
	});
	__webpack_require__(97);
	function TaDialog($dialogId) {
		var defaults = {
			title: 'New Dialog',
			href: null,
			collapsible: false,
			minimizable: false,
			maximizable: false,
			resizable: false,
			toolbar: null,
			buttons: null,
			buttonsAlgin: null //设置按钮在left，right，center，默认right
		};
		//TODO
		function init() {}
		function dialog(options, param) {
			if (typeof options == 'string') {
				switch (options) {
					case 'options':
						//return $($dialogId[0]).window('options');
						new TaWindow($($dialogId[0])).window('options');
					case 'dialog':
						//return $($dialogId[0]).window('window');
						new TaWindow($($dialogId[0])).window('window');
					case 'setTitle':
						return $dialogId.each(function () {
							//$(this).window('setTitle', param);
							new TaWindow($(this)).window('setTitle', param);
						});
					case 'open':
						return $dialogId.each(function () {
							//$(this).window('open', param);
							new TaWindow($(this)).window('open', param);
						});
					case 'close':
						return $dialogId.each(function () {
							//$(this).window('close', param);
							new TaWindow($(this)).window('close', param);
						});
					case 'destroy':
						return $dialogId.each(function () {
							//$(this).window('destroy', param);
							new TaWindow($(this)).window('destroy', param);
						});
					case 'refresh':
						return $dialogId.each(function () {
							refresh(this);
						});
					case 'resize':
						return $dialogId.each(function () {
							//$(this).window('resize', param);
							new TaWindow($(this)).window('resize', param);
						});
					case 'move':
						return $dialogId.each(function () {
							//$(this).window('move', param);
							new TaWindow($(this)).window('move', param);
						});
					case 'maximize':
						return $dialogId.each(function () {
							//$(this).window('maximize');
							new TaWindow($(this)).window('maximize');
						});
					case 'minimize':
						return $dialogId.each(function () {
							//$(this).window('minimize');
							new TaWindow($(this)).window('minimize');
						});
					case 'restore':
						return $dialogId.each(function () {
							//$(this).window('restore');
							new TaWindow($(this)).window('restore');
						});
					case 'collapse':
						return $dialogId.each(function () {
							//$(this).window('collapse', param);
							new TaWindow($(this)).window('collapse', param);
						});
					case 'expand':
						return $dialogId.each(function () {
							//$(this).window('expand', param);
							new TaWindow($(this)).window('expand', param);
						});
				}
			}

			options = options || {};
			return $dialogId.each(function () {
				var state = $.data(this, 'dialog');
				if (state) {
					$.extend(state.options, options);
				} else {
					var t = $(this);
					var opts = $.extend({}, defaults, {
						title: t.attr('title') ? t.attr('title') : undefined,
						href: t.attr('href'),
						collapsible: t.attr('collapsible') ? t.attr('collapsible') == 'true' : undefined,
						minimizable: t.attr('minimizable') ? t.attr('minimizable') == 'true' : undefined,
						maximizable: t.attr('maximizable') ? t.attr('maximizable') == 'true' : undefined,
						resizable: t.attr('resizable') ? t.attr('resizable') == 'true' : undefined
					}, options);
					$.data(this, 'dialog', {
						options: opts,
						contentPanel: wrapDialog(this)
					});
				}
				buildDialog(this);
			});
		}
		/**
   * wrap dialog and return content panel.
   */
		function wrapDialog(target) {
			var t = $(target);
			t.wrapInner('<div class="dialog-content"></div>');
			var contentPanel = t.find('>div.dialog-content');

			contentPanel.css('padding', t.css('padding'));
			t.css('padding', 0);

			new TaPanel(contentPanel).ta3panel({
				border: false
			});

			return contentPanel;
		}

		/**
   * build the dialog
   */
		function buildDialog(target) {
			var opts = $.data(target, 'dialog').options;
			var contentPanel = $.data(target, 'dialog').contentPanel;

			$(target).find('div.dialog-toolbar').remove();
			$(target).find('div.dialog-button').remove();
			if (opts.toolbar) {
				var toolbar = $('<div class="dialog-toolbar"></div>').prependTo(target);
				for (var i = 0; i < opts.toolbar.length; i++) {
					var p = opts.toolbar[i];
					if (p == '-') {
						toolbar.append('<div class="dialog-tool-separator"></div>');
					} else {
						var tool = $('<a href="javascript:void(0)"></a>').appendTo(toolbar);
						tool.css('float', 'left').text(p.text);
						if (p.iconCls) tool.attr('icon', p.iconCls);
						if (p.handler) tool[0].onclick = p.handler;
						tool.linkbutton({
							plain: true,
							disabled: p.disabled || false
						});
					}
				}
				toolbar.append('<div style="clear:both"></div>');
			}

			if (opts.buttons) {
				var buttonsAlgin = "";
				if (opts.buttonsAlgin) buttonsAlgin = " style=\"text-align:" + opts.buttonsAlgin + "\"";
				var buttons = $('<div class="dialog-button" ' + buttonsAlgin + '></div>').appendTo(target);
				for (var i = 0; i < opts.buttons.length; i++) {
					var p = opts.buttons[i];
					//修改成sexybutton
					var icon = "",
					    text = "",
					    id = "";
					if (p.iconCls) icon = "<span  class='" + p.iconCls + "'>";
					if (p.text) text = p.text;
					if (p.id) id = " id='" + id + "'";
					//var h = '<button'+id+' type="button" class="sexybutton"><span><span>'+icon+text+(icon==''?'':'</span>')+'</span></span></button>';
					var h = "";
					if (p.buttonHighHlight) {
						h = '<button' + id + ' type="button" class="dialog_new_button isok">' + text + '</button>';
					} else {
						h = '<button' + id + ' type="button" class="dialog_new_button">' + text + '</button>';
					}
					var button = $(h).appendTo(buttons);
					button.focus(function () {
						$("span.button_span", this).addClass("button_focus");
					}).blur(function () {
						$("span.button_span", this).removeClass("button_focus");
					});
					if (p.hotKey && hotKeyregister) hotKeyregister.add(p.hotKey, function () {
						button.focus();button.click();return false;
					});

					if (p.handler) button[0].onclick = p.handler;
				}
			}

			if (opts.href) {
				//				contentPanel.ta3panel({
				//					href: opts.href,
				//					onLoad: opts.onLoad
				//				});
				new TaPanel(contentPanel).ta3panel({
					href: opts.href,
					onLoad: opts.onLoad
				});
				opts.href = null;
			}

			new TaWindow($(target)).window($.extend({}, opts, {
				onResize: function onResize(width, height) {
					var wbody = new TaPanel($(target)).ta3panel('panel').find('>div.panel-body');

					new TaPanel(contentPanel).ta3panel('resize', {
						width: wbody.width(),
						height: height == 'auto' ? 'auto' : wbody.height() - wbody.find('>div.dialog-toolbar').outerHeight(true) - wbody.find('>div.dialog-button').outerHeight(true)
					});

					if (opts.onResize) opts.onResize.call(target, width, height);
				}
			}));
		}

		function refresh(target) {
			var contentPanel = $.data(target, 'dialog').contentPanel;
			//			contentPanel.ta3panel('refresh');
			new TaPanel(contentPanel).ta3panel('refresh');
		}

		init(); // 调初始化方法
		$.extend(this, { // 为this对象
			"cmptype": 'dialog', // 将方法注册为公共方法
			"version": "3.13.0",
			"dialog": dialog
		});
	}
	return TaDialog;
});

/***/ }),

/***/ 90:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function($) {

/**
 * autor: xuxiao , zubaoshan
 * modify by xiep
 */
(function () {
	//定义一些默认参数
	var _options = {
		ZH: {
			dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
			shortDayNames: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
			monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
			shortMonthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
		},
		US: {
			dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
			shortDayNames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
			monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
			shortMonthNames: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		}

		//定义一些api
	};var _date_format_api = {

		/**
   * 格式化时间
   * @param date
   * @param fmt
   * @returns {*}
   */
		format: function format(date, fmt) {
			var o = {
				'M+': date.getMonth() + 1, //月份
				'd+': date.getDate(), //日
				'H+': date.getHours(), //小时
				'm+': date.getMinutes(), //分
				's+': date.getSeconds(), //秒
				'q+': Math.floor((date.getMonth() + 3) / 3) //季度
			};
			if (!this.isNotEmpty(fmt)) {
				fmt = 'yyyy-MM-dd HH:mm:ss';
			}
			if (/(y+)/.test(fmt)) {
				fmt = fmt.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
			}
			if (/(S+)/.test(fmt)) {
				fmt = fmt.replace(RegExp.$1, ((Array(3).join(0) + date.getMilliseconds()).slice(-3) + '').substr(3 - RegExp.$1.length));
			}
			for (var k in o) {
				if (new RegExp('(' + k + ')').test(fmt)) {
					fmt = fmt.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
				}
			}
			return fmt;
		},

		formatToDate: function formatToDate(dateStr) {
			if (this.isNotEmpty(dateStr)) {
				return new Date(Date.parse(dateStr.replace(/-/g, "/")));
			}
			return '';
		},

		/**
   * 得到一天的开始 date类型
   * @param date
   */
		getDateStart: function getDateStart(date) {
			var fmt = 'yyyy-MM-dd';
			var dateStartStr = this.getDateStartStr(date, fmt);
			var startTime = new Date(Date.parse(dateStartStr));
			return startTime;
		},

		/**
   * 得到一天的开始 str 类型
   * @param date
   */
		getDateStartStr: function getDateStartStr(date, fmt) {
			if (typeof fmt == 'undefined') {
				fmt = 'yyyy-MM-dd';
			}
			var dateStr = this.format(date, fmt);
			dateStr += ' 00:00:00';
			return dateStr;
		},

		/**
   * 得到一天的结束 date类型
   * @param date
   */
		getDateEnd: function getDateEnd(date) {
			var fmt = 'yyyy-MM-dd';
			var dateEndStr = this.getDateEndStr(date, fmt);
			var endTime = new Date(Date.parse(dateEndStr));
			return endTime;
		},

		/**
   * 得到一天的结束 str 类型
   * @param date
   */
		getDateEndStr: function getDateEndStr(date, fmt) {
			if (typeof fmt == 'undefined') {
				fmt = 'yyyy-MM-dd';
			}
			var endStr = this.format(date, fmt);
			endStr += ' 23:59:59';
			return endStr;
		},

		/**
   * 两个时间比较大小
   * @param d1
   * @param d2
   */
		compareDate: function compareDate(d1, d2) {
			if (d1 && d2) {
				if (d1.getTime() > d2.getTime()) {
					return 1;
				} else if (d1.getTime() == d2.getTime()) {
					return 0;
				} else if (d1.getTime() < d2.getTime()) {
					return -1;
				}
			}
		},

		/**
   * 得到星期几, 支持中英
   * @param date
   * @param type
   * @returns {string}
   */
		getWeek: function getWeek(date, type) {
			if (date) {
				if (!this.isNotEmpty(type)) {
					type = 0;
				}
				var index = date.getDay();
				var dateStr = '';
				switch (type) {
					case this.WEEKTYPE.ZH_DAYNAME:
						dateStr = _options.ZH.dayNames[index];
						break;
					case this.WEEKTYPE.ZH_SDAYNAME:
						dateStr = _options.ZH.shortDayNames[index];
						break;
					case this.WEEKTYPE.US_DAYNAME:
						dateStr = _options.US.dayNames[index];
						break;
					case this.WEEKTYPE.US_SDAYNAME:
						dateStr = _options.US.shortDayNames[index];
						break;
				}
				return dateStr;
			}
		},

		/**
   * 是否为闰年
   * @param date
   * @returns {boolean}
   */
		isLeapYear: function isLeapYear(date) {
			if (date instanceof Date) {
				return 0 == date.getYear() % 4 && (date.getYear() % 100 != 0 || date.getYear() % 400 == 0);
			}
			console.warn('argument format is wrong');
			return false;
		},

		/**
   * 字符串是否为正确的时间格式，支持 - /
   * @param dateStr
   * @returns {boolean}
   */
		isValidDate: function isValidDate(dateStr) {
			if (this.isNotEmpty(dateStr)) {
				var r = dateStr.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
				if (r == null) {
					return false;
				}
				var d = new Date(r[1], r[3] - 1, r[4]);
				var num = d.getFullYear() == r[1] && d.getMonth() + 1 == r[3] && d.getDate() == r[4];
				return num != 0;
			}
		},

		/**
   * 增加天数
   * @param date
   * @param dayNum
   */
		addDay: function addDay(date, dayNum) {
			if (this.isNotEmpty(date) && this.isNotEmpty(dayNum) && date instanceof Date && typeof dayNum == 'number') {
				date.setDate(date.getDate() + dayNum);
			} else {
				console.warn('date or dayNum format wrong');
			}
			return date;
		},

		addDayStr: function addDayStr(dateStr, dayNum) {
			var date = '';
			if (this.isNotEmpty(dateStr) && this.isNotEmpty(dayNum) && typeof dayNum == 'number') {
				date = this.formatToDate(dateStr);
				date.setDate(date.getDate() + dayNum);
			} else {
				console.warn('dateStr or dayNum format wrong');
			}
			return date;
		},

		/**
   * 增加月份
   * @param date
   * @param dayNum
   */
		addMonth: function addMonth(date, monthNum) {
			if (this.isNotEmpty(date) && this.isNotEmpty(monthNum) && date instanceof Date && typeof monthNum == 'number') {
				date.setMonth(date.getMonth() + monthNum);
			} else {
				console.warn('date or monthNum format wrong');
			}
			return date;
		},

		addMonthStr: function addMonthStr(dateStr, monthNum) {
			var date = '';
			if (this.isNotEmpty(dateStr) && this.isNotEmpty(monthNum) && typeof monthNum == 'number') {
				date = this.formatToDate(dateStr);
				date.setMonth(date.getMonth() + monthNum);
			} else {
				console.warn('date or monthNum format wrong');
			}
			return date;
		},

		/**
   * 增加年份
   * @param date
   * @param dayNum
   */
		addYear: function addYear(date, yearNum) {
			if (this.isNotEmpty(date) && this.isNotEmpty(yearNum) && date instanceof Date && typeof yearNum == 'number') {
				date.setYear(date.getFullYear() + yearNum);
			} else {
				console.warn('date or yearNum format wrong');
			}
			return date;
		},

		addYearStr: function addYearStr(dateStr, yearNum) {
			var date = '';
			if (this.isNotEmpty(dateStr) && this.isNotEmpty(yearNum) && typeof yearNum == 'number') {
				date = this.formatToDate(dateStr);
				date.setYear(date.getFullYear() + yearNum);
			} else {
				console.warn('date or yearNum format wrong');
			}
			return date;
		},

		/**
   * 是否为空
   * @param str
   * @returns {boolean}
   */
		isNotEmpty: function isNotEmpty(str) {
			if (str != '' && str != null && typeof str != 'undefined') {
				return true;
			}
			console.warn('argument format is wrong');
			return false;
		},

		//定义内部常量
		WEEKTYPE: {
			ZH_DAYNAME: 0,
			ZH_SDAYNAME: 1,
			US_DAYNAME: 2,
			US_SDAYNAME: 3
		}
		//这里确定了插件的名称
		// this.DateFormat = _date_format_api;
	};$.extend(true, window, {
		Ta: {
			util: {
				Date: _date_format_api
			}
		}
	});
})();
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0)))

/***/ }),

/***/ 91:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 92:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(60)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {

	function setTitle(target, title, asHtml) {
		if (asHtml == true) $(">div >div.panel-title", $(target)).html(title);else $(">div >div.panel-title", $(target)).text(title);
	}
	function collapsePanel(target) {
		var $panel = $(target);
		var tool = $('>div.panel-header .panel-tool-collapse', $panel);
		if (tool && !tool.hasClass('icon-dbArrow_up')) {
			$panel.find(">div.panel-toolbar,>div.panel-body,>div.panel-button").slideUp(200);
			tool.addClass('icon-dbArrow_up').removeClass('icon-dbArrow_down');
		}
	}

	function expandPanel(target) {
		var $panel = $(target);
		var tool = $('>div.panel-header .panel-tool-collapse', $panel);
		if (tool && tool.hasClass('icon-dbArrow_up')) {
			$panel.find(">div.panel-toolbar,>div.panel-body,>div.panel-button").slideDown(200);
			tool.addClass('icon-dbArrow_down').removeClass('icon-dbArrow_up');
		}
	}
	/**
  * 让panel的body部分自动随父亲容器的宽高伸展
  */
	function fitPanel(target) {
		//$(target).tauifitheight();
		new TaFit($(target)).tauifitheight();
	}
	function mask(target, param) {}
	$.fn.tauipanel = function (options, param, asHtml) {
		if (typeof options == 'string') {
			switch (options) {
				case 'setTitle':
					return this.each(function () {
						setTitle(this, param, asHtml);
					});
				case 'collapse':
					return this.each(function () {
						collapsePanel(this);
					});
				case 'expand':
					return this.each(function () {
						expandPanel(this);
					});
				case 'destroy':
					return this.each(function () {
						destroyPanel(this, param);
					});
				case 'resize':
					return this.each(function () {
						fitPanel(this);
					});

				case 'mask':
					return this.each(function () {
						mask(this, param);
					});
			}
		}

		options = options || {};
		return this.each(function () {
			var opts;
			var t = $(this);
			opts = $.extend({}, $.fn.tauipanel.defaults, {
				href: t.attr('href'),
				onLoad: t.attr('onLoad') ? t.attr('onLoad') : undefined,
				fit: t.attr('fit') == 'true' ? true : false,
				heightDiff: t.attr('heightDiff') || 0,
				minHeight: t.attr('minHeight')
			}, options);
			$.data(this, 'panel', opts);

			if (opts.fit) {
				fitPanel(this);
			}

			$("> div.panel-header > div.panel-tool-box > div.panel-tool > div.panel-tool-collapse", t).mouseover(function () {
				$(this).addClass('panel-tool-over');
			}).mouseout(function () {
				$(this).removeClass('panel-tool-over');
			}).click(function () {
				var flag = $(this).hasClass("icon-dbArrow_up");
				var $p;
				if (!flag) {
					$(this).addClass('icon-dbArrow_up').removeClass('icon-dbArrow_down');
					$p = $(this.parentNode.parentNode.parentNode.parentNode);
					$p.find(">div.panel-toolbar,>div.panel-body,>div.panel-button").slideUp(100);
					setTimeout(function () {
						$p.siblings('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]').each(function () {
							$(this).triggerHandler('_resize');
						});
					}, 100);
				} else {
					$(this).addClass('icon-dbArrow_down').removeClass('icon-dbArrow_up');
					$p = $(this.parentNode.parentNode.parentNode.parentNode);
					$p.find(">div.panel-toolbar,>div.panel-body,>div.panel-button").slideDown(100);
					setTimeout(function () {
						$p.siblings('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]').each(function () {
							$(this).triggerHandler('_resize');
						});
					}, 100);
				}
			});
			//李从波添加缩放控制代码2012.09.07
			var originWidth = 0; //初始高宽  z-index  top  left   margin  bodyHeight
			var originHeight = 0;
			var originZindex = 0;
			var originTop = 0;
			var originLeft = 0;
			var originMarginTop = 0;
			var originMarginBottom = 0;
			var originMarginLeft = 0;
			var originMarginRight = 0;
			var originBodyHeight = 0;
			var maxWidth = 0; //最大高宽
			var maxHeight = 0;
			var panelBodyBorder = 0; //左右边框宽度
			var panelToolbarHeight = 0; //工具条的高度
			var panelButtonbarHeight = 0; //按钮条的高度
			var isBorderLayout = false; //panel所在页面是否使用了border布局
			var isWidthAuto = false; //宽度是否根据父容器自动计算
			var isHeightAuto = false; //高度是否根据父容器自动计算
			var $handler = null; //border布局下的工具条
			var $borderContainer = $("body").find("div.l-layout-left,div.l-layout-right,div.l-layout-center,div.l-layout-top,div.l-layout-bottom"); //border布局下的区域
			$("> div.panel-header > div.panel-tool-box > div.panel-tool > div.panel-tool-max", t).mouseover(function () {
				$(this).addClass('panel-tool-over');
			}).mouseout(function () {
				$(this).removeClass('panel-tool-over');
			}).click(function () {
				var flag = $(this).hasClass("icon-restore");
				var $p, $panelBody;
				if (!flag) {
					$(this).addClass('icon-restore').removeClass('icon-maximization');
					$p = $(this.parentNode.parentNode.parentNode.parentNode);
					$panelBody = $p.find(">div.panel-body");
					if (originWidth == 0 && originHeight == 0) {
						//初始化 初始高宽  top  left margin z-index等
						var $panelToolbar = $p.find(">div.panel-toolbar");
						var $panelButtonbar = $p.find(">div.panel-button");
						originWidth = $p.width();
						originHeight = $p.height();
						originTop = $p.css("top");
						originLeft = $p.css("left");
						originZindex = $p.css("z-index");
						originMarginTop = $p.css("margin-top");
						originMarginBottom = $p.css("margin-bottom");
						originMarginLeft = $p.css("margin-left");
						originMarginRight = $p.css("margin-right");
						originBodyHeight = $panelBody.height();
						panelBodyBorder = parseInt($panelBody.css("border-left-width").replace("px", "")) + parseInt($panelBody.css("border-right-width").replace("px", ""));
						if ($p.width() + parseInt(originMarginLeft.replace("px", "")) + parseInt(originMarginRight.replace("px", "")) == $p.parent().width()) {
							isWidthAuto = true;
						}
						if ($p.attr("fit") == "true") {
							isHeightAuto = true;
						}
						if ($panelToolbar.length > 0) {
							panelToolbarHeight = 31;
						}
						if ($panelButtonbar.length > 0) {
							panelButtonbarHeight = 40;
						}
					}
					maxWidth = $(window).width() - 2; //获取当前最大高宽
					maxHeight = $(window).height() - 2;
					$handler = $("body").find("div.l-layout-drophandle-left,div.l-layout-drophandle-right,div.l-layout-drophandle-top,div.l-layout-drophandle-bottom,div.l-layout-collapse-left,div.l-layout-collapse-right").not(":hidden");
					if ($borderContainer.length > 0 || $handler.length > 0) {
						$handler.hide(); //隐藏border布局下的工具条
						$borderContainer.css({ position: "static" }); //设置所有的boder容器position 为static
						isBorderLayout = true;
					}
					if (panelToolbarHeight > 0 || panelButtonbarHeight > 0) $p.removeClass("panelnomargin"); //移除no-magin 样式
					var pIndex = originZindex == "auto" ? 0 : originZindex;
					$p.css({ position: "fixed", zIndex: 9002 > pIndex ? 9002 : pIndex, background: "#fcfdfd" }); //设置position为fixed 修改z-index显示在最前面  设置背景色盖住下方内容
					$p.animate({ //动画开始
						width: maxWidth,
						height: maxHeight,
						top: isBorderLayout == true ? -2 : isHeightAuto == true ? -1 : -2,
						left: 1,
						marginTop: 3,
						marginBottom: 3,
						marginLeft: 0,
						marginRight: 0
					}, { duration: 100, complete: function complete() {
							var panelBodyHeight = maxHeight - 25 - panelToolbarHeight - panelButtonbarHeight; //减去标题、 toolbar、 buttonbar的高度得到panelbody高度
							$panelBody.css({ height: panelBodyHeight, width: maxWidth - panelBodyBorder });
							$panelBody.find('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]').each(function () {
								$(this).triggerHandler('_resize');
							}); //处理子容器自适应高度
						} });
				} else {
					$(this).addClass('icon-maximization').removeClass('icon-restore');
					$p = $(this.parentNode.parentNode.parentNode.parentNode);
					$panelBody = $p.find(">div.panel-body");
					var pTop = originTop == "auto" ? 0 : originTop;
					var pLeft = originLeft == "auto" ? 0 : originLeft;
					$p.css({ zIndex: originZindex });
					$p.animate({ //动画开始
						width: originWidth,
						height: originHeight,
						top: pTop,
						left: pLeft,
						marginTop: originMarginTop,
						marginBottom: originMarginBottom,
						marginLeft: originMarginLeft,
						marginRight: originMarginRight
					}, { duration: 100, complete: function complete() {
							if ($borderContainer || $handler) {
								$borderContainer.css({ position: "absolute" }); //恢复原有的设置
								$handler.show(); //显示border布局下的工具条
							}
							if (panelToolbarHeight > 0 || panelButtonbarHeight > 0) $p.addClass("panelnomargin"); //恢复no-margin样式
							//$p.css({ position: "relative",background:"#fff",top:originTop,left:originLeft,width: isWidthAuto==true?"auto":originWidth,height:isHeightAuto==true?"auto":originHeight});//处理缩放后页面缩放panel失效的问题
							$p.css({ position: "relative", background: "#fff", top: originTop, left: originLeft, width: isWidthAuto == true ? "auto" : originWidth, height: "auto" }); //处理缩放后页面缩放panel失效的问题
							$panelBody.css({ height: originBodyHeight, width: isWidthAuto == true ? "auto" : originWidth }); //处理panelBody适应父容器高宽
							$panelBody.find('>div[fit=true],>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]').each(function () {
								$(this).triggerHandler('_resize');
							}); //处理子容器自适应高度
						} });
				}
			});
		});
	};

	$.fn.tauipanel.defaults = {
		href: null,
		onLoad: function onLoad() {},
		fit: false,
		heightDiff: 0
	};
});

/***/ }),

/***/ 93:
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
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(5)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		Base: core()
	});

	function core() {
		/**
   * 收起panel
   * @method slideUpPanel
   * @param {String} panelId panel的id
   */
		function slideUpPanel(panelId) {
			$("#" + panelId).tauipanel('collapse');
		}
		/**
   * 拉下panel
   * @method slideDownPanel
   * @param {String} panelId panel的id
   */
		function slideDownPanel(panelId) {
			$("#" + panelId).tauipanel('expand');
		}
		/**
   * 设置panel的标题
   * @method setPanelTitle
   * @param {String} panelId panel的id
   * @param {String} title panel的新标题，可以包含html标签
   * @param {Boolean} asHtml 当title中包含了html标签，必须将asHtml设置成true，否则新标题会将html标签直接显示出来
   */
		function setPanelTitle(panelId, title, asHtml) {
			$("#" + panelId).tauipanel('setTitle', title, asHtml);
		}

		return {
			slideUpPanel: slideUpPanel,
			slideDownPanel: slideDownPanel,
			setPanelTitle: setPanelTitle
		};
	}
});

/***/ }),

/***/ 94:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 95:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(jQuery) {var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

/**
 * 模拟窗口组件常用方法,调用方式为Base.xxx();
 * @module Base
 * @class window
 * @static
 */
(function (factory) {
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(5), __webpack_require__(54), __webpack_require__(22), __webpack_require__(71), __webpack_require__(36)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
})(function ($) {
	$.extend(true, window, {
		Base: core()
	});

	function core() {
		return {
			openWindow: openWindow,
			openWindowWithSubmitIds: openWindowWithSubmitIds,
			closeWindow: closeWindow,
			alert: alert,
			msgTip: msgTip,
			msgTopTip: msgTopTip,
			confirm: confirm,
			prompt: prompt,
			buttonsDialog: buttonsDialog,
			sendMsgToFrame: sendMsgToFrame,
			openTabMenu: openTabMenu,
			closeTabMenu: closeTabMenu,
			showBoxComponent: showBoxComponent,
			wizard: wizard,
			openProcess: openProcess,
			closeBoxComponent: closeBoxComponent
			/**
    *
    * @method
    * @param  {boolean} replay 是否自动播放
    * @param {boolean} flag panel的id
    * @param {String} name 在cookie中存放的名称，应保证唯一，最好采用当前页面的id
    * @param {Array} data 导航内容，包含1.所要提示的dom元素的jquery对象；2.提示内容
    * var data = [object1,object2,[..objectn]]
    * var object1 = {};
    * object1.id = "#id" || $("#id")
    * object1.message = "这是你的下一步提示信息";
    * data:[{id:$("ul.tabs li:eq(0)"),
           	message:"1-这是您的当前页"
            },
    {id:$("ul.tabs li:eq(1)"),
               message:"2-点击这里，您将进入一个查询页面"
          },
    {id:$("ul.tabs li:eq(2)"),
               message:"3-点击这里，您将进入一个查询页面"
          }]
    *
    */
		};function wizard(id, replay, flag, name, data) {
			/*	$("#"+id).hintTip({
    replay:replay,
    show:flag,
    cookname:name,
    data:data
    });
    */
			new TaHelpTip($("#" + id)).helpTip({
				replay: replay,
				show: flag,
				cookname: name,
				data: data
			});
		}

		/**
   * 打开窗口
   * @method openWindow
   * @param {String} id 窗口id
   * @param {String} title 窗口标题
   * @param {String} url aciton地址
   * @param {map} parameter 入参 json格式对象，例如:{"dto['aac001']":"1000001","dto['aac002']":"01"}
   * @param {Number} width 宽度 不要加 px；也可设置成百分比，例如"80%"
   * @param {Number} height 高度 不要加 px；也可设置成百分比，例如"80%"
   * @param {Function} onLoad 窗口加载完毕回调，如果useIframe=true的话 这参数不起作用
   * @param {Funciton} onClose 窗口关闭的时候回调
   * @param {Boolean} useIframe 是否使用iframe的方式加载，默认为false，iframe方式会存在seesion丢失，应当避免;为true的时候，打开页面为一个完整的jsp页面
   * @param {String} style 自定义打开窗口css样式
   * @param {Object} myoptions window的创建参数
   */
		function openWindow(id, title, url, parameter, width, height, onLoad, onClose, useIframe, style, myoptions) {
			var $w = $("<div id=\"" + id + "\" " + (style ? "style=\"" + style + "\"" : "") + "></div>");
			$w.appendTo($("body"));
			var tawindow = new TaWindow($w);
			var options = {};

			title ? options.title = title : null;
			width ? options.width = width : options.width = 200;
			height ? options.height = height : options.height = 200;
			onLoad ? options.onLoad = onLoad : null;

			options.modal = true;
			options.resizable = false;
			options.minimizable = false;
			options.collapsible = false;
			options.border = true;

			useIframe = useIframe === true ? true : false;

			if (parameter) {
				if (url.indexOf('?') != -1) {
					url += "&" + jQuery.param(parameter);
				} else {
					url += "?" + jQuery.param(parameter);
				}
			}
			if (url.indexOf('?') != -1) {
				url += "&_r=" + Math.random();
			} else {
				url += "?_r=" + Math.random();
			}
			url += "&___businessId=" + Base.globvar.currentMenuId;
			if (url && useIframe) {
				options.content = '<iframe type="window" src="' + url + '" frameborder="0" style="width:100%;height:100%"></iframe>';
			} else {
				url ? options.href = url : null;
			}
			options.onClose = function (_onClose) {
				return function () {
					if (_onClose) _onClose($w.attr("id"));
					//remove window里面TaUIManager对应的对象
					Ta.core.TaUIManager.removeObjInCantainer($w);
					Base.hideMask();
					//$w.window('destroy');
					tawindow.window('destroy');
					$w.remove();
				};
			}(onClose);
			if (myoptions) $.extend(options, myoptions);
			//$w.window(options);
			tawindow.window(options);
			if (!url) {
				onLoad();
			}
		}
		function openWindowWithSubmitIds(id, title, url, submitIds, parameter, width, height, onLoad, onClose, useIframe, style, myoptions, type) {
			var paramThis = {};
			if (parameter != undefined) paramThis = parameter;
			var submitId = submitIds.split(",");
			for (var i = 0; i < submitId.length; i++) {
				if (submitId[i] == "") continue;
				var value = Base.getValue(submitId[i]);
				if (value != undefined && value != "") {
					paramThis[submitId[i]] = value;
					paramThis["dto['" + submitId[i] + "']"] = value;
				}
			}
			switch (type) {
				case "top":
					top._child = window.self;
					top.Base.openWindow(id, title, url, paramThis, width, height, onLoad, onClose, useIframe, style, myoptions);
					break;
				case "parent":
					parent._child = window.self;
					parent.Base.openWindow(id, title, url, paramThis, width, height, onLoad, onClose, useIframe, style, myoptions);
					break;
				default:
					Base.openWindow(id, title, url, paramThis, width, height, onLoad, onClose, useIframe, style, myoptions);
					break;
			}
		}
		/**
   * 关闭窗口
   * @method closeWindow
   * @param {String} id 窗口id
   */
		function closeWindow(id) {
			//setTimeout(function(){	$("#"+id).window('close');}, 1);
			setTimeout(function () {
				new TaWindow($("#" + id)).window('close');
			}, 1);
		}
		/**
   * 弹出提示
   * @method alert
   * @param {String} msg 提示的信息，可以是html
   * @param {String} type 提示的图标，不传就无图标。type可以选择如下：success,error,warn,question
   * @param {Function} callback 回调函数
   * @param {Obj} options 指定参数,可设置宽高等例如{width:"200",height:"400"};//add by cy
   */
		function alert(msg, type, callback, options) {
			var title = Base.I18n.getLangText("taface.module.window.prompt"),
			    image = "",
			    html; //i18n:提示
			switch (type) {
				case 'success':
					title = Base.I18n.getLangText("taface.module.window.successtip"); //i18n:成功提示
					image = "icon-correct2";
					break;
				case 'error':
					title = Base.I18n.getLangText("taface.module.window.failtip"); //i18n:失败提示
					image = "icon-close2";
					break;
				case 'warn':
					title = Base.I18n.getLangText("taface.module.window.warn"); //i18n:警告
					image = "icon-warn";
					break;
				case 'question':
					title = Base.I18n.getLangText("taface.module.window.confirm"); //i18n:确认
					image = "icon-notice";
					break;
			}
			if (type) {
				html = "<div><div class='l-dialog-icon faceIcon " + image + "'></div><div class='l-dialog-txt' >" + msg + "</div></div>";
			} else {
				html = "<div><span>" + msg + "</span><div>";
			}
			var $w = $(html);
			$w.appendTo($("body"));
			var tadialog = new TaDialog($w);
			var _op = $.extend({}, {
				title: title,
				width: 300,
				height: 150,
				//top : '100px',
				modal: true,
				resizable: true,
				onClose: function onClose() {
					tadialog.dialog('destroy');
					$w.remove();
					if (callback) callback();
					Base.hideMask();
				},
				buttonsAlgin: 'center',
				buttons: [{
					text: Base.I18n.getLangText("taface.general.ensure"), //i18n:确定
					buttonHighHlight: true,
					handler: function handler() {
						tadialog.dialog('destroy');
						$w.remove();
						if (callback) callback();
						Base.hideMask();
					}
				}]
			}, options);
			tadialog.dialog(_op);
			$w.find("div.panel").css("margin", 0);
			$w.find('.dialog-button button:first').delay(100).focus();
		}
		/**
   * @method msgTip
   * @deprecated 弃用的方法
   */
		function msgTip(target, message) {
			//TODO
			var box = $(target);
			var msg = message; //= $.data(target, 'validatebox').message;
			var tip = $('<div class="validatebox-tip">' + '<div class="validatebox-tip-content  ui-corner-all">' + '</div>' + '<div class="validatebox-tip-pointer">' + '</div>' + '</div>').appendTo('body');
			//$.data(target, 'validatebox').tip = tip;
			var $c = tip.find('.validatebox-tip-content');
			$c.html(msg);
			var cheight = $c.height();
			if (cheight == 0) cheight = 17;
			tip.css({
				display: 'block',
				left: box.offset().left + 10,
				top: box.offset().top - cheight - 15
			});
			//$.data(target, 'validatebox').tip =tip;
		}

		/**
   * 信息展示框,在页面头顶出现一悬浮框,显示信息
   * @method msgTopTip
   * @param {String} message 提示的信息，可以是html
   * @param {Number} time 悬浮框持续时间,毫秒计时,如果不定义此参数或者不是数字,则默认为2s.
   * @param {Number} width 悬浮框宽度,默认250.
   * @param {Number} height 悬浮框高度,默认50.
   * @param {String} style 自定义样式，例如:background:red;font-size:14px;.
   * @param {type} String 风格：success，error，warn
   * @param {String} position 提示信息位置：top-left,top-right,bottom-left,bottom-right,left,top,right,bottom
   * @param {boolean} autoClose 显示后是否自动隐藏，默认为true（自动隐藏） ，false则为手动关闭
   * @param {Function} fnCallBack 关闭回调
   */
		function msgTopTip(message, time, width, height, style, type, position, autoClose, fnCallBack) {
			var tip,
			    left,
			    tempHeight = -63,
			    image = "",
			    html = "";

			if (time == null || isNaN(time)) {
				time = 2000;
			}

			if (autoClose === undefined || autoClose === null || autoClose === "") {
				autoClose = true;
			}

			switch (type) {
				case 'success':
					image = "icon-correct2";
					break;
				case 'error':
					image = "icon-close2";
					break;
				case 'warn':
					image = "icon-warn";
					break;
			}

			style = style == undefined ? "" : style;

			if (type) {
				html = '<div class="body" style="' + style + '"><div class="msgTopTip-icon faceIcon ' + image + '"></div><div class="l-dialog-txt">' + message + '</div></div>';
			} else {
				html = '<div class="body" style="margin-top:3px;' + style + '">' + message + '</div>';
			}

			tip = $('<div class="windowTopMsg"></div>').append('<div class="header" ><span class="closeTip faceIcon icon-close"></span></div>' + html).appendTo('body');

			if (width !== undefined && width !== null && width !== "" && !isNaN(width)) {
				left = ($("body").width() - width) / 2;
				tip.width(width);
			} else {
				left = ($("body").width() - 250) / 2;
			}

			if (height !== undefined && height !== null && height !== "" && !isNaN(height)) {
				tip.height(height);
				tempHeight = -(Number(height) + 13);
			}

			var animateShowJson = { top: "10px" };
			var animateHideJson = { top: tempHeight + "px" };

			switch (position) {
				case "top-left":
					left = 10;
					tip.css("left", left);
					tip.css("top", tempHeight);
					break;
				case "top-right":
					var right = 10;
					tip.css("right", right);
					tip.css("top", tempHeight);
					break;
				case "bottom-left":
					left = 10;
					tip.css("left", left);
					tip.css("bottom", tempHeight);
					animateShowJson = { bottom: "10px" };
					animateHideJson = { bottom: tempHeight + "px" };
					break;
				case "bottom-right":
					var right = 10;
					tip.css("right", right);
					tip.css("bottom", tempHeight);
					animateShowJson = { bottom: "10px" };
					animateHideJson = { bottom: tempHeight + "px" };
					break;
				case "left":
					var tempWidth = width !== undefined && width !== null && width !== "" && !isNaN(width) ? -(Number(width) + 13) : -263;
					tip.css("left", tempWidth);
					var top = height !== undefined && height !== null && height !== "" && !isNaN(height) ? ($("body").height() - height) / 2 : ($("body").height() - 70) / 2;
					tip.css("top", top);
					animateShowJson = { left: "10px" };
					animateHideJson = { left: tempWidth + "px" };
					break;
				case "right":
					var tempWidth = width !== undefined && width !== null && width !== "" && !isNaN(width) ? -(Number(width) + 13) : -263;
					tip.css("right", tempWidth);
					var top = height !== undefined && height !== null && height !== "" && !isNaN(height) ? ($("body").height() - height) / 2 : ($("body").height() - 70) / 2;
					tip.css("top", top);
					animateShowJson = { right: "10px" };
					animateHideJson = { right: tempWidth + "px" };
					break;
				case "bottom":
					tip.css("left", left);
					tip.css("bottom", tempHeight);
					animateShowJson = { bottom: "10px" };
					animateHideJson = { bottom: tempHeight + "px" };
					break;
				default:
					tip.css("left", left);
					tip.css("top", tempHeight);
			}

			tip.animate(animateShowJson, "slow");

			if (autoClose) {
				setTimeout(function () {
					tip.animate(animateHideJson, 500);
					setTimeout(function () {
						tip.remove();
					}, 500);
					if (fnCallBack && typeof fnCallBack == "function") {
						fnCallBack();
					}
				}, time);
			}

			$(".closeTip").click(function () {
				tip.animate(animateHideJson, 500);
				setTimeout(function () {
					tip.remove();
				}, 500);
				if (fnCallBack && typeof fnCallBack == "function") {
					fnCallBack();
				}
			});
		}

		/**
   * 确认框
   * @method confirm
   * @param {String} msg 提示的信息，可以是html
   * @param {Function} fn
   * <br/>示例：
   * <br/>function (yes) { if(yes) alert('11'); });
   * <br/>"yes"根据你的选择来取值，当你点击"确定"按钮时，yes为true；当你点击"取消"按钮时，yes为false
   * @param {Object} options json格式，配置文字显示title, buttonOk, buttonCancel
   * @param {String} hotKeys 字符串，两个按钮的热键,第一个为确认键,第二个为取消键,例如"o,c"表示确认键的快捷键为alt+o,取消为alt+c
   * @param focus true或flase，为true时焦点在确认按钮上，为flase时焦点在取消按钮上
   */
		function confirm(msg, fn, options, hotKeys, focus) {
			var $w = $("<div><div class='l-dialog-icon faceIcon icon-help'></div><div class='l-dialog-txt'>" + msg + "</div></div>");
			//var $w = $("<div style='word-break:break-all;overflow:hidden;'><span style='margin:10px 2px 2px 10px;'>"+msg+"</span></div>");
			$w.appendTo($("body"));
			var buttonHotKeys = [];
			if (typeof hotKeys == "string") {
				buttonHotKeys = hotKeys.split(",");
			}
			var tadialog = new TaDialog($w);
			tadialog.dialog({
				title: options && options.title ? options.title : Base.I18n.getLangText("taface.module.window.confirmtip"), //i18n:确认提示
				width: 350,
				height: 150,
				modal: true,
				closable: false,
				resizable: true,
				onClose: function onClose() {
					tadialog.dialog('destroy');
					$w.remove();
				},
				buttonsAlgin: 'center',
				buttons: [{
					text: options && options.buttonOk ? options.buttonOk : buttonHotKeys[0] ? Base.I18n.getLangText("taface.general.ensure") + '[' + buttonHotKeys[0].toUpperCase() + ']' : Base.I18n.getLangText("taface.general.ensure"), //i18n:确定
					buttonHighHlight: true,
					handler: function handler() {
						tadialog.dialog('destroy');
						$w.remove();
						if (fn) {
							fn(true);
						}
					}
				}, {
					text: options && options.buttonCancel ? options.buttonCancel : buttonHotKeys[1] ? Base.I18n.getLangText("taface.general.cancel") + '[' + buttonHotKeys[1].toUpperCase() + ']' : Base.I18n.getLangText("taface.general.cancel"), //i18n:取消
					handler: function handler() {
						tadialog.dialog('destroy');
						$w.remove();
						if (fn) fn(false);
					}
				}]
			});
			if (focus) {
				$w.find('.dialog-button button:first').focus();
			} else {
				$w.find('.dialog-button button:last').focus();
			}
			//添加热键
			if (buttonHotKeys) {
				var buttons = $w.find('.dialog-button button');
				if (buttonHotKeys[0]) {
					if (buttonHotKeys[0].length == 1) {
						hotKeyregister.add("alt+" + buttonHotKeys[0], function () {
							buttons.eq(0).focus();buttons.eq(0).click();return false;
						});
					} else if (buttonHotKeys[0].length > 1) {
						hotKeyregister.add(buttonHotKeys[0], function () {
							buttons.eq(0).focus();buttons.eq(0).click();return false;
						});
					}
				}
				if (buttonHotKeys[1]) {
					if (buttonHotKeys[1].length == 1) {
						hotKeyregister.add("alt+" + buttonHotKeys[1], function () {
							buttons.eq(1).focus();buttons.eq(1).click();return false;
						});
					} else if (buttonHotKeys[1].length > 1) {
						hotKeyregister.add(buttonHotKeys[1], function () {
							buttons.eq(1).focus();buttons.eq(1).click();return false;
						});
					}
				}
			}
			$w.keydown(function (e) {
				//让按钮支持左右键选择聚焦
				var o = e.target || e.srcElement;
				if (e.keyCode == 39) {
					//->
					var next = $(o).next()[0];
					if (next) next.focus();
				} else if (e.keyCode == 37) {
					//<-
					var prev = $(o).prev()[0];
					if (prev) prev.focus();
				}
			});
			$w.find("div.panel").css("margin", 0);
		}

		/**
   * 接收输入的提示框
   * @method prompt
   * @param {String} msg 提示的信息，可以是html
   * @param {Function} fn
   * <br/>示例：
   * <br/>function (yes,value) { if(yes) alert(value); });
   * <br/>"yes"根据你的选择来取值，当你点击"确定"按钮时，yes为true；当你点击"取消"按钮时，yes为false。value是你输入的值
   * @param {String} initValue 初始值
   */
		function prompt(msg, fn, initValue) {
			var $w = $("<div ><div class='prompt-label'>" + msg + "</div><input type=\"text\" class='prompt-input' id=\"___prompt\" value=\"" + (initValue ? initValue : "") + "\"/></div>");
			$w.appendTo($("body"));
			$('#___prompt').keydown(function (e) {
				if (e.keyCode == 13) {
					$w.find('.dialog-button button:first').delay(100).focus();
					//setTimeout(function(){$w.find('.dialog-button button:first').focus();},100);
				}
			});
			var tadialog = new TaDialog($w);
			tadialog.dialog({
				title: Base.I18n.getLangText('taface.module.window.defineprompttitle'), //i18n:请输入
				width: 350,
				height: 150,
				modal: true,
				closable: false,
				onClose: function onClose() {
					tadialog.dialog('destroy');
					$w.remove();
				},
				buttonsAlgin: 'center',
				buttons: [{
					text: Base.I18n.getLangText('taface.general.ensure'), //i18n:确定
					buttonHighHlight: true,
					handler: function handler() {
						var v = $('#___prompt').val();
						tadialog.dialog('destroy');
						$w.remove();
						if (fn) fn(true, v);
					}
				}, {
					text: Base.I18n.getLangText('taface.general.cancel'), //i18n:取消
					handler: function handler() {
						var v = $('#___prompt').val();
						tadialog.dialog('destroy');
						$w.remove();
						if (fn) fn(false, v);
					}
				}]
			});
			$w.keydown(function (e) {
				//让按钮支持左右键选择聚焦
				if (e.keyCode == 39) {
					//->
					var next = $(e.srcElement).next()[0];
					if (next) next.focus();
				} else if (e.keyCode == 37) {
					//<-
					var prev = $(e.srcElement).prev()[0];
					if (prev) prev.focus();
				}
			});
			$('#___prompt').delay(100).focus();
		}

		/**
   * 多个按钮的提示框,
   * @method buttonsDialog
   * @param {String} msg 提示的信息，可以是html
   * @param {Number} width 宽度，不要加px
   * @param {Number} height 高度，不要加px
   * @param {Object} buttons
   * 示例：
   * [
   * {text:'确定1',
   * handler:function(){}
   * url:'test/testAction!query1.do'},
   * {text:'确定2',
   * handler:function(){}
   * url:'test/testAction!query2.do'}
   * ]
   */
		//TODO 可以考虑，某些按钮直接传url的时候做一些事情
		function buttonsDialog(msg, width, height, buttons) {
			var $w = $("<div style='word-break:break-all;overflow:hidden;'><div style='margin:8px 20px;'>" + msg + "</div></div>");
			$w.appendTo($("body"));
			var tadialog = new TaDialog($w);
			var _buttons = buttons;
			if (_buttons) {
				for (var i = 0; i < _buttons.length; i++) {
					if (_buttons[i].handler) {
						_buttons[i].handler = function (_click) {
							return function () {
								tadialog.dialog('destroy');
								$w.remove();
								_click();
							};
						}(_buttons[i].handler);
					}
				}
			}

			tadialog.dialog({
				title: Base.I18n.getLangText('taface.module.window.definebuttonsdialogtitle'), //i18n:选择操作
				width: width ? width : 350,
				height: height ? height : 250,
				modal: true,
				closable: false,
				buttonsAlgin: 'center',
				onClose: function onClose() {
					//$w.dialog('destroy');
					tadialog.dialog('destroy');
					$w.remove();
				},
				buttons: buttons
			});
			$w.keydown(function (e) {
				//让按钮支持左右键选择聚焦
				if (e.keyCode == 39) {
					//->
					var next = $(e.srcElement).next()[0];
					if (next) next.focus();
				} else if (e.keyCode == 37) {
					//<-
					var prev = $(e.srcElement).prev()[0];
					if (prev) prev.focus();
				}
			});
			$w.find('.dialog-button button:first').delay(100).focus();
		}

		function sendMsgToFrame(target, msg, args) {
			window.sendPostMessage(target || window.top, msg, args);
		}

		/**
   * 打开一个首页tab窗口
   * @method openTabMenu
   * @param {String} tabid 不可重复，最好取菜单id，若没菜单可自定义
   * @param {String} title tab名称
   * @param {String} !url 要访问的地址
   */
		function openTabMenu(tabid, title, url, reLoad) {
			if (!url) return;
			var args = tabid + ";" + title + ";" + url;
			if (reLoad) {
				sendMsgToFrame(window.top, "indexTab.closeTab", args);
			}
			sendMsgToFrame(window.top, "indexTab.addTab", args);
		}
		/**
   * 关闭一个首页tab窗口
   * @method closeTabMenu
   * @param {String} tabid
   */
		function closeTabMenu(tabid) {
			sendMsgToFrame(window.top, "indexTab.closeTab", tabid);
		}

		/**
  * 关闭所有工作tab
  * @author xp
   */
		function closeAllTabMenu() {
			sendMsgToFrame(window.top, "indexTab.closeAllTab");
		}

		/**
   * 显示boxComponet组建，根据不同的目标对象显示在不同位置
   * @method showBoxComponent
   * @param {String} id boxComponet组建的id,必传
   * @param {String} target 目标对象，为一dom对象，必传
   */
		function showBoxComponent(id, target) {
			var $target = $(target);
			var bodyHeight = $(document.body).outerHeight(true);
			var bodyWidth = $(document.body).outerWidth(true);
			var $id = $("#" + id);
			var boxHeight = $id.outerHeight(true);
			var boxWidth = $id.outerWidth(true);
			if ($target && $target.length == 1) {
				var targetOffset = $target.offset();
				if (targetOffset) {
					var targetTop = targetOffset.top;
					var targetLeft = targetOffset.left;
					var targetHeight = $target.innerHeight();
					var targetWidth = $target.innerWidth();
					var heightDifference = bodyHeight - targetHeight - targetTop;
					var widthDifference = bodyWidth - targetWidth - targetLeft;

					var ap = $id.attr("_position");
					if (ap == "horizontal") {
						heightDifference = bodyHeight - targetTop;
						widthDifference = bodyWidth - targetWidth - targetLeft;
					} else if (ap == "vertical") {
						heightDifference = bodyHeight - targetHeight - targetTop;
						widthDifference = bodyWidth - targetLeft;
					}
					//					console.log("bodyWidth:" + bodyWidth +",boxWidth:" + boxWidth +",targetLeft:" + targetLeft + ",targetWidth:" + targetWidth + ",widthDifference:" +widthDifference);
					//					console.log("bodyHeight:" + bodyHeight +",boxHeight:" + boxHeight +",targetTop:" + targetTop + ",targetHeight:" + targetHeight + ",heightDifference:" +heightDifference);
					//
					var horizontalP, verticalP;
					if (heightDifference >= boxHeight) {
						if (ap == "horizontal") {
							$id.css("top", targetTop + targetHeight - 40 - targetHeight / 2);
						} else if (ap == "vertical") {
							$id.css("top", targetTop + targetHeight + 10);
						}
						verticalP = false;
					} else {
						if (ap == "horizontal") {
							$id.css("top", targetTop - boxHeight + 50);
						} else if (ap == "vertical") {
							$id.css("top", targetTop - boxHeight - 10);
						}
						verticalP = true;
					}
					if (widthDifference >= boxWidth) {
						if (ap == "horizontal") {
							$id.css("left", targetLeft + targetWidth);
						} else if (ap == "vertical") {
							$id.css("left", targetLeft - 20);
						}
						horizontalP = false;
					} else {
						if (ap == "horizontal") {
							$id.css("left", targetLeft - boxWidth - 10);
						} else if (ap == "vertical") {
							$id.css("left", targetLeft - boxWidth + 40);
						}
						horizontalP = true;
					}
					var $boxComponent_b = $("#" + id + " > b");
					if (ap == "horizontal") {
						if (verticalP && horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_rightBottom");
						} else if (verticalP && !horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_leftBottom");
						} else if (!verticalP && horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_rightTop");
						} else if (!verticalP && !horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_leftTop");
						}
					} else if (ap == "vertical") {
						if (verticalP && horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_bottomRight");
						} else if (verticalP && !horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_bottomLeft");
						} else if (!verticalP && horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_topRight");
						} else if (!verticalP && !horizontalP) {
							removeClass_b($boxComponent_b);
							$boxComponent_b.addClass("boxComponent_b_topLeft");
						}
					}
				}
			}
			$id.show();
		}
		/**
   *关闭boxComponet组建，根据不同的目标对象显示在不同位置
   * @method closeBoxComponent
   * @param {String} id boxComponet组建的id,必传
   * @author cy
   */
		function closeBoxComponent(id) {
			$("#" + id).hide();
		}
		function removeClass_b(o) {
			o.removeClass("boxComponent_b_topLeft boxComponent_b_topRight boxComponent_b_bottomLeft boxComponent_b_bottomRight boxComponent_b_leftTop boxComponent_b_rightTop boxComponent_b_leftBottom boxComponent_b_rightBottom");
		}

		//打开进度条
		function openProcess(url) {
			//			var height,width,top,left;
			//			var $obj = $("body");
			//			height = $obj.height();
			//			width = $obj.width();
			//			top = $obj.offset().top;
			//			left = $obj.offset().left;

			$("<div id='ta-progress-1' style='position:absolute;z-index:9990;width:100%;width:400px;height:20px;text-align:left;overflow: hidden;font-family: Verdana, Arial, sans-serif;font-size: 1.1em;border: 1px solid #aaaaaa;background: #ffffff 50% 50% repeat-x;top:45%;;left:35%;'>" + "<div id='ta-progress-2' style='position: absolute;left: 40%;top: 1px;font-weight: bold;text-align: left;'>Loading...</div>" + "<div id='ta-progress-3' style='background-image: none;background: #cccccc 50% 50% repeat-x;font-weight: bold;display: block; width: 0%;height:20px;'></div></div>").appendTo($('body'));

			//初始化
			$("#ta-progress-2").text("Loading..."); //进度条里面文字
			$("#ta-progress-3").css("width", '0%'); //初始化背景色

			if (url.indexOf("!") != -1) {
				session = url.split("!")[0];
			} else {
				session = url.substring(0, url.lastIndexOf("."));
			}
			//不断请求的action地址,该地址不断的从session中读取进度条完成的值
			function simulateProgress() {
				var loadBarValue = 0;
				var int = setInterval(function () {
					$.ajax({
						type: 'POST',
						url: session + '!getProcess.do',
						data: null,
						success: function success(data) {
							loadBarValue = data.percent; //返回的百分比
						},
						dataType: 'json'
					});

					$("#ta-progress-2").text(loadBarValue + '%');
					$("#ta-progress-3").css("width", loadBarValue + '%');
					//加载完成
					if (loadBarValue == 100) {
						$("#ta-progress-2").text(Base.I18n.getLangText("taface.module.window.loadcomplete")); //i18n:加载完成！
						clearInterval(int);
						$("#ta-progress-1").remove();
					}
				}, 300);
			}
			simulateProgress();
		}
	}
});
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(0)))

/***/ }),

/***/ 96:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 97:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 98:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

/******/ });