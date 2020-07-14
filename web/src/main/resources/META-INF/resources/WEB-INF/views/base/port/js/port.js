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
        validators: [
            {
                type: "required",
                validateOnChange: true,
            },
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
        width: 450,
        editorType: "SelectItem",
        colSpan: 1,
        required: true,
        errorOrientation: "bottom",
        titleColSpan: 1,
        displayField: "nameFa",
        wrapTitle: false,
        valueField: "id",
        pickListWidth: 450,
        pickListheight: 450,
        pickListProperties: { showFilterEditor: true },
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([{ name: "id" }, { name: "nameFa" }, { name: "nameEn" }]),
            fetchDataURL: "${contextPath}" + "/api/country/spec-list",
        }),
        pickListFields: [
            { name: "id", title: "<spring:message code='global.id'/>" },
            { name: "nameFa", title: "<spring:message code='currency.name.fa'/>" },
            { name: "nameEn", title: "<spring:message code='currency.name.en'/>" },
        ],
    },
]);
Object.assign(portTab.listGrid.fields, portTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(portTab, "api/port/");
portTab.dynamicForm.main.windowWidth = 700;