isc.defineClass("IncotermSteps", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    valueField: "",
    displayField: "",
    startSpacerWidth: 0,
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.addMember(isc.LayoutSpacer.create({
            width: This.startSpacerWidth
        }));
        this.dataSource.forEach((steps, index, stepsList) => {
            This.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100%",
                    autoFit: false,
                    autoDraw: false,
                    item: steps,
                    colNum: index,
                    value: steps[This.valueField],
                    contents: steps[This.displayField]
                })
            );
        });
    },
    getSteps: function (stepsIndex) {
        return this.getComponent(stepsIndex).item;
    },
    getStepsValues: function () {
        return this.getStepsComponents().map(q => q.value);
    },
    getStepsValue: function (stepsIndex) {
        return this.getStepsComponent(stepsIndex).value;
    },
    getStepsComponents: function () {
        return this.members.slice(1);
    },
    getStepsComponent: function (stepsIndex) {
        return this.members.get(stepsIndex + 1);
    }
});
