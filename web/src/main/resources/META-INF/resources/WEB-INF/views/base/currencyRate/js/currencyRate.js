var currencyRateTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
currencyRateTab.dynamicForm.fields = BaseFormItems.concat([

    {
        name: "id",
        hidden: true ,
        width: "10%"
    },

    {
        name: "currencyDate",
        title: "<spring:message code='currencyRate.curDate'/>",
        type: "date",
        width: "100%",
        required: true,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "symbolCF",
        title: "<spring:message code='unit.symbol'>",
        type: 'text',
        required: true,
        width: "100%" ,
        valueMap : JSON.parse('${Enum_SymbolUnit.SymbolCUR}'),
    } ,
    {
        name: "symbolCT",
        title: "<spring:message code='unit.symbol'>",
        type: 'text',
        required: true,
        width: "100%" ,
        valueMap : JSON.parse('${Enum_SymbolUnit.SymbolCUR}'),
    },
    {
        name : "reference" ,
        title: "<spring:message code='unit.symbol'>",
        typeof: 'text' ,
        required: true,
        width: "100%" ,
        valueMap : JSON.parse('${Enum_RateReference}')
    }
]);
Object.assign(currencyRateTab.listGrid.fields, currencyRateTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(currencyRateTab, "");
currencyRateTab.dynamicForm.main.windowWidth = 500;





