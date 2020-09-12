isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({
    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    contract: null,
    shipment: null,
    invoiceType: null,
    remittanceDetails: null,
    contractDetailData: null,
    invoiceBasePriceComponent: null,
    invoiceBaseAssayComponent: null,
    invoiceBaseWeightComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        if (this.invoiceType.id === ImportantIDs.invoiceType.FINAL) {

            this.invoiceBasePriceComponent = isc.InvoiceBasePrice.create({
                currency: This.currency,
                contract: This.contract,
                shipment: This.shipment,
                contractDetailData: This.contractDetailData
            });
            this.addMember(this.invoiceBasePriceComponent);
            this.addMember(isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }));

            if (this.contract.materialId !== ImportantIDs.material.COPPER_CATHOD) {

                this.invoiceBaseAssayComponent = isc.InvoiceBaseAssay.create({
                    shipment: This.shipment,
                    remittanceDetail: This.remittanceDetails[0],
                });
                this.addMember(this.invoiceBaseAssayComponent);
                this.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));
            }

            this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
                shipment: This.shipment,
                remittanceDetail: This.remittanceDetails[0],
            });
            this.addMember(this.invoiceBaseWeightComponent);
            this.addMember(isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }));
        } else {

        }

        this.addMember(isc.ToolStrip.create({
            width: "100%",
            border: '0px',
            members: [
                isc.ToolStripButton.create({
                    width: "100",
                    height: "25",
                    autoFit: false,
                    title: "<spring:message code='global.ok'/>",
                    click: function () {

                        if (!This.validate())
                            return;

                        This.okButtonClick();

                        let tab = This.parentElement.parentElement;
                        tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                        tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                    }
                })
            ]
        }));
        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));
    },
    okButtonClick: function () {

    },
    getValues: function () {

        return {
            assay: this.invoiceBaseAssayComponent.getValues(),
            weight: this.invoiceBaseWeightComponent.getValues(),
            basePrice: this.invoiceBasePriceComponent.getValues()
        }
    },
    validate: function () {

        let isValid = true;
        if (!this.invoiceBasePriceComponent.validate())
            isValid = false;

        if (!this.invoiceBaseAssayComponent.validate())
            isValid = false;

        if (!this.invoiceBaseWeightComponent.validate())
            isValid = false;

        if (!(this.invoiceBasePriceComponent.getDataRowNo() === this.invoiceBaseAssayComponent.getDataRowNo()))
            isValid = false;

        if (!isValid)
            isc.warn("<spring:message code='global.message.data.not.complete'/>");

        return isValid;
    }
});
