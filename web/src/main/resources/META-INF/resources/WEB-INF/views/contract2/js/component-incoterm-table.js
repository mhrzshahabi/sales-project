isc.defineClass("IncotermTable", isc.VLayout).addProperties({
    height: "800",
    width: "100%",
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    title: "",
    httpMethod: "PUT",
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
            alignLayout: "center",
            padding: 10,
            layoutMargin: 5,
            membersMargin: 10,
            members: [
                isc.IButtonSave.create({

                    top: 260,
                    title: "<spring:message code='global.form.save'/>",
                    icon: "pieces/16/save.png",
                    click: function () {

                        if (!This.incotermRuleTableComponent.validate()) {

                            isc.say('<spring:message code="incoterm.exception.required-info"/>');
                            return;
                        }

                        let data = This.incotermRuleTableComponent.getAllDetailValues();
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            data: JSON.stringify(data),
                            httpMethod: This.httpMethod,
                            actionURL: "${contextPath}" + "/api/incoterm-detail/",
                            callback: function (response) {
                                if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                    let window = This.getParentElements().last();
                                    window.close();
                                    window.destroy();
                                } else
                                    isc.RPCManager.handleError(response);
                            }
                        }));                    }
                }),
                isc.IButtonCancel.create({

                    width: 100,
                    orientation: "vertical",
                    icon: "pieces/16/icon_delete.png",
                    title: "<spring:message code='global.close'/>",
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
