webpackJsonp([13],{494:function(e,t,a){"use strict";var l,i,s;!function(n){i=[a(0),a(17),a(54),a(53)],(s="function"==typeof(l=n)?l.apply(t,i):l)===undefined||(e.exports=s)}(function(e){function t(t,a){a=e.extend({bpopTipMsg:null,bpopTipWidth:500,bpopTipHeight:300,bpopTipPosition:"top",multiple:!1,inputQueryNum:2,inputMinWidth:140,titleValue:"title",hiddenValue:"id",displayValue:"name",placeholder:null,value:null,required:!1,readOnly:!1,disabled:!1,validType:null},a||{});var l=e("#"+t).attr("realId",t),i=l.parent("div.selectData-input-box"),s=i.parent("div.selectData-input-Container"),n=s.parent("div.selectData-layout-Container"),d=e("div.selectData-win-Container",s),c=e("#"+a.name).addClass("ComponentsSerialize"),r=l.siblings(".validateIcon"),o=e(".selectData-label",n),u=null,p=!1;function v(e){e?(null!==a.value&&m(a.value),a.readOnly&&b(),a.disabled&&g(!1),a.required&&D()):(m(a.value),b(a.readOnly),g(!a.disabled),D(a.required))}function f(){var i=e("#selectData_"+t+" div.selectData-select-li"),n=0;if(i&&i.length>0)for(var c=0;c<i.length;c++)n+=e(i[c]).outerWidth(!0);var r=n+8,o=s.width()-a.inputMinWidth,u=o-r;u<0?(e("#selectData_"+t+" .selectData-selected-ul").css("margin-left",u+"px"),l.css("padding-left",o+"px")):(e("#selectData_"+t+" .selectData-selected-ul").css("margin-left","0px"),l.css("padding-left",r+"px")),d.css("left","0px")}function m(t){e.isPlainObject(t)||(t={}),h(t[a.hiddenValue],t[a.displayValue],t.isAppend)}function h(s,n,d){n!==undefined&&null!==n&&""!=n||(n=s),d!==undefined&&null!==d||(d=!1);var c=Base.I18n.getLangText("taface.module.selectdata.clickdelete");if(a.multiple){if(d||(e("#selectData_"+t+" div.selectData-select-li").remove(),e("#"+a.name).val("")),"string"==typeof s||!isNaN(s))for(var r=s.split(","),o=n.split(","),u=0;u<r.length;u++){var p=l.siblings(".selectData-selected-ul").find(".selectData-select-li:last");p!==undefined&&null!==p&&0!=p.length?l.siblings(".selectData-selected-ul").find(".selectData-select-li:last").after("<div class='selectData-select-li'_id='item_"+r[u]+"'><span class='selectData-select-li-name'>"+o[u]+"</span><span class='selectData-select-li-remove faceIcon icon-close' title='"+c+"'></span></div>"):l.siblings(".selectData-selected-ul").prepend("<div class='selectData-select-li'_id='item_"+r[u]+"'><span class='selectData-select-li-name'>"+o[u]+"</span><span class='selectData-select-li-remove faceIcon icon-close' title='"+c+"'></span></div>");var v=e("#"+a.name).val();null==v||""==v?v=r[u]:v+=","+r[u],e("#"+a.name).val(v)}}else e("#selectData_"+t+" div.selectData-select-li").remove(),e("#"+a.name).val(""),"string"!=typeof s&&isNaN(s)||(l.siblings(".selectData-selected-ul").prepend("<div class='selectData-select-li' selectDataId='item_"+s+"'><span class='selectData-select-li-name'>"+n+"</span><span class='selectData-select-li-remove faceIcon icon-close'  title='"+c+"' ></span></div>"),e("#"+a.name).val(s));f(),i.find(".selectData-select-li-remove").unbind("click").bind("click",function(){if(a.multiple){var t=e(this).parent().attr("_id").substring(8),l=e("#"+a.name).val();if(t==l)e("#"+a.name).val("");else{var i=l.split(","),s=i.indexOf(t);i.splice(s,1);var n=i.join(",");e("#"+a.name).val(n)}}else e("#"+a.name).val("");e(this).parent().remove(),f()})}function b(e,a){var i=!1===e;d.hide(),l.blur(),i?(s.removeClass("readonly"),l.removeAttr("readOnly"),c.removeAttr("readOnly"),o.attr("for",t)):(s.addClass("readonly"),l.attr("readOnly",!0),c.attr("readOnly",!0),o.attr("for",t+"_readonly"),Bubble.hideInfo()),C(),T(!i,!(i||!1===a))}function g(e){var t=!1===e;d.hide(),t?(l.attr("disabled",!0),c.attr("disabled",!0),s.addClass("disabled"),Bubble.hideInfo()):(l.attr("disabled",!1),c.attr("disabled",!1),s.removeClass("disabled")),C(),T(t,t)}function D(e){!1===e?(n.removeClass("required"),u&&u.removeOrder("required")):(n.addClass("required"),u?u.addOrder({type:"required",msg:a.toolTip}):(u=new validateObj(t,l,a,C),l.addClass("validate"),u.addOrder({type:"required",msg:a.toolTip})))}function y(){return!u||u.executeValidate()}function C(e){!1===e?(s.removeClass("successvalidate").addClass("failvalidate"),r.removeClass("icon-correct2").addClass("icon-close2")):!0===e?(s.removeClass("failvalidate").addClass("successvalidate"),r.removeClass("icon-close2").addClass("icon-correct2")):(s.removeClass("failvalidate successvalidate"),r.removeClass("icon-close2 icon-correct2"))}function T(e,t){t?s.find(".selectData-select-li-remove").hide():s.find(".selectData-select-li-remove").show(),p=e}return function(){if(e(document).mousedown(function(t){var a=t.target||t.srcElement;e(a).is(".selectData-win-Container")||e(a).parents(".selectData-win-Container").length>0||d.hide()}),l.on("focus",function(e){p||s.addClass("active")}).on("blur",function(){p||s.removeClass("active")}).on("keyup",function(i){if(!p&&null!=this.value&&""!=e.trim(this.value)&&e.trim(this.value).length>=a.inputQueryNum&&a.url){var s={};if(s["dto['"+t+"']"]=l.val(),a.name&&(s["dto['"+a.name+"']"]=c.val()),a.submitIds)for(var n=a.submitIds.split(","),r=0;r<n.length;r++)s["dto['"+n[r]+"']"]=Base.getValue(n[r]);Base.getJson(a.url,s,function(e){if(null!=e&&e.length>0){d.empty();for(var t=0;t<e.length;t++){var l=a.titleValue,i=a.hiddenValue,s=a.displayValue;d.append("<div title='"+e[t][l]+"'  _id='"+e[t][i]+"'>"+e[t][s]+"</div>")}d.show()}})}}),d.delegate("div","click",function(){if(a.multiple){var t="item_"+e(this).attr("_id");0==i.find("div[_id='"+t+"']").length?h(e(this).attr("_id"),e(this).html(),!0):Base.msgTopTip(Base.I18n.getLangText("taface.module.selectdata.duplicatealarms"))}else h(e(this).attr("_id"),e(this).html());l.val(""),e(this).parent().hide(),y()}),r.on("click",function(){var t=e(this);!p&&t.hasClass("icon-close2")&&(m(""),C(),l.val(""))}),a.placeholder&&Base.funPlaceholder(l[0]),a.bpopTipMsg){var n={width:a.bpopTipWidth,height:a.bpopTipHeight,position:a.bpopTipPosition,info:a.bpopTipMsg};Bubble.setBubbleEvent(l,n)}a.validType&&(l.addClass("validate"),u=new validateObj(t,l,a,C)),v(!0)}(),{cmptype:"TaSelectData",version:"1.1.0",getValue:function(){return c.val()},setValue:m,setReadOnly:b,setEnable:g,setVisible:function(e,t){e?n.show().css("visibility","visible"):t?n.css("visibility","hidden"):n.hide()},setFocus:function(){l.focus()},newSerialize:function(e,t){return c.taserialize(t)},doValidate:y,setValidateStyle:C,setRequired:D,getInput:function(){return l},getInputLabel:function(){return e(".selectData-label",n)},reset:function(){v()},clear:function(){m(null)}}}return a(517),e.extend(!0,window,{TaSelectData:t}),t})},517:function(e,t){}});