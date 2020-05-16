/**
 <%@ page contentType="text/html;charset=UTF-8" %>
 <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 **/

async function getAccessToken(user = "user", password = "password") {
    const response = await fetch("http://apps.nicico.com/oauth/token", {
        "headers": {
            "authorization": "Basic U2FsZXM6MmxPbGZxdHowMldDQjFOYXBKUEs=",
            "content-type": "application/x-www-form-urlencoded"
        },
        "body": "grant_type=password&username=" + user + "&password=" + password,
        "method": "POST",
    });
    const json = await response.json()
    return json['access_token'];
}

function contractReport() {
    const crTab = {
        chartData: [],
        contract: {
            all: [],
            byYear: {}
        },
        shipment: {
            all: [],
            byYear: {},
        },
        invoice: {
            all: [],
            byYear: [],
        }
    }


    fetch(
        SalesConfigs.Urls.RootUrl + '/api/contract/report-spec-list', {
            headers: SalesConfigs.httpHeaders,
        }
    ).then(r => r.json()).then(j => {
        crTab.contract.all = j.response.data;

        crTab.contract.all.forEach(
            contract => {
                if (crTab.contract.byYear[contract['year']] === undefined || crTab.contract.byYear[contract['year']] === null) {
                    crTab.contract.byYear[contract['year']] = [contract]
                } else crTab.contract.byYear[contract['year']].add(contract)
                if (contract.shipments.length > 0) {
                    contract.shipments.forEach(
                        shipment => {
                            shipment['contract'] = contract
                            shipment['year'] = shipment['swBlDate'].substring(0, 4);
                            crTab.shipment.all.add(shipment)
                            if (crTab.shipment.byYear[shipment['year']] === undefined ||
                                crTab.shipment.byYear[shipment['year']] === null) {
                                crTab.shipment.byYear[shipment['year']] = [shipment]
                            } else crTab.shipment.byYear[shipment['year']].add(shipment)
                            const invoices = shipment.invoices;
                            if (invoices.length > 0) {
                                invoices.forEach(
                                    invoice => {
                                        invoice['shipment'] = shipment
                                        invoice['year'] = invoice['invoiceDate'].substr(-4)
                                        crTab.invoice.all.add(invoice)
                                        const invoiceDate = crTab.invoice.byYear[invoice['year']];
                                        if (invoiceDate === undefined || invoice === null) {
                                            crTab.invoice.byYear[invoice['year']] = [invoice]
                                        } else crTab.invoice.byYear[invoice['year']].add(invoice)
                                    }
                                )
                            }

                        }
                    )
                }
            }
        )

        crTab.chartData.push(...Object.keys(crTab.contract.byYear).map(year => {
            return {year: year, type: "contract", values: crTab.contract.byYear[year].length}
        }))
        crTab.chartData.push(...Object.keys(crTab.shipment.byYear).map(year => {
            return {year: year, type: "shipment", values: crTab.shipment.byYear[year].length}
        }))

        crTab.chartData.push(...Object.keys(crTab.invoice.byYear).map(year => {
            return {year: year, type: "invoice", values: crTab.invoice.byYear[year].length}
        }))


        crTab.chartData.push(...Object.keys(crTab.invoice.byYear).map(year => {
            return {
                "year": year, "type": "price", values: crTab.invoice.byYear[year].reduce(
                    (sum, invoice) => {
                        if (isNaN(sum)) sum = 0;

                        return (invoice['invoiceValue'] + sum)
                    }
                ) / Math.pow(10, 9)
            }
        }))
        mainTabSet.getTab(mainTabSet.selectedTab).setPane(
            isc.VLayout.create({
                width: "100%",
                height: "100%",
                membersMargin: 20,
                members: [
                    isc.HLayout.create({
                        width: "100%",
                        height: 0.01 * window.innerHeight,
                        members:
                            [
                                isc.ToolStrip.create({
                                    width: "100%",
                                    membersMargin: 5,
                                    members:
                                        [
                                            isc.MenuButton.create({
                                                autoDraw: false,
                                                title: "<spring:message code='tozin.report.betweenComplexes'/>",
                                                prompt: "<spring:message code='tozin.report.betweenComplexes.date'/>",
                                                width: 125,
                                                menu: isc.Menu.create({
                                                    width: 150,
                                                    data: [
                                                        {
                                                            title: "<spring:message code='global.form.print.pdf'/>",
                                                            icon: "icon/pdf.png",
                                                            click: function () {
                                                                //   "<spring:url value="/warehouseStock/print/beyn_mojtama/pdf" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.excel'/>",
                                                            icon: "icon/excel.png",
                                                            click: function () {
                                                                //   "<spring:url value="/warehouseStock/print/beyn_mojtama/excel" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.html'/>",
                                                            icon: "icon/html.jpg",
                                                            click: function () {
                                                                // "<spring:url value="/warehouseStock/print/beyn_mojtama/html" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                            }
                                                        }
                                                    ]
                                                })
                                            }),
                                            isc.MenuButton.create({
                                                autoDraw: false,
                                                title: "<spring:message code='tozin.report.salesUpload'/>",
                                                prompt: "<spring:message code='tozin.report.salesUpload.byDate'/>",
                                                width: 200,
                                                menu: isc.Menu.create({
                                                    width: 200,
                                                    data: [
                                                        {
                                                            title: "<spring:message code='global.form.print.pdf'/>",
                                                            icon: "icon/pdf.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/pdf" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.excel'/>",
                                                            icon: "icon/excel.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/excel" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.html'/>",
                                                            icon: "icon/html.jpg",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/html" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        }
                                                    ]
                                                })
                                            }),
                                            isc.MenuButton.create({
                                                autoDraw: false,
                                                title: "<spring:message code='tozin.report.cons.buy'/>",
                                                prompt: "<spring:message code='tozin.report.cons.buy.byDate'/>",
                                                width: 200,
                                                menu: isc.Menu.create({
                                                    width: 200,
                                                    data: [
                                                        {
                                                            title: "<spring:message code='global.form.print.pdf'/>",
                                                            icon: "icon/pdf.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/pdf" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.excel'/>",
                                                            icon: "icon/excel.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/excel" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.html'/>",
                                                            icon: "icon/html.jpg",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/html" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        }
                                                    ]
                                                })
                                            }),
                                            isc.MenuButton.create({
                                                autoDraw: false,
                                                title: "<spring:message code='tozin.report.waste'/>",
                                                prompt: "<spring:message code='tozin.report.waste.byDate'/>",
                                                width: 250,
                                                menu: isc.Menu.create({
                                                    width: 250,
                                                    data: [
                                                        {
                                                            title: "<spring:message code='global.form.print.pdf'/>",
                                                            icon: "icon/pdf.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/pdf" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.excel'/>",
                                                            icon: "icon/excel.png",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/excel" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        },
                                                        {
                                                            title: "<spring:message code='global.form.print.html'/>",
                                                            icon: "icon/html.jpg",
                                                            click: function () {
                                                                var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                                // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/html" var="printUrl"/>"
                                                                window.open('${printUrl}' + '/' + toDay);
                                                            }
                                                        }
                                                    ]
                                                })
                                            }),
                                            isc.DynamicForm.create({
                                                ID: "DynamicForm_DailyReport_Tozin",
                                                width: "200",
                                                wrapItemTitles: false,
                                                // height: "100%",
                                                action: "report/printDailyReportBandarAbbas",
                                                target: "_Blank",
                                                titleWidth: "200",
                                                numCols: 4,
                                                fields: [{
                                                    name: "toDay",
                                                    ID: "toDayDateTozin",
                                                    title: "<spring:message code='dailyWarehouse.toDay'/>",
                                                    type: 'text',
                                                    align: "center",
                                                    width: 150,
                                                    colSpan: 1,
                                                    titleColSpan: 1,
                                                    icons: [{
                                                        src: "pieces/pcal.png",
                                                        click: function () {
                                                            displayDatePicker('toDayDateTozin', this, 'ymd', '/');
                                                        }
                                                    }],
                                                    defaultValue: "1398/10/26",
                                                },]
                                            }),
                                        ]
                                })
                            ]
                    }),

                    isc.FacetChart.create({

                        showDataValues: true,
                        showDoughnut: true,
                        facets: [{
                            id: 'type', title: "type"
                        }, {
                            id: 'year', title: "year"
                        }],
                        data: crTab.chartData,
                        valueProperty: "values",
                        chartType: "Pie"
                    }),
                    isc.ListGrid.create({
                        groupStartOpen: "first",
                        groupByField: ['year', "material.descl"],
                        width: "100%",
                        height: 0.5 * window.innerHeight,
                        data: crTab.contract.all,
                        fields: [
                            {
                                name: "contact.nameEN"
                            }, {
                                name: "year", hidden: true
                            }, {
                                name: "material.descl", hidden: true
                            },
                            {
                                name: "invoices",
                                formatCellValue(value, record, rowNum, colNum, grid) {
                                    if (record.shipments.length === 0) return 0;
                                    sum = 0;
                                    record.shipments.forEach(shipment => {
                                        if (shipment.invoices.length != 0) {
                                            shipment.invoices.forEach(
                                                invoice => sum = sum + Number(invoice.invoiceValue)
                                            )
                                        }
                                    })
                                    sum = sum / Math.pow(10, 6)
                                    return (Math.round(sum * 100)) / 100;
                                }
                            },
                            {
                                name: "وزن",
                                formatCellValue(value, record, rowNum, colNum, grid) {
                                    if (record.shipments.length === 0) return 0;
                                    sum = 0;
                                    record.shipments.forEach(shipment => {
                                        if (shipment.invoices.length != 0) {
                                            shipment.invoices.forEach(
                                                invoice => sum = sum + Number(invoice.gross)
                                            )
                                        }
                                    })
                                    return (Math.round(sum * 100)) / 100
                                }
                            },

                        ]

                    })
                    ,
                ]
            })
        )


    })

    return crTab;

}

crTab = contractReport()
