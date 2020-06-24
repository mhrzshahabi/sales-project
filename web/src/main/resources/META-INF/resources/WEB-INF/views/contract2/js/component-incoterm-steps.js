isc.defineClass("IncotermSteps", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    border: "1px solid blue",
    backgroundColor: "lightgray",
    dataSource: [],
    valueField: "",
    displayField: "",
    startSpacerWidth: 0,
    startSpacerContents: null,
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.addMember(isc.Label.create({
            width: This.startSpacerWidth,
            contents: "<b><i>" + This.startSpacerContents + "</i></b>",
            align: "center",
            backgroundColor: "gray"
        }));
        this.dataSource.forEach((steps, index, stepsList) => {
            This.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100",
                    height: "70",
                    autoFit: false,
                    autoDraw: false,
                    align: "center",
                    item: steps,
                    colNum: index,
                    value: eval("steps." + This.valueField),
                    contents: "<b>" + eval("steps." + This.displayField) + "</b>"
                })
            );
        });
    },
    draw: function () {

        this.Super("draw", arguments);
        this.members[0].setHeight(this.getVisibleHeight());
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
