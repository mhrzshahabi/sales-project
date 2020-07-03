var priceBaseTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
priceBaseTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "priceDate",
        width: "10%",
        type: 'date',
        title: "<spring:message code='priceBase.date'/>"
    }, {
        type: 'number',
        name: "elementId",
        title: "<spring:message code='priceBase.element'/>",
        width: "300",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "name"}
            ]),
            fetchDataURL: "${contextPath}/api/element/" + "spec-list"
        }),
        pickListFields: [
            {name: "name", title: '<spring:message code="priceBase.element"/>'}
        ]
    }, {
        type: 'number',
        name: "currencyId",
        title: "<spring:message code='currency.title'/>",
        width: "300",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameEn",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "nameFa"},
                {name: "nameEn"}
            ]),
            fetchDataURL: "${contextPath}/api/currency/" + "spec-list"
        }),
        pickListFields: [
            {name: "nameFa", title: '<spring:message code="currency.name.fa"/>'},
            {name: "nameEn", title: '<spring:message code="currency.name.en"/>'}
        ]
    }, {
        type: 'number',
        name: "unitId",
        title: "<spring:message code='unit.title'/>",
        width: "300",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameEN",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "nameFA"},
                {name: "nameEN"}
            ]),
            fetchDataURL: "${contextPath}/api/unit/" + "spec-list"
        }),
        pickListFields: [
            {name: "nameFA", title: '<spring:message code="unit.nameFa"/>'},
            {name: "nameEN", title: '<spring:message code="unit.nameEN"/>'}
        ]
    }, {
        name: "priceBaseReference",
        width: "300",
        required: true,
        title: "<spring:message code='priceBase.reference'/>",
        valueMap: {
            0: "LME",
            1: "MetalsWeek"
        }
    }, {
        name: "price",
        width: "300",
        type: "text",
        title: "<spring:message code='priceBase.price'/>"
    }
]);
Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.listGrid.main.contextMenu = null;
priceBaseTab.dynamicForm.main.windowWidth = 500;