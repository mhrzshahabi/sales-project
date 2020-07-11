var unitTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
unitTab.dynamicForm.fields = BaseFormItems.concat([

    {
        name: "id",
        hidden: true , width: "10%",
    },
    {
        name: "nameFA",
        title: "<spring:message code='unit.nameFa'/>",
        required: true,
        width: "100%",
        validators: [
            {
                type:"required",
                validateOnChange: true
            }]
    },
    {
        name: "nameEN",
        title: "<spring:message code='unit.nameEN'/>",
        type: 'text',
        required: true,
        width: "100%",
        validators: [
            {
                type:"required",
                validateOnChange: true
            }]
    },
    {
        name: "symbolUnit",
        title: "<spring:message code='unit.symbol'/>",
        type: 'text',
        required: true,
        width: "100%",
        valueMap: JSON.parse('${Enum_SymbolUnit}'),
    },
    {
        name: "categoryUnit",
        title: "<spring:message code='unit.category'/>",
        type: 'text',
        required: true,
        width: "100%",
        valueMap: JSON.parse('${Enum_CategoryUnit}'),
    }

]);
Object.assign(unitTab.listGrid.fields, unitTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(unitTab, "api/unit/");
unitTab.listGrid.main.contextMenu = null;
unitTab.dynamicForm.main.windowWidth = 500;





