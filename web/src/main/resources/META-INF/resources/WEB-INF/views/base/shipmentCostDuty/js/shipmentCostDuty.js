var costDutyTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
costDutyTab.dynamicForm.fields = BaseFormItems.concat([

    {
        name: "nameFA",
        title: "<spring:message code='unit.nameFa'/>",
        required: true,
        width: "100%",
        keyPressFilter: "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F ]",
        length: 20,
        validators: [
            {
                type: "required",
                validateOnChange: true
            },
            {
                type: "regexp",
                expression: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F ]*$",
                validateOnChange: true
            }
        ]
    },
    {
        name: "nameEN",
        title: "<spring:message code='unit.nameEN'/>",
        type: 'text',
        required: true,
        width: "100%",
        length: 20,
        keyPressFilter: "[A-Za-z ]",
        validators: [
            {
                type: "required",
                validateOnChange: true
            },
            {
                type: "regexp",
                expression: "^[A-Za-z ]*$",
                validateOnChange: true
            }]
    },
    {
        name: "code",
        title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>",
        type: 'text',
        required: true,
        width: "100%"
    }

]);
Object.assign(costDutyTab.listGrid.fields, costDutyTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(costDutyTab, "api/costDuty/");

costDutyTab.dynamicForm.main.windowWidth = 500;





