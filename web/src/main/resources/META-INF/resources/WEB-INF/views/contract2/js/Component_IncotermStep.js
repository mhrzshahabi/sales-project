isc.defineClass("IncotermStep", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    valueField: "",
    displayField: "",
    startSpacerWidth: 0,
    initWidget: function () {
        this.Super("initWidget", arguments);

        this.addMember(isc.LayoutSpacer.create({
            width: this.startSpacerWidth
        }));
        this.dataSource.forEach((step, index, steps) => {
            this.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100%",
                    autoFit: true,
                    autoDraw: false,
                    item: step,
                    colNum: index,
                    value: step[this.valueField],
                    contents: step[this.displayField]
                })
            );
        });
    },
    getStep: function (columnIndex) {
        this.getComponent(columnIndex).map(q => q.item);
    },
    getStepValues: function () {
        this.getStepComponents().map(q => q.value);
    },
    getStepValue: function (columnIndex) {
        this.getStepComponent(columnIndex).value;
    },
    getStepComponents: function () {
        this.members.slice(1);
    },
    getStepComponent: function (columnIndex) {
        this.members.get(columnIndex + 1);
    }
});
