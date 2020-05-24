isc.defineClass("IncotermTable", isc.VLayout).addProperties({
    height: 800,
    width: "100%",
    autoDraw: false,
    layoutMargin: 3,
    membersMargin: 2,
    dataSource: [],
    rulesDataSource: [],
    stepsDataSource: [],
    aspectDataSource: [],
    partyDataSource: [],
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);

        this.addMember(isc.IncotermSteps.create({
            startSpacerWidth: 200,
            valueField: "id",
            displayField: "incotermStep.titleEn",
            dataSource: This.stepsDataSource
        }));
        this.addMember(isc.HLayout.create({
            width: "100%",
            members: [
                isc.IncotermRules.create({
                    valueField: "id",
                    aspectValueField: "id",
                    aspectDisplayField: "titleEn",
                    displayField: "incotermRule.titleEn",
                    dataSource: This.rulesDataSource,
                    aspectDataSource: This.aspectDataSource
                }),
                isc.IncotermRuleTable.create({
                    dataSource: This.dataSource,
                    stepsDataSource: This.stepsDataSource,
                    rulesDataSource: This.rulesDataSource,
                    aspectDataSource: This.aspectDataSource
                })
            ]
        }));
        this.addMember(isc.IncotermParty.create({
            valueField: "id",
            colorField: "bgColor",
            displayField: "titleEn",
            memberSpacerWidth: 20,
            dataSource: This.partyDataSource
        }));
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
