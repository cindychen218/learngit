webpackJsonp([10],{

/***/ 500:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(60), __webpack_require__(28)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {

    __webpack_require__(527);
    $.extend(true, window, {
        TaVerticalTabs: TaVerticalTabs
    });
    function TaVerticalTabs(id, options) {
        var self = this,
            $obj = $("#" + id);
        //加上:first筛选，解决tabsVertical互相嵌套，标签头显示重复问题 add by zhouhy
        var tblist = $obj.find(".v-con:first>div>div");
        var dfHeight = $obj.parent().height();
        self.options = $.extend({
            cssClass: "",
            cssStyle: {},
            fit: true,
            width: "100%",
            height: dfHeight + "px",
            tabWidth: 100
        }, options);
        var layout = new TaFit($obj);
        function init() {
            initTabsStyle();
            initTabs();
            initState();
            layout.tauifitheight();
        }
        //初始化样式
        function initTabsStyle() {
            //class
            if (self.options.cssClass) {
                $obj.addClass(self.options.cssClass);
            }
            //style
            if (self.options.cssStyle) {
                $obj.attr("style", self.options.cssStyle);
            }
            if (self.options.height) {
                $obj.css("height", self.options.height);
            }
            if (self.options.width) {
                $obj.css("width", self.options.width);
            }
            if (self.options.tabWidth) {
                $obj.find('.v-tabs').css("width", parseInt(self.options.tabWidth) + "px");
            }
        }
        //初始化选项卡
        //        * cssClass 自定义class样式
        //        * cssStyle 自定义css样式
        //        * id       组件id
        //        * key      组件显示在tab页的名字
        //        * selected tab是否选中
        function initTabs() {
            var a = [],
                i = 0,
                len = tblist.length;
            //初始化选项卡
            for (i; i < len; i++) {
                var key = tblist[i].getAttribute("title") || "tab" + (i + 1);
                var cardId = tblist[i].getAttribute("id") + "_card";
                var str = "<div id='" + cardId + "' title='" + key + "'>" + key + "</div>";
                a.push(str);
            }
            $obj.find(".v-tabs").html(a.join(" "));
            //选项卡点击切换
            $obj.find(".v-tabs>div").off("click").on("click", function () {
                var id = this.getAttribute("id");
                id = id.substring(0, id.lastIndexOf("_"));
                setFocus(id);
                if (options.onSelect) options.onSelect(id);
            });
        }

        function setFocus(id) {
            $("#" + id).addClass("selected").siblings("div").removeClass("selected");
            //对tab嵌套的tabs的表头进行重绘
            var pl = $("#" + id);
            if (pl.find(".tabs-container").length > 0) {
                var panel = pl.find(".tabs-container");
                panel.tauitabs("setScrollers");
                layout.tauifitheight();
            }
            $('>div:visible[fit=true],>div[fit=true] ,>form[fit=true],>div.grid[height],>div.ez-fl>div.grid[height]', pl).each(function () {
                $(this).triggerHandler('_resize');
            });

            $("#" + id + "_card").addClass("selected").siblings("div").removeClass("selected");
        }
        function initState() {
            var i = 0,
                len = tblist.length;
            for (i; i < len; i++) {
                if (tblist[i].getAttribute("selected") == true || tblist[i].getAttribute("selected") == "true") {
                    setFocus(tblist[i].getAttribute("id"));
                    return;
                }
            }
            setFocus(tblist[0].getAttribute("id"));
            return;
        }

        function setEnable(isEnable) {
            if (!$obj) return false;
            if (isEnable === false) {
                $obj.find(".v-con>div>div").addClass('disabled');
                TaContainerSupport.setEnable(id, false);
            } else {
                $obj.find(".v-con>div>div").removeClass('disabled');
                TaContainerSupport.setEnable(id, true);
            }
        }

        function setVisible(isVisiable, isHold) {
            TaContainerSupport.setVisible(id, isVisiable, isHold);
        }
        function setReadOnly(isReadOnly) {
            TaContainerSupport.setReadOnly(id, isReadOnly);
        }

        function setRequired(isRequired) {
            TaContainerSupport.setRequired(options.id, isRequired);
        }

        function resetData() {
            TaContainerSupport.resetData(options.id);
        }
        function clearData() {
            TaContainerSupport.clearData(options.id);
        }
        function doValidate() {
            var result = TaContainerSupport.doValidate(options.id);
            if (typeof result == 'string') {
                return false;
            }
            return result;
        }

        function cleanValidateStyle() {
            TaContainerSupport.cleanValidateStyle(options.id);
        }

        init();
        $.extend(this, {
            "cmptype": 'TaVerticalTabs',
            "version": '3.13.0',
            "setFocus": setFocus,
            "setVisible": setVisible,
            "setEnable": setEnable,
            "setReadOnly": setReadOnly,
            "setRequired": setRequired,
            "reset": resetData,
            "clearData": clearData,
            "doValidate": doValidate,
            "cleanValidateStyle": cleanValidateStyle
        });
    }
    return TaVerticalTabs;
});

/***/ }),

/***/ 527:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});