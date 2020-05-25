isc.defineClass("IncotermRuleRecord", isc.HStack).addProperties({
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    isValid: null,
    dataSource: [],
    incotermRules: null,
    stepsDataSource: [],
    aspectDataSource: [],
    incotermPartyComponent: null,
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);
        this.stepsDataSource.forEach((steps, index, stepsList) => {

            let detailLayout = isc.VLayout.create({
                width: "100",
                height: "30",
                membersMargin: 2
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
                detail.requiredParty = aspect.requiredParty;
                detailLayout.addMember(isc.IncotermDetail.create({

                    height: "8",
                    width: "100%",
                    detailRecord: detail,
                    incotermPartyComponent: This.incotermPartyComponent,
                    backgroundColor: This.incotermPartyComponent.getPartyBgColor(0)
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
    },
    validate: function () {

        this.isValid = true;
        let allDetailComponents = this.getAllDetailComponents();
        for (let i = 0; i < allDetailComponents.length; i++)
            if (!allDetailComponents[i].validate()) {

                this.isValid = false;
                break;
            }

        this.setBorder(this.isValid ? "" : "1px solid red");
        return this.isValid;
    }
});
