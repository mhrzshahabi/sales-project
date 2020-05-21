
for (let i = 0; i < This.aspects.length; i++) {

    dynamicForms.add(isc.DynamicForm.create({
        width: "100%",
        align: "center",
        titleAlign: "right",
        margin: 10,
        canSubmit: true,
        showErrorText: true,
        showErrorStyle: true,
        showInlineErrors: true,
        // dataSource: incotermDetails.filter(q => q.incotermAspectId === This.aspects[i].id).first(),
        fields: BaseFormItems.concat([
            {
                hidden: true,
                name: "termId",
            },
            {
                index: -1,
                type: "ButtonItem",
                name: "incotermParties",
                required: This.aspects[i].requiredParty,
                click: function () {

                    this.index = (this.index + 1) % This.parties.length;
                    let party = This.parties[this.index];

                    this.backgroundColor = party.bgColor;
                    this.value = [{portion: 100, incotermPartyId: party.id}];
                }
            },
            {
                hidden: true,
                required: true,
                name: "incotermStepId",
                defaultValue: field.ref
            },
            {
                hidden: true,
                required: true,
                name: "incotermRuleId",
                defaultValue: incotermRuleId
            },
            {
                hidden: true,
                required: true,
                name: "incotermAspectId",
                defaultValue: This.aspects[i].id
            },
        ], true)
    }));
    let incotermParties = dynamicForms[i].getItem("incotermParties");
    let incotermPartiesValues = incotermParties.getValue();
    if (incotermPartiesValues != null && incotermPartiesValues.length === 1) {

        let party = This.parties.filter(q => q.id === incotermPartiesValues[0].incotermPartyId).first();
        incotermParties.index = This.parties.indexOf(party);
        incotermParties.backgroundColor = party.bgColor;
    }
}


isc.defineClass("IncotermDetail", isc.DynamicForm).addProperties({
    margin: 10,
    align: "center",
    titleAlign: "right",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    dataSource: [],
    fields: BaseFormItems.concat([
        {
            hidden: true,
            name: "termId",
        },
        {
            index: -1,
            type: "ButtonItem",
            name: "incotermParties",
            required: This.aspects[i].requiredParty,
            click: function () {

                this.index = (this.index + 1) % This.parties.length;
                let party = This.parties[this.index];

                this.backgroundColor = party.bgColor;
                this.value = [{portion: 100, incotermPartyId: party.id}];
            }
        },
        {
            hidden: true,
            required: true,
            name: "incotermStepId",
            defaultValue: field.ref
        },
        {
            hidden: true,
            required: true,
            name: "incotermRuleId",
            defaultValue: incotermRuleId
        },
        {
            hidden: true,
            required: true,
            name: "incotermAspectId",
            defaultValue: This.aspects[i].id
        },
    ], true),
    initWidget: function () {
        this.Super("initWidget", arguments);
        this.dataSource.forEach((party, index, parties) => {
            this.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100%",
                    autoFit: true,
                    autoDraw: false,
                    item: party,
                    colNum: index,
                    value: party[this.valueField],
                    contents: party[this.displayField],
                    backgroundColor: party[this.colorField]
                })
            );
            this.addMember(isc.LayoutSpacer.create({
                width: this.startSpacerWidth
            }));
        });
    },
    getParty: function (columnIndex) {
        this.getComponent(columnIndex).item;
    },
    getPartyValues: function () {
        this.getPartyComponents().map(q => q.value);
    },
    getPartyValue: function (columnIndex) {
        this.getPartyComponent(columnIndex).value;
    },
    getPartyBgColors: function () {
        this.getPartyComponents().map(q => q.backgroundColor);
    },
    getPartyBgColor: function (columnIndex) {
        this.getPartyComponent(columnIndex).backgroundColor;
    },
    getPartyComponents: function () {
        this.members.filter(q => q.colNum);
    },
    getPartyComponent: function (columnIndex) {
        this.members.get(columnIndex * 2);
    }
});
