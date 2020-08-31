isc.defineClass("Unit", isc.DynamicForm).addProperties({
    numCols: 4,
    width: 500,
    wrapItemTitles: false,
    data: null,
    unitHint: "",
    unitCategory: "",
    fieldValueTitle: "",
    fieldValueTitleWidth: "",
    disabledUnitField: false,
    disabledValueField: false,
    showValueFieldTitle: true,
    showUnitFieldTitle: false,
    showUnitField: true,
    required: true,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addField({
            wrapTitle: false,
            required: This.required,
            name: "value",
            type: 'float',
            format: "#.##",
            titleAlign: "left",
            keyPressFilter: "[0-9.]",
            title: This.fieldValueTitle,
            titleWidth: This.fieldValueTitleWidth,
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
            wrapTitle: false,
            required: This.required,
            type: 'long',
            autoFetchData: false,
            name: "unitId",
            valueField: "id",
            displayField: "nameEN",
            wrapHintText: false,
            hint: This.unitHint,
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
