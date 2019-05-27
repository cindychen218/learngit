webpackJsonp([15],{

/***/ 488:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

/**
 * Created by whisper on 2017/2/16.
 */
(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(33), __webpack_require__(53)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {
    __webpack_require__(509);
    $.extend(true, window, {
        cascadePicker: cascadePicker
    });
    //初始化
    function cascadePicker(id, options) {
        cascadePicker.DEFAULTS = {
            data: [], // id   name   pid
            url: "",
            isSearch: true,
            toolTip: null,
            required: false,
            defaultValue: null,
            disabled: false,
            readOnly: false,
            validType: []
        };
        var opts = $.extend({}, cascadePicker.DEFAULTS, $.isPlainObject(options) && options);

        var $selectContainer;
        var allData;
        var $divCon;
        var $input;
        var $descInput;
        var $arrow;
        var $clearButton;
        var validObj;

        function init() {
            $descInput = $("#" + id + "_desc");
            $input = $("#" + id);
            $divCon = $input.parent();
            $selectContainer = $("<div id='" + id + "_selectContainer' class='selectContainer '></div>");
            $selectContainer.appendTo($("body"));
            $arrow = $("#" + id + "_arrow");
            //下拉箭头绑定展开/收缩事件
            $arrow.on("click", function () {
                arrowClick();
            });
            $clearButton = $("#" + id + "_clear");
            $clearButton.on("click", function () {
                clearClick();
            });

            //查询数据
            if (opts.data == null || opts.data.length == 0) {
                queryData();
            } else {
                allData = opts.data;
            }
            //给描述框绑定事件
            $descInput.on("click", function () {
                showSelectPanel();
            }).on("keyup", function () {
                showSearchPanel();
            }).on("foucs", function () {
                showSelectPanel();
            });
            //给选项面板绑定事件
            $selectContainer.on("click", function (event) {
                var obj = event.srcElement ? event.srcElement : event.target;
                //避免div容器
                if (obj.tagName != "SPAN") {
                    return;
                }
                //允许选中非叶子节点
                if ($(obj).hasClass("cascadeSelected")) {
                    var id = obj.getAttribute("key");
                    var node = getNode(id);
                    var paths = getPaths(node, [node.id, node.name]);
                    $input.val(paths[0]);
                    $descInput.val(paths[1]);
                    hidePanel();
                    $descInput.triggerHandler("contentChange");
                    return;
                }

                $(obj).siblings().removeClass("cascadeSelected");
                $(obj).addClass("cascadeSelected");

                var mod = obj.getAttribute("_mod");
                if (mod == "select") {
                    var id = obj.getAttribute("key");
                    var node = getNode(id);
                    if (isLeaf(node)) {
                        var paths = getPaths(node, [node.id, node.name]);
                        $input.val(paths[0]);
                        $descInput.val(paths[1]);
                        hidePanel();
                        $descInput.triggerHandler("contentChange");
                    } else {
                        //删除子菜单
                        $(obj).parent().nextAll().remove();
                        showNextLevel(node);
                    }
                    return;
                }
                if (mod == "search") {
                    $input.val(obj.getAttribute("key"));
                    $descInput.val(obj.innerHTML);
                    hidePanel();
                    $descInput.triggerHandler("contentChange");
                }
            });
            //全局绑定 关闭事件
            $("body").on("click", function (e) {
                var obj = event.srcElement ? event.srcElement : event.target;
                if (!$.contains($selectContainer[0], obj) && !$.contains($input.parent().parent()[0], obj)) {
                    hidePanel();
                }
            });
            //开启验证
            if (opts.validType) {
                $descInput.addClass("validate");
                var _op = {
                    triggerHandles: "contentChange click mouseover focus"
                };
                validObj = new validateObj(id, $descInput, _op, setStateStyle);
            }
            //设置必输验证
            if (opts.required) {
                setRequired();
            }
            //设置只读
            if (opts.readOnly) {
                setReadOnly(true);
            }
            if (opts.disabled) {
                setEnable(false);
            }
            //设置默认值
            if (opts.defaultValue) {
                setValue(opts.defaultValue);
            }
        }

        function arrowClick() {
            if ($arrow.hasClass("icon-arrow_down")) {
                showSelectPanel();
            } else {
                hidePanel();
            }
        }
        function clearClick() {
            $input.val("");
            $descInput.val("");
            doValidate();
        }
        //展示选择面板
        function showSelectPanel() {
            var value = $("#" + id).val();
            if (value == null || value == "") {
                $selectContainer.html("");
                showNextLevel(null);
            } else {
                var keys = value.split("/");
                var str = "";
                for (var j = 0; j < keys.length; j++) {
                    for (var i = 0; i < allData.length; i++) {
                        if (allData[i].id == keys[j]) {
                            str += "<div>";
                            var levelDatas = getSiblings(allData[i]);
                            for (var k = 0; k < levelDatas.length; k++) {
                                var obj = levelDatas[k];
                                if (obj.id == keys[j]) {
                                    if (isLeaf(obj)) {
                                        str += "<span _mod='select' key='" + obj.id + "' class='cascadeSelected' title='" + obj.name + "'>" + obj.name + "</span>";
                                    } else {
                                        str += "<span _mod='select' key='" + obj.id + "' class='cascadeSelected hasChild' title='" + obj.name + "' >" + obj.name + "</span>";
                                    }
                                } else {
                                    if (isLeaf(obj)) {
                                        str += "<span _mod='select' key='" + obj.id + "'  title='" + obj.name + "' >" + obj.name + "</span>";
                                    } else {
                                        str += "<span _mod='select' key='" + obj.id + "' class='hasChild' title='" + obj.name + "' >" + obj.name + "</span>";
                                    }
                                }
                            }
                            str += "</div>";
                        }
                    }
                }
                $selectContainer.html(str);
            }
            showPanel();
        }
        //展示下一层级
        function showNextLevel(node) {
            var levelDatas = getChildNode(node);
            var str = "<div>";
            for (var k = 0; k < levelDatas.length; k++) {
                var obj = levelDatas[k];
                if (isLeaf(obj)) {
                    str += "<span _mod='select' key='" + obj.id + "' title='" + obj.name + "' >" + obj.name + "</span>";
                } else {
                    str += "<span _mod='select' key='" + obj.id + "' class='hasChild' title='" + obj.name + "' >" + obj.name + "</span>";
                }
            }
            str += "</ul>";
            $(str).appendTo($selectContainer);
        }
        //展示搜索面板
        function showSearchPanel() {
            $input.val("");
            doValidate();
            //判断输入值
            var value = $("#" + id + "_desc").val();
            var index = value.indexOf("/");
            var lastValue;
            if (index == -1) {
                lastValue = value;
            } else if (index == value.length - 1) {
                var keys = value.split("/");
                lastValue = keys[keys.length - 2];
            } else {
                var keys = value.split("/");
                lastValue = keys[keys.length - 1];
            }

            //搜索选项
            if (lastValue != null && lastValue != "") {
                var str = "<div >";
                var n = 0;
                for (var i = 0; i < allData.length; i++) {
                    var obj = allData[i];
                    if (obj.id.toUpperCase().indexOf(lastValue.toUpperCase()) != -1 || obj.name.toUpperCase().indexOf(lastValue.toUpperCase()) != -1) {
                        var paths = getPaths(obj, [obj.id, obj.name]);
                        str += "<span _mod='search' key='" + paths[0] + "' title='" + paths[1] + "' >" + paths[1] + "</span>";
                        n++;
                    }
                }
                if (n == 0) {
                    str += "<span >没有找到对应数据</span>";
                }
                str += "</ul>";
                $selectContainer.html(str);
                var searchWidth = $divCon.width() + parseInt($divCon.css("padding-left")) + parseInt($divCon.css("padding-right"));
                $selectContainer.find("div").width(searchWidth);
                showPanel();
            }
        }
        //显示顶层面板
        function showPanel() {
            var offset = $divCon.offset();
            $selectContainer.css("left", offset.left + 2 + "px").css("top", offset.top + 32 + "px");
            $selectContainer.slideDown();

            $arrow.removeClass("icon-arrow_down").addClass("icon-arrow_up");
        }
        //隐藏面板
        function hidePanel() {
            $selectContainer.slideUp();
            $arrow.removeClass("icon-arrow_up").addClass("icon-arrow_down");
        }
        //获取节点路径
        function getPaths(nodeObj, path) {
            if (nodeObj.pid == null || nodeObj.pid == undefined) {
                return path;
            } else {
                var pnode = getParentNode(nodeObj);
                if (pnode == null) {
                    return path;
                } else {
                    path[0] = pnode.id + "/" + path[0];
                    path[1] = pnode.name + "/" + path[1];
                    return getPaths(pnode, path);
                }
            }
        }
        //获取节点数据
        function getNode(id) {
            for (var i in allData) {
                if (allData[i].id == id) {
                    return allData[i];
                }
            }
            return null;
        }
        //获取父节点数据
        function getParentNode(nodeObj) {
            for (var i in allData) {
                if (allData[i].id == nodeObj.pid) {
                    return allData[i];
                }
            }
            return null;
        }
        //获取子节点数据
        function getChildNode(nodeObj) {
            if (nodeObj == null) {
                nodeObj = { id: '' };
            }
            var childs = [];
            for (var i in allData) {
                if (allData[i].pid == nodeObj.id) {
                    childs.push(allData[i]);
                }
            }
            return childs;
        }
        //获取同级元素
        function getSiblings(nodeObj) {
            var pnode = getParentNode(nodeObj);
            return getChildNode(pnode);
        }
        //判断是否是叶子节点
        function isLeaf(nodeObj) {
            for (var i in allData) {
                if (allData[i].pid == nodeObj.id) {
                    return false;
                }
            }
            return true;
        }
        //查询数据
        function queryData() {
            $.ajax({
                type: "post",
                timeout: 60000,
                url: opts.url,
                async: false,
                data: {},
                dataType: 'json',
                success: function success(data) {
                    allData = data;
                },
                error: function error() {
                    allData = [];
                }
            });
        }
        function unbindCascadeEvent() {
            $descInput.off("click");
            $descInput.off("keyup");
            $descInput.off("focus");
            $arrow.off("click");
            if ($clearButton) $clearButton.off("click");
            if ($selectContainer.is(':visible')) {
                hidePanel();
            }
        }
        function bindCascadeEvent() {
            $descInput.on("click", function () {
                showSelectPanel();
            });
            $descInput.on("keyup", function () {
                showSearchPanel();
            });
            $descInput.on("focus", function () {
                showSelectPanel();
            });
            $arrow.on("click", function () {
                arrowClick();
            });
            if ($clearButton) {
                $clearButton.on("click", function () {
                    clearClick();
                });
            };
        }

        //以下为暴露的事件
        function getValue() {
            return $input.val();
        }
        function setValue(value) {
            if (value != "undefined") {
                if (typeof value != "string") {
                    value += "";
                }
                var keys = value.split("/");
                var lastKey = keys[keys.length - 1];

                var node = getNode(lastKey);
                if (node == null) {
                    $input.val("");
                    $descInput.val("");
                    return;
                }
                var paths = getPaths(node, [node.id, node.name]);
                if (paths[0] == value) {
                    $input.val(paths[0]);
                    $descInput.val(paths[1]);
                } else {
                    $input.val("");
                    $descInput.val("");
                }
            }
        }
        function setReadOnly(bool) {
            if (bool === false) {
                $input.removeAttr('readonly');
                $divCon.removeClass("readonly");
                bindCascadeEvent();
            } else {
                $input.attr('readonly', 'readonly');
                $divCon.addClass("readonly");
                unbindCascadeEvent();
            }
        }
        function setEnable(bool) {
            if (bool === false) {
                $input.attr('disabled', "true");
                $descInput.attr('disabled', "true");
                $divCon.addClass("disabled");
                unbindCascadeEvent();
            } else {
                $input.removeAttr('readonly');
                $divCon.removeClass("readonly");

                $input.removeAttr('disabled');
                $descInput.removeAttr('disabled');
                $divCon.removeClass("disabled");
                bindCascadeEvent();
            }
        }
        function setVisible(showOrHide, isHold) {
            if (showOrHide) {
                $divCon.parent().show().css('visibility', 'visible');
            } else {
                if (isHold) $divCon.parent().css('visibility', 'hidden');else $divCon.parent().hide();
            }
        }
        function setFocus() {
            $descInput.focus();
        }
        function newSerialize(id, isIncludeNullFields) {
            var str = "";
            if ($descInput) {
                str += $descInput.taserialize(isIncludeNullFields) + "&";
            }
            str += $input.taserialize(isIncludeNullFields);
            return str;
        }
        function doValidate() {
            if (validObj) {
                return validObj.executeValidate();
            } else {
                return true;
            }
        }
        function setStateStyle(bool) {
            if (bool === false) {
                $divCon.removeClass("successvalidate").addClass("failvalidate");
            } else if (bool === true) {
                $divCon.removeClass("failvalidate").addClass("successvalidate");
            } else {
                $divCon.removeClass("failvalidate").removeClass("successvalidate");
            }
        }
        function setRequired(bool) {
            if (bool === false) {
                $divCon.removeClass("failvalidate");
                $divCon.parent().removeClass("required");
                validObj && validObj.removeOrder("required");
            } else {
                //必输
                $divCon.parent().addClass("required");
                if (validObj) {
                    validObj.addOrder({ type: "required", msg: opts.toolTip });
                } else {
                    validObj = new validateObj(null, $descInput, opts, self.setStateStyle);
                    $descInput.addClass("validate");
                    validObj.addOrder({ type: "required", msg: opts.toolTip });
                }
            }
        }
        function getInput() {
            return $descInput;
        }
        function getInputLabel() {
            return $divCon.prev();
        }
        function reset() {
            $input.val("");
            $descInput.val("");
            if (opts.defaultValue) {
                setValue(opts.defaultValue);
            }
        }
        init();
        $.extend(this, { // 为this对象
            "cmptype": 'cascadePicker',
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
            "reset": reset
        });
    };
    //继承父类
    cascadePicker.prototype = new TaFieldComponent();
    cascadePicker.prototype.constructor = cascadePicker;
    return cascadePicker;
});

/***/ }),

/***/ 509:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});