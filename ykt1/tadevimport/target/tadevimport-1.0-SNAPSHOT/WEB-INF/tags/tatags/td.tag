<%@tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@tag import="com.yinhai.core.app.api.util.TagUtil"%>
<%@tag import="com.yinhai.core.app.api.web.resultbaen.IResultBean"%>
<%@tag import="com.yinhai.core.common.api.util.ValidateUtil"%>
<%@tag import="com.yinhai.modules.codetable.api.domain.vo.AppCodeVo"%>
<%@tag import="com.yinhai.modules.codetable.api.util.CodeTableUtil"%>
<%@tag import="com.yinhai.modules.org.api.vo.user.UserVo"%>
<%@tag import="com.yinhai.modules.security.api.util.ISecurityConstant"%>
<%@tag import="com.yinhai.modules.security.api.util.SecurityUtil"%>
<%@tag import="com.yinhai.modules.security.api.vo.UserAccountInfo"%>
<%@tag import="org.apache.commons.lang3.StringUtils" %>
<%@tag import="javax.servlet.jsp.tagext.JspTag"%>
<%@tag import="java.beans.PropertyDescriptor"%>
<%@tag import="java.lang.reflect.Method"%>
<%@tag import="java.util.Iterator"%>
<%@tag import="java.util.List" %>
<%@tag import="java.util.Map"%>

<%--@doc--%>
<%@tag description='用于输出td标签' display-name='td' %>
<%@attribute description='组件id匹配field' name='id' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式class，如:cssClass="no-padding"' name='cssClass' type='java.lang.String' %>
<%@attribute description='给该组件添加自定义样式，如:cssStyle="padding-top:10px"' name='cssStyle' type='java.lang.String' %>
<%@attribute description='指定组件标签' name='key' type='java.lang.String' %>
<%@attribute description='定义单元格跨行数' name='rowspan' type='java.lang.String' %>
<%@attribute description='定义单元格跨列数' name='colspan' type='java.lang.String' %>
<%@attribute description='指定内容的垂直对齐方式' name='valign' type='java.lang.String' %>
<%@attribute description='指定内容对齐方式,默认是right' name='align' type='java.lang.String' %>
<%@attribute description='指定td中显示的内容' name='content' type='java.lang.String' %>
<%@attribute description='指定码表转换' name='collection' type='java.lang.String' %>
<%@attribute description='指定td的宽度' name='width' type='java.lang.String' %>
<%@attribute description='指定td的高度' name='height' type='java.lang.String' %>
<%@attribute description='指定td显示的最大字符长度' name='maxLength' type='java.lang.String' %>
<%@attribute description='是否需要权限控制' name='fieldsAuthorization' type='java.lang.String' %>
<%@attribute description='true/false,是否过滤org（分中心），默认false' name='filterOrg' type='java.lang.String' %>
<%--@doc--%>
<%
	
	
	String parnetIsfiledscontrol = "";
	try{
		JspTag parent = TagUtil.getTa3ParentTag(getParent());
		PropertyDescriptor pd1 = new PropertyDescriptor("fieldsAuthorization", parent.getClass());
		Method method1 = pd1.getReadMethod();
	    parnetIsfiledscontrol = (String)method1.invoke(parent);
	   }
	catch(Exception e){
	}
	if("true".equals(parnetIsfiledscontrol)){
		fieldsAuthorization="true";
	}
	if ("true".equals(fieldsAuthorization)) {
		String status = SecurityUtil.getFieldStatus(request, id);
		if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_DEFAULT.equals(status)
				|| ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_EDIT.equals(status)) {
			// 正常
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_ONLY_LOOK.equals(status)) {
			// 只能查看
		} else if (ISecurityConstant.FIELD_CONTROL_STATUS_LEVEL_NO_LOOK.equals(status)) {
			// 不能看
			return;
		}
	}
