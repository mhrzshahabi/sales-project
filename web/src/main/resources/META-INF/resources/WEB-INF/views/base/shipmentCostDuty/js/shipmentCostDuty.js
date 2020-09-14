var costDutyTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
costDutyTab.dynamicForm.fields = BaseFormItems.concat([

    {
        name: "nameFA",
        title: "<spring:message code='unit.nameFa'/>",
        required: true,
        width: "100%",
        keyPressFilter: "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
        length: 66,
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
    },
    {
        name: "nameEN",
        title: "<spring:message code='unit.nameEN'/>",
        type: 'text',
        required: true,
        width: "100%",
        length: 66,
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
    },
    {
        name: "code",
        title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>",
        type: 'text',
        required: true,
        length: 100,
        width: "100%",
        keyPressFilter: "[0-9A-Za-z |\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|*\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
        validators: [
            {
                type: "regexp",
                expression: "^[0-9A-Za-z |\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|*\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
            }]
    }

]);
Object.assign(costDutyTab.listGrid.fields, costDutyTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(costDutyTab, "api/costDuty/");

costDutyTab.dynamicForm.main.windowWidth = 500;





