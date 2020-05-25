<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="js/Component_IncotermSteps.js"%>
<%@include file="js/Component_IncotermRules.js"%>
<%@include file="js/Component_IncotermParty.js"%>
<%@include file="js/Component_IncotermDetail.js"%>
<%@include file="js/Component_IncotermDetail-old.js"%>
<%@include file="js/Component_IncotermRuleRecord.js"%>
<%@include file="js/Component_IncotermRuleTable.js"%>
<%@include file="js/Component_IncotermTable.js"%>
