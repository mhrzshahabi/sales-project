var unitTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
unitTab.dynamicForm.fields = BaseFormItems.concat([

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
        name: "symbolUnit",
        title: "<spring:message code='unit.symbol'/>",
        type: 'text',
        required: true,
        width: "100%",
        filterOperator: "equals",
        valueMap:JSON.parse('${Enum_SymbolUnit}')
    },
    {
        name: "categoryUnit",
        title: "<spring:message code='unit.category'/>",
        type: 'text',
        required: true,
        width: "100%",
        filterOperator: "equals",
        valueMap: JSON.parse('${Enum_CategoryUnit}'),
    }

]);
Object.assign(unitTab.listGrid.fields, unitTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(unitTab, "api/unit/");
unitTab.dynamicForm.main.windowWidth = 500;





