isc.defineClass("InvoiceCalculation", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    calculationData: null,
    invoiceBaseAssayComponent: null,
    invoiceBasePriceComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.Label.create({
            margin: 10,
            height: 5,
            align: nicico.CommonUtil.getAlignByLang(),
            contents: "<spring:message code='foreign-invoice.form.calculation.label'/>"
        }));

        let assayValues = this.invoiceBaseAssayComponent.getValues();
        let priceValues = this.invoiceBasePriceComponent.getValues();

        for (let index = 0; index < priceValues.length; index++) {

            let assayValue = assayValues.filter(q => q.elementId === priceValues[index].elementId).first();
            this.addMember(isc.InvoiceCalculationRow.create({
                role: "calculationRow",
                assay: assayValue,
                name: assayValue.name,
                price: priceValues[index],
                elementId: priceValues[index].elementId,
                materialElementId: assayValue.materialElementId,
                calculationRowData: This.calculationData ? This.calculationData.filter(q => q.materialElementId === assayValue.materialElementId).first() : null,
                sumPriceChanged: function (sumPrice) {

                    let subtotalForm = This.getMembers().filter(q => q.name === "subTotal").first();
                    subtotalForm.data[this.ID] = sumPrice;
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
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.subtotal.price'/>"
        }));
        this.getMembers().last().setUnitId(this.currency.id);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        This.addMember(isc.ToolStrip.create({
            width: "100%",
            border: '0px',
            members: [
                isc.ToolStripButton.create({
                    width: "100",
                    height: "25",
                    autoFit: false,
                    title: "<spring:message code='global.form.save'/>",
                    click: function () {

                        if (!This.validate())
                            return;

                        This.okButtonClick();

                        let tab = This.parentElement.parentElement;
                        tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                        tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                    }
                }),
                isc.ToolStrip.create({
                    width: "100%",
                    align: "right",
                    border: '0px',
                    members: [
                        isc.ToolStripButton.create({
                            width: "100",
                            height: "25",
                            autoFit: false,
                            title: "<spring:message code='global.cancel'/>",
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

        this.editCalculation();
    },
    validate: function () {

        let isValid = true;
        this.getMembers().filter(q => q.role === "calculationRow").forEach(q => isValid &= q.validate());
        return isValid;
    },
    getValues: function () {

        let data = [];
        this.getMembers().filter(q => q.role === "calculationRow").forEach(current => {

            data.add({
                name: current.name,
                elementId: current.elementId,
                materialElementId: current.materialElementId,
                assay: current.getFinalAssay(),
                basePrice: current.getBasePrice(),
                deductionType: current.getDeductionType(),
                deductionValue: current.getDeductionValue(),
                deductionPrice: current.getDeductionPrice(),
                deductionUnitConversionRate: current.getDeductionUnitConversionRate(),
            });
        });

        return data;
    },
    okButtonClick: function () {

    },
    editCalculation: function () {
        this.getMembers().filter(q => q.role === "calculationRow").forEach(current => current.editRowCalculation());
    },
    getCalculationSubTotal: function () {
        return this.getMembers().filter(q => q.name === "subTotal").first().getValues().value;
    }
});
