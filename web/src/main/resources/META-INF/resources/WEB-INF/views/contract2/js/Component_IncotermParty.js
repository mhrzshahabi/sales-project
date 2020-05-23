isc.defineClass("IncotermParty", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    colorField: "",
    valueField: "",
    displayField: "",
    memberSpacerWidth: 0,
    partyForm: new nicico.FormUtil(),
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.dataSource.forEach((party, index, parties) => {
            This.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100%",
                    autoFit: false,
                    autoDraw: false,
                    item: party,
                    colNum: index,
                    value: party[This.valueField],
                    contents: party[This.displayField],
                    backgroundColor: party[This.colorField]
                })
            );
            This.addMember(isc.LayoutSpacer.create({
                width: This.memberSpacerWidth
            }));
        });

        this.partyForm.populateData = function (body) {
            return {
                termId: body.getMembers()[0].getValue("termId"),
                incotermParties: body.getMembers()[1].data.localData.filter(q => q.portion).map(q => {
                    return {incotermPartyId: q.id, portion: q.portion}
                })
            };
        };
        this.partyForm.validate = function (data) {
            let sum = data.incotermParties.map(q => q.portion).sum();
            return sum === 0 || sum === 100;
        };
        let dynamicForm = isc.DynamicForm.create({
            margin: 10,
            width: "100%",
            canSubmit: true,
            align: "center",
            titleAlign: "right",
            fields: [{
                type: 'long',
                name: "termId",
                editorType: "SelectItem",
                valueField: "id",
                displayField: "titleEn",
                pickListWidth: "400",
                pickListHeight: "300",
                pickListFields: [
                    {name: "code", title: '<spring:message code="global.code"/>'},
                    {name: "titleFa", title: '<spring:message code="global.title-fa"/>'},
                    {name: "titleEn", title: '<spring:message code="global.title-en"/>'},
                ],
                title: "<spring:message code='entity.term'/>",
                optionDataSource: isc.MyRestDataSource.create({
                    fields: BaseFormItems.concat([
                        {name: "code"},
                        {name: "titleFa"},
                        {name: "titleEn"},
                    ]),
                    fetchDataURL: '<spring:url value="/term/spec-list">'
                })
            }]
        });
        let grid = isc.ListGrid.nicico.getDefault([
            {name: "id", title: '<spring:message code="global.id"/>', hidden: true},
            {name: "titleFa", title: '<spring:message code="global.title-fa"/>'},
            {name: "titleEn", title: '<spring:message code="global.title-en"/>'},
            {
                canEdit: true,
                name: "portion",
                defaultValue: 0,
                title: '<spring:message code="incoterm.form.party.portion"/>',
                validators: [
                    {type: "integerRange", min: 0, max: 100}
                ]
            }
        ], null, null, {showFilterEditor: false});
        this.partyForm.init(
            null, null,
            isc.VLayout.create({
                width: "100%",
                height: "400",
                members: [
                    dynamicForm,
                    grid
                ]
            }), '400');
    },
    showPartyForm: function (currentData, okCallback) {

        this.partyForm.okCallBack = function (data) {
            okCallback(data);
        };
        let grid = this.partyForm.bodyWidget.getObject().getMembers()[1];
        let dynamicForm = this.partyForm.bodyWidget.getObject().getMembers()[0];
        dynamicForm.setValue("termId", currentData.termId);
        grid.setData([...this.dataSource]);
        for (let i = 0; i < currentData.incotermParties.length; i++) {

            let incotermParty = grid.data.localData.filter(q => q.id === currentData.incotermParties[i].incotermPartyId).first();
            if (incotermParty != null) {

                incotermParty.portion = currentData.incotermParties[i].portion;
                grid.refreshRow(grid.getRowNum(incotermParty));
            }
        }

        this.partyForm.justShowForm();
    },
    getParty: function (index) {
        this.getComponent(index).item;
    },
    getPartyValues: function () {
        this.getPartyComponents().map(q => q.value);
    },
    getPartyValue: function (index) {
        this.getPartyComponent(index).value;
    },
    getPartyBgColors: function () {
        this.getPartyComponents().map(q => q.backgroundColor);
    },
    getPartyBgColor: function (index) {
        this.getPartyComponent(index).backgroundColor;
    },
    getPartyComponents: function () {
        this.members.filter(q => q.colNum);
    },
    getPartyComponent: function (index) {
        this.members.get(index * 2);
    }
});
