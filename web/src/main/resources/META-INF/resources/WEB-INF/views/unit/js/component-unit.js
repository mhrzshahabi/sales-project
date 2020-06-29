isc.defineClass("Unit", isc.DynamicForm).addProperties({

    numCols: 4,
    width: 500,
    wrapItemTitles: false,
    data: null,
    unitCategory: 0,
    fieldValueTitle: "",
    disabledUnitField: false,
    disabledValueField: false,
    showUnitFieldTitle: true,
    showValueFieldTitle: true,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addField({
            wrap: false,
            required: true,
            name: "value",
            width: "100%",
            type: 'float',
            keyPressFilter: "[0-9.]",
            title: This.fieldValueTitle,
            disabled: This.disabledValueField,
            showTitle: This.showValueFieldTitle,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                wrap: false,
                errorMessage: "<spring:message code='global.form.correctType'/>"
            }]
        });
        this.addField({
            type: 'long',
            width: "100%",
            autoFetchData: false,
            name: "unitId",
            valueField: "id",
            displayField: "nameEN",
            editorType: "SelectItem",
            disabled: This.disabledUnitField,
            showTitle: This.showUnitFieldTitle,
            title: "<spring:message code='unit.title'/>",
            pickListWidth: "400",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BaseFormItems.concat([
                    {name: "id"},
                    {name: "nameFA"},
                    {name: "nameEN"},
                    {name: "categoryValue", title: "categoryValue"}
                ]),
                fetchDataURL: "${contextPath}" + "/api/unit/spec-list"
            }),
            pickListFields: [
                {name: "categoryValue", title: "categoryValue"},
                {name: "id", title: '<spring:message code="global.code"/>'},
                {name: "nameFA", title: '<spring:message code="global.title-fa"/>'},
                {name: "nameEN", title: '<spring:message code="global.title-en"/>'},
            ],
            pickListCriteria: {
                _constructor: 'AdvancedCriteria', operator: "and", criteria: [{
                    fieldName: "categoryValue", operator: "equals", value: This.unitCategory
                }]
            },
        });

        this.setValues(this.data);
    },
    getValue: function () {
        this.getValue("value");
    },
    getUnitId: function () {
        this.getValue("unitId");
    },
    setValue: function (value) {
        this.setValue("value", value);
    },
    setUnitId: function (unitId) {
        this.setValue("unitId", unitId);
    }
});
