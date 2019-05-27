webpackJsonp([14],{

/***/ 490:
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
    ;
    __webpack_require__(512);
    $.extend(true, window, {
        TaProgress: TaProgress
    });

    function TaProgress($obj, wd, ht) {
        var self = this;
        var $el;
        var all = 100,
            pro = 0,
            wd = wd || 320,
            ht = ht || 16,
            wd = parseInt(wd),
            ht = parseInt(ht);
        function creatProgress() {
            $el = $("<div class='progress'><div class='in' style='width: 0px'><span>" + pro + "%</span></div></div>");
            $el.css({ "width": wd + "px", "height": ht + "px", "line-height": ht + "px" });
            pro = 0;
            $obj.html($el);
        }
        function setProgress(p) {
            var p = parseInt(p),
                w;
            if (p < 0) {
                pro = 0, w = 0;
            } else if (p > 100) {
                pro = 100, w = wd;
            } else {
                pro = p, w = pro / 100 * wd;
            }
            var pro_in = $el.find(".in");
            $(pro_in).children().html(pro + "%");
            pro_in.stop().animate({
                width: w + "px"
            }, 300);
        }
        function removeProgress() {
            $el.remove();
        }
        function init() {
            creatProgress();
        }
        init();

        $.extend(this, { // 为this对象
            "cmptype": 'TaProgress', // 将方法注册为公共方法
            "version": "3.13.0",
            "setProgress": setProgress,
            "removeProgress": removeProgress
        });
    }
    return TaProgress;
});

/***/ }),

/***/ 512:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});