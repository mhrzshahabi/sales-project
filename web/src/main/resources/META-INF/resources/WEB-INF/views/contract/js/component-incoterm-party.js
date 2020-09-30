isc.defineClass("IncotermParty", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    border: "1px solid blue",
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
                    padding: 3,
                    width: "100",
                    height: "20",
                    autoFit: false,
                    autoDraw: false,
                    align: "center",
                    item: party,
                    colNum: index,
                    value: eval("party." + This.valueField),
                    contents: "<b>" + eval("party." + This.displayField) + "</b>",
                    backgroundColor: party[This.colorField]
                })
            );
            This.addMember(isc.LayoutSpacer.create({
                width: This.memberSpacerWidth
            }));
        });

        this.partyForm.populateData = function (body) {
            return {
                termId: body[0].getValue("termId"),
                incotermParties: body[1].data.filter(q => Number(q.portion) > 0).map(q => {
                    return {incotermPartyId: q.id, portion: Number(q.portion)}
                })
            };
        };
        this.partyForm.validate = function (data) {
            let sum = data.incotermParties.map(q => Number(q.portion)).sum();
            return sum === 0 || sum === 100;
        };
        let dynamicForm = isc.DynamicForm.create({
            margin: 10,
            width: "100%",
            canSubmit: true,
            align: "center",
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
                    fetchDataURL: "${contextPath}" + "/api/term/spec-list"
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
            [
                dynamicForm,
                grid
            ], '400', "300");
    },
    showPartyForm: function (currentData, okCallback, cancelCallback) {

        this.partyForm.cancelCallBack = function () {
            if (cancelCallback != null)
                cancelCallback();
        };
        this.partyForm.okCallBack = function (data) {
            if (okCallback != null)
                okCallback(data);
        };
        let grid = this.partyForm.bodyWidget.getObject()[1];
        let dynamicForm = this.partyForm.bodyWidget.getObject()[0];
        dynamicForm.setValue("termId", currentData.termId);
        let gridDataSource = [];
        this.dataSource.forEach(q => gridDataSource.push({...q}));
        grid.setData([]);
        grid.setData(gridDataSource);
        for (let i = 0; i < currentData.incotermParties.length; i++) {

            let incotermParty = grid.data.filter(q => q.id === currentData.incotermParties[i].incotermPartyId).first();
            if (incotermParty != null) {

                incotermParty.portion = currentData.incotermParties[i].portion;
                grid.refreshRow(grid.getRowNum(incotermParty));
            }
        }

        this.partyForm.justShowForm();
    },
    getParty: function (index) {
        return this.getPartyComponent(index).item;
    },
    getPartyValues: function () {
        return this.getPartyComponents().map(q => q.value);
    },
    getPartyValue: function (index) {
        return this.getPartyComponent(index).value;
    },
    getPartyBgColors: function () {
        return this.getPartyComponents().map(q => q.backgroundColor);
    },
    getPartyBgColor: function (index) {
        return this.getPartyComponent(index).backgroundColor;
    },
    getPartyComponents: function () {
        return this.members.filter(q => q.colNum);
    },
    getPartyComponent: function (index) {
        return this.members.get(index * 2);
    }
});
