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
        name: "id",
        hidden: true
    },
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
            {
                name: "name",
                title: '<spring:message code="priceBase.element"/>'
            }
        ],
        validator: [
            {
                type: "required",
                validateOnChange: true
            }
        ],
        changed: function (form, item, value) {
            let elementId = item.getValue();
            switch (elementId) {

                case 1:
                    form.getItem("financeUnitId").setValue(12);
                    form.getItem("weightUnitId").setValue(13);
                    break;
                case 2:
                    form.getItem("financeUnitId").setValue(12);
                    form.getItem("weightUnitId").setValue(14);
                    break;
            }
        }
    },
    {
        name: "financeUnitId",
        title: "<spring:message code='priceBase.financeUnit'/>",
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
        ],
        validator: [
            {
                type: "required",
                validateOnChange: true
            }
        ],
    },
    {
        name: "weightUnitId",
        title: "<spring:message code='priceBase.weightUnit'/>",
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
        ],
        validator: [
            {
                type: "required",
                validateOnChange: true
            }
        ],
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
        type: "float",
        title: "<spring:message code='priceBase.price'/>",
        validator: [
            {
                type: "floatPrecision",
                validateOnChange: true,
                precision: 10,
                min: 0,
                max: 5
            }
        ],
    }
]);

Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.dynamicForm.main.windowWidth = 500;
