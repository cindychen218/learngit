webpackJsonp([16],{

/***/ 486:
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
    __webpack_require__(506);
    $.extend(true, window, {
        TaBadge: TaBadge
    });

    function TaBadge(id, options) {
        options = $.extend({
            badgeKey: null,
            badgeMax: null,
            badgePosition: "topRight",
            badgeDisplay: null,
            badgeIcon: null,
            isDot: null
        }, options || {});
        var $badge = $("#" + id);
        var $badgeContainer = $badge.parent(".badge-Container");
        var $badgeTagContainer = $badge.siblings(".badge-tag-Container");
        var $badgeKey = $badge.siblings(".badge-key");

        function init() {
            //包裹组件时隐藏描述文字
            if ($badgeTagContainer.children().size() > 0) {
                $badgeKey.hide();
            }

            //圆点
            if (options.isDot) {
                _setBadgePosition(options.badgePosition);
                return false;
            }

            //文字
            if (options.badgeKey) {
                setBadgeValue(options.badgeKey);
            } else {
                //没有文字、图片默认为的圆点
                if (!options.badgeIcon && options.isDot != false) {
                    $badge.addClass("isDot");
                }
                _setBadgePosition(options.badgePosition);
            }
        }

        /**
         * 设置徽标记显示值
         * @method setBadgeValue
         * @param {value} 若徽标记为数字且大于最大值，显示为 "最大值+"。否则直接显示
         */
        function setBadgeValue(value) {
            //圆点设值
            if (options.isDot || !options.badgeKey && !options.badgeIcon) {
                $badge.removeClass("isDot");
            }

            //数字且最大值存在
            if (options.badgeMax != null && !isNaN(options.badgeMax) && !isNaN(value)) {
                var badgeKey = parseInt(value),
                    badgeMax = parseInt(options.badgeMax);
                if (badgeMax > 0) {
                    if (badgeKey > badgeMax) {
                        $badge.html(badgeMax + "+");
                    } else {
                        $badge.html(badgeKey);
                    }
                } else {
                    setBadgeVisible(false);
                }
            } else {
                $badge.html(value);
            }
            _setBadgePosition(options.badgePosition);
        }

        /**
         * 设置徽标记位置
         * @method _setBadgePosition
         * @param {value} 设置徽标记位置，left：居左，right：居右，topRight：右上方（默认）
         */
        function _setBadgePosition(position) {
            if ($badgeTagContainer.children().size() > 0) {
                $badgeContainer.css("display", "block");
                $badge.css({ "left": "auto", "right": "-4px" });
            } else if (options.badgeDisplay != "false" && options.badgeDisplay != "none") {
                var containerH = $badgeContainer.outerHeight(true),
                    badgeH = $badge.outerHeight(true),
                    badgeTop = 0;
                if (containerH - badgeH > 0) {
                    badgeTop = (containerH - badgeH) / 2;
                }

                if (position == "left") {
                    $badgeContainer.prepend($badge);
                    $badge.addClass("badge-left");
                    $badge.css({ "top": badgeTop });
                } else if (position == "right") {
                    $badge.css({ "top": badgeTop });
                }
            }
        }

        /**
         * 设置徽标记是否显示
         * @method setBadgeVisible
         * @param {showOrHide} 设置隐藏还是显示，默认true显示
         */
        function setBadgeVisible(showOrHide) {
            var showOrHide = showOrHide === false ? false : true;
            if (showOrHide) {
                $badge.show();
                _setBadgePosition(options.badgePosition);
            } else {
                $badge.hide();
                $badgeContainer.css({ "padding-left": 0 });
            }
        }

        init();

        return {
            "cmptype": 'TaBadge',
            'version': '1.1.0',
            setBadgeValue: setBadgeValue,
            setBadgeVisible: setBadgeVisible
        };
    }

    return TaBadge;
});

/***/ }),

/***/ 506:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});