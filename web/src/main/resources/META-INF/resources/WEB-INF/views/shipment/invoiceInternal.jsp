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
        {name: "lcDueDate"},
        {name: "documentId"}
    ],
    fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
    });
    var RestDataSource_InvoiceInternal_Sent = isc.MyRestDataSource.create({
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
        {name: "lcDueDate"},
        {name: "documentId"}
    ],
    fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
    });
    <%-- accounting window --%>
    var departmentDS = isc.MyRestDataSource.create({
        fields:[
            {name:"id", primaryKey:true, type:"integer", title:" ID"},
            {name:"departmentName" , title:"<spring:message code='department.name'/>"},
            {name: "departmentCode", title:"<spring:message code='department.code'/>" }
        ],
        dataFormat:"json",
        jsonPrefix:"",
        jsonSuffix:"",
        fetchDataURL:"${contextPath}/api/accounting/departments"
    });
    var documentMainInfoForm = isc.DynamicForm.create({
        width:"100%",
        height :"100%",
        titleWidth: 30,
        align:"right",
        autoDraw:false,
        canEdit:true,
        autoFetchData:false,
        // colWidths: [100, "*"],
        numCols: 4,
        margin :5,
        fields: [
            { name:"remittanceId",title:"<spring:message code='invoice.havalehId'/>",width:"150" , canEdit:false},
            { name:"customerName",title:"<spring:message code='invoice.customerName'/>",width:"150" , canEdit:false},
            { name:"invoiceSerial",title:"<spring:message code='invoice.shomarehSoratHesab'/>",width:"150" , canEdit:false},
            { name:"productName",title:"<spring:message code='invoice.gdsName'/>",width:"150" , canEdit:false},
            { name:"unitPrice",title:"<spring:message code='invoice.ghematUnit'/>",width:"150" , canEdit:false},
            { name:"totalAmount",title:"<spring:message code='invoice.mablaghKol'/>",width:"150" , canEdit:false},
            { name:"totalDeductions",title:"<spring:message code='invoice.totalKosorat'/>",width:"150" , canEdit:false},
            {type:"SpacerItem" ,width:"100%" , height: "50",colSpan: 4},
            { name:"documentDate",title:"<spring:message code='document.header.date'/>",width:"150",icons: [ persianDatePicker ],
            wrapTitle: false,type:"persianDate",length:10,keyPressFilter:"[0-9/]",
			},
            { name:"department.id" ,title:"<spring:message code='department.name'/>",required:true,
				editorType: "select",
				wrapTitle: false,
				optionDataSource: departmentDS,
				valueField: "id",
				displayField:"departmentName",
				width:"150",
				pickListWidth: "150",
				allowAdvancedCriteria:false,
				autoFetchData:false,
				pickListFields: [
                    { name: "departmentCode" ,width:"20%"},
                    { name: "departmentName" ,width:"80%"}
				],

			},
    			{ name:"documentTitle", title:"<spring:message code='document.header.desc'/>", type:"textArea"  ,colSpan:"4" ,width:"485",wrapTitle:false,
    			}
        ]
});
    var IButton_Document_Save = isc.IButtonSave.create({
        top: 260,
        title:"<spring:message code='global.form.save'/>",
        click : function () {
                let record = ListGrid_InvoiceInternal.getSelectedRecord();
                if (!record||!record.id) {
                let ERROR = isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
                setTimeout(function(){ERROR.hide();},3000);
                return;
            }
            let data = isc.clone(documentMainInfoForm.getValues());
            data.department = data.department.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/accounting/documents/internal/"+record.id,
                    httpMethod: "POST",
                    useSimpleHttp: true,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(data),
                    willHandleError: true,
                    serverOutputAsString: false,
                    callback: function (RpcResponse_o) {

                          if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                let data =  JSON.stringify(RpcResponse_o.data).split("@");
                                record.documentId = data[1].replace("\"","");
                                isc.say(data[0]);
                                newDocumentWindow.close();
                                ListGrid_InvoiceInternal.getCellCSSText(record);
                                ListGrid_InvoiceInternal.refreshRow(ListGrid_InvoiceInternal.getRowNum(record));
                          }else
                            {
                                newDocumentWindow.close();
                                record.documentId = -1 ;
                                ListGrid_InvoiceInternal.getCellCSSText(record);
                                ListGrid_InvoiceInternal.refreshRow(ListGrid_InvoiceInternal.getRowNum(record));
                            }

                    }

            }));

        }
    });
    var IButton_Windows_Close = isc.IButtonCancel.create({
            top: 260,
            title:"<spring:message code='global.close'/>",
            click : function () {
                newDocumentWindow.close();
            }
    });
    var windows_button_Layout = isc.HLayout.create({
    width: "100%",
    height: "100%",
    align :"center",
    membersMargin : 10,
    members: [
     IButton_Document_Save,
     IButton_Windows_Close
    ]
    });
    var newDocumentWindow = isc.Window.create({
		title: "<spring:message code='accounting.document.create'/>",
		width: 700,
		height: 400,
		// autoSize:true,
		autoCenter: true,
		isModal: true,
		showModalMask: true,
		align: "center",
		autoDraw: false,
		dismissOnEscape: true,
		showMinimizeButton: false,
		closeClick: function () {
			this.Super("closeClick", arguments)
		},
		items: [
		    documentMainInfoForm,windows_button_Layout
		]
	});

    function ListGrid_InvoiceInternal_refresh() {
        ListGrid_InvoiceInternal.invalidateCache();
        ListGrid_InvoiceInternal_Sent.invalidateCache();
    }
    function ListGrid_InvoiceInternal_Sent_refresh() {
        ListGrid_InvoiceInternal_Sent.invalidateCache();
    }
    function ToolStripButton_InvoiceInternal_Pdf_F() {

        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane;
        var record = grid.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            window.open("invoiceInternal/print/pdf/" + record.id);
        }
    }
    function createAccountingDoc(){

        if (invoiceInternalTabs.selectedTab === 1) {
            isc.say("<spring:message code='global.grid.tab.selected.sentDocument'/>")
            return;
        }

        documentMainInfoForm.clearValues();
         var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record == null) {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else  if (record.documentId == null){
            documentMainInfoForm.setValue("remittanceId",record.remittanceId);
            documentMainInfoForm.setValue("customerName",record.customerName);
            documentMainInfoForm.setValue("customerName",record.customerName);
            documentMainInfoForm.setValue("invoiceSerial",record.invoiceSerial);
            documentMainInfoForm.setValue("productName",record.productName);
            documentMainInfoForm.setValue("unitPrice",record.unitPrice);
            documentMainInfoForm.setValue("totalAmount",record.totalAmount);
            documentMainInfoForm.setValue("totalDeductions",record.totalDeductions);
            newDocumentWindow.show();
        }
        else  isc.say("<spring:message code='accounting.create.document.sent'/>");
    }
    function ToolStripButton_InvoiceInternal_Html_F() {

        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane;
        var record = grid.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            window.open("invoiceInternal/print/html/" + record.id);
        }
    }
    <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
     var ToolStripButton_AccountingDoc = isc.ToolStripButtonPrint.create({
            title: "<spring:message code='accounting.document.create'/>",
            icon: "icon/accountingDoc.png",
            click: function () {

                createAccountingDoc();
            }
        });
     </sec:authorize>
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
    function Menu_ListGrid_InvoiceInternal_Sent_Pdf_F() {

        var record = ListGrid_InvoiceInternal_Sent.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal_Sent.getSelectedRecord().id;
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
    function Menu_ListGrid_InvoiceInternal_Sent_Html_F() {
        var record = ListGrid_InvoiceInternal_Sent.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal_Sent.getSelectedRecord().id;
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
            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='accounting.document.create'/>",
                icon: "icon/accountingDoc.png",
                click: function () {
                    createAccountingDoc();
                }
            }
            </sec:authorize>
        ]
    });

    var Menu_ListGrid_InvoiceInternal_Sent = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_Sent_refresh();
                }
            },
            <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='global.form.print.pdf'/>",
                icon: "icon/pdf.png",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Sent_Pdf_F();
                }

            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('O_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='global.form.print.html'/>",
                icon: "icon/html.jpg",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Sent_Html_F();
                }
            },
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
                ToolStripButton_AccountingDoc,
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
    initialCriteria: {
    operator: 'and',
    criteria: [{
        fieldName: 'documentId',
        operator: 'isNull'
    }]
    },
    canMultiSort: true,
    initialSort: [
        {property: "invoiceDate", direction: "descending"},
        {property: "remittanceId", direction: "descending"},
        {property: "salesType", direction: "descending"},
    ],
    recordDoubleClick(record) {
        createAccountingDoc();
    },
    getCellCSSText:{},
    fields:
    [
    {name: "id", title: "<spring:message code='global.id'/>"},
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
    {name: "documentId", title: "<spring:message code='invoice.documentId'/>"},
    ],
    autoFetchData: true,
    allowFilterOperators: true
    });

    ListGrid_InvoiceInternal.getCellCSSText = function (record) {
         if(record.documentId)
            return "font-weight:bold; color:green;";
        else  if(record.documentId === -1)
            return "font-weight:bold; color:red;";
        else if(record.salesType === 2)
            return "font-weight:bold; color:#287fd6;";
    }

    var ListGrid_InvoiceInternal_Sent = isc.ListGrid.create({
    showFilterEditor: true,
    width: "100%",
    height: "100%",
    dataSource: RestDataSource_InvoiceInternal_Sent,
    contextMenu: Menu_ListGrid_InvoiceInternal_Sent,
    implicitCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'documentId',
            operator: 'notNull'
        },
        {
            fieldName: 'documentId',
            operator: 'notEqual',
            value : '0'
        }
        ]
    },
    canMultiSort: true,
    initialSort: [
        {property: "invoiceDate", direction: "descending"},
        {property: "remittanceId", direction: "descending"},
        {property: "salesType", direction: "descending"},
    ],
    getCellCSSText : function (record) {
        if(record.salesType === 2)
            return "font-weight:bold; color:#287fd6;";
    },
    fields:
    [
    {name: "id", title: "<spring:message code='global.id'/>"},
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
    {name: "documentId", title: "<spring:message code='invoice.documentId'/>"},
    ],
    autoFetchData: true,
    allowFilterOperators: true
    });

    var invoiceInternalTabs = isc.TabSet.create({
        width: "100%",
        height: "100%",
        showTabScroller: true,
        tabs: [
            {
                title: "<spring:message code='issuedInternalInvoices.dontSent'/>",
                pane: ListGrid_InvoiceInternal
            },
            {
                title: "<spring:message code='issuedInternalInvoices.sent'/>",
                pane: ListGrid_InvoiceInternal_Sent
            }
        ]
    });

    var HLayout_InvoiceInternal_Grid = isc.HLayout.create({
    width: "100%",
    height: "100%",
    members: [
            invoiceInternalTabs
    ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_InvoiceInternal_Actions, HLayout_InvoiceInternal_Grid
        ]
    });