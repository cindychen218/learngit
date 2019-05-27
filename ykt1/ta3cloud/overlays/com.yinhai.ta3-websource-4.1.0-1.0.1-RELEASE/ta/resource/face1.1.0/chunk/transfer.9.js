webpackJsonp([9],{

/***/ 498:
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
    __webpack_require__(523);
    $.extend(true, window, {
        transfer: transfer
    });

    function transfer(id, options) {
        options = $.extend({
            btnToNextId: null,
            btnToPrevId: null,
            btnToNextClick: null,
            btnToPrevClick: null,
            addIndex: 0 //添加的时候的位置

        }, options || {});
        var sourceObj = Base.getObj(options.sourceId);
        var targetObj = Base.getObj(options.targetId);
        var $next = $("#" + options.btnToNextId);
        var $prev = $("#" + options.btnToPrevId);
        if (!sourceObj || !targetObj || !$next || !$prev) {
            return;
        }

        function init() {
            //源组件删除目标组件添加
            $next.on("click", function () {
                var srcda = sourceObj.getLister().getSelectedDataList();
                if (typeof options.btnToNextClick == "function") {
                    //传入选中的数据
                    options.btnToNextClick(srcda);
                }
                //删除源数据
                removeObjData(sourceObj);
                //目标添加数据
                addObjData(targetObj, srcda, options.addIndex);
            });
            //源组件添加目标组件删除
            $prev.on("click", function () {
                var srcda = targetObj.getLister().getSelectedDataList();
                if (typeof options.btnToPrevClick == "function") {
                    //是否需要传入添加到源的数据
                    options.btnToPrevClick(srcda);
                }
                //删除源数据
                removeObjData(targetObj);
                //目标添加数据
                addObjData(sourceObj, srcda, options.addIndex);
            });
        } // end init
        function removeObjData(obj) {
            if (!obj) return;
            var lister = obj.getLister();
            if (lister) {
                lister.deleteSelectedRows();
            }
        }

        //给搜索面板添加数据json格式
        function addObjData(obj, rows, index) {
            if (!obj) return;
            var lister = obj.getLister();
            if (lister) {
                lister.addRows(rows, index);
            }
        }

        init(); // 调用初始化方法


        $.extend(this, { // 为this对象
            "cmptype": 'transfer', // 将方法注册为公共方法
            removeObjData: removeObjData,
            addObjData: addObjData

        });
    }

    return transfer;
});

/***/ }),

/***/ 523:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});