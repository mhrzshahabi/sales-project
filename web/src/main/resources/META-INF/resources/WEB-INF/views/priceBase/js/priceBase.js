var priceBaseTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

let financeCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: "Finance"}]
};

let weightCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: "Weight"}]
};

priceBaseTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "priceDate",
        width: "10%",
        type: 'date',
        title: "<spring:message code='priceBase.date'/>"
    },
    {
        name: "elementId",
        title: "<spring:message code='priceBase.element'/>",
        type: 'number',
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
        ],
        changed: function (form, item, value) {
            let elementId = item.getValue();
            switch (elementId) {

                case 1:
                    form.getItem("currencyId").setValue(12);
                    form.getItem("unitId").setValue(13);
                    break;
                case 2:
                    form.getItem("currencyId").setValue(12);
                    form.getItem("unitId").setValue(14);
                    break;
            }
        }
    },
    {
        name: "currencyId",
        title: "<spring:message code='currency.title'/>",
        type: 'number',
        width: "300",
        required: true,
        autoFetchData: false,
        canEdit: false,
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
        optionCriteria: financeCriteria,
        pickListFields: [
            {name: "nameFA", title: '<spring:message code="unit.nameFa"/>'},
            {name: "nameEN", title: '<spring:message code="unit.nameEN"/>'}
        ]
    },
    {
        name: "unitId",
        title: "<spring:message code='unit.title'/>",
        type: 'number',
        width: "300",
        required: true,
        autoFetchData: false,
        canEdit: false,
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
        optionCriteria: weightCriteria,
        pickListFields: [
            {name: "nameFA", title: '<spring:message code="unit.nameFa"/>'},
            {name: "nameEN", title: '<spring:message code="unit.nameEN"/>'}
        ]
    },
    {
        name: "priceBaseReference",
        width: "300",
        required: true,
        title: "<spring:message code='priceBase.reference'/>",
        valueMap: {
            0: "LME",
            1: "MetalsWeek"
        },
        defaultValue: 0
    },
    {
        name: "price",
        width: "300",
        type: "text",
        title: "<spring:message code='priceBase.price'/>"
    }
]);

priceBaseTab.listGrid.fields = [
    {
        name: "id",
        hidden: true
    },
    {
        name: "priceDate",
    },
    {
        name: "elementId",
        title: "elementId",

    },
    {
        name: "priceBaseReference",
        title: "<spring:message code='inspectionReport.inspectionPlace'/>"
    },
    {
        name: "unitId",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "date",
        width: "10%"
    },
    {
        name: "currencyId"
    }
];

Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.dynamicForm.main.windowWidth = 500;
