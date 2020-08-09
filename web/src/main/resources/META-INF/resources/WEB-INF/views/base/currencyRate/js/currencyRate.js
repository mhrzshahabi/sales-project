var currencyRateTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
const currencyTypes = {
       //null:"",
      "AZAD": "<spring:message code='currency.type.azad'/>",
      "NIMAEE": "<spring:message code='currency.type.nimaee'/>"
}
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
        filterOperator: "equals",
        valueMap: JSON.parse('${Enum_SymbolCUR}'),
    },
    {
        name: "currencyTypeFrom",
        title: "<spring:message code='currency.type.from'/>",
        //required: true,
        width: "100%",
        length: "8",
        filterOperator: "equals",
        valueMap: currencyTypes,
    },
    {
        name: "symbolCT",
        title: "<spring:message code='currency.rate.t'/>",
        required: true,
        width: "100%",
        filterOperator: "equals",
        valueMap: JSON.parse('${Enum_SymbolCUR}'),
    },
    {
        name: "currencyTypeTo",
        title: "<spring:message code='currency.type.to'/>",
        //required: true,
        width: "100%",
        length: "8",
        filterOperator: "equals",
        valueMap: currencyTypes,
    },
    {
        name: "reference",
        title: "<spring:message code='currencyRate.Central.Bank'/>",
        required: true,
        width: "100%",
        filterOperator: "equals",
        valueMap: JSON.parse('${Enum_RateReference}')
    },
    {
        name: "currencyRateValue",
        title: "<spring:message code='rate.title'/>",
        required: true,
        width: "100%",
        length: "8",
        keyPressFilter: "[0-9]"
    },

]);
Object.assign(currencyRateTab.listGrid.fields, currencyRateTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(currencyRateTab, "/api/currencyRate");
currencyRateTab.dynamicForm.main.windowWidth = 500;

currencyRateTab.dynamicForm.main.validate = function () {
    let isValid = this.Super("validate", arguments);
    let data = currencyRateTab.dynamicForm.main.getValues();
    if (data.symbolCF != null && data.symbolCF === data.symbolCT) {
        currencyRateTab.dynamicForm.main.errors["symbolCT"] = "<spring:message code='currencyRate.checkRate'/>";
        return false;
    }
    return isValid;
}