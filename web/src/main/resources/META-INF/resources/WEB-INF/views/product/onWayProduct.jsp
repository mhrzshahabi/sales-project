<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>
    <% DateUtil dateUtil = new DateUtil();%>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="on-way-product-create-remmitance.js" %>
<%@include file="onWayProduct.js" %>
//</script>