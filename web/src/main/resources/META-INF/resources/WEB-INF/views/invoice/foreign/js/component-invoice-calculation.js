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
    invoiceBaseAssayComponent: null,
    invoiceBasePriceComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let assayValues = this.invoiceBaseAssayComponent.getValues();
        let priceValues = this.invoiceBasePriceComponent.getValues();

        for (let index = 0; index < priceValues.length; index++) {

            this.addMember(isc.InvoiceCalculationRow.create({
                assay: assayValues[index],
                price: priceValues[index],
                name: assayValues[index].name,
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
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
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
                    title: "<spring:message code='global.ok'/>",
                    click: function () {

                        if (!This.validate()) return;
                        else {
                            This.okButtonClick();

                            let tab = This.parentElement.parentElement;
                            tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                            tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                        }

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
    },
    getCalculationSubTotal: function () {
        return this.getMembers().filter(q => q.name === "subTotal").first().getValues().value;
    },
    getValues: function () {

        let data = [];
        this.getMembers().slice(0, this.invoiceBasePriceComponent.getValues().length).forEach(current => {

            data.add({
                name: current.name,
                finalAssay: current.getFinalAssay(),
            });
        });

        return data;
    },
    okButtonClick: function () {

    },
    validate: function () {

        var isValid = true;
        this.getMembers().slice(0, this.invoiceBaseAssayComponent.getValues().length).forEach(q => isValid &= q.validate());
        return isValid;
    }
});
