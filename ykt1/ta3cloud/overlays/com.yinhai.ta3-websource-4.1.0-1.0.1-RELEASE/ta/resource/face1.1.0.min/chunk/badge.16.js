webpackJsonp([16],{486:function(e,a,i){"use strict";var n,t,s;!function(o){t=[i(0)],(s="function"==typeof(n=o)?n.apply(a,t):n)===undefined||(e.exports=s)}(function(e){function a(a,i){i=e.extend({badgeKey:null,badgeMax:null,badgePosition:"topRight",badgeDisplay:null,badgeIcon:null,isDot:null},i||{});var n=e("#"+a),t=n.parent(".badge-Container"),s=n.siblings(".badge-tag-Container"),o=n.siblings(".badge-key");function d(e){if((i.isDot||!i.badgeKey&&!i.badgeIcon)&&n.removeClass("isDot"),null==i.badgeMax||isNaN(i.badgeMax)||isNaN(e))n.html(e);else{var a=parseInt(e),t=parseInt(i.badgeMax);t>0?a>t?n.html(t+"+"):n.html(a):g(!1)}l(i.badgePosition)}function l(e){if(s.children().size()>0)t.css("display","block"),n.css({left:"auto",right:"-4px"});else if("false"!=i.badgeDisplay&&"none"!=i.badgeDisplay){var a=t.outerHeight(!0),o=n.outerHeight(!0),d=0;a-o>0&&(d=(a-o)/2),"left"==e?(t.prepend(n),n.addClass("badge-left"),n.css({top:d})):"right"==e&&n.css({top:d})}}function g(e){(e=!1!==e)?(n.show(),l(i.badgePosition)):(n.hide(),t.css({"padding-left":0}))}return function(){if(s.children().size()>0&&o.hide(),i.isDot)return l(i.badgePosition),!1;i.badgeKey?d(i.badgeKey):(i.badgeIcon||0==i.isDot||n.addClass("isDot"),l(i.badgePosition))}(),{cmptype:"TaBadge",version:"1.1.0",setBadgeValue:d,setBadgeVisible:g}}return i(506),e.extend(!0,window,{TaBadge:a}),a})},506:function(e,a){}});