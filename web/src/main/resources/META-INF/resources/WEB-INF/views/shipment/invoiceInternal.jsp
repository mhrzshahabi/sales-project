<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

var RestDataSource_InvoiceInternal = isc.MyRestDataSource.create({
fields:
[
{name: "id"},
{name: "lcId"},
{name: "remittanceId"},
{name: "invoiceDate"},
{name: "buyerId"},
{name: "customerId"},
{type: 'integer', name: "productId"},
{type: 'float', name: "invoiceOtherDeductions"},
{name: "remittanceFinalDate"},
{type: 'float', name: "realWeight"},
{type: 'float', name: "unitPrice"},
{type: 'float', name: "totalDeductions"},
{type: 'float', name: "totalAmount"},
{name: "invoiceSerial"},
{type: 'float', name: "taxChargeAmount"},
{type: 'float', name: "pollutionChargeAmount"},
{name: "invoiceSent"},
{type: 'integer', name: "salesType"},
{type: 'integer', name: "hasPollution"},
{name: "nosaPollutionCode"},
{name: "pollutionCostCenterCode"},
{type: 'integer', name: "hasTax"},
{name: "nosaTaxCode"},
{name: "taxCostCenterCode"},
{name: "nosaBankCode"},
{name: "nosaCustomerCode"},
{name: "nosaCustomerCreditCode"},
{name: "customerCostCenterCode"},
{name: "lcCostCenterCode"},
{name: "nosaProductCode"},
{name: "productCostCenterCode"},
{name: "bankGroupDesc"},
{name: "customerName"},
{name: "productName"},
{name: "nosaProductGroupCode"},
{name: "productGroupName"},
{name: "lcDueDate"}
],

fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
    });

    function ListGrid_InvoiceInternal_refresh() {
        ListGrid_InvoiceInternal.invalidateCache();
    }

    function ToolStripButton_InvoiceInternal_Pdf_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/pdf/" + rowId);
        }
    }


    function ToolStripButton_InvoiceInternal_Html_F() {
        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/html/" + rowId);
        }
    }

    <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_InvoiceInternal_Html_F();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceInternal_Pdf_F();

        }
    });
    </sec:authorize>

    var ToolStripButton_InvoiceInternal_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });

    function Menu_ListGrid_InvoiceInternal_Pdf_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/pdf/" + rowId);
        }
    }

    function Menu_ListGrid_InvoiceInternal_Html_F() {
        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/html/" + rowId);
        }
    }

    var Menu_ListGrid_InvoiceInternal = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_refresh();
                }
            },
            <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='global.form.print.pdf'/>",
                icon: "icon/pdf.png",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Pdf_F();
                }

            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='global.form.print.html'/>",
                icon: "icon/html.jpg",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Html_F();
                }
            }
            </sec:authorize>
        ]
    });

    var ToolStrip_Actions_InvoiceInternal = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Pdf,
                </sec:authorize>

                <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_html,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_InvoiceInternal_Refresh,
                    ]
                })

            ]
    });

    var HLayout_InvoiceInternal_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_InvoiceInternal
            ]
    });

var ListGrid_InvoiceInternal = isc.ListGrid.create({
showFilterEditor: true,
width: "100%",
height: "100%",
dataSource: RestDataSource_InvoiceInternal,
contextMenu: Menu_ListGrid_InvoiceInternal,
fields:
[
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "invoiceDate", title: "<spring:message code='invoice.invDate'/>"},
{name: "remittanceId", title: "<spring:message code='invoice.havalehId'/>"},
{name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
{name: "invoiceSerial", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
{name: "productName", title: "<spring:message code='invoice.gdsName'/>"},
{
type: 'integer',
name: "salesType",
valueMap: {"2": "اعتباری", "1": "نقدی"},
title: "<spring:message code='invoice.typeForosh'/>"
},
{type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
{type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
{type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
{type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
{name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
],
autoFetchData: true,
allowFilterOperators: true
});

var HLayout_InvoiceInternal_Grid = isc.HLayout.create({
width: "100%",
height: "100%",
members: [
            ListGrid_InvoiceInternal
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_InvoiceInternal_Actions, HLayout_InvoiceInternal_Grid
        ]
    });