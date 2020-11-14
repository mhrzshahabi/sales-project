<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
//<script>
Enums.contract = {
"Enum_DataType": JSON.parse('${Enum_DataType}'),
"contractDetailTypeReferences": JSON.parse('${contractDetailTypeReferences}'),
"Enum_EContractDetailTypeCode": JSON.parse('${Enum_EContractDetailTypeCode}'),
"Enum_EContractDetailValueKey": JSON.parse('${Enum_EContractDetailValueKey}'),
"Enum_RateReference": JSON.parse('${Enum_RateReference}'),
"Enum_PriceBaseReference": JSON.parse('${Enum_PriceBaseReference}'),
}
//</script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<%@include file="../common/ts/BasicFormUtil.js"%>
<%@include file="js/contract-references.js" %>
<%@include file="js/contract.js" %>
<%@include file="js/contract-addendum.js" %>
<%@include file="js/contract-add-dynamic-table.js" %>
