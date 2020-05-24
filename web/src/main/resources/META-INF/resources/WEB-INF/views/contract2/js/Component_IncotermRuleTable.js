isc.defineClass("IncotermRuleTable", isc.VStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    stepsDataSource: [],
    rulesDataSource: [],
    aspectDataSource: [],
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.rulesDataSource.forEach((rules, index, rulesList) => {

            let details = This.dataSource.filter(q => q.incotermRulesId === rules.id);
            This.addMember(isc.IncotermRuleRecord.create({
                dataSource: details,
                incotermRules: rules,
                stepsDataSource: This.stepsDataSource,
                aspectDataSource: This.aspectDataSource,
            }));
        });
    },
    getAllDetailValues: function () {
        return this.getAllDetailComponents().map(q => q.dataSource);
    },
    getDetailValues: function (ruleTableIndex) {
        return this.getDetailComponents(ruleTableIndex).map(q => q.dataSource);
    },
    getDetailValuesAtSteps: function (ruleTableIndex, stepsIndex) {
        return this.getDetailComponentsAtSteps(ruleTableIndex, stepsIndex).map(q => q.dataSource);
    },
    getDetailValue: function (ruleTableIndex, stepsIndex, aspectIndex) {
        return this.getDetailComponent(ruleTableIndex, stepsIndex, aspectIndex).dataSource;
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
    }
});
