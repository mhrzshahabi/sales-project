isc.defineClass("IncotermParty", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    colorField: "",
    valueField: "",
    displayField: "",
    startSpacerWidth: 0,
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
