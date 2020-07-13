var currencyTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
currencyTab.dynamicForm.fields = BaseFormItems.concat([

    {
        name: "id",
        hidden: true
    },
    {
        name: "nameEn",
        title: "<spring:message code='currency.nameLatin'/>",
        width: "100%",
        required: true
    },
    {
        name: "nameFa",
        title: "<spring:message code='currency.nameFa'/>",
        width: "100%",
        required: true
    },
    {
        name: "symbolCurrency",
        title: "<spring:message code='currency.symbol'/>",
        type: 'text',
        required: true,
        width: "100%",
        valueMap: JSON.parse('${Enum_SymbolCurrency}'),
    }
]);
Object.assign(currencyTab.listGrid.fields, currencyTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(currencyTab, "api/currency");
currencyTab.dynamicForm.main.windowWidth = 500;





