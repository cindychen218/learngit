webpackJsonp([17],{

/***/ 491:
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
        TaRichText: TaRichText
    });

    function TaRichText(id, options) {

        var $editor = window.frames["richFrame_" + id].editor;
        var $hiddenInput = $("<input id=\"" + id + "_hidden\"  realId=\"" + id + "\"  type=\"hidden\" style=\"display:none\" name=\"dto['" + id + "']\" />");
        $("iframe[name='richFrame_" + id + "']").after($hiddenInput);

        function getText() {
            return $editor.$txt.text();
        }

        function getHtml() {
            return $editor.$txt.html();
        }

        function clearContent() {
            $editor.$txt.html('<p><br></p>');
        }

        function setValue(value) {
            $editor.$txt.html(value);
        }

        function setEnable(isEnable) {
            if (isEnable == null) isEnable = true;
            if (isEnable) {
                $editor.enable();
            } else {
                $editor.disable();
            }
        }

        function getEditor() {
            return $editor;
        }

        function newSerialize(id, isIncludeNullFields) {
            if (options.submitType == "html") {
                $hiddenInput.val(getHtml());
            } else {
                $hiddenInput.val(getText());
            }
            return $hiddenInput.taserialize(isIncludeNullFields);
        }

        $.extend(this, { // 为this对象
            "cmptype": 'TaRichText', // 将方法注册为公共方法
            "version": '1.0.0',
            "getText": getText,
            "getHtml": getHtml,
            "clearContent": clearContent,
            "setEnable": setEnable,
            "getEditor": getEditor,
            "newSerialize": newSerialize,
            "setValue": setValue
        });
    }

    return TaRichText;
});

/***/ })

});