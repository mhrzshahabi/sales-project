var incotermPartyTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermPartyTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "code",
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.code'/>"
}, {
    width: "100%",
    required: true,
    name: "titleFa",
    title: "<spring:message code='global.title-fa'/>",
    keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9]"
}, {
    width: "100%",
    required: true,
    name: "titleEn",
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.title-en'/>"
}, {
    width: "100%",
    editorType: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>",
}]);
incotermPartyTab.listGrid.fields = incotermPartyTab.dynamicForm.fields.map(q => {
    const item = {...q};
    if (item.isBaseItem) {
        item.hidden = false;
        return item;
    } else if (item.name === 'code' || item.name === 'titleFa' || item.name === 'titleEn') {
        item.width = '20%';
        item.showHover = true;
        return item;
    } else if (item.name === 'description') {
        item.width = '40%';
        item.showHover = true;
        item.hoverWidth = '30%';
        return item;
    }
    return item;
});
nicico.BasicFormUtil.getDefaultBasicForm(incotermPartyTab, "api/incoterm-party/");
incotermPartyTab.dynamicForm.main.windowWidth = 500;
