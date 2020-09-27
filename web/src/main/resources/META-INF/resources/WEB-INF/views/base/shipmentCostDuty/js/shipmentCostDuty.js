var costDutyTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
costDutyTab.dynamicForm.fields = BaseFormItems.concat([{
    length: 100,
    name: "code",
    type: 'text',
    width: "100%",
    required: true,
    title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>",
    keyPressFilter: "[0-9A-Za-z |\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|*\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
    validators: [
        {
            type: "regexp",
            expression: "^[0-9A-Za-z |\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|*\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
        }]
}, {
    length: 66,
    width: "100%",
    name: "nameFA",
    required: true,
    title: "<spring:message code='unit.nameFa'/>",
    keyPressFilter: "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
    validators: [
        {
            type: "required",
            validateOnChange: true
        },
        {
            type: "regexp",
            expression: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
            validateOnChange: true
        }
    ]
}, {
    length: 66,
    width: "100%",
    name: "nameEN",
    required: true,
    title: "<spring:message code='unit.nameEN'/>",
    keyPressFilter: "[A-Za-z *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
    validators: [
        {
            type: "required",
            validateOnChange: true
        },
        {
            type: "regexp",
            expression: "^[A-Za-z *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
            validateOnChange: true
        }]
}]);
costDutyTab.listGrid.fields = BaseFormItems.concat([{
    name: "code",
    title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>",
}, {
    name: "name",
    title: "<spring:message code='global.name'/>",
}]);
nicico.BasicFormUtil.getDefaultBasicForm(costDutyTab, "api/costDuty/");
costDutyTab.dynamicForm.main.windowWidth = 500;