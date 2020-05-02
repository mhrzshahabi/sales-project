var termTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
termTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    name: "title",
    required: true,
    title: "<spring:message code='global.title'/>"
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
    } else if (item.name === 'title') {
        item.width = '30%';
        return item;
    } else if (item.name === 'description') {
        item.width = '70%';
        item.showHover = true;
        item.hoverWidth = '50%';
        return item;
    }
    return item;
});
nicico.BasicFormUtil.getDefaultBasicForm(termTab, "api/term/");
termTab.dynamicForm.main.windowWidth = 500;
