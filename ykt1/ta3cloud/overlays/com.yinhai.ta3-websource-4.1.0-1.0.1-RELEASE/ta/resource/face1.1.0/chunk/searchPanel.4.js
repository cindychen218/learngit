webpackJsonp([4],{

/***/ 492:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

/**
 * 搜索面板 searchPanel//预计做成可以和穿梭框一起使用的框
 * 先做成 单标签搜索的,后面有需求做成多标签的再拓展
 * @author cy
 */
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
    __webpack_require__(513);
    $.extend(true, window, {
        searchPanel: searchPanel
    });
    function searchPanel(id, options) {
        this.$obj = $("#" + id);
        this.$input_con = this.$obj.find(".search-insert-con");
        this.$list_con = this.$obj.find(".search-list-con");
        this.options = $.extend({
            //搜索框类型//default(text),self自定义搜索框 那么搜索框自己写 需要查询的时候
            //直接调用searchPanel的dispatchSearch 方法传入 需要过滤的值
            //如果是需要直接设置数据list中的值然后通过
            searchType: "default",
            id: id,
            _self: this
        }, options || {});
        this.searcher = null; //搜索框对象
        this.lister = null; //显示框对象
        this.init();
    }

    searchPanel.prototype = {
        constructor: searchPanel,
        init: function init() {
            this.setSearchType(this.options.searchType);
            this.setList(this.options.listId, this.options);
        },
        /**
         * 设置搜索框类型
         * @method setSearchType
         * @param {String}  type 类型 可取值 text,number,date,self默认text
         */
        setSearchType: function setSearchType(type) {
            if (type == "self") {
                //如果是自定义搜索方式,那么searcher就为空,需要调用dispatchSearch方法分发搜索内容,
                // 或者是直接设置搜索list(表格)的值
                return;
            }
            var tool = __webpack_require__(504)[type];
            if (!tool) {
                tool = __webpack_require__(504)["text"];
            }
            this.searcher = new tool(this.$input_con, this.options);

            var h = parseInt(this.$obj.height());
            var th = parseInt(this.$input_con.outerHeight(true)) || 0;
            this.$list_con.css({ "height": h - th + "px" });
            //重绘
            this.$list_con.find(">div[fit=true]").triggerHandler("_resize");
        },
        //设置数据框list
        setList: function setList(listId, options) {
            var o = Base.getObj(listId);
            var list;
            if (o) {
                var type = o.cmptype;
                list = __webpack_require__(505)[type];
                if (!list) {
                    list = __webpack_require__(505)["datagrid"];
                }
                this.lister = new list(listId, options);
            }
        },
        //搜索数据触发搜索事件
        dispatchSearch: function dispatchSearch(value) {
            if (this.searcher) {
                this.lister.setColumnFilter(this.searcher.getValue());
            } else if (value !== undefined && value !== null) {
                //自定义的搜索框也可以直接触发搜索
                this.lister.setColumnFilter(value);
            }
        },
        getLister: function getLister() {
            return this.lister;
        },
        getSearcher: function getSearcher() {
            return this.searcher;
        }

    };

    return searchPanel;
});

/***/ }),

/***/ 504:
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

    var searchTools = {
        text: function text($con, options) {
            var $input;
            var id = options.id;
            var _defaults = {};
            var _options = $.extend(true, {}, _defaults, options);
            var _search_ops = $.extend({}, options);
            var validObj = null;
            this.init = function () {
                $input = $("<input type='text' id='" + id + "_search' class='search-input' placeholder='搜索...'>").appendTo($con);
                $input.bind("keydown", function (e) {
                    if (e.keyCode === 13) {
                        _options._self.dispatchSearch();
                        return false;
                    } else if (e.keyCode === 9) {}
                });
                this.focus();
                if (_options.validType) {
                    validObj = new validateObj(id, $input, _search_ops);
                }
            };

            this.focus = function () {
                $input.focus();
            };

            this.setValue = function (val) {
                $input.val(val);
            };
            this.getValue = function () {
                return $input.val();
            };
            this.destroy = function () {
                Bubble.hideInfo();
                $con.empty();
            };
            this.validate = function () {
                var rs = true;
                if (validObj) {
                    rs = validObj.executeValidate();
                }
                return {
                    valid: rs,
                    msg: null
                };
            };

            this.init();
        }

    };

    return searchTools;
});

/***/ }),

/***/ 505:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0), __webpack_require__(88)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        factory(jQuery);
    }
})(function ($) {

    var searchLists = {
        datagrid: function datagrid(id, options) {
            var obj = Base.getObj(id);
            this.init = function () {
                //隐藏头部搜索信息标签
                obj.getHeaderSearchTopPanelNode().style.height = "0px";
            };
            //添加行data为json格式
            this.addRows = function (data, index) {
                if (!$.isArray(data)) return;
                index = Number(index) === NaN ? 0 : parseInt(index);
                for (var i = 0; i < data.length; i++) {
                    Base.addGridRowTo(id, data[i], parseInt(index) + i);
                }
            };
            //删除选中行
            this.deleteSelectedRows = function () {
                obj.deleteSelectedRows();
            };
            //获取选中数据
            this.getSelectedDataList = function () {
                return Base.getGridSelectedRows(id);
            };
            //设置全选/全不选 true/false
            this.setAllDataChecked = function (bool) {};
            //设置指定行选中
            this.setSelectedRows = function () {};
            //设置过滤//过滤就调用这个属性
            this.setColumnFilter = function (value) {
                Base.clearAllColumnsFilter(id); //清空搜索
                Base.setColumnFilter(id, options.listFilterColId, value); //添加列搜索
            };
            this.init();
        }

    };
    return searchLists;
});

/***/ }),

/***/ 513:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

});