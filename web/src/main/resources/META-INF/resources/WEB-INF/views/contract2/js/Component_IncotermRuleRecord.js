isc.defineClass("IncotermRuleRecord", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    incotermRules: null,
    stepsDataSource: [],
    aspectDataSource: [],
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.stepsDataSource.forEach((steps, index, stepsList) => {

            let detailLayout = isc.VLayout.create({
                width: "50%",
                height: "100%"
            });
            This.aspectDataSource.forEach((aspect, index2, aspects) => {

                let detail = This.dataSource.filter(q => q.incotermStepsId === steps.id && q.incotermAspectId === aspect.id && q.incotermRulesId === This.incotermRules.id).first();
                if (detail == null)
                    detail = {
                        termId: null,
                        incotermParties: [],
                        incotermStepsId: steps.id,
                        incotermAspectId: aspect.id,
                        incotermRulesId: This.incotermRules.id
                    };

                detailLayout.addMember(isc.IncotermDetail.create({

                    aspect: aspect,
                    detailRecord: detail
                }));
            });

            This.addMember(detailLayout);
        });
    },
    getAllDetailValues: function () {
        return this.getAllDetailComponents().map(q => q.detailRecord);
    },
    getDetailValues: function (stepsIndex) {
        return this.getDetailComponents(stepsIndex).map(q => q.detailRecord);
    },
    getDetailValue: function (stepsIndex, aspectIndex) {
        return this.getDetailComponent(stepsIndex, aspectIndex).detailRecord;
    },
    getComponents: function () {
        return this.members;
    },
    getComponent: function (stepsIndex) {
        return this.members.get(stepsIndex);
    },
    getAllDetailComponents: function () {

        let result = [];
        this.members.forEach(q => result.addAll(q.members));

        return result;

    },
    getDetailComponents: function (stepsIndex) {
        return this.members.get(stepsIndex).members;
    },
    getDetailComponent: function (stepsIndex, aspectIndex) {
        return this.members.get(stepsIndex).members.get(aspectIndex);
    }
});
