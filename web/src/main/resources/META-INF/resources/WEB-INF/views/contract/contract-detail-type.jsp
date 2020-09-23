<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

//<script>
    let contractDetailTypeReferences = JSON.parse('<%=request.getAttribute("contractDetailTypeReferences")%>');
    let contractDetailTypeReferencesValues = {
        Enum_RateReference: JSON.parse('<%=request.getAttribute("Enum_RateReference")%>'),
        Enum_PriceBaseReference: JSON.parse('<%=request.getAttribute("Enum_PriceBaseReference")%>')
    };
//</script>

<%@include file="js/contract-references.js" %>
<%@include file="js/contract-detail-type.js" %>
