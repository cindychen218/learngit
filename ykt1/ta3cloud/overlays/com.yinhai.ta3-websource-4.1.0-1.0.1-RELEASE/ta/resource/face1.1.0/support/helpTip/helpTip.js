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
/******/ 	return __webpack_require__(__webpack_require__.s = 205);
/******/ })
/************************************************************************/
/******/ ({

/***/ 0:
/***/ (function(module, exports) {

module.exports = window.$;

/***/ }),

/***/ 100:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/*!
 * cookie
 * Copyright(c) 2012-2014 Roman Shtylman
 * Copyright(c) 2015 Douglas Christopher Wilson
 * MIT Licensed
 */



/**
 * Module exports.
 * @public
 */

exports.parse = parse;
exports.serialize = serialize;

/**
 * Module variables.
 * @private
 */

var decode = decodeURIComponent;
var encode = encodeURIComponent;
var pairSplitRegExp = /; */;

/**
 * RegExp to match field-content in RFC 7230 sec 3.2
 *
 * field-content = field-vchar [ 1*( SP / HTAB ) field-vchar ]
 * field-vchar   = VCHAR / obs-text
 * obs-text      = %x80-FF
 */

var fieldContentRegExp = /^[\u0009\u0020-\u007e\u0080-\u00ff]+$/;

/**
 * Parse a cookie header.
 *
 * Parse the given cookie header string into an object
 * The object has the various cookies as keys(names) => values
 *
 * @param {string} str
 * @param {object} [options]
 * @return {object}
 * @public
 */

function parse(str, options) {
  if (typeof str !== 'string') {
    throw new TypeError('argument str must be a string');
  }

  var obj = {}
  var opt = options || {};
  var pairs = str.split(pairSplitRegExp);
  var dec = opt.decode || decode;

  for (var i = 0; i < pairs.length; i++) {
    var pair = pairs[i];
    var eq_idx = pair.indexOf('=');

    // skip things that don't look like key=value
    if (eq_idx < 0) {
      continue;
    }

    var key = pair.substr(0, eq_idx).trim()
    var val = pair.substr(++eq_idx, pair.length).trim();

    // quoted values
    if ('"' == val[0]) {
      val = val.slice(1, -1);
    }

    // only assign once
    if (undefined == obj[key]) {
      obj[key] = tryDecode(val, dec);
    }
  }

  return obj;
}

/**
 * Serialize data into a cookie header.
 *
 * Serialize the a name value pair into a cookie string suitable for
 * http headers. An optional options object specified cookie parameters.
 *
 * serialize('foo', 'bar', { httpOnly: true })
 *   => "foo=bar; httpOnly"
 *
 * @param {string} name
 * @param {string} val
 * @param {object} [options]
 * @return {string}
 * @public
 */

function serialize(name, val, options) {
  var opt = options || {};
  var enc = opt.encode || encode;

  if (typeof enc !== 'function') {
    throw new TypeError('option encode is invalid');
  }

  if (!fieldContentRegExp.test(name)) {
    throw new TypeError('argument name is invalid');
  }

  var value = enc(val);

  if (value && !fieldContentRegExp.test(value)) {
    throw new TypeError('argument val is invalid');
  }

  var str = name + '=' + value;

  if (null != opt.maxAge) {
    var maxAge = opt.maxAge - 0;
    if (isNaN(maxAge)) throw new Error('maxAge should be a Number');
    str += '; Max-Age=' + Math.floor(maxAge);
  }

  if (opt.domain) {
    if (!fieldContentRegExp.test(opt.domain)) {
      throw new TypeError('option domain is invalid');
    }

    str += '; Domain=' + opt.domain;
  }

  if (opt.path) {
    if (!fieldContentRegExp.test(opt.path)) {
      throw new TypeError('option path is invalid');
    }

    str += '; Path=' + opt.path;
  }

  if (opt.expires) {
    if (typeof opt.expires.toUTCString !== 'function') {
      throw new TypeError('option expires is invalid');
    }

    str += '; Expires=' + opt.expires.toUTCString();
  }

  if (opt.httpOnly) {
    str += '; HttpOnly';
  }

  if (opt.secure) {
    str += '; Secure';
  }

  if (opt.sameSite) {
    var sameSite = typeof opt.sameSite === 'string'
      ? opt.sameSite.toLowerCase() : opt.sameSite;

    switch (sameSite) {
      case true:
        str += '; SameSite=Strict';
        break;
      case 'lax':
        str += '; SameSite=Lax';
        break;
      case 'strict':
        str += '; SameSite=Strict';
        break;
      default:
        throw new TypeError('option sameSite is invalid');
    }
  }

  return str;
}

/**
 * Try decoding a string using a decoding function.
 *
 * @param {string} str
 * @param {function} decode
 * @private
 */

function tryDecode(str, decode) {
  try {
    return decode(str);
  } catch (e) {
    return str;
  }
}


/***/ }),

