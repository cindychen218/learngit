webpackJsonp([13],{

/***/ 494:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(17), __webpack_require__(54), __webpack_require__(53)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {

    __webpack_require__(517);
    $.extend(true, window, {
        TaSelectData: TaSelectData
    });
    function TaSelectData(selectDataId, options) {
        options = $.extend({
            bpopTipMsg: null,
            bpopTipWidth: 500,
            bpopTipHeight: 300,
            bpopTipPosition: "top",
            multiple: false,
            inputQueryNum: 2,
            inputMinWidth: 140,
            titleValue: 'title',
            hiddenValue: 'id',
            displayValue: 'name',
            placeholder: null,
            value: null,
            required: false,
            readOnly: false,
            disabled: false,
            validType: null
        }, options || {});
        var $showInput = $("#" + selectDataId).attr("realId", selectDataId);
        var $showInputBox = $showInput.parent("div.selectData-input-box");
        var $inputContainer = $showInputBox.parent("div.selectData-input-Container");
        var $layoutContainer = $inputContainer.parent("div.selectData-layout-Container");
        var $winContainer = $("div.selectData-win-Container", $inputContainer);
        var $hiddenInput = $("#" + options.name).addClass("ComponentsSerialize"); //添加组件传参标识
        var $validateIcon = $showInput.siblings(".validateIcon");
        var $Label = $(".selectData-label", $layoutContainer);
        var validObj = null;
        //组件事件静默标志 true 静默，静默类事件不执行
        var isSilence = false;

        function init() {
            $(document).mousedown(function (e) {
                var target = e.target || e.srcElement;
                if (!($(target).is(".selectData-win-Container") || $(target).parents(".selectData-win-Container").length > 0)) {
                    $winContainer.hide();
                }
            });

            $showInput.on("focus", function (event) {
                if (isSilence) return;
                $inputContainer.addClass("active");
            }).on("blur", function () {
                if (isSilence) return;
                $inputContainer.removeClass("active");
            }).on("keyup", function (event) {
                if (isSilence) return;
                if (this.value != null && $.trim(this.value) != "" && $.trim(this.value).length >= options.inputQueryNum) {
                    if (options.url) {
                        var param = {};
                        param["dto['" + selectDataId + "']"] = $showInput.val();
                        if (options.name) {
                            param["dto['" + options.name + "']"] = $hiddenInput.val();
                        }
                        if (options.submitIds) {
                            var ids = options.submitIds.split(",");
                            for (var i = 0; i < ids.length; i++) {
                                param["dto['" + ids[i] + "']"] = Base.getValue(ids[i]);
                            }
                        }
                        Base.getJson(options.url, param, function (data) {
                            if (data != null && data.length > 0) {
                                $winContainer.empty();
                                for (var i = 0; i < data.length; i++) {
                                    var titleValue = options.titleValue;
                                    var hiddenValue = options.hiddenValue;
                                    var displayValue = options.displayValue;
                                    $winContainer.append("<div title='" + data[i][titleValue] + "'  _id='" + data[i][hiddenValue] + "'>" + data[i][displayValue] + "</div>");
                                }
                                $winContainer.show();
                            }
                        });
                    }
                }
            });

            $winContainer.delegate("div", "click", function () {
                if (options.multiple) {
                    var item_id = "item_" + $(this).attr('_id');
                    if ($showInputBox.find("div[_id='" + item_id + "']").length == 0) {
                        _setValue($(this).attr('_id'), $(this).html(), true);
                    } else {
                        // Base.msgTopTip("已存在，不能重复添加");
                        Base.msgTopTip(Base.I18n.getLangText('taface.module.selectdata.duplicatealarms'));
                    }
                } else {
                    _setValue($(this).attr('_id'), $(this).html());
                }
                $showInput.val("");
                $(this).parent().hide();
                doValidate();
            });

            $validateIcon.on("click", function () {
                var $this = $(this);
                if (isSilence || !$this.hasClass("icon-close2")) return;
                setValue("");
                setStateStyle();
                $showInput.val("");
            });

            // 提示文字 代替全局的方法
            if (options.placeholder) {
                Base.funPlaceholder($showInput[0]);
            }

            if (options.bpopTipMsg) {
                var _op = {
                    width: options.bpopTipWidth,
                    height: options.bpopTipHeight,
                    position: options.bpopTipPosition,
                    info: options.bpopTipMsg
                };
                Bubble.setBubbleEvent($showInput, _op);
            }
            if (options.validType) {
                $showInput.addClass("validate");
                validObj = new validateObj(selectDataId, $showInput, options, setStateStyle);
            }

            _declarationState(true);
        }

        /**
         * 声明组件状态
         * @param isInit 是否是组件初始化
         * @private
         */
        function _declarationState(isInit) {
            if (isInit) {
                if (options.value !== null) setValue(options.value);
                if (options.readOnly) setReadOnly();
                if (options.disabled) setEnable(false);
                if (options.required) setRequired();
            } else {
                setValue(options.value);
                setReadOnly(options.readOnly);
                setEnable(!options.disabled);
                setRequired(options.required);
            }
        }

        //重新计算选择项位置和输入框padding
        function reRenderPostion() {
            var $items = $("#selectData_" + selectDataId + " div.selectData-select-li"),
                itemWidth = 0;
            if ($items && $items.length > 0) {
                for (var i = 0; i < $items.length; i++) {
                    itemWidth += $($items[i]).outerWidth(true);
                }
            }
            var itemsWidth = itemWidth + 8;
            var maxItemsWidth = $inputContainer.width() - options.inputMinWidth;
            var diffWidth = maxItemsWidth - itemsWidth;
            if (diffWidth < 0) {
                $("#selectData_" + selectDataId + " .selectData-selected-ul").css("margin-left", diffWidth + "px");
                $showInput.css("padding-left", maxItemsWidth + "px");
                // $winContainer.css("left",maxItemsWidth + "px");
            } else {
                $("#selectData_" + selectDataId + " .selectData-selected-ul").css("margin-left", "0px");
                $showInput.css("padding-left", itemsWidth + "px");
                // $winContainer.css("left",itemsWidth + "px");
            }

            $winContainer.css("left", 0 + "px"); //取消面板随输入框动的特性
        }

        function clear() {
            setValue(null);
        }

        function setValue(obj) {
            if (!$.isPlainObject(obj)) obj = {};
            _setValue(obj[options.hiddenValue], obj[options.displayValue], obj['isAppend']);
        }

        function _setValue(hiddenValue, displayValue, isAppend) {
            if (displayValue === undefined || displayValue === null || displayValue == "") displayValue = hiddenValue;
            if (isAppend === undefined || isAppend === null) isAppend = false;

            var title = Base.I18n.getLangText('taface.module.selectdata.clickdelete'); //点击删除
            if (options.multiple) {
                //判断setValue的赋值方式 覆盖/追加
                if (!isAppend) {
                    $("#selectData_" + selectDataId + " div.selectData-select-li").remove();
                    $("#" + options.name).val("");
                }

                if (typeof hiddenValue == "string" || !isNaN(hiddenValue)) {
                    var ids = hiddenValue.split(",");
                    var names = displayValue.split(",");
                    for (var i = 0; i < ids.length; i++) {
                        var $last = $showInput.siblings(".selectData-selected-ul").find(".selectData-select-li:last");

                        if ($last !== undefined && $last !== null && $last.length != 0) {
                            $showInput.siblings(".selectData-selected-ul").find(".selectData-select-li:last").after("<div class='selectData-select-li'_id='item_" + ids[i] + "'><span class='selectData-select-li-name'>" + names[i] + "</span><span class='selectData-select-li-remove faceIcon icon-close' title='" + title + "'></span></div>");
                        } else {
                            $showInput.siblings(".selectData-selected-ul").prepend("<div class='selectData-select-li'_id='item_" + ids[i] + "'><span class='selectData-select-li-name'>" + names[i] + "</span><span class='selectData-select-li-remove faceIcon icon-close' title='" + title + "'></span></div>");
                        }

                        var val = $("#" + options.name).val();
                        if (val == null || val == "") {
                            val = ids[i];
                        } else {
                            val += "," + ids[i];
                        }
                        $("#" + options.name).val(val);
                    }
                }
            } else {
                $("#selectData_" + selectDataId + " div.selectData-select-li").remove();
                $("#" + options.name).val("");
                if (typeof hiddenValue == "string" || !isNaN(hiddenValue)) {
                    $showInput.siblings(".selectData-selected-ul").prepend("<div class='selectData-select-li' selectDataId='item_" + hiddenValue + "'><span class='selectData-select-li-name'>" + displayValue + "</span><span class='selectData-select-li-remove faceIcon icon-close'  title='" + title + "' ></span></div>");
                    $("#" + options.name).val(hiddenValue);
                }
            }
            reRenderPostion();

            //给关闭按钮bind事件,替代以前的click
            $showInputBox.find(".selectData-select-li-remove").unbind("click").bind("click", function () {
                var o = this;
                if (options.multiple) {
                    var _id = $(o).parent().attr("_id").substring(8);
                    var val = $("#" + options.name).val();
                    if (_id == val) {
                        $("#" + options.name).val("");
                    } else {
                        var arrVal = val.split(",");
                        var num = arrVal.indexOf(_id);
                        arrVal.splice(num, 1);
                        var strVal = arrVal.join(",");
                        $("#" + options.name).val(strVal);
                    }
                } else {
                    $("#" + options.name).val("");
                }
                $(o).parent().remove();
                reRenderPostion();
            });
        }

        function getValue() {
            return $hiddenInput.val();
        }

        function setReadOnly(isReadOnly, isIconSilence) {
            var bool = isReadOnly === false;
            $winContainer.hide();
            $showInput.blur();
            if (bool) {
                $inputContainer.removeClass("readonly");
                $showInput.removeAttr('readOnly');
                $hiddenInput.removeAttr('readOnly');
                $Label.attr("for", selectDataId);
            } else {
                $inputContainer.addClass("readonly");
                $showInput.attr('readOnly', true);
                $hiddenInput.attr('readOnly', true);
                $Label.attr("for", selectDataId + "_readonly");
                Bubble.hideInfo();
            }
            setStateStyle();
            _silenceControl(!bool, !bool && !(isIconSilence === false));
        }

        function setEnable(isEnable) {
            var bool = isEnable === false;
            $winContainer.hide();
            if (bool) {
                $showInput.attr('disabled', true);
                $hiddenInput.attr('disabled', true);
                $inputContainer.addClass("disabled");
                Bubble.hideInfo();
            } else {
                $showInput.attr('disabled', false);
                $hiddenInput.attr('disabled', false);
                $inputContainer.removeClass("disabled");
            }
            setStateStyle();
            _silenceControl(bool, bool);
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

        function setFocus() {
            $showInput.focus();
        }

        /**
         * 设置是是否必输。
         * @method setRequired
         * @param {bool} value true:必输 false 没有必输要求,默认true
         * @author cy
         */
        function setRequired(bool) {
            if (bool === false) {
                $layoutContainer.removeClass("required");
                validObj && validObj.removeOrder("required");
            } else {
                //必输
                $layoutContainer.addClass("required");
                if (validObj) {
                    validObj.addOrder({ type: "required", msg: options.toolTip });
                } else {
                    validObj = new validateObj(selectDataId, $showInput, options, setStateStyle);
                    $showInput.addClass("validate");
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
        //验证状态样式调整
        function setStateStyle(bool) {
            if (bool === false) {
                $inputContainer.removeClass("successvalidate").addClass("failvalidate");
                $validateIcon.removeClass("icon-correct2").addClass("icon-close2");
            } else if (bool === true) {
                $inputContainer.removeClass("failvalidate").addClass("successvalidate");
                $validateIcon.removeClass("icon-close2").addClass("icon-correct2");
            } else {
                $inputContainer.removeClass("failvalidate successvalidate");
                $validateIcon.removeClass("icon-close2 icon-correct2");
            }
        }
        //获取显示的input
        function getInput() {
            return $showInput;
        }

        function getInputLabel() {
            return $(".selectData-label", $layoutContainer);
        }

        //组件静默状态控制，按事件和图标区分，readOnly,disable默认都是事件不执行，图标不显示 add by xp
        function _silenceControl(eventBool, iconBool) {
            if (iconBool) {
                $inputContainer.find(".selectData-select-li-remove").hide();
            } else {
                $inputContainer.find(".selectData-select-li-remove").show();
            }
            isSilence = eventBool;
        }

        function reset() {
            _declarationState();
        }

        /**
         *序列化方法,用于提交时拼接数据
         */
        function newSerialize(id, isIncludeNullFields) {
            return $hiddenInput.taserialize(isIncludeNullFields);
        }

        init();
        return {
            "cmptype": 'TaSelectData',
            "version": "1.1.0",
            "getValue": getValue,
            "setValue": setValue,
            "setReadOnly": setReadOnly,
            "setEnable": setEnable,
            "setVisible": setVisible,
            "setFocus": setFocus,
            "newSerialize": newSerialize,
            "doValidate": doValidate,
            "setValidateStyle": setStateStyle,
            "setRequired": setRequired,
            "getInput": getInput,
            "getInputLabel": getInputLabel,
            "reset": reset,
            "clear": clear
        };
    }
    return TaSelectData;
});

/***/ }),

/***/ 517:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});