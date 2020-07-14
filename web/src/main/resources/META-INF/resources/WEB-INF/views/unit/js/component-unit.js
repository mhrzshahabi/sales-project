isc.defineClass("Unit", isc.DynamicForm).addProperties({
    numCols: 4,
    width: 500,
    wrapItemTitles: false,
    data: null,
    unitCategory: 0,
    fieldValueTitle: "",
    disabledUnitField: false,
    disabledValueField: false,
    disabledCurrencyField: false,
    showValueFieldTitle: true,
    showUnitFieldTitle: false,
    showCurrencyFieldTitle: false,
    showUnitField: true,
    showCurrencyField: true,
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
            name: "currencyId",
            valueField: "id",
            displayField: "symbol",
            editorType: "SelectItem",
            visible: This.showUnitField,
            disabled: This.disabledCurrencyField,
            showTitle: This.showCurrencyFieldTitle,
            title: "<spring:message code='currency.title'/>",
            pickListWidth: "400",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BaseFormItems.concat([
                    {name: "id"},
                    {name: "nameFa"},
                    {name: "nameEn"},
                    {name: "symbol"}
                ]),
                fetchDataURL: "${contextPath}" + "/api/currency/spec-list"
            }),
            pickListFields: [
                {name: "id", title: "<spring:message code='global.id'/>"},
                {name: "nameFa", title: "<spring:message code='currency.name.fa'/>"},
                {name: "nameEn", title: "<spring:message code='currency.name.en'/>"},
                {name: "symbol", title: "<spring:message code='currency.symbol'/>"}
            ]
        });
        this.addField({
            type: 'long',
            width: "100%",
            autoFetchData: false,
            name: "unitId",
            valueField: "id",
            displayField: "nameEN",
            editorType: "SelectItem",
            visible: This.showCurrencyField,
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
    getCurrencyId: function () {
        this.getValue("currencyId");
    },
    setValue: function (value) {
        this.setValue("value", value);
    },
    setUnitId: function (unitId) {
        this.setValue("unitId", unitId);
    },
    setCurrencyId: function (currencyId) {
        this.setValue("currencyId", currencyId);
    }
});
