<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.nicico.copper.core.SecurityUtil" %>


<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="../common/ts/BasicFormUtil.js"%>
<%@include file="js/contract-references.js" %>
<%@include file="js/contract.js" %>
<%@include file="js/contract-addendum.js" %>
