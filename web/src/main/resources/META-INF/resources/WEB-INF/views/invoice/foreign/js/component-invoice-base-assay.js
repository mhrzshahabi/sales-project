isc.defineClass("InvoiceBaseAssay", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    height: "20%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    inventories: [],
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let fields = [];
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {inventoryIds: This.inventories.map(q => q.id)},
            actionURL: "${contextPath}/api/assayInspection/get-assay-values",
            callback: function (resp) {

                let assayValues = JSON.parse(resp.data);
                for (let index = 0; index < assayValues.length; index++) {

                    if (!assayValues[index].payable)
                        continue;

                    fields.add(isc.Unit.create({

                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        disabledCurrencyField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showCurrencyFieldTitle: false,
                        showUnitField: false,
                        showCurrencyField: false,
                        fieldValueTitle: assayValues[index].name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                    fields.last().setValue(assayValues[index].price);
                    fields.last().setUnitId(assayValues[index].unit.id);
                    fields.last().setCurrencyId(assayValues[index].currency.id);
                }

                This.addMember(isc.Label.create({
                    contents: "<b>" + "AVERAGE OF " + (month + moasValue) + "th MONTH OF " + year + " (MOAS" + (moasValue > 0 ? "+" : "-") + moasValue + ")<b>"
                }));
                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
        // },
        // getValues: function () {
        //     return this.members[1].getValues();
        // },
        // setValues: function (data) {
        //     return this.members[1].setValues(data);
        // },
        //
        //
        // material: null,
        // unitComponentCopper: null,
        // unitComponentSilver: null,
        // unitComponentGold: null,
        // unitComponentPlatinum: null,
        // unitComponentPalladium: null,
        // unitComponentSelenium: null,
        // invoiceAssayObj: "",
        // initWidget: function () {
        //
        //     var This = this;
        //     this.Super("initWidget", arguments);
        //
        //     invoiceAssayObj = {
        //         assayCopper: 0,
        //         assaySilver: 0,
        //         assayGold: 0,
        //         assayPlatinum: 0,
        //         assayPalladium: 0,
        //         assaySelenium: 0,
        //     };
        //
        //     switch (this.material) {
        //
        //         case 0:
        //             unitComponentCopper = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             this.addMember(unitComponentCopper);
        //             break;
        //
        //         case 1:
        //             unitComponentCopper = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentSilver = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.silver"/>:' + "       (Ag)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentGold = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.gold"/>:' + "     (Au)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             this.addMember(unitComponentCopper);
        //             this.addMember(unitComponentSilver);
        //             this.addMember(unitComponentGold);
        //             break;
        //
        //         case 4:
        //             unitComponentCopper = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentSilver = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.silver"/>:' + "       (Ag)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentGold = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.gold"/>:' + "     (Au)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentPlatinum = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.platinum"/>:' + "       (Pt)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentPalladium = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.palladium"/>:' + "       (Pd)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             unitComponentSelenium = isc.Unit.create({
        //                 fieldValueTitle: '<spring:message code="component.invoice.price.selenium"/>:' + "     (Se)",
        //                 unitCategory: 1,
        //                 showTitle: false,
        //                 // disabled: true
        //             });
        //
        //             this.addMember(unitComponentCopper);
        //             this.addMember(unitComponentSilver);
        //             this.addMember(unitComponentGold);
        //             this.addMember(unitComponentPlatinum);
        //             this.addMember(unitComponentPalladium);
        //             this.addMember(unitComponentSelenium);
        //             break;
        //     }


    },
    // getAssayValues: function () {
    //
    //     switch (this.material) {
    //         case 0:
    //             invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
    //             break;
    //         case 1:
    //             invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
    //             invoiceAssayObj.assaySilver = this.members.get(1).getUnitValues();
    //             invoiceAssayObj.assayGold = this.members.get(2).getUnitValues();
    //             break;
    //         case 4:
    //             invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
    //             invoiceAssayObj.assaySilver = this.members.get(1).getUnitValues();
    //             invoiceAssayObj.assayGold = this.members.get(2).getUnitValues();
    //             invoiceAssayObj.assayPlatinum = this.members.get(3).getUnitValues();
    //             invoiceAssayObj.assayPalladium = this.members.get(4).getUnitValues();
    //             invoiceAssayObj.assaySelenium = this.members.get(5).getUnitValues();
    //             break;
    //     }
    //     return invoiceAssayObj;
    // },
    // setAssayValues: function (data) {
    //     this.members.get(0).setUnitValues(data.assayCopper);
    //     this.members.get(1).setUnitValues(data.assaySilver);
    //     this.members.get(2).setUnitValues(data.assayGold);
    //     this.members.get(3).setUnitValues(data.assayPlatinum);
    //     this.members.get(4).setUnitValues(data.assayPalladium);
    //     this.members.get(5).setUnitValues(data.assaySelenium);
    //
    // }
});
