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
        width: "300",
        type: 'date',
        title: "<spring:message code='priceBase.date'/>"
    },
    {
        name: "elementId",
        title: "<spring:message code='priceBase.element'/>",
        width: "300",
        type: "long",
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
                    form.getItem("financeUnitId").setValue(-32);
                    form.getItem("weightUnitId").setValue(-11);
                    break;
                case 2:
                    form.getItem("financeUnitId").setValue(-32);
                    form.getItem("weightUnitId").setValue(-1);
                    break;
                case 3:
                    form.getItem("financeUnitId").setValue(-32);
                    form.getItem("weightUnitId").setValue(-11);
                    break;
                case 4:
                    form.getItem("financeUnitId").setValue(-32);
                    form.getItem("weightUnitId").setValue(-1);
                    break;
            }
        }
    },
    {
        name: "financeUnitId",
        title: "<spring:message code='priceBase.financeUnit'/>",
        width: "300",
        type: "long",
        required: true,
        autoFetchData: false,
        canEdit: "${SecurityUtil.hasAuthority('U_PRICE_BASE')}".toString() === 'true',
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
        type: "long",
        required: true,
        autoFetchData: false,
        canEdit: "${SecurityUtil.hasAuthority('U_PRICE_BASE')}".toString() === 'true',
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
        // type: "long",
        required: true,
        title: "<spring:message code='priceBase.reference'/>",
        filterOperator: "equals",
        valueMap: JSON.parse('${Enum_PriceBaseReference}'),
        defaultValue: "LME"
    },
    {
        name: "price",
        width: "300",
        type: "float",
        length: 11,
        title: "<spring:message code='priceBase.price'/>",
        keyPressFilter : "[0-9.]",
        validator: [
            {
                type: "regexp",
                expression: "^(\d{1,10}(\.\d{1,5})?)$",
                validateOnChange: true,
            }
        ],
        formatCellValue: function (value, record, rowNum, colNum) {
            return `<span style="font-weight: bolder; font-size: small;">` + value + `</span>`;
        }
    }
]);

Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.dynamicForm.main.windowWidth = 500;
nicico.BasicFormUtil.removeExtraGridMenuActions(priceBaseTab);
