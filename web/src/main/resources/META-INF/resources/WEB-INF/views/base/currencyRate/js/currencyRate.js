var currencyRateTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
currencyRateTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true,
        width: "10%",
    },
    {
        name: "currencyDate",
        title: "<spring:message code='currencyRate.curDate'/>",
        type: "date",
        format: 'DD-MM-YYYY',
        width: "100%",
        required: true,
    },
    {
        name: "symbolCF",
        title: "<spring:message code='currency.rate.f'/>",
        required: true,
        width: "100%",
        valueMap : JSON.parse('${Enum_SymbolCUR}'),
    },
    {
        name: "symbolCT",
        title: "<spring:message code='currency.rate.t'/>",
        required: true,
        width: "100%",
        valueMap : JSON.parse('${Enum_SymbolCUR}'),
    },
    {
        name: "reference",
        title: "<spring:message code='unit.symbol'/>",
        required: true,
        width: "100%",
       valueMap : JSON.parse('${Enum_RateReference}')
    },
    {
        name: "currencyRateValue",
        title: "<spring:message code='rate.title'/>",
        required: true,
        width: "100%" ,
        length: "8",
    }
]);
Object.assign(currencyRateTab.listGrid.fields, currencyRateTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(currencyRateTab, "/api/currencyRate");
currencyRateTab.dynamicForm.main.windowWidth = 500;
