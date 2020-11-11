<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

<%@include file="../common/ts/BasicFormUtil.js"%>
<%@include file="packing-list.js" %>
