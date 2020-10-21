var incotermFormTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermFormTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "code",
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.code'/>"
}, {
    width: "100%",
    required: true,
    name: "title",
    title: "<spring:message code='global.title'/>",
    keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9 ]"
}]);
incotermFormTab.listGrid.fields = incotermFormTab.dynamicForm.fields.map(q => {
    const item = {...q};
    if (item.isBaseItem) {
        item.hidden = false;
        return item;
    } else if (item.name === 'code' || item.name === 'title') {
        item.width = '20%';
        item.showHover = true;
        return item;
    }

    return item;
});
nicico.BasicFormUtil.getDefaultBasicForm(incotermFormTab, "api/incoterm-form/");
incotermFormTab.dynamicForm.main.windowWidth = 500;
nicico.BasicFormUtil.removeExtraGridMenuActions(incotermFormTab);
