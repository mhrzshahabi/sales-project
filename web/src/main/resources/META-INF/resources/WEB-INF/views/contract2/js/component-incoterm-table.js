isc.defineClass("IncotermTable", isc.VLayout).addProperties({
    height: "800",
    width: "100%",
    autoDraw: false,
    layoutMargin: 0,
    membersMargin: 2,
    dataSource: [],
    rulesDataSource: [],
    stepsDataSource: [],
    aspectDataSource: [],
    partyDataSource: [],
    title: "",
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);

        this.addMember(isc.IncotermSteps.create({
            height: "70",
            width: "100%",
            startSpacerWidth: "200",
            startSpacerContents: This.title,
            valueField: "id",
            displayField: "incotermStep.titleEn",
            dataSource: This.stepsDataSource
        }));
        let incotermPartyComponent = isc.IncotermParty.create({
            height: "30",
            width: "100%",
            valueField: "id",
            colorField: "bgColor",
            displayField: "titleEn",
            memberSpacerWidth: "20",
            dataSource: This.partyDataSource
        });
        this.addMember(isc.HLayout.create({
            width: "100%",
            height: This.height - 112,
            members: [
                isc.IncotermRules.create({
                    width: "200",
                    height: This.height - 112,
                    valueField: "id",
                    aspectValueField: "id",
                    aspectDisplayField: "titleEn",
                    displayField: "incotermRule.titleEn",
                    dataSource: This.rulesDataSource,
                    aspectDataSource: This.aspectDataSource
                }),
                isc.IncotermRuleTable.create({
                    width: "100%",
                    height: This.height - 112,
                    dataSource: This.dataSource,
                    stepsDataSource: This.stepsDataSource,
                    rulesDataSource: This.rulesDataSource,
                    aspectDataSource: This.aspectDataSource,
                    incotermPartyComponent: incotermPartyComponent
                })
            ]
        }));
        this.addMember(incotermPartyComponent);
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

                        // TODO
                    }
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
