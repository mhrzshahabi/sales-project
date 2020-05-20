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
        this.dataSource.forEach((item, index, arr) => {
            this.addMember(
                isc.HLayout.create({
                    width: "100%",
                    members: [
                        isc.Label.create({
                            padding: 6,
                            width: "50%",
                            autoFit: true,
                            autoDraw: false,
                            item: item,
                            colNum: index,
                            value: item[this.valueField],
                            contents: item[this.displayField]
                        })
                    ]
                })
            );
        });
    },
    // getRule: function (columnIndex) {
    //     this.getComponent(columnIndex).map(q => q.item);
    // },
    // getValues: function () {
    //     this.getComponents.map(q => q.value);
    // },
    // getValue: function (columnIndex) {
    //     this.getComponent(columnIndex).value;
    // },
    // getComponents: function () {
    //     this.members.slice(1);
    // },
    // getComponent: function (columnIndex) {
    //     this.members.get(columnIndex + 1);
    // }
});
