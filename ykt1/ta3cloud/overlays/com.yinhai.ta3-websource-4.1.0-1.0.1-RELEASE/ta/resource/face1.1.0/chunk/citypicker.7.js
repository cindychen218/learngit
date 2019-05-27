webpackJsonp([7],{

/***/ 487:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

/**
 * Created by whisper on 2017/2/16.
 */

__webpack_require__(507);
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
        CityPicker: CityPicker
    });
    var NAMESPACE = 'citypicker';
    var EVENT_CHANGE = 'change.' + NAMESPACE;
    var PROVINCE = 'province'; //省
    var CITY = 'city'; //市
    var DISTRICT = 'district'; //区
    var XIANG = 'xiang'; //乡
    var CUN = 'cun'; //村
    var ChineseDistricts = __webpack_require__(508);
    //初始化
    function CityPicker(element, options) {
        this.$element = $("#" + element).attr("realId", element);
        this.$textHelp = $("#textHelp_" + element);
        this.$container = this.$element.parent().parent();
        this.cmptype = "CityPicker";
        this.$code = $("#" + element + "_code").addClass("ComponentsSerialize");
        this.$dropdown = null;
        this.options = $.extend({}, CityPicker.DEFAULTS, $.isPlainObject(options) && options);
        this.options.defaultValue = {
            province: this.options.province,
            city: this.options.city,
            district: this.options.district,
            xiang: this.options.xiang,
            cun: this.options.cun
        };
        this.active = true;
        this.dems = [];
        this.needBlur = true;
        this.init();
    }
    //默认参数
    CityPicker.DEFAULTS = {
        simple: true,
        responsive: false,
        placeholder: '--请选择--',
        url: Base.globvar.basePath + "sysapp/regionSupportController!querySubRegions.do",
        level: '3',
        levelOneName: "省",
        levelTwoName: "市",
        levelThreeName: "区/县",
        levelFourName: "街道/乡镇",
        levelFiveName: "社区/村",
        province: '',
        city: '',
        district: '',
        xiang: '',
        cun: '',
        required: false,
        disabled: false,
        readOnly: false,
        toolTip: null,
        validObj: null
    };
    //初始化参数
    CityPicker.setDefaults = function (options) {
        $.extend(CityPicker.DEFAULTS, options);
    };
    //方法
    CityPicker.prototype = {
        constructor: CityPicker,

        init: function init() {

            this.defineDems();

            this.render();

            this.bind();

            this.active = true;
            this.initState(true);
            if (this.options.textHelp) {
                this.textHelp();
            }
        },

        initState: function initState(isInit) {
            if (isInit) {
                if (this.options.required) {
                    this.setRequired(true);
                }
                if (this.options.disabled) {
                    this.setEnable(false);
                }
                if (this.options.readOnly) {
                    this.setReadOnly(true);
                }
            } else {
                this.setRequired(this.options.required);
                this.setEnable(!this.options.disabled);
                this.setReadOnly(this.options.readOnly);
            }
        },

        render: function render() {
            var p = this.getPosition(),
                placeholder = this.$element.attr('placeholder') || this.options.placeholder,
                textspan = '<span class="city-picker-span" style="' + 'width:100%;' + 'height:' + p.height + 'px;line-height:' + (p.height - 1) + 'px;">' + (placeholder ? '<span class="placeholder">' + placeholder + '</span>' : '') + '<span class="title"></span><div class="arrow faceIcon icon-arrow_down"></div>' + '</span>',
                dropdown = '<div class="city-picker-dropdown" style="left:0px;top:100%;width:100%;">' + '<div class="city-select-wrap">' + '<div class="city-select-tab">' + '<a class="active" data-count="province">' + this.options.levelOneName + '</a>' + (this.includeDem('city') ? '<a data-count="city">' + this.options.levelTwoName + '</a>' : '') + (this.includeDem('district') ? '<a data-count="district">' + this.options.levelThreeName + '</a>' : '') + (this.includeDem('xiang') ? '<a data-count="xiang">' + this.options.levelFourName + '</a>' : '') + (this.includeDem('cun') ? '<a data-count="cun">' + this.options.levelFiveName + '</a>' : '') + '</div>' + '<div class="city-select-content">' + '<div class="city-select province" data-count="province"></div>' + (this.includeDem('city') ? '<div class="city-select city" data-count="city"></div>' : '') + (this.includeDem('district') ? '<div class="city-select district" data-count="district"></div>' : '') + (this.includeDem('xiang') ? '<div class="city-select xiang" data-count="xiang"></div>' : '') + (this.includeDem('cun') ? '<div class="city-select cun" data-count="cun"></div>' : '') + '</div></div>';

            this.$element.addClass('city-picker-input');
            this.$textspan = $(textspan).insertAfter(this.$element);
            this.$dropdown = $(dropdown).insertAfter(this.$textspan);
            var $select = this.$dropdown.find('.city-select');

            // setup this.$province, this.$city and/or this.$district object
            $.each(this.dems, $.proxy(function (i, type) {
                this['$' + type] = $select.filter('.' + type + '');
            }, this));
            this.refresh();
        },

        refresh: function refresh(force) {
            // clean the data-item for each $select
            var $select = this.$dropdown.find('.city-select');
            $select.data('item', null);
            // parse value from value of the target $element
            var val = this.$element.val() || '';
            val = val.split('/');
            $.each(this.dems, $.proxy(function (i, type) {
                if (val[i] && i < val.length) {
                    this.options[type] = val[i];
                } else if (force) {
                    this.options[type] = '';
                }
                this.output(type);
            }, this));
            this.tab(PROVINCE);
            this.feedText();
            this.feedVal();
            var code = this.getCode();
            this.$code.val(code);
        },

        defineDems: function defineDems() {
            var stop = false;
            $.each([PROVINCE, CITY, DISTRICT, XIANG, CUN], $.proxy(function (i, type) {
                if (!stop) {
                    this.dems.push(type);
                }
                if (i + 1 == this.options.level) {
                    stop = true;
                }
            }, this));
        },

        includeDem: function includeDem(type) {
            return $.inArray(type, this.dems) !== -1;
        },

        getPosition: function getPosition() {
            var p, h, w, s, pw;
            p = this.$element.position();
            s = this.getSize(this.$element);
            h = s.height;
            w = s.width;
            if (this.options.responsive) {
                pw = this.$element.offsetParent().width();
                if (pw) {
                    w = w / pw;
                    if (w > 0.99) {
                        w = 1;
                    }
                    w = w * 100 + '%';
                }
            }
            return {
                top: p.top || 0,
                left: p.left || 0,
                height: h,
                width: w
            };
        },

        getSize: function getSize($dom) {
            var $wrap, $clone, sizes;
            if (!$dom.is(':visible')) {
                $wrap = $("<div class='city-ta-picker'/>").appendTo($("body"));
                $wrap.css({
                    "position": "absolute !important",
                    "visibility": "hidden !important",
                    "display": "block !important"
                });
                $clone = $dom.clone().appendTo($wrap);
                sizes = {
                    width: $clone.outerWidth(),
                    height: $clone.outerHeight()
                };
                $wrap.remove();
            } else {
                sizes = {
                    width: $dom.outerWidth(),
                    height: $dom.outerHeight()
                };
            }

            return sizes;
        },

        getWidthStyle: function getWidthStyle(w, dropdown) {
            if (this.options.responsive && !$.isNumeric(w)) {
                return 'width:' + w + ';';
            } else {
                return 'width:' + (dropdown ? Math.max(320, w) : w) + 'px;';
            }
        },

        bind: function bind() {
            this.unbind();
            var $this = this;

            $(document).on('click', this._mouteclick = function (e) {
                var $target = $(e.target);
                var $dropdown, $span, $input;
                if ($target.is('.city-picker-span')) {
                    $span = $target;
                } else if ($target.is('.city-picker-span *')) {
                    $span = $target.parents('.city-picker-span');
                }
                if ($target.is('.city-picker-input')) {
                    $input = $target;
                }
                if ($target.is('.city-picker-dropdown')) {
                    $dropdown = $target;
                } else if ($target.is('.city-picker-dropdown *')) {
                    $dropdown = $target.parents('.city-picker-dropdown');
                }
                if (!$input && !$span && !$dropdown || $span && $span.get(0) !== $this.$textspan.get(0) || $input && $input.get(0) !== $this.$element.get(0) || $dropdown && $dropdown.get(0) !== $this.$dropdown.get(0)) {
                    $this.close(true);
                }
            });

            this.$element.on('change', this._changeElement = $.proxy(function () {
                this.close(true);
                this.refresh(true);
            }, this)).on('focus', this._focusElement = $.proxy(function () {
                this.needBlur = true;
                this.open();
            }, this)).on('blur', this._blurElement = $.proxy(function () {
                if (this.needBlur) {
                    this.needBlur = false;
                    this.close(true);
                }
            }, this));

            this.$textspan.on('click', function (e) {
                var $target = $(e.target),
                    type;
                $this.needBlur = false;
                if ($target.is('.select-item')) {
                    type = $target.data('count');
                    $this.open(type);
                } else {
                    if ($this.$dropdown.is(':visible')) {
                        $this.close();
                    } else {
                        $this.open();
                    }
                }
            }).on('mousedown', function () {
                $this.needBlur = false;
            });

            this.$dropdown.on('click', '.city-select a', function () {
                var $select = $(this).parents('.city-select');
                var $active = $select.find('a.active');
                var last = $select.next().length === 0;
                $active.removeClass('active');
                $(this).addClass('active');
                if ($active.data('code') !== $(this).data('code')) {
                    $select.data('item', {
                        address: $(this).attr('title'), code: $(this).data('code')
                    });
                    $(this).trigger(EVENT_CHANGE);
                    $this.feedText();
                    $this.feedVal();
                    if (last) {
                        $this.close();
                    }
                }
            }).on('click', '.city-select-tab a', function () {
                if (!$(this).hasClass('active')) {
                    var type = $(this).data('count');
                    $this.tab(type);
                }
            }).on('mousedown', function () {
                $this.needBlur = false;
            });

            if (this.$province) {
                this.$province.on(EVENT_CHANGE, this._changeProvince = $.proxy(function () {
                    this.output(CITY);
                    this.output(DISTRICT);
                    this.output(XIANG);
                    this.output(CUN);
                    this.tab(CITY);
                }, this));
            }
            if (this.$city) {
                this.$city.on(EVENT_CHANGE, this._changeCity = $.proxy(function () {
                    this.output(DISTRICT);
                    this.output(XIANG);
                    this.output(CUN);
                    this.tab(DISTRICT);
                }, this));
            }
            if (this.$district) {
                this.$district.on(EVENT_CHANGE, this._changeDistrict = $.proxy(function () {
                    this.output(XIANG);
                    this.output(CUN);
                    this.tab(XIANG);
                }, this));
            }
            if (this.$xiang) {
                this.$xiang.on(EVENT_CHANGE, this._changeXiang = $.proxy(function () {
                    this.output(CUN);
                    this.tab(CUN);
                }, this));
            }
        },

        open: function open(type) {
            type = type || PROVINCE;
            this.$dropdown.show();
            this.$textspan.addClass('open').addClass('focus').find(".arrow").addClass("icon-arrow_up").removeClass("icon-arrow_down");
            this.tab(type);
        },

        close: function close(blur) {
            this.$dropdown.hide();
            this.$textspan.removeClass('open').find(".arrow").addClass("icon-arrow_down").removeClass("icon-arrow_up");
            if (blur) {
                this.$textspan.removeClass('focus');
            }
            var code = this.getCode();
            this.$code.val(code);
        },

        unbind: function unbind() {

            $(document).off('click', this._mouteclick);

            this.$element.off('change', this._changeElement);
            this.$element.off('focus', this._focusElement);
            this.$element.off('blur', this._blurElement);

            this.$textspan.off('click');
            this.$textspan.off('mousedown');

            this.$dropdown.off('click');
            this.$dropdown.off('mousedown');

            if (this.$province) {
                this.$province.off(EVENT_CHANGE, this._changeProvince);
            }

            if (this.$city) {
                this.$city.off(EVENT_CHANGE, this._changeCity);
            }
            if (this.$district) {
                this.$district.off(EVENT_CHANGE, this._changeDistrict);
            }
            if (this.$xiang) {
                this.$xiang.off(EVENT_CHANGE, this._changeXiang);
            }
        },

        getText: function getText() {
            var text = '';
            this.$dropdown.find('.city-select').each(function () {
                var item = $(this).data('item'),
                    type = $(this).data('count');
                if (item) {
                    text += ($(this).hasClass('province') ? '' : '/') + '<span class="select-item" data-count="' + type + '" data-code="' + item.code + '">' + item.address + '</span>';
                }
            });
            return text;
        },

        getPlaceHolder: function getPlaceHolder() {
            return this.$element.attr('placeholder') || this.options.placeholder;
        },

        feedText: function feedText() {
            var text = this.getText();
            if (text) {
                this.$textspan.find('>.placeholder').hide();
                this.$textspan.find('>.title').html(this.getText()).show();
            } else {
                this.$textspan.find('>.placeholder').text(this.getPlaceHolder()).show();
                this.$textspan.find('>.title').html('').hide();
            }
            this.$textspan.triggerHandler("contentChange");
        },

        getVal: function getVal() {
            var text = '';
            this.$dropdown.find('.city-select').each(function () {
                var item = $(this).data('item');
                if (item) {
                    text += ($(this).hasClass('province') ? '' : '/') + item.address;
                }
            });
            return text;
        },
        getValue: function getValue() {
            return this.getVal();
        },

        feedVal: function feedVal() {
            this.$element.val(this.getVal());
        },

        output: function output(type) {
            var options = this.options;
            //var placeholders = this.placeholders;
            var $select = this['$' + type];
            var data = type === PROVINCE ? {} : [];
            var item;
            var districts;
            var code;
            var matched = null;
            var value;
            var _self = this;

            if (!$select || !$select.length) {
                return;
            }

            item = $select.data('item');

            value = (item ? item.address : null) || options[type];
            code = type === PROVINCE ? 86 : type === CITY ? this.$province && this.$province.find('.active').data('code') : type === DISTRICT ? this.$city && this.$city.find('.active').data('code') : type === XIANG ? this.$district && this.$district.find('.active').data('code') : type === CUN ? this.$xiang && this.$xiang.find('.active').data('code') : code;

            //异步加载省级以下的数据
            if ($.isNumeric(code)) {
                if (code == 86) {
                    //如果是省那么是前台的数据
                    districts = ChineseDistricts[code];
                    initChooseInfo();
                } else {
                    var getcode = $.ajax({
                        type: "post",
                        timeout: 60000,
                        url: this.options.url,
                        async: false,
                        data: { code: code },
                        dataType: 'json',
                        success: function success(data) {
                            districts = data ? data : null;
                        },
                        error: function error() {
                            districts = null;
                        },
                        complete: function complete() {
                            initChooseInfo();
                        }
                    });
                }
            } else {
                districts = null;
                initChooseInfo();
            }
            //districts = $.isNumeric(code) ? ChineseDistricts[code] : null;
            //initChooseInfo();
            function initChooseInfo() {
                if ($.isPlainObject(districts)) {
                    $.each(districts, function (code, address) {
                        var provs;
                        if (type === PROVINCE) {
                            provs = [];
                            for (var i = 0; i < address.length; i++) {
                                if (address[i].code === value || address[i].address === value) {
                                    matched = {
                                        code: address[i].code,
                                        address: address[i].address
                                    };
                                }
                                provs.push({
                                    code: address[i].code,
                                    address: address[i].address,
                                    selected: address[i].code === value
                                });
                            }
                            data[code] = provs;
                        } else {
                            if (code === value || address === value) {
                                matched = {
                                    code: code,
                                    address: address
                                };
                            }
                            data.push({
                                code: code,
                                address: address,
                                selected: code === value || address === value
                            });
                        }
                    });
                }

                $select.html(type === PROVINCE ? _self.getProvinceList(data) : _self.getList(data, type));
                $select.data('item', matched);
            }
        },

        getProvinceList: function getProvinceList(data) {
            var list = [],
                $this = this,
                simple = this.options.simple;

            $.each(data, function (i, n) {
                list.push('<dl class="clearfix">');
                list.push('<dt>' + i + '</dt><dd>');
                $.each(n, function (j, m) {
                    list.push('<a' + ' title="' + (m.address || '') + '"' + ' data-code="' + (m.code || '') + '"' + ' class="' + (m.selected ? ' active' : '') + '">' + (simple ? $this.simplize(m.address, PROVINCE) : m.address) + '</a>');
                });
                list.push('</dd></dl>');
            });

            return list.join('');
        },

        getList: function getList(data, type) {
            var list = [],
                $this = this,
                simple = this.options.simple;
            list.push('<dl class="clearfix"><dd>');

            $.each(data, function (i, n) {
                list.push('<a' + ' title="' + (n.address || '') + '"' + ' data-code="' + (n.code || '') + '"' + ' class="' + (n.selected ? ' active' : '') + '">' + (simple ? $this.simplize(n.address, type) : n.address) + '</a>');
            });
            list.push('</dd></dl>');

            return list.join('');
        },

        simplize: function simplize(address, type) {
            address = address || '';
            if (address == "市辖区") return address;
            if (type === PROVINCE) {
                return address.replace(/[省,市,自治区,壮族,回族,维吾尔]/g, '');
            } else if (type === CITY) {
                return address.replace(/[市,地区,回族,蒙古,苗族,白族,傣族,景颇族,藏族,彝族,壮族,傈僳族,布依族,侗族]/g, '').replace('哈萨克', '').replace('自治州', '').replace(/自治县/, '');
            } else if (type === DISTRICT) {
                return address.length > 2 ? address.replace(/[市,区,县,旗]/g, '') : address;
            } else {
                return address;
            }
        },

        tab: function tab(type) {
            var $selects = this.$dropdown.find('.city-select');
            var $tabs = this.$dropdown.find('.city-select-tab > a');
            var $select = this['$' + type];
            var $tab = this.$dropdown.find('.city-select-tab > a[data-count="' + type + '"]');
            if ($select) {
                $selects.hide();
                $select.show();
                $tabs.removeClass('active');
                $tab.addClass('active');
            }
        },

        destroy: function destroy() {
            this.unbind();
            this.$element.removeData(NAMESPACE).removeClass('city-picker-input');
            this.$textspan.remove();
            this.$dropdown.remove();
        },
        getCode: function getCode() {
            var $selectList = this.$element.parent().find("span.select-item");
            var len = $selectList.length;
            if (len <= 0) {
                return this.$code.val();
            }
            var code = $selectList[len - 1].getAttribute("data-code");
            return code;
        },
        setCode: function setCode(code) {
            if (!code) {
                return;
            }
            var str = code.toString();
            this.options.province = str.substring(0, 2) ? str.substring(0, 2) + "0000000000" : "";
            this.options.city = str.substring(0, 4) ? str.substring(0, 4) + "00000000" : "";
            this.options.district = str.substring(0, 6) ? str.substring(0, 6) + "000000" : "";
            this.options.xiang = str.substring(0, 9) ? str.substring(0, 9) + "000" : "";
            this.options.cun = str.substring(0, 12) ? str.substring(0, 12) : "";
            this.$element.val("");
            this.refresh();
        },
        setValue: function setValue(code) {
            this.setCode(code);
        },
        setFocus: function setFocus() {
            this._focusElement();
        },

        setRequired: function setRequired(bool) {
            if (bool === false) {
                this.$textspan.removeClass("required");
                this.$container.removeClass("required");
                this.validObj && this.validObj.removeOrder("required");
            } else {
                //必输
                this.$textspan.addClass("required");
                this.$container.addClass("required");
                if (this.validObj) {
                    this.validObj.addOrder({ type: "required", msg: this.options.toolTip || null });
                } else {
                    var _op = {
                        triggerHandles: "contentChange click mouseover focus",
                        toolTip: this.options.toolTip || null
                    };
                    this.validObj = new validateObj(this.$element.attr("id"), this.$textspan, _op);
                    this.$element.addClass("validate");
                    this.validObj.addOrder({ type: "required", msg: this.options.toolTip || null });
                }
            }
        },
        getInput: function getInput() {
            return this.$element;
        },
        getInputLabel: function getInputLabel() {
            return this.$container.find("label");
        },
        doValidate: function doValidate() {
            if (this.validObj) {
                return this.validObj.executeValidate();
            } else {
                return true;
            }
        },
        textHelp: function textHelp() {
            var $textHelp = this.$textHelp;
            var _op = {
                width: this.options.textHelpWidth || "200",
                position: this.options.textHelpPosition || "bottomLeft",
                info: this.options.textHelp || "这是帮助信息",
                arrowWidth: 16
            };
            Bubble.setBubbleEvent($textHelp, _op);
        },
        reset: function reset(isForce) {
            if (isForce) {
                this.$element.val(null).trigger('change');
                return;
            } else {
                var $select = this.$dropdown.find('.city-select');
                $select.data('item', null);
                $.each(this.dems, $.proxy(function (i, type) {
                    this.options[type] = this.options.defaultValue[type];
                    this.output(type);
                }, this));
                this.tab(PROVINCE);
                this.feedText();
                this.feedVal();
                var code = this.getCode();
                this.$code.val(code);
            }
            Bubble.hideInfo();
            this.setValidateStyle();
            this.initState();
        },
        setEnable: function setEnable(bool) {
            this.setValidateStyle("reset");
            var bool = bool === false;
            if (!bool) {
                this.bind();
                this.$element.attr('disabled', false);
                this.$code.attr('disabled', false);
                this.$textspan.removeClass("disabled");
            } else {
                this.close(true);
                this.unbind();
                this.$element.attr('disabled', true);
                this.$code.attr('disabled', true);
                this.$textspan.addClass("disabled");
                Bubble.hideInfo();
            }
        },
        setReadOnly: function setReadOnly(value) {
            this.setValidateStyle("reset");

            if (value === true) {
                Bubble.hideInfo();
                this.close(true);
                this.unbind();
                this.$textspan.addClass("readonly");
            } else {
                this.bind();
                this.$textspan.removeClass("readonly");
            }
        },
        setValidateStyle: function setValidateStyle(value) {
            if (value === false) {
                this.$textspan.removeClass("successvalidate").addClass("failvalidate");
                return;
            } else if (value === true) {
                this.$textspan.removeClass("failvalidate").addClass("successvalidate");
                return;
            } else {
                this.$textspan.removeClass("failvalidate successvalidate");
                return;
            }
        },
        newSerialize: function newSerialize(id, isIncludeNullFields) {
            return this.$code ? this.$code.taserialize(isIncludeNullFields) : "";
        },
        cmptype: "citypicker"

    };

    return CityPicker;
});

