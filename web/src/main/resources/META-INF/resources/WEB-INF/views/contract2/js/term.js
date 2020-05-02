var termTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
termTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "code",
    title: "<spring:message code='global.code'/>"
}, {
    width: "100%",
    required: true,
    name: "titleFa",
    title: "<spring:message code='global.title-fa'/>"
}, {
    width: "100%",
    required: true,
    name: "titleEn",
    title: "<spring:message code='global.title-en'/>"
}, {
    width: "100%",
    type: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>",
}]);
termTab.listGrid.fields = termTab.dynamicForm.fields.map(q => {
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
nicico.BasicFormUtil.getDefaultBasicForm(termTab, "api/term/");
termTab.dynamicForm.main.windowWidth = 500;
termTab.listGrid.main.sort