/***/ 101:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 205:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


window.Base = window.Base || {};
//cookie并不是标准的模块所以webpack不能识别用相对路径来引入
__webpack_require__(99);
__webpack_require__(72);

/***/ }),

/***/ 72:
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;(function(factory){
	if (true) {
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0),__webpack_require__(100)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		factory(jQuery);
	}
}(function($){
	$.extend(true, window, {
		TaHelpTip : TaHelpTip
	});

	__webpack_require__(101);
	function TaHelpTip($helpTipId){
		var defaults = {
			replay:false,// 是否自动播放
			delayTime:3000,
			show:true,
			cookname:null,
			func: null,
			reID:"xxx",// "hint_tip",
			data:[]
		};

        $.clearCookieHintArray = function(currentBid){
            var data = {};
            var cookieArray = document.cookie.split(";");
            var hintCookies = new Array();

            for (var i = 0; i < cookieArray.length; i++) {
                var cookie = cookieArray[i].split("=");// 将名和值分开
                var name = $.trim(cookie[0]);
                var c_start = name.indexOf("hint_")
                if (c_start != -1) {
                    if(!currentBid)
                        $.cookie(name,null,{path:'/'});
                    if(("hint_"+currentBid) == name)
                        $.cookie(name,null,{path:'/'});
                }
            }

        }

		function helpTip(options){
			var opts = $.extend(defaults,options);
			var replay   = opts.replay;
			var delayTime= opts.delayTime;
			var show     = opts.show;
			var cookname = opts.cookname;
			var func     = opts.func;
			var data     = opts.data;
			var reID     = opts.reID;

			var screenHeight = $(window).height();
			var bodyHeight   = $(document).height();
			//var s_b = screenHeight/bodyHeight;
			var bodyWidth  = $("body").width();
			var nowbody    = $("body"),url = window.location.href;
			var time1;
			var time2;
			var hintName   = encodeURI("hint_"+cookname); // encodeURI("hint_"+url);    //"hint_"+url.replace(/\//g, "").replace(/:/g, "");
			var hintValue  = encodeURI("hint_"+cookname); // encodeURI("hint_"+url);    //"hint_"+url.replace(/\//g, "").replace(/:/g, "");
			//初始化
			init();
			//初始化
			function init(){
               // $.clearCookieHintArray(cookname);//change by zzb
				if(show){
					if(!checkHintCookie()){
						nowbody.append("<div class='hint-mask'"
							+"style='width:"+bodyWidth+"px;height:"+bodyHeight+"px;'></div>");
						//遍历提示步骤
						stepTip();
					}
				}

				$(".hint-tips .hint-contents .hc-message .hm-opts .ho-next").bind("click",function(){

					var nowhint = $(this).parent().parent().parent().parent();
					var step = parseInt(nowhint.attr("step"));
					//当前div如果是最后一个，则不在执行任何下一步操作（隐藏当前窗口 和 寻找下一窗口并且打开）
					if(step == data.length-1){
						return;
					}
//						nowhint.remove();
					nowhint.hide();

					var nexthint = $(".hint-tips[step='"+(step+1)+"']");
					nexthint.show();
					var scrollTop = nexthint.offset().top;
					$("body,html").animate({
						scrollTop:scrollTop-200
					});
				});

				//注册点击上一步事件
				$(".hint-tips .hint-contents .hc-message .hm-opts .ho-pre").bind("click",function(){
					var nowhint = $(this).parent().parent().parent().parent();
					var step = parseInt(nowhint.attr("step"));
//				     nowhint.remove();
					nowhint.hide();

					var prehint = $(".hint-tips[step='"+(step-1)+"']");
					prehint.show();
					var scrollTop = prehint.offset().top;
					$("body,html").animate({
						scrollTop:scrollTop-200
					});

				});

				//注册点击关闭向导事件
				$(".hint-tips .hint-contents .hc-close").bind("click",function(){

					$(".hint-tips").remove();
					$(".hint-mask").remove();
					if(!checkHintCookie()){
						writeCookie(hintName,hintValue);// 暂时关闭
					}
					clearTimeout(time1);
					clearTimeout(time2);
//					 self = null;
				});

				//最后一步关闭向导
				$(".hint-tips .hint-contents .hc-message .hm-opts .ho-last").bind("click",function(){
					$(".hint-tips").remove();
					$(".hint-mask").remove();
					if(!checkHintCookie()){
						writeCookie(hintName,hintValue);
					}
					clearTimeout(time1);
					clearTimeout(time2);
				});

				//自动播放
				if(replay){
					time1 = setTimeout(autoPlay,delayTime) ;
				}

				/**
				 * 重新引导
				 */
				$("#"+reID).bind("click",function(){

					var hintCookieArray = new Array();
					var data = {};
					hintCookieArray = _getHintCookies("hint_");
					for(var i = 0;i<hintCookieArray.length;i++){
						var name = hintCookieArray[i];
						$.cookie(name,null,{path:'/'});
					}
				});

			};
			//遍历data
			function stepTip(){
				var len = data.length;
				var isOne = false;
				var i,
					obj,
					id;

				if(len==0){
					return false;
				}
				for(i=0;i<len;i++){
					var ditem = data[i];
					id = ditem.id;
					var message = ditem.message;
					var child = ditem.child;
					if(typeof id == "string") {
						obj = $("#"+id);
					}
					if(typeof id == "object") {
						obj = id;
					}
					if(!obj || !obj[0]){
						continue;
					}else{
						isOne = true;
					}
					createHint(obj,message,i,len,child);
				}
				if(!isOne){
					$(".hint-tips").remove();
					$(".hint-mask").remove();
				}
			};

			/**
			 * 创建提示的div
			 */
			function createHint(obj,message,i,len,child){
				var message,
					o_height,
					o_width,
					ditem,
					o_x,
					o_y,
					borderHeight,
					borderWidth,
					arrowHeight,
					arrowWidth;
				o_height = obj.outerHeight();
				o_width  = obj.outerWidth();

				o_x = obj.offset().left;
				o_y = obj.offset().top;
				if(child == true) {
					o_x = o_x + 140;
					o_y = o_y + 101;
				}
				arrowHeight = 65;
				var ht_style = "width:"+(350)+	"px;left:"+o_x+"px;top:"+o_y+	"px;min-width:250px;";
				var hc_style = "margin-top:"+(arrowHeight+o_height)+"px;";
				var hb_style = "width:"+o_width   +"px;height:"+o_height   +"px;top:"+-(arrowHeight+o_height)	+"px;left:-1px;";

				var div =$("<div class=\"hint-tips\" style="+ht_style+"  step="+i+">"
					+"<div class=\"hint-contents\" style="+hc_style+">"
					+"<div class=\"hc-border\" style="+hb_style+"></div>"
					+"<div class=\"hc-arrow toTop\"></div>"
					+"<div class=\"hc-close faceIcon icon-close \"></div>"
					+"<div class=\"hc-message\">"
					+"<div class=\"hm-content\">"+message+"</div>"
					+"<div class=\"hm-opts\">"
					+"<span class=\"ho-next\">"+ Base.I18n.getLangText('taface.module.helptip.nextstep')+"</span>"//下一步
					+"<span class=\"ho-last\">"+ Base.I18n.getLangText('taface.module.helptip.navigationendenterwebsite')+"</span>"//导航结束进入网站
					+"<span class=\"ho-pre\">"+ Base.I18n.getLangText('taface.module.helptip.previousstep')+"</span>"//上一步
					+"</div>"
					+"</div>"
					+"</div>"
					+"</div>");
				nowbody.append(div);

				//箭头 提示内容的位置
				var offset = 30;
				var div_width = div.outerWidth()+offset;
				var div_height = div.outerHeight();
				var content_height =div_height - parseInt(div.children(".hint-contents").css("margin-top"));

				var flag_w = div_width + o_x;
				var flag_h = div_height + o_y;

				// 2.
				if(flag_w>=bodyWidth&&flag_h<bodyHeight){
					div.css("left",(o_x+o_width-div_width)+"px");
					div.find(".hc-border").css("left",(div_width-o_width)+"px");
					div.find(".hc-arrow").css({"left":(div_width-70)+"px"}).removeClass("toBottom").addClass("toTop");
				}
				// 3.
				if(flag_w>=bodyWidth&&flag_h>=bodyHeight){
					div.css({"left":(o_x+o_width-div_width)+"px","top":(o_y-div_height-arrowHeight)+ "px"});
					div.find(".hc-border").css({"left":(div_width-o_width)+"px","top":(content_height+arrowHeight)});
					div.find(".hc-arrow" ).css({
						"left":(div_width-70)+"px","top":content_height+"px"}).removeClass("toTop").addClass("toBottom");
					//add by cy 调整目标元素为全屏的时候的情况
					if(parseInt(div.css("top"))+o_height+arrowHeight<0){//如果向上超出//改为向下显示
						div.css({"top":(o_y-div_height-arrowHeight+content_height+arrowHeight+arrowHeight)+"px"});
						div.find(".hc-border").css({"top":(content_height+arrowHeight-content_height-arrowHeight-arrowHeight)});
						div.find(".hc-arrow").css({"top":-arrowHeight+4+"px"}).removeClass("toBottom").addClass("toTop");
					}
				}
				//4.
				if(flag_w<bodyWidth&&flag_h>=bodyHeight){
					div.css({"top":(o_y-div_height-arrowHeight)+"px"});
					div.find(".hc-border").css({"top":(content_height+arrowHeight)});
					div.find(".hc-arrow").css({"top":content_height+"px"}).removeClass("toTop").addClass("toBottom");//原设置
					//add by cy 调整目标元素为全屏的时候的情况
					if(parseInt(div.css("top"))+o_height+arrowHeight<0){//如果向上超出//改为向下显示
					 div.css({"top":(o_y-div_height-arrowHeight+content_height+arrowHeight+arrowHeight)+"px"});
					 div.find(".hc-border").css({"top":(content_height+arrowHeight-content_height-arrowHeight-arrowHeight)});
					 div.find(".hc-arrow").css({"top":-arrowHeight+4+"px"}).removeClass("toBottom").addClass("toTop");
					}


				}
				if(i==0){
					div.show();
					$("body,html").animate({
						scrollTop:o_y-200 //*s_b + 100
					});
				}else{
					div.find(".hm-opts").children(".ho-pre").show();// 只要不是第一次，就显示“上一步”按钮
				}

				if(i==(len-1)){
					div.find(".hm-opts").children(".ho-next").hide();
					div.find(".hm-opts").children(".ho-last").show();
				}

			};

			//注册点击下一步事件
			function autoPlay(){
				var nowhint = $(".hint-tips:visible");//获取当前可见的那个div，首次执行时可见的就是第一个div
				var step = parseInt(nowhint.attr("step"));
				$(".hint-tips[step='"+(step)+"'] .hint-contents .hc-message .hm-opts .ho-next").click();
				if(step==data.length-1){
					clearTimeout(time1);
					return;
				}
				time2 = setTimeout(autoPlay,delayTime) ;
			}

			//向cookie写入数据
			function writeCookie(hintName,hintValue){
				var data= {};
				data["dto['hintName']"]  = hintName;
				data["dto['hintValue']"] = hintValue;
				$.cookie(hintName, hintValue, { expires: 365, path: '/' });

			};

			//检查hintcookie是否存在
			function checkHintCookie(){
				var cookieValue = getHintCookie(hintName);
				if(cookieValue==hintValue){
					return true;
				}
				return false;
			};

			/**
			 * 获得所有名称包括c_name的cookie
			 */
			function _getHintCookies(c_name){
				var cookieArray = document.cookie.split(";");
				var hintCookies = new Array();
				for (var i = 0;i<cookieArray.length;i++){
					var cookie = cookieArray[i].split("=");//将名和值分开
					var name   = $.trim(cookie[0]);
					var c_start = name.indexOf(c_name)
					if(c_start != -1){
						hintCookies.push(name);
					}
				}

				return hintCookies;
			}

			function getHintCookie(name){
				var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对
				var cookie = new Object();
				for (var i=0;i<cookieArray.length;i++){
					var arr=cookieArray[i].split("=");       //将名和值分开

					if($.trim(arr[0])==$.trim(name))
						return unescape(arr[1]); //如果是指定的cookie，则返回它的值
				}
				return "";
			};
		}

		// init(); 调初始化方法
		$.extend(this, { // 为this对象
			"cmptype" : 'helptip',// 将方法注册为公共方法
			"version" : "3.13.0",
			"helpTip": helpTip,
			"clearCookieHintArray" : $.clearCookieHintArray
		});
	}
	return TaHelpTip;
}));



