isc.defineClass("IncotermTable", isc.VLayout).addProperties({
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    title: null,
    dataSource: [],
    rulesDataSource: [],
    stepsDataSource: [],
    aspectDataSource: [],
    partyDataSource: [],
    incotermStepsComponent: null,
    incotermRulesComponent: null,
    incotermPartyComponent: null,
    incotermRuleTableComponent: null,
    initWidget: function () {

        this.width = this.stepsDataSource.length * 103 + 200;

        let This = this;
        this.Super("initWidget", arguments);

        this.incotermStepsComponent = isc.IncotermSteps.create({
            height: "70",
            width: "100%",
            startSpacerWidth: "200",
            startSpacerContents: This.title,
            valueField: "id",
            displayField: "incotermStep.titleEn",
            dataSource: This.stepsDataSource
        });
        this.addMember(this.incotermStepsComponent);
        this.incotermPartyComponent = isc.IncotermParty.create({
            height: "30",
            width: "100%",
            valueField: "id",
            colorField: "bgColor",
            displayField: "titleEn",
            memberSpacerWidth: "20",
            dataSource: This.partyDataSource
        });
        this.incotermRulesComponent = isc.IncotermRules.create({
            width: "200",
            height: This.height - 112,
            valueField: "id",
            aspectValueField: "id",
            aspectDisplayField: "titleEn",
            displayField: "incotermRule.titleEn",
            dataSource: This.rulesDataSource,
            aspectDataSource: This.aspectDataSource
        });
        this.incotermRuleTableComponent = isc.IncotermRuleTable.create({
            width: "100%",
            height: This.height - 112,
            dataSource: This.dataSource,
            stepsDataSource: This.stepsDataSource,
            rulesDataSource: This.rulesDataSource,
            aspectDataSource: This.aspectDataSource,
            incotermPartyComponent: This.incotermPartyComponent
        });
        this.addMember(isc.HLayout.create({
            width: "100%",
            height: This.height - 112,
            members: [
                This.incotermRulesComponent,
                This.incotermRuleTableComponent
            ]
        }));
        this.addMember(this.incotermPartyComponent);
        this.addMember(isc.HLayout.create({

            height: "5%",
            width: "100%",
            showEdges: false,
            layoutAlign: "center",
            padding: 10,
            layoutMargin: 5,
            membersMargin: 10,
            members: [
                isc.IButtonSave.create({
                    click: function () {

                        if (!This.incotermRuleTableComponent.validate()) {

                            isc.say('<spring:message code="incoterm.exception.required-info"/>');
                            return;
                        }

                        let data = This.incotermRuleTableComponent.getAllDetailValues();
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            data: JSON.stringify(data),
                            httpMethod: This.dataSource == null || This.dataSource.length === 0 ? "POST" : "PUT",
                            actionURL: "${contextPath}" + "/api/incoterm-detail/list",
                            callback: function (response) {
                                if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                    let window = This.getParentElements().last();
                                    window.close();
                                    window.destroy();
                                } else
                                    isc.RPCManager.handleError(response);
                            }
                        }));
                    }
                }),
                isc.IButtonCancel.create({
                    width: 100,
                    click: function () {

                        let window = This.getParentElements().last();
                        window.close();
                        window.destroy();
                    }
                })
            ]
        }));
    }
});
