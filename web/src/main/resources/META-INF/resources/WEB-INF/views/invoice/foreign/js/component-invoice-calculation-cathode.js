isc.defineClass("InvoiceCalculationCathode", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    contract: null,
    shipment: null,
    currency: null,
    contractDetailData: null,
    inspectionWeightData: null,
    invoiceBaseWeightComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
            shipment: This.shipment,
            inspectionWeightData: This.inspectionWeightData,
        });
        this.addMember(this.invoiceBaseWeightComponent);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

    },

    validate: function () {

        // let isValid = !(this.getMember(0).getTotalRows() === 0);
        // for (let i = 0; i < this.getMember(0).getTotalRows(); i++) {
        //     this.getMember(0).validateRow(i);
        //     isValid &= !this.getMember(0).hasErrors()
        // }
        // return isValid;
    },
    okButtonClick: function () {

    },
    getBaseWeightValues: function () {

        // return {
        //     weightND: {
        //         getValues: function () {
        //
        //             return {
        //                 value: 1
        //             };
        //         }
        //     }
        // };
    },
    getDeductionSubTotal: function () {
        // return 0;
    },
    getCalculationSubTotal: function () {
        // return this.getMember(0).getGridSummaryData().map(q => q.amount).sum();
    },
    getForeignInvoiceItems: function () {

        // let items = [];
        // let This = this;
        // let gridData = this.getMember(0).getData();
        //
        // function getForeignInvoiceItemDetails(gridRecord) {
        //
        //     let itemDetails = [];
        //     let remittanceDetailId = gridRecord.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
        //     let assayData = This.inspectionAssayData.assayInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId);
        //     assayData.forEach(q => {
        //         itemDetails.add({
        //             assay: q.value,
        //             materialElementId: q.materialElementId,
        //             basePrice: This.getMember(0).priceBase.filter(bp => bp.elementId === q.materialElement.elementId).first().price,
        //             deductionType: JSON.parse('${Enum_DeductionType}').DiscountPercent,
        //             deductionValue: gridRecord.discount,
        //             deductionPrice: gridRecord.price * gridRecord.discount / 100,
        //             rcPrice: 0,
        //             rcBasePrice: 0,
        //             rcUnitConversionRate: 1
        //         })
        //     });
        //
        //     return itemDetails;
        // }
        //
        // gridData.forEach(current => {
        //
        //     let remittanceDetailId = current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
        //     let weightData = This.inspectionWeightData.weightInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId)
        //         .first();
        //
        //     items.add({
        //         treatCost: 0,
        //         weightGW: weightData.weightGW,
        //         weightND: weightData.weightND,
        //         assayMilestone: This.inspectionAssayData.assayInspections[0].mileStone,
        //         weightMilestone: This.inspectionWeightData.weightInspections[0].mileStone,
        //         deductionUnitConversionRate: current.unitConversionRate,
        //         remittanceDetailId: remittanceDetailId,
        //         foreignInvoiceItemDetails: getForeignInvoiceItemDetails(current)
        //     });
        // });
        // return items;
    }
});