var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

//******************************************************* VARIABLES *************************************************-**

inspectionReportTab.variable.inspectionReportUrl = "${contextPath}" + "/api/inspectionReport/";

//***************************************************** RESTDATASOURCE *************************************************

inspectionReportTab.restDataSource.inspecReportRest = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "InspectionNO",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "inspector.nameFA",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "inspectorId",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "inspectionPlace",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "IssueDate",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "remittanceDetail.amount",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "remittanceDetailId",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "seller.nameFA",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "buyer.nameFA",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "inspectionRateValue",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "inspectionRateValueType",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "currency.nameFa",
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "currencyId",
            title: "<spring:message code='global.code'/>"
        },
    ]),
    fetchDataURL: inspectionReportTab.variable.inspectionReportUrl + "spec-list"
});

inspectionReportTab.listGrid.inspecReportGrid = isc.ListGrid.create({});