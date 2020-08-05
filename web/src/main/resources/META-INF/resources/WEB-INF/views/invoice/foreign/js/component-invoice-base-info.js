isc.defineClass("InvoiceBaseInfo", isc.VLayout).addProperties({
    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    contract: null,
    billLadings: null,
    invoiceNo: null,
    invoiceDate: null,
    invoiceType: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let result = '';
        let buyer = __contract.getBuyer(This.contract);
        let material = __contract.getMaterial(This.contract);
        let deliveryTerm = __contract.getDeliveryTerm(This.contract);

        this.addMember(isc.Label.create({
            contents: `
                <style>
                    .i-contract-info-tab {
                        width: 100%;
                        padding: 20px;
                        color: #000000;
                        font-size: 13px;
                        overflow-y: scroll;
                    }
                    .i-contract-info-tab td{
                        padding: 10px 5px;
                        vertical-align: top;
                        border-bottom: 1px solid rgba(0,0,0,0.3);
                    }
                    .i-contract-info-tab tr {
                        width: 100%;
                        line-height: 1.5;
                        margin-bottom: 15px;
                        border-bottom: 1px solid rgba(0,0,0,0.3);
                    }
                    .table-td{
                        width: 25%;
                        font-size: 12px;
                        font-weight: 500;
                        color: rgba(0  ,0 ,0 , 0.8); 
                    }
                    .table-td-value{
                        color: #000000;
                        font-size: 14px;
                    }
                    .i-contract-info-tab .i-invoice-type {
                        text-align: center;
                        text-decoration: underline;
                    }
                    .i-invoice-type{
                        margin-top: 40px;
                    }
                </style>
                <table class="i-contract-info-tab">
                  <caption class="i-invoice-type">` + This.invoiceType.title + `</caption>
                  <tr> 
                    <td class="table-td">REF NO:&nbsp;</td>
                    <td class="table-td-value">` + (!This.invoiceNo ? "" : This.invoiceNo) + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DATE:&nbsp;</td>
                    <td class="table-td-value">` + DateUtil.format(This.invoiceDate, "EEE dd MM YYYY HH:mm:ss") + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">CONTRACT NO:&nbsp;</td>
                    <td class="table-td-value">` + This.contract[__contract.nameOfNumberProperty] + `</td>
                  </tr>
                  <tr class="i-buyer-info">
                    <td class="table-td">BUYER:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + buyer.nameEN + `</div>
                        <div>` + buyer.address + `</div>
                        <div>` + buyer.phone + `</div>
                        <div>` + buyer.fax + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">MATERIAL:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + material.descl + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">SHIPPED:&nbsp;</td>
                    <td class="table-td-value">` +
                This.billLadings.map(bl => {
                    result = "<div>" + bl.vesselName + "</div>";
                    if (bl.switchBillLading)
                        result += "<div>SWITCH B/L NO: " + bl.switchBillLading.no + " DATED " + DateUtil.format(bl.switchBillLading.date, "dd MM YYYY") + "</div>";
                    result += "<div>NICICO B/L NO: " + bl.no + " DATED " + DateUtil.format(bl.date, "dd MM YYYY") + "</div>";
                    result += "<div>FROM: " + bl.from + "</div>";
                    result += "<div>TO: " + bl.to + "</div>";
                    result += "<div>G/W WEIGHT: " + bl.weightGW + "</div>";

                    return result;
                }).join('<hr>') + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DELIVERY TERMS:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + deliveryTerm.rule + `</div>
                        <div>` + deliveryTerm.version + `</div>
                    </td>
                  </tr>
                </table>`
        }));
    }
});
