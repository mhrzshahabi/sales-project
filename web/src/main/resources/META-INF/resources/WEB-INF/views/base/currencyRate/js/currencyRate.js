var currencyRateTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
const currencyTypes = {
       //null:"",
      "AZAD": "<spring:message code='currency.type.azad'/>",
      "NIMAEE": "<spring:message code='currency.type.nimaee'/>"
}
var RestDataSource_Units = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        {name: "id", title: "id", primaryKey: true, hidden: true},
        {name: "nameFA"},
        {name: "nameEN"},
        {name: "name"}
    ]),
    fetchDataURL: "${contextPath}/api/unit/spec-list"
})
var RestDataSource_Units_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: "Finance"}]
};

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
        name: "unitFromId",
        title: "<spring:message code='currency.rate.f'/>",
        required: true,
        width: "100%",
        filterOperator: "equals",
        optionDataSource: RestDataSource_Units,
        optionCriteria: RestDataSource_Units_optionCriteria,
        displayField: "name",
        valueField: "id",
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
        name: "unitToId",
        title: "<spring:message code='currency.rate.t'/>",
        required: true,
        width: "100%",
        filterOperator: "equals",
        optionDataSource: RestDataSource_Units,
        displayField: "name",
        optionCriteria: RestDataSource_Units_optionCriteria,
        valueField: "id",
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
        title: "<spring:message code='currencyRate.reference.bank'/>",
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
        filterOperator :"equals",
        type: "float",
        keyPressFilter: "[0-9.]",
        formatCellValue: function (value, record, rowNum, colNum) {

            return  value + "";
        }
    },

]);
Object.assign(currencyRateTab.listGrid.fields, currencyRateTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(currencyRateTab, "/api/currencyRate");
currencyRateTab.dynamicForm.main.windowWidth = 500;
nicico.BasicFormUtil.removeExtraGridMenuActions(currencyRateTab);

currencyRateTab.dynamicForm.main.validate = function () {

    let isValid = this.Super("validate", arguments);
    let data = currencyRateTab.dynamicForm.main.getValues();
    if (data.unitFromId != null && data.unitFromId === data.unitToId) {
        currencyRateTab.dynamicForm.main.errors["unitToId"] = "<spring:message code='currencyRate.checkRate'/>";
        return false;
    }
    return isValid;
}