isc.defineClass("IncotermDetail", isc.DynamicForm).addProperties({
    margin: 10,
    align: "center",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    aspect: null,
    detailRecord: null,
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
        }
    ], true),
    initWidget: function () {

        this.fields.filter(q => q.name === "incotermParties").first().required = this.aspect.requiredParty;
        this.Super("initWidget", arguments);
        this.editRecord(this.detailRecord);
    }
});
