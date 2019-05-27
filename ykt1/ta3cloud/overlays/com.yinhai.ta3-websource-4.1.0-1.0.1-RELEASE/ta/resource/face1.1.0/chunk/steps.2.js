webpackJsonp([2],{

/***/ 496:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(519);
__webpack_require__(520);
__webpack_require__(521);

/***/ }),

/***/ 519:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 520:
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
        TaSteps: TaSteps
    });

    function TaSteps(id, options) {
        options = $.extend({
            current: 0,
            withIcon: false
        }, options || {});

        var $steps = $("#" + id);
        var $stepsItem = $steps.find(".step-item");
        var $stepsLine = $steps.find(".step-item-line");

        function init() {
            if (options.size) {
                stepInitStyle();
            }
            setStep(options.current);
            if (options.withIcon) {
                $stepsLine.addClass("step-item-with-icon");
            }
        }

        //设置步骤条宽度初始值
        function stepInitStyle() {
            var stepWidth = 1 / options.size * 100;
            $stepsItem.css("width", stepWidth + "%");
            $stepsItem.eq(0).addClass("step-item-head");
            $stepsItem.eq(options.size - 1).addClass("step-item-tail");
        }

        //获取当前步骤
        function getStep() {
            var step = $steps.find(".step-item-process").index();
            return step == -1 ? "finish" : step / 2;
        }

        //指定当前步骤
        function setStep(current) {
            $stepsItem.removeClass("step-item-finish step-item-process");
            if (current < options.size) {
                for (var i = 0; i < current; i++) {
                    $stepsItem.eq(i).addClass("step-item-finish");
                }
                $stepsItem.eq(current).addClass("step-item-process");
            }if (current == options.size) {
                $stepsItem.addClass("step-item-finish");
            }
        }

        //设置下一步
        function nextStep(callback) {
            var currentIndex = getStep();
            if (currentIndex != "finish") {
                setStep(currentIndex + 1);
                if (typeof callback == 'function') {
                    var status = currentIndex + 1 == options.size ? true : false;
                    var step = currentIndex + 1 == options.size ? 'finish' : currentIndex + 1;
                    callback(status, step);
                }
            }
        }

        init();

        return {
            "cmptype": 'TaSteps',
            'version': '1.1.0',
            getStep: getStep,
            setStep: setStep,
            nextStep: nextStep
        };
    }
    return TaSteps;
});

/***/ }),

/***/ 521:
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
        TaStep: TaStep
    });

    function TaStep(id, options) {
        options = $.extend({
            textHelp: false,
            beforeSelect: null,
            onClick: null,
            afterSelected: null
        }, options || {});

        var $stepItem = $("#" + id);
        var $textHelp = $stepItem.find(".step-item-line");
        var $stepsItem = $stepItem.parent(".steps-layout-container").find(".step-item");
        var size = $stepItem.parent(".steps-layout-container").attr("size");

        function init() {
            if (options.textHelp) {
                var _op = {
                    info: options.textHelp,
                    width: "180",
                    position: 'topCenter'
                };
                Bubble.setInfoConStyle(180);
                Bubble.setBubbleEvent($textHelp, _op);
            }

            $stepItem.on("click", function () {
                if (options.onClick) {
                    eval(options.onClick)(id, getStep());
                }
            });
        }

        function getStep() {
            return $stepItem.index() / 2;
        }

        function setStepSelect() {
            var current = getStep();
            if (options.beforeSelect) {
                var result = eval(options.beforeSelect)();
                if (!(result == true || result == "true")) {
                    return false;
                }
            }

            $stepsItem.removeClass("step-item-finish step-item-process");
            if (current < size) {
                for (var i = 0; i < current; i++) {
                    $stepsItem.eq(i).addClass("step-item-finish");
                }
                $stepsItem.eq(current).addClass("step-item-process");
            }if (current == size) {
                $stepsItem.addClass("step-item-finish");
            }

            if (options.afterSelected) {
                eval(options.afterSelected)(current);
            }
        }

        init();

        return {
            "cmptype": 'TaStep',
            'version': '1.1.0',
            getStep: getStep,
            setStepSelect: setStepSelect
        };
    }
    return TaStep;
});

/***/ })

});