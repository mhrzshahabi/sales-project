isc.defineClass("IncotermRules", isc.VStack).addProperties({
    autoDraw: false,
    layoutMargin: 2,
    membersMargin: 2,
    border: "1px solid blue",
    dataSource: [],
    valueField: "",
    displayField: "",
    aspectDataSource: [],
    aspectValueField: "",
    aspectDisplayField: "",
    findForm: new nicico.FindFormUtil(),
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.dataSource.forEach((rules, index, rulesList) => {

            let aspectLayout = isc.VLayout.create({
                width: "50%",
                height: "30",
                membersMargin: 2,
            });
            This.aspectDataSource.forEach((aspect, index2, aspects) => {
                aspectLayout.addMember(
                    isc.Label.create({
                        padding: 0,
                        width: "50%",
                        height: "8",
                        autoFit: false,
                        autoDraw: false,
                        align: "center",
                        item: aspect,
                        rowNum: index2,
                        value: aspect[This.aspectValueField],
                        contents: "<b>" + aspect[This.aspectDisplayField] + "</b>"
                    })
                );
                if (index2 < aspects.length - 1)
                    aspectLayout.members[index2].contents += "<br>";
            });
            This.addMember(
                isc.HLayout.create({
                    width: "100%",
                    height: "30",
                    members: [
                        isc.Label.create({
                            padding: 0,
                            width: "50%",
                            height: "100%",
                            autoFit: false,
                            autoDraw: false,
                            align: "center",
                            item: rules,
                            rowNum: index,
                            value: eval("rules." + This.valueField),
                            contents: "<u>" + eval("rules." + This.displayField) + "</u>",
                            click: function () {

                                let incotermForms = this.item.incotermForms;
                                This.findForm.showFindFormByData(
                                    null, "500", "400", "<spring:message code='incoterm.window.incoterm-forms.show'/>",
                                    incotermForms, null,
                                    BaseFormItems.concat([{
                                        name: "incotermForm.code",
                                        title: "<spring:message code='global.code'/>"
                                    }, {
                                        name: "incotermForm.title",
                                        title: "<spring:message code='global.title'/>",
                                    }, {
                                        name: "order",
                                        title: "<spring:message code='global.order'/>",
                                    }]), 0);
                            }
                        }),
                        aspectLayout
                    ]
                })
            );
        });
    },
    getRules: function (rulesIndex) {
        return this.getRulesComponent(rulesIndex).item;
    },
    getAspects: function (rulesIndex) {
        return this.getAspectComponents(rulesIndex).map(q => q.item);
    },
    getAspect: function (rulesIndex, aspectIndex) {
        return this.getAspectComponent(rulesIndex, aspectIndex).item;
    },
    getRulesValues: function () {
        return this.getRulesComponents().map(q => q.value);
    },
    getRulesValue: function (rulesIndex) {
        return this.getRulesComponent(rulesIndex).value;
    },
    getAllAspectValues: function () {
        return this.getAllAspectComponents().map(q => q.value);
    },
    getAspectValues: function (rulesIndex) {
        return this.getAspectComponents(rulesIndex).map(q => q.value);
    },
    getAspectValue: function (rulesIndex, aspectIndex) {
        return this.getAspectComponent(rulesIndex, aspectIndex).value;
    },
    getComponents: function () {
        return this.members;
    },
    getComponent: function (rulesIndex) {
        return this.members.get(rulesIndex);
    },
    getRulesComponents: function () {
        return this.members.map(q => q.members.get(0));
    },
    getRulesComponent: function (rulesIndex) {
        return this.members.get(rulesIndex).members.get(0);
    },
    getAllAspectComponents: function () {

        let result = [];
        this.members.forEach(q => result.addAll(q.members.get(1).members));

        return result;
    },
    getAspectComponents: function (rulesIndex) {
        return this.members.get(rulesIndex).members.get(1).members;
    },
    getAspectComponent: function (rulesIndex, aspectIndex) {
        return this.members.get(rulesIndex).members.get(1).members.get(aspectIndex);
    }
});
