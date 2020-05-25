isc.defineClass("IncotermRuleTable", isc.VStack).addProperties({
    autoDraw: false,
    layoutMargin: 2,
    membersMargin: 2,
    border: "1px solid blue",
    isValid: null,
    dataSource: [],
    stepsDataSource: [],
    rulesDataSource: [],
    aspectDataSource: [],
    incotermPartyComponent: null,
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.rulesDataSource.forEach((rules, index, rulesList) => {

            let details = This.dataSource.filter(q => q.incotermRulesId === rules.id);
            This.addMember(isc.IncotermRuleRecord.create({
                width: "100%",
                height: "30",
                dataSource: details,
                incotermRules: rules,
                stepsDataSource: This.stepsDataSource,
                aspectDataSource: This.aspectDataSource,
                incotermPartyComponent: This.incotermPartyComponent
            }));
        });
    },
    getAllDetailValues: function () {
        return this.getAllDetailComponents().map(q => q.detailRecord);
    },
    getDetailValues: function (ruleTableIndex) {
        return this.getDetailComponents(ruleTableIndex).map(q => q.detailRecord);
    },
    getDetailValuesAtSteps: function (ruleTableIndex, stepsIndex) {
        return this.getDetailComponentsAtSteps(ruleTableIndex, stepsIndex).map(q => q.detailRecord);
    },
    getDetailValue: function (ruleTableIndex, stepsIndex, aspectIndex) {
        return this.getDetailComponent(ruleTableIndex, stepsIndex, aspectIndex).detailRecord;
    },
    getComponents: function () {
        return this.members;
    },
    getComponent: function (ruleTableIndex) {
        return this.members.get(ruleTableIndex);
    },
    getAllDetailComponents: function () {

        let result = [];
        this.members.forEach(q => result.addAll(q.getAllDetailComponents()));

        return result;
    },
    getDetailComponents: function (ruleTableIndex) {
        return this.members.get(ruleTableIndex).getAllDetailComponents();
    },
    getDetailComponentsAtSteps: function (ruleTableIndex, stepsIndex) {
        return this.members.get(ruleTableIndex).getDetailComponents(stepsIndex);
    },
    getDetailComponent: function (ruleTableIndex, stepsIndex, aspectIndex) {
        return this.members.get(ruleTableIndex).getDetailComponent(stepsIndex, aspectIndex);
    },
    validate: function () {

        this.isValid = true;
        let allDetailComponents = this.getAllDetailComponents();
        for (let i = 0; i < allDetailComponents.length; i++)
            if (!allDetailComponents[i].validate()) {

                this.isValid = false;
                break;
            }

        return this.isValid;
    }
});
