<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
_noClose = false;
$(function(){
	$(document).click(function(event){
		if(!_noClose){
			try{
				top.indexCommon.popBoxControl();
			}	
			catch(e){
				Base.sendMsgToFrame(window.top,"indexCommon.popBoxControl");
			}	
		}
	});
});

</script>