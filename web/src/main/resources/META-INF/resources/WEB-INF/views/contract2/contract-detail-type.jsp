<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<spring:eval var="Enum_DataType" expression="pageContext.getAttribute('Enum_DataType')"/>
<%@include file="js/contract-detail-type.js" %>