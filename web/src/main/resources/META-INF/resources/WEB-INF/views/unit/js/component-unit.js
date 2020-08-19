isc.defineClass("Unit", isc.DynamicForm).addProperties({
    numCols: 4,
    width: 500,
    wrapItemTitles: false,
    data: null,
    unitCategory: "",
    fieldValueTitle: "",
    disabledUnitField: false,
    disabledValueField: false,
    showValueFieldTitle: true,
    showUnitFieldTitle: false,
    showUnitField: true,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addField({
            wrap: false,
            required: true,
            name: "value",
            width: "100%",
            type: 'float',
            format: "#.000",
            titleAlign: "left",
            keyPressFilter: "[0-9.]",
            title: This.fieldValueTitle,
            editorType: This.disabledValueField ? "StaticText" : "TextItem",
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
            visible: This.showUnitField,
            editorType: This.disabledUnitField ? "StaticText" : "SelectItem",
            showTitle: This.showUnitFieldTitle,
            title: "<spring:message code='unit.title'/>",
            pickListWidth: "400",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BaseFormItems.concat([
                    {name: "id"},
                    {name: "nameFA"},
                    {name: "nameEN"},
                    {name: "categoryUnit", title: "categoryUnit"}
                ]),
                fetchDataURL: "${contextPath}" + "/api/unit/spec-list"
            }),
            pickListFields: [
                {name: "id", title: '<spring:message code="global.code"/>'},
                {name: "nameFA", title: '<spring:message code="global.title-fa"/>'},
                {name: "nameEN", title: '<spring:message code="global.title-en"/>'},
                {name: "categoryUnit", title: "categoryUnit"},
            ],
            pickListCriteria: {
                _constructor: 'AdvancedCriteria', operator: "and", criteria: [{
                    fieldName: "categoryUnit", operator: "equals", value: This.unitCategory
                }]
            },
        });

        this.setValues(this.data);
    },
    getValue: function () {
        this.getItem("value").getValue();
    },
    getUnitId: function () {
        this.getItem("unitId").getValue();
    },
    setValue: function (value) {
        this.getItem("value").setValue(value);
    },
    setUnitId: function (unitId) {
        this.getItem("unitId").setValue(unitId);
    }
});
