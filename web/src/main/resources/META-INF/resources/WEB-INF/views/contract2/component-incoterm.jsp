<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="js/component-incoterm-steps.js"%>
<%@include file="js/component-incoterm-rules.js"%>
<%@include file="js/component-incoterm-party.js"%>
<%@include file="js/component-incoterm-detail.js"%>
<%@include file="js/component-incoterm-rule-record.js"%>
<%@include file="js/component-incoterm-rule-table.js"%>
<%@include file="js/component-incoterm-table.js"%>