%>
<%

		if ((this.id == null || this.id.length() == 0)) {
			jspContext.setAttribute("id", "");
			jspContext.setAttribute("content", "");
		}
		if (this.id != null && !this.id.equals("")) {
			jspContext.setAttribute("id", this.id);
			if (this.content != null && !this.content.equals("")) {
				jspContext.setAttribute("content", jspContext.getAttribute("content"));
				jspContext.setAttribute("fullContent",content);
		} else {
				IResultBean resultBean = (IResultBean)TagUtil.getResultBean();
				if (resultBean != null) {
					Map<String, Object> map = resultBean.getFieldsData();
					if (map != null) {
						Object obj = map.get(this.id);
						if (obj != null) {
							if (collection != null && !"".equals(collection)) {
								String orgId = null;
								if("true".equals(filterOrg)){
									UserAccountInfo userAccountInfo = SecurityUtil.getUserAccountInfo(request);
									if(userAccountInfo != null)
										orgId = userAccountInfo.getPositionOrg().getYab003();
								}
								List<AppCodeVo> codeList = CodeTableUtil.getCodeList(collection, orgId);
								boolean  flage=false;
								String fullContent = "";
								for (Iterator<AppCodeVo> i = codeList.iterator(); i.hasNext();) {
									AppCodeVo app = i.next();
									if (app.getCodeValue().equals(obj.toString())) {
										fullContent=app.getCodeDESC();
										jspContext.setAttribute("content",getFinalString(fullContent));
										jspContext.setAttribute("fullContent",fullContent);
										flage=true;
									}
								}
								
								if(!flage){
									fullContent=obj.toString();
									jspContext.setAttribute("content", getFinalString(fullContent));
									jspContext.setAttribute("fullContent",fullContent);
								}
									

							} else {
								String fullContent=obj.toString();
								jspContext.setAttribute("content", getFinalString(fullContent));
								jspContext.setAttribute("fullContent", fullContent);
							}

						} else {
							jspContext.setAttribute("content", "");
						}
					}
				}
			}
			
			
		}
 %>
<%!
	public  String  getFinalString(String s){
	JspContext tdJspContext = getJspContext();
		if(this.maxLength != null && !this.maxLength.equals("")){
			if(StringUtils.isNumeric(maxLength)){
				Integer length= Integer.parseInt(maxLength);
				s=textCut(s,length,"...");
				tdJspContext.setAttribute("maxLength",tdJspContext.getAttribute("maxLength"));
			}
		}
		return s;
	}
	
	public  String textCut(String s, int len, String append) {
		if (s == null) {
			return null;
		}
		int slen = s.length();
		if (slen <= len) {
			return s;
		}
		// 最大计数（如果全是英文）
		int maxCount = len * 2;
		int count = 0;
		int i = 0;
		for (; count < maxCount && i < slen; i++) {
			if (s.codePointAt(i) < 256) {
				count++;
			} else {
				count += 2;
			}
		}
		if (i < slen) {
			if (count > maxCount) {
				i--;
			}
			if (!StringUtils.isBlank(append)) {
				if (s.codePointAt(i - 1) < 256) {
					i -= 2;
				} else {
					i--;
				}
				return s.substring(0, i) + append;
			} else {
				return s.substring(0, i);
			}
		} else {
			return s;
		}
	}
 %>
<td    
<% if( !ValidateUtil.isEmpty(align) ){%>
   align="${align}" 
<%}else{%>
   align="right"
<%}%>
<% if( !ValidateUtil.isEmpty(valign) ){%>
   valign="${valign}"
<%}%>
<% if(  !ValidateUtil.isEmpty(rowspan) ){%>
  rowspan="${rowspan}" 
<%}%>
<% if(  !ValidateUtil.isEmpty(colspan) ){%>
  colspan="${colspan}"  
<%}%>
 <% if( !ValidateUtil.isEmpty(cssStyle) ){%>
       style="${cssStyle}"  
  <%}%>
  <% if( !ValidateUtil.isEmpty(height) ){%>
             height="${height}" 
       <%}else{%>
             height="23" 
  <%}%>
<% if( !ValidateUtil.isEmpty(id) ){%>
       id="${id}" 
       <% if( !ValidateUtil.isEmpty(width) ){%>
            width="${width}" 
       <%}else{%>
             width="120" 
       <%}%>
    <%}else{%>
    <% if( !ValidateUtil.isEmpty(width) ){%>
            width="${width}" 
       <%}else{%>
             width="80" 
       <%}%>
 <%}%>
<% if( !ValidateUtil.isEmpty(id) ){%>
   <% if( !ValidateUtil.isEmpty(cssClass) ){%>
        class="table-td-cell ${cssClass}" 
      <%}else{%>
        class="table-td-cell"  
  <%}%>
 <%}else{%>
     <% if( !ValidateUtil.isEmpty(cssClass) ){%>
       class="table-td-cell table-td-cell-label   ${cssClass}" 
      <%}else{%>
       class="table-td-cell table-td-cell-label "  
    <%}%>
<%}%>
<% if(  !ValidateUtil.isEmpty(maxLength) ){%>
       maxLength="${maxLength}"  
     <% if( !ValidateUtil.isEmpty(jspContext.getAttribute("fullContent")) ){%>
        title="${fullContent}"  
     <%}%>
<%}%>
>
<jsp:doBody />
		<div style="clear:both"></div>
<% if( !ValidateUtil.isEmpty(id) ){%>
    <% if( !ValidateUtil.isEmpty(jspContext.getAttribute("content") ) ){%>
      ${content}  
    <%}%>
    <%}else{%>
     <% if( !ValidateUtil.isEmpty(key) ){%>
      ${key}
    <%}%>
<%}%>
</td>
