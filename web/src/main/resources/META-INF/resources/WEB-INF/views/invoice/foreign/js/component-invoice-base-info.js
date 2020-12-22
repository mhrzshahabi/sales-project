isc.defineClass("InvoiceBaseInfo", isc.VLayout).addProperties({
    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    contract: null,
    billLadings: null,
    invoiceNo: null,
    invoiceDate: null,
    invoiceType: null,
    contractDetailDataIncoterm: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let result = '';

        let material = This.contract.material;
        let incoterm = This.contractDetailDataIncoterm;
        let buyer = This.contract.contractContacts.filter(q => q.commercialRole === JSON.parse('${Enum_CommercialRole}').Buyer).first().contact;

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
                    <td class="table-td-value">` + This.checkUndefined(This.invoiceNo) + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DATE:&nbsp;</td>
                    <td class="table-td-value">` + DateUtil.format(This.invoiceDate, "EEE dd MM YYYY HH:mm:ss") + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">CONTRACT NO:&nbsp;</td>
                    <td class="table-td-value">` + This.contract.no + `</td>
                  </tr>
                  <tr class="i-buyer-info">
                    <td class="table-td">BUYER:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + This.checkUndefined(buyer.nameEN) + `</div>
                        <div>` + This.checkUndefined(buyer.address) + `</div>
                        <div>` + This.checkUndefined(buyer.country.nameEN) + `</div>
                        <div>` + This.checkUndefined(buyer.phone) + `</div>
                        <div>` + This.checkUndefined(buyer.fax) + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">MATERIAL:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + material.descEN + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">SHIPPED:&nbsp;</td>
                    <td class="table-td-value">` +
                        This.billLadings.map(bl => {
                            result = "<div>" + bl.oceanVessel.name + "</div>";
                            result += "<div>B/L NO./ DATE: " + bl.documentNo + " DATED " + DateUtil.format(bl.dateOfIssue, "dd MM YYYY");
                            if (bl.switchDocumentNo)
                                result += " & SW B/L NO: " + bl.switchDocumentNo + " - DATED " + DateUtil.format(bl.dateOfIssue, "dd MM YYYY");
                            result += "</div>";
                            if (bl.containers && bl.containers.length > 0)
                                result += "<div>" + bl.containers.length + " X " + bl.containers[0].containerType + " CONTAINERS</div>";
                            result += "<div>FROM: " + bl.portOfLoading.port + "</div>";
                            result += "<div>TO: " + bl.portOfDischarge.port + "</div>";
                            result += "<div>NET WET WEIGHT: " + bl.totalGross + "</div>";

                            return result;
                        }).join('<br/>') + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DELIVERY TERMS:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + incoterm.incotermRules[0].incotermRule.titleEn + `</div>
                        <div>` + incoterm.incotermVersion.incotermVersion + `</div>
                    </td>
                  </tr>
                </table>`
        }));
    },
    checkUndefined: function(text) {
        if (text == null)
            return "";
        else
            return text;
    }
});
