<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

<%@include file="../common/ts/BasicFormUtil.js" %>
<%@include file="../unit/js/component-unit.js" %>
<%@include file="../common/js/component-file.js" %>
<%@include file="js/report.js" %>
