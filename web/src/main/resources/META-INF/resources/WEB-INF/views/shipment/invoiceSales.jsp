<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>
    <% DateUtil dateUtil = new DateUtil();%>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />


    var RestDataSource_invoiceSales = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "serial",
                    title: "<spring:message code='invoiceSales.serial'/>",
                },
                {
                    name: "invoiceNo",
                    title: "<spring:message code='invoiceSales.invoiceNo'/>",
                },
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoiceSales.invoiceDate'/>",
                },
                {
                    name: "district",
                    title: "<spring:message code='invoiceSales.district'/>",
                },
                {
                    name: "customerId",
                    title: "<spring:message code='invoiceSales.customerId'/>",
                },
                {
                    name: "customerName",
                    title: "<spring:message code='invoiceSales.customerName'/>",
                },
                {
                    name: "salesTypeId",
                    title: "<spring:message code='invoiceSales.salesTypeId'/>",
                },
                {
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                },
                {
                    name: "currency",
                    title: "<spring:message code='invoiceSales.currency'/>",
                },
                {
                    name: "contaminationTaxesId",
                    title: "<spring:message code='invoiceSales.contaminationTaxesId'/>",
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
                },
                {
                    name: "paymentTypeId",
                    title: "<spring:message code='invoiceSales.paymentTypeId'/>",
                },
                {
                    name: "paymentTypeName",
                    title: "<spring:message code='invoiceSales.paymentTypeName'/>",
                },
                {
                    name: "lcNoId",
                    title: "<spring:message code='invoiceSales.lcNoId'/>",
                },
                {
                    name: "lcNoName",
                    title: "<spring:message code='invoiceSales.lcNoName'/>",
                },
                {
                    name: "preInvoiceId",
                    title: "<spring:message code='invoiceSales.preInvoiceId'/>",
                },
                {
                    name: "preInvoiceDate",
                    title: "<spring:message code='invoiceSales.preInvoiceDate'/>",
                },
                {
                    name: "issueId",
                    title: "<spring:message code='invoiceSales.issueId'/>",
                },
                {
                    name: "issueDate",
                    title: "<spring:message code='invoiceSales.issueDate'/>",
                },
                {
                    name: "openingBankId",
                    title: "<spring:message code='invoiceSales.openingBankId'/>",
                },
                {
                    name: "openingDate",
                    title: "<spring:message code='invoiceSales.openingDate'/>",
                },
                {
                    name: "dealerBankId",
                    title: "<spring:message code='invoiceSales.dealerBankId'/>",
                },
                {
                    name: "dealerBankName",
                    title: "<spring:message code='invoiceSales.dealerBankName'/>",
                },
                {
                    name: "otherDescription",
                    title: "<spring:message code='invoiceSales.otherDescription'/>",
                },
                {
                    name: "firstContractNo",
                    title: "<spring:message code='invoiceSales.firstContractNo'/>",
                },
                {
                    name: "secondContractNo",
                    title: "<spring:message code='invoiceSales.secondContractNo'/>",
                },
                {
                    name: "secondContractName",
                    title: "<spring:message code='invoiceSales.secondContractName'/>",
                },

            ],
            fetchDataURL: "${contextPath}/api/invoiceSales/spec-list"
        });

 var RestDataSource_nosa_IN_invoiceSales = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    <%--title: "<spring:message code='invoiceSales.secondContractName'/>"--%>
                },
                {
                    name: "detailName",
                    <%--title: "<spring:message code='invoiceSales.secondContractName'/>"--%>
                },
                {
                    name: "childrenDigitCount",
                    <%--title: "<spring:message code='invoiceSales.secondContractName'/>"--%>
                },
                {
                    name: "code",
                    <%--title: "<spring:message code='invoiceSales.secondContractName'/>"--%>
                }
            ],
            fetchDataURL: "${contextPath}/api/invoiceNosaSales/list"
        });


    function ListGrid_InvoiceSales_refresh() {
        ListGrid_invoiceSales.invalidateCache();
    }

    function ListGrid_InvoiceSales_edit() {

        var record = ListGrid_invoiceSales.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            DynamicForm_invoiceSales.clearValues();
            DynamicForm_invoiceSales.editRecord(record);
            Window_invoiceSales.show();
        }
    }

    function ListGrid_InvoiceSales_remove() {

        var record = ListGrid_invoiceSales.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [
                        isc.IButtonSave.create(
                            {
                                title: "<spring:message code='global.yes'/>"
                            }),
                        isc.IButtonCancel.create(
                            {
                                title: "<spring:message code='global.no'/>"
                            })
                    ],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var invoiceSalesId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/invoiceSales/" + invoiceSalesId,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_InvoiceSales_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }


    var Menu_ListGrid_InvoiceSales = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_InvoiceSales_refresh();
                    }
                },
                <%--<sec:authorize access="hasAuthority('C_INVOICE_SALES')">--%>
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_invoiceSales.clearValues();
                        Window_invoiceSales.show();
                    }
                },
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('U_INVOICE_SALES')">--%>
                {
                    title: "<spring:message code='global.form.edit'/>",
                    icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_InvoiceSales_edit();
                    }
                },
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('D_INVOICE_SALES')">--%>
                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_InvoiceSales_remove();
                    }
                }
                <%--</sec:authorize>--%>
            ]
        });

    var DynamicForm_invoiceSales = isc.DynamicForm.create(
        {
            width: 700,
            height: 100,
            setMethod: 'POST',
            align: "center",
            canSubmit: true,
            showInlineErrors: true,
            showErrorText: true,
            showErrorStyle: true,
            errorOrientation: "right",
            titleWidth: "100",
            titleAlign: "right",
            requiredMessage: "<spring:message code='validator.field.is.required'/>",
            numCols: 4,
            fields: [
                {
                    name: "id",
                    hidden: true
                },
                {
                   type: "RowSpacerItem"
                },
                {
                    name: "serial",
                    title: "<spring:message code='invoiceSales.serial'/>",
                    // width: 500,
                    // colSpan: 3
                },
                {
                    name: "invoiceNo",
                    title: "<spring:message code='invoiceSales.invoiceNo'/>",
                    // width: 500,
                    // colSpan: 3
                },
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoiceSales.invoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: "date",
                    format: 'DD-MM-YYYY',
                },
                {
                    name: "district",
                    title: "<spring:message code='invoiceSales.district'/>",
                },
                {
                    name: "customerId",
                    title: "<spring:message code='invoiceSales.customerId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("customerId")).getSelectedRecord().detailName;
                        (form.getItem("customerName")).setValue(detName);
                    }
                    else
                        (form.getItem("customerName")).setValue("");
                    },
                },
                {
                    name: "customerName",
                    title: "<spring:message code='invoiceSales.customerName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "salesTypeId",
                    title: "<spring:message code='invoiceSales.salesTypeId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("salesTypeId")).getSelectedRecord().detailName;
                        (form.getItem("salesTypeName")).setValue(detName);
                    }
                    else
                        (form.getItem("salesTypeName")).setValue("");
                    },
                },
                {
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "currency",
                    title: "<spring:message code='invoiceSales.currency'/>",
                    colSpan: 4
                },
                {
                    name: "contaminationTaxesId",
                    title: "<spring:message code='invoiceSales.contaminationTaxesId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("contaminationTaxesId")).getSelectedRecord().detailName;
                        (form.getItem("contaminationTaxesName")).setValue(detName);
                    }
                    else
                        (form.getItem("contaminationTaxesName")).setValue("");
                    },
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "paymentTypeId",
                    title: "<spring:message code='invoiceSales.paymentTypeId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("paymentTypeId")).getSelectedRecord().detailName;
                        (form.getItem("paymentTypeName")).setValue(detName);
                    }
                    else
                        (form.getItem("paymentTypeName")).setValue("");
                    },
                },
                {
                    name: "paymentTypeName",
                    title: "<spring:message code='invoiceSales.paymentTypeName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "lcNoId",
                    title: "<spring:message code='invoiceSales.lcNoId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("lcNoId")).getSelectedRecord().detailName;
                        (form.getItem("lcNoName")).setValue(detName);
                    }
                    else
                        (form.getItem("lcNoName")).setValue("");
                    },
                },
                {
                    name: "lcNoName",
                    title: "<spring:message code='invoiceSales.lcNoName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "preInvoiceId",
                    title: "<spring:message code='invoiceSales.preInvoiceId'/>",
                },
                {
                    name: "preInvoiceDate",
                    title: "<spring:message code='invoiceSales.preInvoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: "date",
                    format: 'DD-MM-YYYY',
                },
                {
                    name: "issueId",
                    title: "<spring:message code='invoiceSales.issueId'/>",
                },
                {
                    name: "issueDate",
                    title: "<spring:message code='invoiceSales.issueDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: "date",
                    format: 'DD-MM-YYYY',
                },
                {
                    name: "openingBankId",
                    title: "<spring:message code='invoiceSales.openingBankId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                },
                {
                    name: "openingDate",
                    title: "<spring:message code='invoiceSales.openingDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: "date",
                    format: 'DD-MM-YYYY',
                },
                {
                    name: "dealerBankId",
                    title: "<spring:message code='invoiceSales.dealerBankId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("dealerBankId")).getSelectedRecord().detailName;
                        (form.getItem("dealerBankName")).setValue(detName);
                    }
                    else
                        (form.getItem("dealerBankName")).setValue("");
                    },
                },
                {
                    name: "dealerBankName",
                    title: "<spring:message code='invoiceSales.dealerBankName'/>",
                    type: "staticText",
                    Value : ""
                },
                {
                    name: "otherDescription",
                    title: "<spring:message code='invoiceSales.otherDescription'/>",
                    width: 570,
                    colSpan: 4
                },
                {
                    name: "firstContractNo",
                    title: "<spring:message code='invoiceSales.firstContractNo'/>",
                    colSpan: 4
                },
                {
                    name: "secondContractNo",
                    title: "<spring:message code='invoiceSales.secondContractNo'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    <%--cachePickListResults: false,--%>
                    <%--pickListProperties: {--%>
                        <%--showFilterEditor: true--%>
                    <%--},--%>
                    <%--pickListFields: [--%>
                    <%--{--%>
                        <%--name: "detailName",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--},--%>
                    <%--{--%>
                        <%--name: "code",--%>
                        <%--&lt;%&ndash;title: "<spring:message code='invoiceSales.secondContractName'/>"&ndash;%&gt;--%>
                    <%--}--%>
                    <%--],--%>
                    changed: function (form, item, value) {

                    if (value != null && value != 'undefined') {
                        var detName =(form.getItem("secondContractNo")).getSelectedRecord().detailName;
                        (form.getItem("secondContractName")).setValue(detName);
                    }
                    else
                        (form.getItem("secondContractName")).setValue("");
                    },
                },
                {
                    name: "secondContractName",
                    title: "<spring:message code='invoiceSales.secondContractName'/>",
                    type: "staticText",
                    Value : ""
                },

            ]
        });

     var ToolStripButton_InvoiceSales_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceSales_refresh();
        }
    });

    <%--<sec:authorize access="hasAuthority('C_INVOICE_SALES')">--%>
    var ToolStripButton_InvoiceSales_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_invoiceSales.clearValues();
            Window_invoiceSales.show();
        }
    });
    <%--</sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('U_INVOICE_SALES')">--%>
    var ToolStripButton_InvoiceSales_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_InvoiceSales_edit();
        }
    });
    <%--</sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('D_INVOICE_SALES')">--%>
    var ToolStripButton_InvoiceSales_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_InvoiceSales_remove();
        }
    });
    <%--</sec:authorize>--%>

    var ToolStrip_Actions_InvoiceSales = isc.ToolStrip.create(
        {
            width: "100%",
            members: [
                <%--<sec:authorize access="hasAuthority('C_INVOICE_SALES')">--%>
                ToolStripButton_InvoiceSales_Add,
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('U_INVOICE_SALES')">--%>
                ToolStripButton_InvoiceSales_Edit,
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('D_INVOICE_SALES')">--%>
                ToolStripButton_InvoiceSales_Remove,
                <%--</sec:authorize>--%>

                isc.ToolStrip.create(
                    {
                        width: "100%",
                        align: "left",
                        border: '0px',
                        members: [
                            ToolStripButton_InvoiceSales_Refresh,
                        ]
                    })

            ]
        });

    var HLayout_InvoiceSales_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_InvoiceSales
            ]
    });

    var IButton_invoiceSales_Save = isc.IButtonSave.create(
        {
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_invoiceSales.validate();
                if (DynamicForm_invoiceSales.hasErrors())
                    return;

                var data = DynamicForm_invoiceSales.getValues();
                var method = "PUT";
                if (data.id == null)
                    method = "POST";

                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/invoiceSales/",
                        httpMethod: method,
                        data: JSON.stringify(data),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_InvoiceSales_refresh();
                                Window_invoiceSales.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var Window_invoiceSales = isc.Window.create(
        {
            title: "<spring:message code='invoiceSales.title'/> ",
            width: 700,
            autoSize: true,
            autoCenter: true,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: false,
            dismissOnEscape: true,
            closeClick: function () {
                this.Super("closeClick", arguments)
            },
            items: [
                DynamicForm_invoiceSales,
                isc.HLayout.create(
                    {
                        margin: '10px',
                        padding: 10,
                        layoutMargin: 10,
                        membersMargin: 5,
                        align: "center",
                        width: "100%",
                        members: [
                            IButton_invoiceSales_Save,
                            isc.Label.create(
                                {
                                    width: 5,
                                }),
                            isc.IButtonCancel.create(
                                {
                                    ID: "invoiceSalesEditExitIButton",
                                    title: "<spring:message code='global.cancel'/>",
                                    width: 100,
                                    icon: "pieces/16/icon_delete.png",
                                    orientation: "vertical",
                                    click: function () {
                                        Window_invoiceSales.close();
                                    }
                                })
                        ]
                    })
            ]
        });


    var ListGrid_invoiceSales = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_invoiceSales,
            contextMenu: Menu_ListGrid_InvoiceSales,
            autoFetchData: true,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "serial",
                    title: "<spring:message code='invoiceSales.serial'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "invoiceNo",
                    title: "<spring:message code='invoiceSales.invoiceNo'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoiceSales.invoiceDate'/>",
                    width: "10%",
                    align: "center",
                    dateFormatter: true
                },
                {
                    name: "district",
                    title: "<spring:message code='invoiceSales.district'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "customerId",
                    title: "<spring:message code='invoiceSales.customerId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "customerName",
                    title: "<spring:message code='invoiceSales.customerName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "salesTypeId",
                    title: "<spring:message code='invoiceSales.salesTypeId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "currency",
                    title: "<spring:message code='invoiceSales.currency'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "contaminationTaxesId",
                    title: "<spring:message code='invoiceSales.contaminationTaxesId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "paymentTypeId",
                    title: "<spring:message code='invoiceSales.paymentTypeId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "paymentTypeName",
                    title: "<spring:message code='invoiceSales.paymentTypeName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "lcNoId",
                    title: "<spring:message code='invoiceSales.lcNoId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "lcNoName",
                    title: "<spring:message code='invoiceSales.lcNoName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "preInvoiceId",
                    title: "<spring:message code='invoiceSales.preInvoiceId'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "preInvoiceDate",
                    title: "<spring:message code='invoiceSales.preInvoiceDate'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "issueId",
                    title: "<spring:message code='invoiceSales.issueId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "issueDate",
                    title: "<spring:message code='invoiceSales.issueDate'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "openingBankId",
                    title: "<spring:message code='invoiceSales.openingBankId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "openingDate",
                    title: "<spring:message code='invoiceSales.openingDate'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "dealerBankId",
                    title: "<spring:message code='invoiceSales.dealerBankId'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "dealerBankName",
                    title: "<spring:message code='invoiceSales.dealerBankName'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "otherDescription",
                    title: "<spring:message code='invoiceSales.otherDescription'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "firstContractNo",
                    title: "<spring:message code='invoiceSales.firstContractNo'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "secondContractNo",
                    title: "<spring:message code='invoiceSales.secondContractNo'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                },
                {
                    name: "secondContractName",
                    title: "<spring:message code='invoiceSales.secondContractName'/>",
                    width: "10%",
                    align: "center",
                    showIf: "false"
                }
            ],
        });


    var HLayout_invoiceSales_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [

            ListGrid_invoiceSales
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [

            HLayout_InvoiceSales_Actions,
            HLayout_invoiceSales_Grid
        ]
    });