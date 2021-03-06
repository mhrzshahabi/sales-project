isc.defineClass("InvoiceDeduction", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    rcDeductionData: null,
    contractDetailDataTC: null,
    contractDetailDataRC: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.Label.create({
            margin: 10,
            height: 5,
            align: nicico.CommonUtil.getAlignByLang(),
            contents: "<spring:message code='foreign-invoice.form.deduction.label'/>"
        }));

        this.addMember(isc.DynamicForm.create({
            width: "10%",
            fields: [{
                width: "10%",
                height: "50",
                name: "TC",
                top: 5,
                align: "left",
                type: "staticText",
                value: This.contractDetailDataTC,
                title: "<spring:message code='contract.TC'/>"
            }]
        }));

        let calculationValues = this.invoiceCalculationComponent.getValues();
        for (let index = 0; index < calculationValues.length; index++) {

            this.addMember(isc.InvoiceDeductionRow.create({
                role: "RC",
                name: calculationValues[index].name,
                isInvoiceDeductionRow: true,
                currency: This.currency,
                elementId: calculationValues[index].elementId,
                elementFinalAssay: calculationValues[index].assay,
                materialElementId: calculationValues[index].materialElementId,
                rcData: This.contractDetailDataRC.filter(q => q.materialElement.elementId === calculationValues[index].elementId).first(),
                rcDeductionRowData: This.rcDeductionData ? This.rcDeductionData.filter(q => q.materialElementId === calculationValues[index].materialElementId).first() : null,
                sumDeductionChanged: function (sumDeduction) {

                    let subtotalForm = This.getMembers().filter(q => q.name === "subTotal").first();
                    subtotalForm.data[this.ID] = sumDeduction;
                    subtotalForm.setValue(Object.values(subtotalForm.data).sum());
                }
            }));
        }

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        this.addMember(isc.Unit.create({
            data: {},
            name: "subTotal",
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            unitCategory: This.currency.categoryUnit,
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.deductions.subtotal'/>",
        }));
        this.getMembers().last().setUnitId(this.currency.id);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        this.getMembers().filter(q => q.isInvoiceDeductionRow).forEach(q => q.calculate());

        this.addMember(isc.ToolStrip.create({
            width: "100%",
            border: '0px',
            members: [
                isc.ToolStripButton.create({
                    width: "100",
                    height: "25",
                    autoFit: false,
                    title: "<spring:message code='global.form.next.step'/>",
                    click: function () {

                        if (!This.validate())
                            return;

                        This.okButtonClick();

                        let tab = This.parentElement.parentElement;
                        tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                        tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                    }
                }),
                isc.ToolStrip.create(
                    {
                        width: "100%",
                        align: "right",
                        border: '0px',
                        members: [
                            isc.ToolStripButton.create({
                                width: "100",
                                height: "25",
                                autoFit: false,
                                title: "<spring:message code='global.form.previous.step'/>",
                                click: function () {

                                    let tab = This.parentElement.parentElement;
                                    let selectedTab = tab.selectedTab;
                                    tab.getTab(tab.selectedTab - 1).pane.members.forEach(q => q.enable());
                                    tab.selectTab(selectedTab - 1);
                                    tab.removeTab(selectedTab);
                                }
                            })
                        ]
                    })
            ]
        }));
        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        this.editDeduction();
    },
    validate: function () {

        let isValid = true;
        this.getMembers().filter(q => q.role === "RC").forEach(q => isValid &= q.validate());
        return isValid;
    },
    getValues: function () {

        let data = [{
            name: "TC",
            value: this.contractDetailDataTC
        }];
        this.getMembers().filter(q => q.role === "RC").forEach(current => {

            data.add({
                name: current.name,
                elementId: current.elementId,
                materialElementId: current.materialElementId,
                assay: current.getFinalAssay(),
                rcPrice: current.getRCPrice(),
                rcBasePrice: current.getRCBasePrice(),
                rcUnitConversionRate: current.getRCUnitConversionRate(),
            });
        });
        return data;
    },
    okButtonClick: function () {

    },
    editDeduction: function () {
        this.getMembers().filter(q => q.role === "RC").forEach(current => current.editRowDeduction());
    },
    getDeductionSubTotal: function () {
        return this.getMembers().filter(q => q.name === "subTotal").first().getValues().value;
    }
});
