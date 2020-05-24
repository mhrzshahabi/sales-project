isc.defineClass("IncotermDetail", isc.DynamicForm).addProperties({
    margin: 10,
    align: "center",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    aspect: null,
    dataSource: null,
    fields: BaseFormItems.concat([
        {
            hidden: true,
            required: true,
            name: "incotermStepsId",
        },
        {
            hidden: true,
            required: true,
            name: "incotermRulesId",
        },
        {
            hidden: true,
            required: true,
            name: "incotermAspectId",
        },
        {
            hidden: true,
            name: "termId",
        },
        {
            name: "incotermParties",
            editorType: "IncotermParties",
            required: this.aspect.requiredParty
        }
    ], true)/*,
    initWidget: function () {

        this.Super("initWidget", arguments);
        this.editRecord(this.dataSource);
    }*/
});
