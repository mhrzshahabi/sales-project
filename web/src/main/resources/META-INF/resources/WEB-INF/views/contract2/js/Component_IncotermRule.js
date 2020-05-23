isc.defineClass("IncotermRules", isc.VStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    valueField: "",
    displayField: "",
    aspectDataSource: [],
    aspectValueField: "",
    aspectDisplayField: "",
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.dataSource.forEach((rules, index, rulesList) => {

            let aspectLayout = isc.VLayout.create({
                width: "50%",
                height: "100%"
            });
            This.aspectDataSource.forEach((aspect, index2, aspects) => {
                aspectLayout.addMember(
                    isc.Label.create({
                        padding: 6,
                        width: "50%",
                        autoFit: false,
                        autoDraw: false,
                        item: aspect,
                        rowNum: index2,
                        value: aspect[This.aspectValueField],
                        contents: aspect[This.aspectDisplayField]
                    })
                );
                if (index2 < aspects.length - 1)
                    aspectLayout.members[index2].contents += "<br>";
            });
            This.addMember(
                isc.HLayout.create({
                    width: "100%",
                    members: [
                        isc.Label.create({
                            padding: 6,
                            width: "50%",
                            autoFit: false,
                            autoDraw: false,
                            item: rules,
                            rowNum: index,
                            value: rules[This.valueField],
                            contents: rules[This.displayField]
                        }),
                        aspectLayout
                    ]
                })
            );
        });
    },
    getRules: function (rowIndex) {
        this.getRulesComponent(rowIndex).item;
    },
    getAspects: function (rowIndex) {
        this.getAspectComponents(rowIndex).map(q => q.item);
    },
    getAspect: function (rowIndex, aspectRowIndex) {
        this.getAspectComponent(rowIndex, aspectRowIndex).item;
    },
    getRulesValues: function () {
        this.getRulesComponents().map(q => q.value);
    },
    getRulesValue: function (rowIndex) {
        this.getRulesComponent(rowIndex).value;
    },
    getAllAspectValues: function () {
        this.getAllAspectComponents().map(q => q.value);
    },
    getAspectValues: function (rowIndex) {
        this.getAspectComponents(rowIndex).map(q => q.value);
    },
    getAspectValue: function (rowIndex, aspectRowIndex) {
        this.getAspectComponent(rowIndex, aspectRowIndex).value;
    },
    getComponents: function () {
        this.members;
    },
    getComponent: function (rowIndex) {
        this.members.get(rowIndex);
    },
    getRulesComponents: function () {
        this.members.map(q => q.members.get(0));
    },
    getRulesComponent: function (rowIndex) {
        this.members.get(rowIndex).members.get(0);
    },
    getAllAspectComponents: function () {
        this.members.map(q => q.members.get(1).members);
    },
    getAspectComponents: function (rowIndex) {
        this.members.get(rowIndex).members.get(1).members;
    },
    getAspectComponent: function (rowIndex, aspectRowIndex) {
        this.members.get(rowIndex).members.get(1).members.get(aspectRowIndex);
    }
});