/***/ }),

/***/ 507:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 508:
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

(function (factory) {
    if (true) {
        // AMD. Register as anonymous module.
        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
    } else {
        // Browser globals.
        factory();
    }
})(function () {
    var ChineseDistricts = {
        86: {
            'A-G': [{ code: '340000000000', address: '安徽省' }, { code: '110000000000', address: '北京市' }, { code: '500000000000', address: '重庆市' }, { code: '350000000000', address: '福建省' }, { code: '620000000000', address: '甘肃省' }, { code: '440000000000', address: '广东省' }, { code: '450000000000', address: '广西壮族自治区' }, { code: '520000000000', address: '贵州省' }],
            'H-K': [{ code: '460000000000', address: '海南省' }, { code: '130000000000', address: '河北省' }, { code: '230000000000', address: '黑龙江省' }, { code: '410000000000', address: '河南省' }, { code: '420000000000', address: '湖北省' }, { code: '430000000000', address: '湖南省' }, { code: '320000000000', address: '江苏省' }, { code: '360000000000', address: '江西省' }, { code: '220000000000', address: '吉林省' }],
            'L-S': [{ code: '210000000000', address: '辽宁省' }, { code: '150000000000', address: '内蒙古自治区' }, { code: '640000000000', address: '宁夏回族自治区' }, { code: '630000000000', address: '青海省' }, { code: '370000000000', address: '山东省' }, { code: '310000000000', address: '上海市' }, { code: '140000000000', address: '山西省' }, { code: '610000000000', address: '陕西省' }, { code: '510000000000', address: '四川省' }],
            'T-Z': [{ code: '120000000000', address: '天津市' }, { code: '650000000000', address: '新疆维吾尔自治区' }, { code: '540000000000', address: '西藏自治区' }, { code: '530000000000', address: '云南省' }, { code: '330000000000', address: '浙江省' }]
        }
    };
    if (typeof window !== 'undefined') {
        window.ChineseDistricts = ChineseDistricts;
    }
    return ChineseDistricts;
});

/***/ })

});