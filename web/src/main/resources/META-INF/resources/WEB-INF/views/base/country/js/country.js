var countryTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
countryTab.dynamicForm.fields = [

    {
        name: "id",
        hidden: true,
        width: "10%",
    },
    {
        name: "code",
        title: "<spring:message code='country.code'/>",
        width: "100%",
        colSpan: 1,
        required: true,
        keyPressFilter: "[0-9]",
        length: "15",
        titleColSpan: 1,
        hint: "<spring:message code='Material.digit'/>",
        showHintInField: true, showIf: "false",
        validators: [
            {
                type:"required",
                validateOnChange: true
            }]
    },
    {
        name: "nameFa",
        title: "<spring:message code='country.nameFa'/>",
        width: "100%",
        colSpan: 1,
        required: true,
        titleColSpan: 1,
        keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F]*$",
        validators: [
            {
                type:"required",
                validateOnChange: true
            }]
    },
    {
        name: "nameEn",
        title: "<spring:message code='country.nameEn'/>",
        width: "100%",
        colSpan: 1,
        required: true,
        titleColSpan: 1,
        keyPressFilter: "^[a-z|A-Z]*$",
        validators: [
            {
                type:"required",
                validateOnChange: true
            }]
    },
];
Object.assign(countryTab.listGrid.fields, countryTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(countryTab, "/api/country/");
countryTab.dynamicForm.main.windowWidth = 500;
