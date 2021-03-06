<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:url value="/foreign-invoice/print/" var="printUrl"/>
<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="js/component-invoice-base-info.js"%>
<%@include file="../../unit/js/component-unit.js"%>
<%@include file="js/component-invoice-base-price.js"%>
<%@include file="js/component-invoice-base-assay.js"%>
<%@include file="js/component-invoice-base-weight.js"%>
<%@include file="js/component-invoice-base-values.js"%>
<%@include file="js/component-invoice-calculation.js"%>
<%@include file="js/component-invoice-calculation-cathode.js" %>
<%@include file="js/component-invoice-calculation2.js"%>
<%@include file="js/component-invoice-calculation-row.js"%>
<%@include file="js/component-invoice-t(r)c.js"%>
<%@include file="js/component-invoice-t(r)c-row.js"%>
<%@include file="js/component-invoice-payment.js"%>
<%@include file="../../common/ts/BasicFormUtil.js"%>
<%@include file="js/foreign-invoice.js"%>
