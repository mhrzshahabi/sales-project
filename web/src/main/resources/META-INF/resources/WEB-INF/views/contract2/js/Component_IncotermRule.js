isc.defineClass("IncotermRule", isc.VStack).addProperties({
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

        this.Super("initWidget", arguments);
        this.dataSource.forEach((rule, index, rules) => {

            let aspectLayout = isc.VLayout.create({
                width: "50%",
                height: "100%"
            });
            this.aspectDataSource.forEach((aspect, index2, aspects) => {
                aspectLayout.addMember(
                    isc.Label.create({
                        padding: 6,
                        width: "50%",
                        autoFit: false,
                        autoDraw: false,
                        item: aspect,
                        rowNum: index2,
                        value: aspect[this.aspectValueField],
                        contents: aspect[this.aspectDisplayField]
                    })
                );
                if (index2 < aspects.length - 1)
                    aspectLayout.members[index2].contents += "<br>";
            });
            this.addMember(
                isc.HLayout.create({
                    width: "100%",
                    members: [
                        isc.Label.create({
                            padding: 6,
                            width: "50%",
                            autoFit: false,
                            autoDraw: false,
                            item: rule,
                            rowNum: index,
                            value: rule[this.valueField],
                            contents: rule[this.displayField]
                        }),
                        aspectLayout
                    ]
                })
            );
        });
    },
    getRule: function (rowIndex) {
        this.getRuleComponent(rowIndex).item;
    },
    getAspects: function (rowIndex) {
        this.getAspectComponents(rowIndex).map(q => q.item);
    },
    getAspect: function (rowIndex, aspectRowIndex) {
        this.getAspectComponent(rowIndex, aspectRowIndex).item;
    },
    getRuleValues: function () {
        this.getRuleComponents().map(q => q.value);
    },
    getRuleValue: function (rowIndex) {
        this.getRuleComponent(rowIndex).value;
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
    getRuleComponents: function () {
        this.members.map(q => q.members.get(0));
    },
    getRuleComponent: function (rowIndex) {
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