/***/ }),

/***/ 99:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
	if (true) {
		// AMD. Register as anonymous module.
		!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	} else {
		// Browser globals.
		factory(jQuery);
	}
})(function ($) {

	var pluses = /\+/g;

	function encode(s) {
		return config.raw ? s : encodeURIComponent(s);
	}

	function decode(s) {
		return config.raw ? s : decodeURIComponent(s);
	}

	function stringifyCookieValue(value) {
		return encode(config.json ? JSON.stringify(value) : String(value));
	}

	function parseCookieValue(s) {
		if (s.indexOf('"') === 0) {
			// This is a quoted cookie as according to RFC2068, unescape...
			s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
		}

		try {
			// Replace server-side written pluses with spaces.
			// If we can't decode the cookie, ignore it, it's unusable.
			s = decodeURIComponent(s.replace(pluses, ' '));
		} catch (e) {
			return;
		}

		try {
			// If we can't parse the cookie, ignore it, it's unusable.
			return config.json ? JSON.parse(s) : s;
		} catch (e) {}
	}

	function read(s, converter) {
		var value = config.raw ? s : parseCookieValue(s);
		return $.isFunction(converter) ? converter(value) : value;
	}

	var config = $.cookie = function (key, value, options) {

		// Write
		if (value !== undefined && !$.isFunction(value)) {
			options = $.extend({}, config.defaults, options);

			if (typeof options.expires === 'number') {
				var days = options.expires,
				    t = options.expires = new Date();
				t.setDate(t.getDate() + days);
			}

			return document.cookie = [encode(key), '=', stringifyCookieValue(value), options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
			options.path ? '; path=' + options.path : '', options.domain ? '; domain=' + options.domain : '', options.secure ? '; secure' : ''].join('');
		}

		// Read

		var result = key ? undefined : {};

		// To prevent the for loop in the first place assign an empty array
		// in case there are no cookies at all. Also prevents odd result when
		// calling $.cookie().
		var cookies = document.cookie ? document.cookie.split('; ') : [];

		for (var i = 0, l = cookies.length; i < l; i++) {
			var parts = cookies[i].split('=');
			var name = decode(parts.shift());
			var cookie = parts.join('=');

			if (key && key === name) {
				// If second argument (value) is a function it's a converter...
				result = read(cookie, value);
				break;
			}

			// Prevent storing a cookie that we couldn't decode.
			if (!key && (cookie = read(cookie)) !== undefined) {
				result[name] = cookie;
			}
		}

		return result;
	};

	config.defaults = {};

	$.removeCookie = function (key, options) {
		if ($.cookie(key) !== undefined) {
			// Must not alter options, thus extending a fresh object...
			$.cookie(key, '', $.extend({}, options, { expires: -1 }));
			return true;
		}
		return false;
	};
});

/***/ })

/******/ });