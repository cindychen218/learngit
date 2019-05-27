webpackJsonp([3],{

/***/ 493:
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * Created by whisper on 2017/3/14.
 */
__webpack_require__(514);
__webpack_require__(515);
__webpack_require__(516);

/***/ }),

/***/ 514:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 515:
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
        TaSelectButtonItem: TaSelectButtonItem
    });
    function TaSelectButtonItem(id, options) {
        var $buttonItem = $("#" + id).attr("realId", id);
        //组件事件静默标志 true 静默，静默类事件不执行
        var isSilence = false;

        options = $.extend({
            disabled: false,
            onClick: null
        }, options || {});

        function init() {
            $buttonItem.on("click.silenceEvent", function (e) {
                if (isSilence) return;
                if (typeof options.onClick == "string") eval(options.onClick);
                // if(typeof options.onClick == "function")options.onClick(this);
            });

            _declarationState(true);
        }

        /**
         * 声明组件状态
         * @param isInit 是否是组件初始化
         * @private
         */
        function _declarationState(isInit) {
            if (isInit) {
                if (options.disabled) setEnable(false);
            } else {
                setEnable(!options.disabled);
            }
        }

        function setEnable(isEnable) {
            var bool = isEnable === false;

            if (bool) {
                $buttonItem.addClass("disabled");
            } else {
                $buttonItem.removeClass("disabled");
            }
            _silenceControl(bool, bool);
        }

        //组件静默状态控制，按事件和图标区分，readOnly,disable默认都是事件不执行，图标不显示 add by xp
        function _silenceControl(eventBool, iconBool) {
            isSilence = eventBool;
        }

        function setVisible(isVisiable, isHold) {
            if (isVisiable) {
                $buttonItem.show().css('visibility', 'visible');
            } else {
                if (isHold) {
                    $buttonItem.css('visibility', 'hidden');
                } else {
                    $buttonItem.hide();
                }
            }
        }

        function reset() {
            _declarationState();
        }

        init(); // 调用初始化方法
        $.extend(this, { // 为this对象
            "cmptype": 'TaSelectButtonItem', // 将方法注册为公共方法
            "version": "1.1.0",
            setEnable: setEnable,
            setVisible: setVisible,
            reset: reset
        });
    }

    return TaSelectButtonItem;
});

/***/ }),

/***/ 516:
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
		TaSelectButton: TaSelectButton
	});

	function TaSelectButton(selectButtonId, options) {
		options = $.extend({
			hotKey: null,
			disabled: false
		}, options || {});

		var $button = $("#" + selectButtonId).attr("realId", selectButtonId);
		var $layoutContainer = $button.parent("div.select-button");
		var $buttonItemContainer = $button.next(".select-content");
		//组件事件静默标志 true 静默，静默类事件不执行
		var isSilence = false;

		function init() {
			$(document.body).on("mousedown", function (e) {
				if ($layoutContainer && $layoutContainer[0] != e.target && !$.contains($layoutContainer[0], e.target)) {
					hideSelectPanel();
				}
			});

			$button.on("click", function () {
				if (isSilence) return;
				$buttonItemContainer.is(":visible") == true ? hideSelectPanel() : showSelectPanel();
			});

			$buttonItemContainer.on("click", function (e) {
				var event = e || window.event,
				    target = event.target || event.srcElement,
				    $target = $(target);
				if ($target.hasClass("select-button-item") && !$target.hasClass("disabled") && $target.is(":visible")) {
					// $button.find(".button-text").html($target.text());
					hideSelectPanel();
				}
			});

			_declarationState(true);
		}

		/**
  * 声明组件状态
   * @param isInit 是否是组件初始化
   * @private
   */
		function _declarationState(isInit) {
			if (isInit) {
				if (options.disabled) setEnable(false);
			} else {
				setEnable(!options.disabled);
			}

			bindHotKey();
		}

		function bindHotKey(bool) {
			if (options.hotKey && hotKeyregister) {
				bool = bool === false;
				if (bool) {
					var _this = $button[0];
					hotKeyregister.add(options.hotKey, function () {
						_this.focus();_this.click();return false;
					});
				} else {
					hotKeyregister.remove(options.hotKey);
				}
			}
		}

		function hideSelectPanel() {
			$buttonItemContainer.stop().fadeOut("fast");
		}
		function showSelectPanel() {
			if ($(document).height() - $layoutContainer.offset().top > $buttonItemContainer.outerHeight(true)) {
				$buttonItemContainer.stop().slideDown("fast");
			} else {
				$buttonItemContainer.css("top", -$buttonItemContainer.outerHeight(true) - 5).stop().fadeIn("fast");
			}
		}

		function setEnable(isEnable) {
			var bool = isEnable === false;
			if (bool) {
				$button.attr('disabled', true);
				$button.addClass("disabled");
				hideSelectPanel();
			} else {
				$button.attr('disabled', false);
				$button.removeClass('disabled');
				setVisible(true, true);
			}
			_silenceControl(bool, bool);
		}

		//组件静默状态控制，按事件和图标区分，readOnly,disable默认都是事件不执行，图标不显示 add by xp
		function _silenceControl(eventBool, iconBool) {
			isSilence = eventBool;
		}

		function setVisible(isVisiable, isHold) {
			bindHotKey(isVisiable);
			if (isVisiable) {
				$layoutContainer.show().css('visibility', 'visible');
			} else {
				if (isHold) $layoutContainer.css('visibility', 'hidden');else $layoutContainer.hide();
			}
		}

		function setFocus() {
			$button.focus();
		}

		function reset() {
			_declarationState();
		}

		init();
		$.extend(this, { // 为this对象
			"cmptype": 'TaSelectButton', // 将方法注册为公共方法
			"version": "1.1.0",
			"setEnable": setEnable,
			"setVisible": setVisible,
			"setFocus": setFocus,
			"reset": reset
		});
	}
	return TaSelectButton;
});

/***/ })

});