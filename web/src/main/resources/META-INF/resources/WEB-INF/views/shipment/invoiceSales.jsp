<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var today = new Date();
    var year = today.getFullYear();
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
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
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

    var RestDataSource_invoiceSalesItem = isc.MyRestDataSource.create(
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
                    name: "productCode",
                    title: "<spring:message code='invoiceSalesItem.productCode'/>",
                },
                {
                    name: "productName",
                    title: "<spring:message code='invoiceSalesItem.productName'/>",
                },
                {
                    name: "unitName",
                    title: "<spring:message code='invoiceSalesItem.unitName'/>",
                },
                {
                    name: "netAmount",
                    title: "<spring:message code='invoiceSalesItem.netAmount'/>",
                },
                {
                    name: "orderAmount",
                    title: "<spring:message code='invoiceSalesItem.orderAmount'/>",
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoiceSalesItem.unitPrice'/>",
                },
                {
                    name: "linePrice",
                    title: "<spring:message code='invoiceSalesItem.linePrice'/>",
                },
                {
                    name: "discount",
                    title: "<spring:message code='invoiceSalesItem.discount'/>",
                },
                {
                    name: "linePriceAfterDiscount",
                    title: "<spring:message code='invoiceSalesItem.linePriceAfterDiscount'/>",
                },
                {
                    name: "legalFees",
                    title: "<spring:message code='invoiceSalesItem.legalFees'/>",
                },
                {
                    name: "vat",
                    title: "<spring:message code='invoiceSalesItem.vat'/>",
                },
                {
                    name: "totalPrice",
                    title: "<spring:message code='invoiceSalesItem.totalPrice'/>",
                },
                {
                    name: "notes",
                    title: "<spring:message code='invoiceSalesItem.notes'/>",
                },
                {
                    name: "explain",
                    title: "<spring:message code='invoiceSalesItem.explain'/>",
                },
                {
                    name: "invoiceSalesId"
                }
            ],
            fetchDataURL: "${contextPath}/api/invoiceSalesItem/spec-list"
        });

    var RestDataSource_nosa_IN_invoiceSales = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id"
                },
                {
                    name: "detailName"
                },
                {
                    name: "childrenDigitCount"
                },
                {
                    name: "code"
                }
            ],
            fetchDataURL: "${contextPath}/api/invoiceNosaSales/spec-list"
        });

        var RestDataSource_accDepartment = isc.MyRestDataSource.create(
            {
                fields: [
                    {
                        name: "id"
                    },
                    {
                        name: "departmentCode"
                    },
                    {
                        name: "departmentName"
                    },
                    {
                        name: "departmentNameLatin"
                    }
                ],
                fetchDataURL: "${contextPath}/api/accDepartment/spec-list"
        });

    var RestDataSource_salesType = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id"
                },
                {
                    name: "salesType"
                }
            ],
            fetchDataURL: "${contextPath}/api/salesType/spec-list"
        });

 var RestDataSource_paymentType = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id"
                },
                {
                    name: "code"
                },
                {
                    name: "paymentType"
                },
                {
                    name: "nonCash"
                }
            ],
            fetchDataURL: "${contextPath}/api/paymentType/spec-list"
        });

 var RestDataSource_percentPerYear = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id"
                },
                {
                    name: "year"
                },
                {
                    name: "cVat"
                },
                {
                    name: "tVat"
                }
            ],
            fetchDataURL: "${contextPath}/api/percentPerYear/spec-list"
        });

 var RestDataSource_Unit_IN_invoiceSales = isc.MyRestDataSource.create(
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
                    name: "nameFA",
                    title: "<spring:message code='MaterialFeature.unit.FA'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='unit.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='unit.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/unit/spec-list"
        });

 var RestDataSource_MaterialItem_IN_invoiceSales = isc.MyRestDataSource.create(
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
                    name: "gdsCode",
                    title: "<spring:message code='MaterialItem.gdsCode'/> "
                },
                {
                    name: "gdsName",
                    title: "<spring:message code='MaterialItem.gdsName'/> "
                },
                {
                    name: "materialId",
                    hidden: true
                },
                ],
            fetchDataURL: "${contextPath}/api/materialItem/spec-list"
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
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.not.selected'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.message'/>",
            buttons: [
                isc.Button.create({
                    title: "<spring:message code='global.ok'/>",
                }),
            ],
            buttonClick: function () {
                this.hide();
            },
        });
    } else {
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.remove.ask'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.grid.record.remove.ask.title'/>",
            buttons: [
                isc.IButtonSave.create({
                    title: "<spring:message code='global.yes'/>",
                }),
                isc.IButtonCancel.create({
                    title: "<spring:message code='global.no'/>",
                }),
            ],
            buttonClick: function (button, index) {
                this.hide();
                if (index == 0) {
                    var invoiceSalesId = record.id;
                    isc.RPCManager.sendRequest(
                        Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/invoiceSales/" + invoiceSalesId,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    ListGrid_InvoiceSales_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            },
                        })
                    );
                }
            },
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

    var optionCriteria__Customer = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "code", operator: "iStartsWith", value: "0"}]
    };

    var optionCriteria__LetterCredit = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "code", operator: "iStartsWith", value: "107"}]
    };

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
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                },
                {
                    name: "invoiceNo",
                    title: "<spring:message code='invoiceSales.invoiceNo'/>",
                    canEdit: false,
                    type: "staticText"
                },
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoiceSales.invoiceDate'/>",
                    ID: "invoiceDateId",
                    type: 'text',
                    required: true ,
                    icons: [{
                        src: "pieces/pcal.png",
                        click: function () {
                            displayDatePicker('invoiceDateId', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/06/01"
                },
                {
                    name: "district",
                    title: "<spring:message code='invoiceSales.district'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_accDepartment,
                    displayField: "departmentName",
                    valueField: "departmentName",
                    required: true ,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                        {
                            name: "departmentCode",
                            title: "<spring:message code='invoiceSales.districtCode'/>"
                        },
                        {
                            name: "departmentName",
                            title: "<spring:message code='invoiceSales.districtName'/>"
                        }
                    ],
                },
                {
                    name: "customerId",
                    title: "<spring:message code='invoiceSales.customerId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    optionCriteria: optionCriteria__Customer,
                    displayField: "code",
                    valueField: "id",
                    required: true ,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                    {
                        name: "detailName",
                        title: "<spring:message code='invoiceSales.detailCode'/>",
                        showHover: true
                    },
                    {
                        name: "code",
                        title: "<spring:message code='invoiceSales.code'/>",
                        showHover: true
                    },
                    ],
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
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_salesType,
                    displayField: "salesType",
                    valueField: "salesType",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListFields: [
                    {
                        name: "id",
                        hidden: true
                    },
                    {
                        name: "salesType",
                        title: "<spring:message code='invoiceSales.salesTypeName'/>"
                    }
                    ],
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    valueMap:
                        {
                            "ندارد" : "ندارد",
                            "دارد" : "دارد"
                        },
                    colSpan: 4
                },
                {
                    name: "paymentTypeName",
                    title: "<spring:message code='invoiceSales.paymentType'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_paymentType,
                    displayField: "paymentType",
                    valueField: "paymentType",
                    colSpan: 4,
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                    {
                        name: "id",
                        hidden: true
                    },
                    {
                        name: "code",
                        title: "<spring:message code='invoiceSales.paymentCode'/>"
                    },
                    {
                        name: "paymentType",
                        title: "<spring:message code='invoiceSales.paymentTypeName'/>",
                        showHover: true
                    },
                    {
                        name: "nonCash",
                        title: "<spring:message code='invoiceSales.paymentNonCash'/>",
                        valueMap:
                        {
                            true : "بلی",
                            false : "<spring:message code='global.no'/>",
                        },
                    }
                    ],
                },
                {
                    name: "lcNoId",
                    title: "<spring:message code='invoiceSales.lcNoId'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    optionCriteria: optionCriteria__LetterCredit,
                    displayField: "code",
                    valueField: "id",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    autoFetchData: false,
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                    {
                        name: "detailName",
                        title: "<spring:message code='invoiceSales.detailCode'/>"
                    },
                    {
                        name: "code",
                        title: "<spring:message code='invoiceSales.code'/>"
                    }
                    ],
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
                    keyPressFilter: "[0-9.]"
                },
                {
                    name: "preInvoiceDate",
                    title: "<spring:message code='invoiceSales.preInvoiceDate'/>",
                    ID: "preInvoiceDateId",
                    type: 'text',
                    icons: [{
                        src: "pieces/pcal.png",
                        click: function () {
                            displayDatePicker('preInvoiceDateId', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/06/01"
                },
                {
                    name: "issueId",
                    title: "<spring:message code='invoiceSales.issueId'/>",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    keyPressFilter: "[0-9.]"
                },
                {
                    name: "issueDate",
                    title: "<spring:message code='invoiceSales.issueDate'/>",
                    ID: "issueDateId",
                    type: 'text',
                    required: true,
                    icons: [{
                        src: "pieces/pcal.png",
                        click: function () {
                            displayDatePicker('issueDateId', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/06/01"
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
                    colSpan: 4 ,
                    keyPressFilter: "[0-9.]"
                },
                {
                    name: "secondContractNo",
                    title: "<spring:message code='invoiceSales.secondContractNo'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_nosa_IN_invoiceSales,
                    displayField: "code",
                    valueField: "id",
                    autoFetchData: false,
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                    {
                        name: "detailName",
                        title: "<spring:message code='invoiceSales.detailCode'/>"
                    },
                    {
                        name: "code",
                        title: "<spring:message code='invoiceSales.code'/>"
                    }
                    ],
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

    var recordNotFound = isc.Label.create({
        height: 30,
        padding: 10,
        align: "center",
        valign: "center",
        wrap: false,
        contents: "<spring:message code='global.record.find'/>"
    });

    recordNotFound.hide();

    var ListGrid_invoiceSales = isc.ListGrid.create(
        {
            showFilterEditor: true,
            canAutoFitFields: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_invoiceSales,
            contextMenu: Menu_ListGrid_InvoiceSales,
            autoFetchData: true,
            styleName: 'expandList',
            alternateRecordStyles: true,
            canExpandRecords: true,
            canExpandMultipleRecords: false,
            wrapCells: false,
            showRollOver: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            autoFitExpandField: true,
            virtualScrolling: true,
            loadOnExpand: true,
            loaded: false,
            sortField: 2,
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
                    name: "salesTypeName",
                    title: "<spring:message code='invoiceSales.salesTypeName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "contaminationTaxesName",
                    title: "<spring:message code='invoiceSales.contaminationTaxesName'/>",
                    width: "10%",
                    align: "center",
                },
                {
                    name: "paymentTypeName",
                    title: "<spring:message code='invoiceSales.paymentType'/>",
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
            getExpansionComponent: function (record) {
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "invoiceSalesId", operator: "equals", value: record.id}]
            };

            ListGrid_InvoiceSalesItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                if (data.length == 0) {
                    recordNotFound.show();
                    ListGrid_InvoiceSalesItem.hide()
                } else {
                    recordNotFound.hide();
                    ListGrid_InvoiceSalesItem.setData(data);
                    ListGrid_InvoiceSalesItem.setAutoFitMaxRecords(1);
                    ListGrid_InvoiceSalesItem.show();
                }
            }, {operationId: "00"});


            var hLayout = isc.HLayout.create({
                align: "center", padding: 5,
                membersMargin: 20,
                members: [
                    <%--<sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">--%>
                    ToolStripButton_InvoiceSalesItem_Add ,
                    <%--</sec:authorize>--%>
                    //TODO ADD authorize !important
                    ToolStripButton_InvoiceSales_Pdf
                ]
            });

            var layoutInvoiceSales = isc.VLayout.create({
                styleName: "expand-layout",
                padding: 5,
                membersMargin: 10,
                members: [
                    ListGrid_InvoiceSalesItem,
                    recordNotFound,
                    hLayout
                ]
            });

            return layoutInvoiceSales;
        }
    });

    var HLayout_InvoiceSales_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [

            ListGrid_invoiceSales
        ]
    });

    var VLayout_InvoiceSales_Body = isc.VLayout.create({
        width: "100%",
        height: "99%",
        members: [
            HLayout_InvoiceSales_Actions,
            HLayout_InvoiceSales_Grid
        ]
    });

    function ListGrid_InvoiceSalesItem_refresh() {
        ListGrid_InvoiceSalesItem.invalidateCache();
        var record = ListGrid_invoiceSales.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "invoiceSalesId", operator: "equals", value: record.id}]
        };
        ListGrid_InvoiceSalesItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_InvoiceSalesItem.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_InvoiceSalesItem_edit() {
        var record = ListGrid_InvoiceSalesItem.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            DynamicForm_InvoiceSalesItem.editRecord(record);
            Window_InvoiceSalesItem.show();
        }
    }

    function ListGrid_InvoiceSalesItem_remove() {

        var record = ListGrid_InvoiceSalesItem.getSelectedRecord();

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
                    buttons: [isc.IButtonSave.create(
                        {
                            title: "<spring:message code='global.yes'/>"
                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code = 'global.no' /> "

                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var InvoiceSalesItemId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/invoiceSalesItem/" + InvoiceSalesItemId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_InvoiceSalesItem_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    },

                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_InvoiceSalesItem = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceSalesItem_refresh();
                }
            },
            <%--<sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">--%>
            {
                title: "<spring:message code='global.form.new'/>",
                icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_InvoiceSalesItem.clearValues();
                    Window_InvoiceSalesItem.show();
                }
            },
            <%--</sec:authorize>--%>

            <%--<sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">--%>
            {
                title: "<spring:message code='global.form.edit'/>",
                icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_InvoiceSalesItem_edit();
                }
            },
            <%--</sec:authorize>--%>

            <%--<sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">--%>
            {
                title: "<spring:message code='global.form.remove'/>",
                icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_InvoiceSalesItem_remove();
                }
            }
            <%--</sec:authorize>--%>
        ]
    });

    var DynamicForm_InvoiceSalesItem = isc.DynamicForm.create({
        width: 700,
        height: "100%",
        titleWidth: "100",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [
                {
                    name: "id",
                    hidden: true,
                },
                {
                    type: "RowSpacerItem"
                },
                {
                    name: "productCode",
                    title: "<spring:message code='invoiceSalesItem.productCode'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_MaterialItem_IN_invoiceSales,
                    displayField: "gdsName",
                    valueField: "id",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListFields: [
                    {
                        name: "gdsCode"
                    },
                    {
                        name: "gdsName"
                    }
                    ],
                    changed: function (form, item, value) {
                        var prodRecord = DynamicForm_InvoiceSalesItem.getItem("productCode").getSelectedRecord()
                        DynamicForm_InvoiceSalesItem.getItem("productName").setValue(prodRecord.gdsName);
                    }
                },
                {
                    name: "productName",
                    title: "<spring:message code='invoiceSalesItem.productName'/>",
                    type: "staticText"
                },
                {
                    name: "unitName",
                    title: "<spring:message code='invoiceSalesItem.unitName'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit_IN_invoiceSales,
                    displayField: "nameFA",
                    valueField: "nameFA",
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListFields: [
                    {
                        name: "nameFA"
                    },
                    {
                        name: "nameEN"
                    }
                    ]
                },
                {
                    name: "orderAmount",
                    title: "<spring:message code='invoiceSalesItem.orderAmount'/>",
                    required: true,
                    length: "12",
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "isInteger",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "netAmount",
                    title: "<spring:message code='invoiceSalesItem.netAmount'/>",
                    required: true,
                    length: "12",
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "isInteger",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed: function (form, item, value) {
                        updatePrice();
                    }
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoiceSalesItem.unitPrice'/>",
                    required: true,
                    length: "12",
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "isInteger",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed: function () {
                        updatePrice();
                    },
                },
                {
                    name: "linePrice",
                    title: "<spring:message code='invoiceSalesItem.linePrice'/>",
                    type: "staticText"
                },
                {
                    name: "discount",
                    title: "<spring:message code='invoiceSalesItem.discount'/>",
                    defaultValue: 0,
                    showIf: "false",
                    validators: [{
                        type: "isInteger",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed: function(){
                        updatePrice();
                    }
                },
                {
                    name: "linePriceAfterDiscount",
                    title: "<spring:message code='invoiceSalesItem.linePriceAfterDiscount'/>",
                    colSpan: 4,
                    type: "staticText"
                },
                {
                    name: "legalFees",
                    title: "<spring:message code='invoiceSalesItem.legalFees'/>",
                    type: "staticText"
                },
                {
                    name: "vat",
                    title: "<spring:message code='invoiceSalesItem.vat'/>",
                    type: "staticText"
                },
                {
                    name: "totalPrice",
                    title: "<spring:message code='invoiceSalesItem.totalPrice'/>",
                    type: "staticText"
                },
                {
                    name: "notes",
                    title: "<spring:message code='invoiceSalesItem.notes'/>",
                },
                {
                    name: "explain",
                    title: "<spring:message code='invoiceSalesItem.explain'/>",
                },
                {
                    name: "invoiceSalesId",
                    type: "long",
                    hidden: true
                },
                {
                    type: "RowSpacerItem"
                }
            ]
    });

    var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "year", operator: "equals", value: year}]
    };

    RestDataSource_percentPerYear.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        legTotal = data[0].cvat;
        vatTotal = data[0].tvat;
    });

    function updatePrice(){
        var net =(DynamicForm_InvoiceSalesItem.getItem("netAmount")).getValue();
        var unit =(DynamicForm_InvoiceSalesItem.getItem("unitPrice")).getValue();
        DynamicForm_InvoiceSalesItem.getItem("linePrice").setValue(net * unit);

        var line = DynamicForm_InvoiceSalesItem.getItem("linePrice").getValue();
        var disc = DynamicForm_InvoiceSalesItem.getItem("discount").getValue();
        var lineAfterDisc = line - disc;
        DynamicForm_InvoiceSalesItem.getItem("linePriceAfterDiscount").setValue(lineAfterDisc);

        DynamicForm_InvoiceSalesItem.getItem("legalFees").setValue( line*legTotal );
        DynamicForm_InvoiceSalesItem.getItem("vat").setValue( line* vatTotal);

        DynamicForm_InvoiceSalesItem.getItem("totalPrice").setValue(
            lineAfterDisc+DynamicForm_InvoiceSalesItem.getItem("legalFees").getValue()+
            DynamicForm_InvoiceSalesItem.getItem("vat").getValue()
        );
    }

    var ToolStripButton_InvoiceSalesItem_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceSalesItem_refresh();
        }
    });

    <%--<sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">--%>
    var ToolStripButton_InvoiceSalesItem_Add = isc.ToolStripButtonAddLarge.create({
        title: "<spring:message code='global.form.new.subInvoice'/>",
        click: function () {
            var record = ListGrid_invoiceSales.getSelectedRecord();

            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else {
                DynamicForm_InvoiceSalesItem.clearValues();
                DynamicForm_InvoiceSalesItem.setValue("invoiceSalesId", record.id);
                Window_InvoiceSalesItem.show();
            }
        }
    });
    <%--</sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">--%>
    var ToolStripButton_InvoiceSalesItem_Edit = isc.ToolStripButtonEdit.create({
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_InvoiceSalesItem.clearValues();
            ListGrid_InvoiceSalesItem_edit();
        }
    });
    <%--</sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">--%>
    var ToolStripButton_InvoiceSalesItem_Remove = isc.ToolStripButtonRemove.create({
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_InvoiceSalesItem_remove();
        }
    });
    <%--</sec:authorize>--%>


    function ToolStripButton_InvoiceSales_Pdf_F() {
        ListGrid_InvoiceSalesItem.selectAllRecords();
        var itemsLength = ListGrid_InvoiceSalesItem.getSelectionLength();
        ListGrid_InvoiceSalesItem.deselectAllRecords();
        if (itemsLength > 0 ) {
            var rowId = ListGrid_invoiceSales.getSelectedRecord().id;
            window.open("invoiceSales/print/pdf/" + rowId);
        } else {
            isc.say("<spring:message code='invoiceSales.report.record'/>");
        }
    }

    var ToolStripButton_InvoiceSales_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='invoiceSales.report.jasper.pdf'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceSales_Pdf_F();
        }
    });

    var ToolStrip_Actions_InvoiceSalesItem = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <%--<sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">--%>
                ToolStripButton_InvoiceSalesItem_Add,
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">--%>
                ToolStripButton_InvoiceSalesItem_Edit,
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">--%>
                ToolStripButton_InvoiceSalesItem_Remove,
                <%--</sec:authorize>--%>
                ToolStripButton_InvoiceSales_Pdf,

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_InvoiceSalesItem_Refresh,
                    ]
                })

            ]
    });

    var HLayout_InvoiceSalesItem_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_InvoiceSalesItem
]
    });

    function setCriteria_ListGrid(recordId) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "invoiceSalesId", operator: "equals", value: recordId}]
        };

        ListGrid_InvoiceSalesItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_InvoiceSalesItem.setData(data);
            ListGrid_InvoiceSalesItem.show();
        }, {operationId: "00"});
    }

    var IButton_InvoiceSalesItem_Save = isc.IButtonSave.create(
        {
            top: 260,
            layoutMargin: 5,
            membersMargin: 5,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_InvoiceSalesItem.validate();
                if (DynamicForm_InvoiceSalesItem.hasErrors())
                    return;

                var data = DynamicForm_InvoiceSalesItem.getValues();
                data.invoiceSalesId = ListGrid_invoiceSales.getSelectedRecord().id;
                var methodXXXX = "PUT";
                if (data.id == null) methodXXXX = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/invoiceSalesItem/",
                        httpMethod: methodXXXX,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_InvoiceSalesItem.invalidateCache();
                                setCriteria_ListGrid(data.invoiceSalesId);
                                Window_InvoiceSalesItem.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        },

                    }));
            }
        });

    var InvoiceSalesItemCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_InvoiceSalesItem.close();
        }
    });

    var HLayout_InvoiceSalesItem_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 15,
        width: "100%",
        height: "100%",
        align: "center",
        members: [
            IButton_InvoiceSalesItem_Save,
            InvoiceSalesItemCancelBtn
        ]
    });

    var Window_InvoiceSalesItem = isc.Window.create({
        title: "<spring:message code='invoiceSalesItem.title'/> ",
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
        items:
            [
                DynamicForm_InvoiceSalesItem,
                HLayout_InvoiceSalesItem_IButton
            ]
    });

    var ListGrid_InvoiceSalesItem = isc.ListGrid.create(
        {
            showFilterEditor: true,
            canAutoFitFields: true,
            width: "100%",
            styleName: "listgrid-child",
            height: 180,
            dataSource: RestDataSource_invoiceSalesItem,
            contextMenu: Menu_ListGrid_InvoiceSalesItem,
            setAutoFitExtraRecords: true,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            // numCols: 2,
            fields: [
                {
                    name: "id",
                    hidden: true,
                    primaryKey: true
                },
                {
                    name: "productCode",
                    title: "<spring:message code='invoiceSalesItem.productCode'/>",
                    width: "10%",
                    showIf: "false"
                },
                {
                    name: "productName",
                    title: "<spring:message code='invoiceSalesItem.productName'/>",
                    width: "10%"
                },
                {
                    name: "unitName",
                    title: "<spring:message code='invoiceSalesItem.unitName'/>",
                    width: "10%"
                },
                {
                    name: "netAmount",
                    title: "<spring:message code='invoiceSalesItem.netAmount'/>",
                    width: "10%"
                },
                {
                    name: "orderAmount",
                    title: "<spring:message code='invoiceSalesItem.orderAmount'/>",
                    width: "10%"
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoiceSalesItem.unitPrice'/>",
                    width: "10%"
                },
                {
                    name: "linePrice",
                    title: "<spring:message code='invoiceSalesItem.linePrice'/>",
                    width: "10%"
                },
                {
                    name: "discount",
                    title: "<spring:message code='invoiceSalesItem.discount'/>",
                    width: "10%"
                },
                {
                    name: "linePriceAfterDiscount",
                    title: "<spring:message code='invoiceSalesItem.linePriceAfterDiscount'/>",
                    width: "10%"
                },
                {
                    name: "legalFees",
                    title: "<spring:message code='invoiceSalesItem.legalFees'/>",
                    width: "10%"
                },
                {
                    name: "vat",
                    title: "<spring:message code='invoiceSalesItem.vat'/>",
                    width: "10%"
                },
                {
                    name: "totalPrice",
                    title: "<spring:message code='invoiceSalesItem.totalPrice'/>",
                    width: "10%"
                },
                {
                    name: "notes",
                    title: "<spring:message code='invoiceSalesItem.notes'/>",
                    width: "10%"
                },
                {
                    name: "explain",
                    title: "<spring:message code='invoiceSalesItem.explain'/>",
                    width: "10%"
                },
                {
                    name: "invoiceSalesId",
                    type: "long",
                    hidden: true,
                },
                {
                    name: "editIcon",
                    width: "4%",
                    align: "center",
                    showTitle: false
                },
                {
                    name: "removeIcon",
                    width: "4%",
                    align: "center",
                    showTitle: false
                }
            ],
            autoFetchData: false,
            createRecordComponent: function (record, colNum) {
                var fieldName = this.getFieldName(colNum);
                var recordCanvas = isc.HLayout.create(
                    {
                        height: 22,
                        width: "100%",
                        align: "center"
                    });
                if (fieldName == "editIcon") {
                    var editImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_edit.png",
                            prompt: "ویرایش",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_InvoiceSalesItem.selectSingleRecord(record);
                                ListGrid_InvoiceSalesItem_edit();
                            }
                        });
                    return editImg;
                }
                else if (fieldName == "removeIcon") {
                    var removeImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_delete.png",
                            prompt: "حذف",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_InvoiceSalesItem.selectSingleRecord(record);
                                ListGrid_InvoiceSalesItem_remove();
                            }
                        });
                    return removeImg;
                }
                else {
                    return null;
                }
            }

        });

    var HLayout_InvoiceSalesItem_Grid = isc.HLayout.create({
        width: "100%",
        members: [
            ListGrid_InvoiceSalesItem
        ]
    });

    var VLayout_InvoiceSalesItem_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_InvoiceSalesItem_Grid,
            HLayout_InvoiceSalesItem_Actions
        ]
    });

    isc.SectionStack.create(
        {
            sections: [
                {
                    title: "<spring:message code='invoiceSales.title'/>",
                    items: VLayout_InvoiceSales_Body,
                    showHeader: false,
                    expanded: true
                },
                {
                    title: "<spring:message code='invoiceSalesItem.title'/>",
                    hidden: true,
                    items: VLayout_InvoiceSalesItem_Body,
                    expanded: false
                }],
            visibilityMode: "multiple",
            animateSections: true,
            height: "100%",
            width: "100%",
            overflow: "hidden"
        });