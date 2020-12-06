var portTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
portTab.dynamicForm.fields = BaseFormItems.concat([
    { name: "id", hidden: true, width: "10%" },
    {
        name: "port",
        title: "<spring:message code='port.port'/>",
        width: "100%",
        required: true,
        length: "4000",
        errorOrientation: "bottom",
        colSpan: 1,
        titleColSpan: 1,
        wrapTitle: false,
        keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z]*$",
        validators: [
            {
                type: "required",
                validateOnChange: true,
            },
            {
                type: "regexp",
                expression: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z|\\s]*$",
                validateOnChange: true
            }
        ],
    },
    {
        name: "loa",
        title: "<spring:message code='port.loa'/>",
        width: "100%",
        colSpan: 1,
        titleColSpan: 1,
        wrapTitle: false,
        keyPressFilter: "[0-9.]",
        length: "100",
        validators: [
            {
                type: "isFloat",
                validateOnExit: true,
                stopOnError: true,
                errorMessage: "<spring:message code='global.form.correctType'/>",
            },
        ],
    },
    {
        name: "beam",
        title: "<spring:message code='port.beam'/>",
        width: "100%",
        colSpan: 1,
        keyPressFilter: "[0-9.]",
        titleColSpan: 1,
        wrapTitle: false,
        length: "100",
    },
    {
        name: "arrival",
        title: "<spring:message code='port.arrival'/>",
        width: "100%",
        colSpan: 1,
        titleColSpan: 1,
        wrapTitle: false,
        keyPressFilter: "[0-9.]",
        length: "100",
        validators: [
            {
                type: "isFloat",
                validateOnExit: true,
                stopOnError: true,
                errorMessage: "<spring:message code='global.form.correctType'/>",
            },
        ],
    },
    {
        name: "countryId",
        title: "<spring:message code='country'/>",
        type: "long",
        width: "100%",
        editorType: "SelectItem",
        colSpan: 1,
        required: true,
        errorOrientation: "bottom",
        titleColSpan: 1,
        displayField: "name",
        wrapTitle: false,
        valueField: "id",
        pickListWidth: 500,
        pickListheight: 500,
        pickListProperties: {showFilterEditor: true},
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([{name: "id"}, {name: "nameFA"}, {name: "nameEN"}]),
            fetchDataURL: "${contextPath}" + "/api/country/spec-list",
        }),
        pickListFields: [
            {name: "nameFA", title: "<spring:message code='currency.name.fa'/>"},
            {name: "nameEN", title: "<spring:message code='currency.name.en'/>"},
        ],
    },
]);
Object.assign(portTab.listGrid.fields, portTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(portTab, "api/port/");
portTab.dynamicForm.main.windowWidth = 700;
nicico.BasicFormUtil.removeExtraGridMenuActions(portTab);

