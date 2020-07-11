var unitBases = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
unitBases.dynamicForm.fields = BaseFormItems.concat([

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
Object.assign(unitBases.listGrid.fields, unitBases.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(unitBases, "api/unit/");
unitBases.listGrid.main.contextMenu = null;
unitBases.dynamicForm.main.windowWidth = 500;





