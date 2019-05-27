webpackJsonp([12],{

/***/ 495:
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
        spinner: spinner
    });
    __webpack_require__(518);
    function spinner(spnId, options) {
        var self = this,
            $input = $("#" + spnId),
            $con = $input.parent(),
            $layoutCon = $con.parent(),
            $Label = $layoutCon.find("label"),
            $up = $con.find(".spinner-ctr-up"),
            $down = $con.find(".spinner-ctr-down");
        options = $.extend({
            max: 9999999, /* 最大值 */
            min: -9999999, /* 最小值 */
            toolTip: null,
            required: false,
            validType: null,
            defValue: 1, /* 默认值 */
            addValue: 1, /* 默认增量 */
            readOnly: false,
            disabled: false,
            isAllowInput: true //默认允许输入
        }, options || {});
        //组件验证
        var validObj = null;
        function init() {
            $input.attr("realId", spnId);
            if (!isNaN(options.defValue)) {
                setValue(options.defValue);
            }
            bindEvent();
            validate();
            setState(true);
        } // end init
        function setState(isInit) {
            if (isInit) {
                if (options.readOnly) setReadOnly();
                if (options.disabled) setEnable(false);
                if (options.required) {
                    setRequired();
                }
                if (options.isAllowInput == false) {
                    controlAllowInput(false);
                }
            } else {
                setReadOnly(options.readOnly);
                setEnable(!options.disabled);
                setValue(options.defValue);
                setRequired(options.required);
                controlAllowInput(options.isAllowInput);
            }
        }

        function bindEvent() {
            $up.on("click.self", function () {
                if (!isNaN(Number(getValue()))) {
                    setValue(FloatAdd(Number(getValue()), options.addValue));
                    $input.triggerHandler("contentChange");
                }
            }).on("mouseout.self", function () {
                Bubble.hideInfo();
            });
            $down.on("click.self", function () {
                if (!isNaN(Number(getValue()))) {
                    setValue(FloatSub(Number(getValue()), options.addValue));
                    $input.triggerHandler("contentChange");
                }
            }).on("mouseout.self", function () {
                Bubble.hideInfo();
            });
            $input.on("focus.self", function () {
                $con.addClass("focus");
            }).on("blur.self", function () {
                $con.removeClass("focus");
            });
        }
        function unbindEvent() {
            $up.off(".self");
            $down.off(".self");
            $input.off(".self");
        }

        function controlAllowInput(bool) {
            if (bool === false) {
                $input.on("focus.AllowInput", function () {
                    $input.blur();
                });
            } else {
                $input.off(".AllowInput");
            }
        }

        function validate() {
            var opts = {
                min: options.min == '0' ? 0 : parseFloat(options.min) || undefined,
                max: options.max == '0' ? 0 : parseFloat(options.max) || undefined
            };
            options.triggerHandles = "input propertychange mouseover focus blur contentChange";
            validObj = new validateObj(spnId, $input, options, setStateStyle);
            $input.addClass("validate");
            validObj.addOrder({ type: "number", param: [opts.min, opts.max] });
            if (options.validType) {
                validObj.addOrder(options.validType);
            }
        }
        //默认验证状态样式调整
        function setStateStyle(value) {
            if (value === false) {
                $con.removeClass("successvalidate").addClass("failvalidate");
                return;
            } else if (value === true) {
                $con.removeClass("failvalidate").addClass("successvalidate");
                return;
            } else {
                Bubble.hideInfo();
                $con.removeClass("failvalidate successvalidate");
            }
        }

        /**
         * 设置是是否必输。
         * @method setRequired
         * @param {bool} value true:必输 false 没有必输要求,默认true
         * @author cy
         */
        function setRequired(bool) {
            if (bool === false) {
                $layoutCon.removeClass("required");
                validObj && validObj.removeOrder("required");
            } else {
                //必输
                $layoutCon.addClass("required");
                if (validObj) {
                    validObj.addOrder({ type: "required", msg: options.toolTip });
                } else {
                    $input.addClass("validate");
                    validObj.addOrder({ type: "required", msg: options.toolTip });
                }
            }
        }
        function doValidate() {
            if (validObj) {
                return validObj.executeValidate();
            } else {
                return true;
            }
        }

        function setReadOnly(isReadOnly) {
            setStateStyle();
            var bool = isReadOnly === false;
            if (bool) {
                bindEvent();
                $con.removeClass("readonly");
                $input.removeAttr('readOnly');
                $Label.attr("for", spnId);
            } else {
                unbindEvent();
                $con.addClass("readonly");
                $input.attr('readOnly', true);
                $Label.attr("for", spnId + "_readonly");
            }
        }

        function setEnable(isEnable) {
            setStateStyle();
            var bool = isEnable === false;
            if (bool) {
                unbindEvent();
                $input.attr('disabled', true);
                $con.addClass("disabled");
            } else {
                bindEvent();
                $input.attr('disabled', false);
                $con.removeClass("disabled");
            }
        }

        function setVisible(isVisiable, isHold) {
            setStateStyle();
            if (isVisiable) {
                $layoutCon.show().css('visibility', 'visible');
            } else {
                if (isHold) {
                    $layoutCon.css('visibility', 'hidden');
                } else {
                    $layoutCon.hide();
                }
            }
        }

        function setFocus() {
            $input.focus();
        }

        // 精确浮点数加运算
        function FloatAdd(arg1, arg2) {
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
            return (arg1 * m + arg2 * m) / m;
        }

        // 精确浮点数减法运算
        function FloatSub(arg1, arg2) {
            var r1, r2, m, n;
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
            // 动态控制精度长度
            n = r1 >= r2 ? r1 : r2;
            return ((arg1 * m - arg2 * m) / m).toFixed(n);
        }

        function getValue() {
            if (!$input) return false;
            return $input.val();
        }

        function setValue(value) {
            if (!$input) return false;
            $input.val(value);
        }
        function clear() {
            if (!$input) return false;
            $input.val("");
            if (validObj) {
                validObj.executeValidate();
            }
        }
        function getInput() {
            return $input;
        }
        function getInputLabel() {
            return $layoutCon.find("label");
        }
        function reset() {
            setState(); //重置状态
            setStateStyle(); //重置样式
        }
        function newSerialize(id, isIncludeNullFields) {
            return $input ? $input.taserialize(isIncludeNullFields) : "";
        }

        init(); // 调用初始化方法

        $.extend(this, { // 为this对象
            "cmptype": 'spinner', // 将方法注册为公共方法
            "getValue": getValue,
            "setValue": setValue,
            "clear": clear,
            "setReadOnly": setReadOnly,
            "setEnable": setEnable,
            "setVisible": setVisible,
            "setFocus": setFocus,
            getInput: getInput,
            doValidate: doValidate,
            controlAllowInput: controlAllowInput,
            getInputLabel: getInputLabel,
            reset: reset,
            "setValidateStyle": setStateStyle,
            "newSerialize": newSerialize,
            "setRequired": setRequired

        });
    }

    return spinner;
});

/***/ }),

/***/ 518:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});