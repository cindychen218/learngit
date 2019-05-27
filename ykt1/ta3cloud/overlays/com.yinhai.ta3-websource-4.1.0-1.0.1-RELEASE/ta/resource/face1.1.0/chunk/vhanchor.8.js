webpackJsonp([8],{

/***/ 502:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

__webpack_require__(530);
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
        VHanchor: VHanchor
    });

    function VHanchor(id, options) {
        var self = $("#" + id);
        options = $.extend({}, options);
        var scrollContainerId = options.scrollContainerId;
        var $container = $(scrollContainerId);
        if (self.hasClass("vertical")) {
            $(".goto_top", self).bind("click", function () {
                $(".anchor_btn", self).removeClass("active");
                $container.stop().animate({
                    "scrollTop": 0
                }, 500, "swing");
            });

            var $anchorBtn = $(".anchor_btn", self),
                anchorHeight = 0;
            for (var i = 0; i < $anchorBtn.length; i++) {
                anchorHeight += $anchorBtn.eq(i).outerHeight(true);
            }
            $(".anchor-box", self).css("height", anchorHeight + "px");

            $(".anchor-close", self).bind("click", function () {
                var $this = $(this);
                if ($this.hasClass("active")) {
                    $this.removeClass("active").children().removeClass("icon-maximization").addClass("icon-dbArrow_right");
                    self.css("width", "98px");
                    $(".anchor-box", self).stop().animate({ height: anchorHeight + "px" }, 200, "linear");
                } else {
                    $this.addClass("active").children().removeClass("icon-dbArrow_right").addClass("icon-maximization");
                    self.css("width", "68px");
                    $(".anchor-box", self).stop().animate({ height: "0px" }, 200, "linear");
                }
            });
        }
        $(".anchor_btn", self).bind("click", function () {
            $(this).addClass("active").siblings().removeClass("active");
            var targetid = $(this).attr("data-targetId");
            var $target = $("#" + targetid);
            if (scrollContainerId == "html,body") {
                var top = $target.offset().top;
            } else {
                //Selina 容器滚动的距离+目标元素到文档顶部的距离-容器到文档顶部的距离
                var top = $container.scrollTop() + $target.offset().top - $container.offset().top;
            }
            $container.stop().animate({
                scrollTop: top
            }, 500, "swing");
        });
    }
});

/***/ }),

/***/ 530:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});