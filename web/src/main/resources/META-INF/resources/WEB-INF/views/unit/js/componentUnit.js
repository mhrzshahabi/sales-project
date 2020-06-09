isc.defineClass("componentUnit", isc.VStack).addProperties({
    width: "100%",
    height: "2%",
    autoDraw: true,
    layoutMargin: 0,
    membersMargin: 2,
    border: "0px solid blue",
    titelFieldValue: "",
    typeUnitCategory: 0,
    numCols: 4,
    showTitle:true,
    disabled:false,
    form:null,
    initWidget: function () {
        this.Super("initWidget", arguments);
        let This = this;
        form = isc.DynamicForm.create({
            width: 500,
            numCols: This.numCols,
            disabled:This.disabled,
            wrapItemTitles: false,
            fields: [
                {
                    name: "value",
                    title: This.titelFieldValue,
                    width: "100%",
                    type: 'float',
                    wrap: false,
                    required: true,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        wrap: false,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                }, {
                    type: 'long',
                    name: "unitId",
                    showTitle: This.showTitle,
                    title: "<spring:message code='unit.title'/>",
                    width: "100%",
                    autoFetchData: false,
                    editorType: "SelectItem",
                    valueField: "id",
                    displayField: "nameEN",
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
                        {name: "id", title: '<spring:message code="global.code"/>'},
                        {name: "nameFA", title: '<spring:message code="global.title-fa"/>'},
                        {name: "nameEN", title: '<spring:message code="global.title-en"/>'},
                        {name: "categoryValue", title: "categoryValue"},
                    ],
                    pickListCriteria: {
                        _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                            {fieldName: "categoryValue", operator: "equals", value: This.typeUnitCategory}]
                    },
                }]
        });
        this.addMember(form);
    },
    getValue: function () {
        return form.getValues();
    }
});





