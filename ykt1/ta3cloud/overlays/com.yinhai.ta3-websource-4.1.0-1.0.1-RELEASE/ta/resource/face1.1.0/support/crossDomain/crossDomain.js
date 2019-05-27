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
/******/ 	return __webpack_require__(__webpack_require__.s = 201);
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

/***/ 201:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


window.Base = window.Base || {};

__webpack_require__(89);
__webpack_require__(36);

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

/***/ 89:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * JS 基本方法扩展
 */
(function () {
    String.prototype.startsWith = function (str) {
        var reg = new RegExp("^" + str);
        return reg.test(this);
    };

    String.prototype.endsWith = function (str) {
        var reg = new RegExp(str + "$");
        return reg.test(this);
    };

    String.prototype.endsWithIn = function (ary) {
        for (var i = 0; i < ary.length; i++) {
            var reg = new RegExp(ary[i] + "$");
            if (reg.test(this)) {
                return true;
            } else {
                continue;
            }
        }
        return false;
    };
})();

/***/ })

/******/ });