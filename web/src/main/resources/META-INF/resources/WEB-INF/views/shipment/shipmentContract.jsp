
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />


    var contactId;

    <%--var RestDataSource_Shipment_HeaderByShipContract = isc.MyRestDataSource.create({--%>
    <%--    fields: [--%>
    <%--        {name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},--%>
    <%--        {name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},--%>
    <%--        {name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}--%>
    <%--    ],--%>
    <%--    fetchDataURL: "${contextPath}/api/shipmentHeader/spec-list"--%>
    <%--});--%>

    var RestDataSource_CountryByShipmentContract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "nameEn", title: "<spring:message code='global.country'/> "}
            ],
        fetchDataURL: "rest/country/list"
    });


/*برای ذخیره*/
    var RestDataSource_Shipment_PriceByContract = isc.MyRestDataSource.create({
        fields:
            [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },

                {
                    name: "capacity",
                    title: "<spring:message code='shipment.Price.capacity'/>", //ظرفیت
                    type: 'long',
                    hidden: true
                },

                {
                    name: "tblCountryByflag.id",
                    type: 'long',
                    hidden: true
                },

                {
                    name: "tblShipmentInquiry.id",
                    title: "<spring:message code='shipment.inquiry.id'/>", //کد مناقصه
                    type: 'text'
                },

                {
                     name: "tblContactByCompany.nameEn",
                     title: "<spring:message code='shipment.Price.shipingCompany'/>", //شرکت حمل و نقل
                     type: 'text'
                },

                {
                    name: "laycanStart",
                    title: "<spring:message code='shipment.Price.laycanStart'/>", //شروع لغو تاریخ
                    type: 'long',
                    hidden: true
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipment.Price.laycanEnd'/>", //پایان لغو تاریخ
                    type: 'text'
                },

                {
                    name: "loadingRate",
                    title: "<spring:message code='shipment.Price.loadingRate'/>", //نرخ بارگیری
                    type: 'text'
                },

                {
                     name: "dischargeRate",
                     title: "<spring:message code='shipment.Price.dischargeRate'/>", //میزلن تخلیه
                     type: 'float'
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipment.Price.demurrage'/>",  //خسارت
                    type: 'integer'
                },

                {
                    name: "dispatch",
                    title: "<spring:message code='shipment.Price.dispatch'/>", //جایزه
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipment.Price.freight'/>", //کرایه
                    type: 'text',
                    required: true,
                    width: "10%"
                },
                {
                    name: "vesselName",
                    title: "<spring:message code='shipment.Price.vessel'/>", //کشتی
                    type: 'text',
                    required: true,
                    width: "10%"

                },
                {
                    name: "yearOfBuilt",
                    title: "<spring:message code='shipment.Price.yearOfBuilt'/>", //سال ساخت
                    type: 'text',
                    required: true,
                    width: "10%"

                },
                {
                    name: "imo",
                    title: "<spring:message code='shipment.Price.imo'/>", //سازمان بین المللی دریایی(IMO)
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipment.Price.holds'/>", //دریچه(Hatch/Hold)
                    type: 'text',
                    required: true,
                    width: "10%"
                },
            ],
        fetchDataURL: "rest/shipmentPrice/list"
    });
/*برای ذخیره*/




    <%--var RestDataSource_ContactByShipmentContract = isc.MyRestDataSource.create({--%>
    <%--    fields:--%>
    <%--        [--%>
    <%--            {--%>
    <%--                name: "id", primaryKey: true, canEdit: false, hidden: true},--%>
    <%--            {--%>
    <%--                name: "code", title: "<spring:message code='contact.code'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "nameFA", title: "<spring:message code='contact.nameFa'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "nameEN", title: "<spring:message code='contact.nameEn'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "commertialRole"},--%>
    <%--            {--%>
    <%--                name: "phone", title: "<spring:message code='contact.phone'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "mobile", title: "<spring:message code='contact.mobile'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "email",--%>
    <%--                title: "<spring:message code='contact.email'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "type",--%>
    <%--                title: "<spring:message code='contact.type'/>",--%>
    <%--                valueMap: {--%>
    <%--                    "true": "<spring:message code='contact.type.real'/>",--%>
    <%--                    "false": "<spring:message code='contact.type.legal'/>"--%>
    <%--                }--%>
    <%--            },--%>
    <%--            {   name: "economicalCode",--%>
    <%--                title: "<spring:message code='contact.economicalCode'/>"--%>
    <%--            },--%>
    <%--            {--%>
    <%--                name: "status", title: "<spring:message code='contact.status'/>", valueMap: {--%>
    <%--                "true":--%>
    <%--                "<spring:message code='enabled'/>",--%>
    <%--                "false":--%>
    <%--                "<spring:message code='disabled'/>"--%>
    <%--                }--%>
    <%--            },--%>
    <%--            {name: "contactAccounts"}--%>
    <%--        ],--%>
    <%--    fetchDataURL: "rest/contact/list"--%>
    <%--});--%>


    //---------------------------------------------------------- shipment Header--------------------------------------------------------------------------------------------
    function ListGrid_Shipment_HeaderByShipContract_refresh() {
        ListGrid_Shipment_HeaderByShipContract.invalidateCache();
        var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_ShipmentByContract.fetchData({}, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentByContract.setData(data);
        }, {operationId: "00"});
    }


    var RestDataSource_ShipmentContract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "tblShipmentPrice.id",
                    <%--title: "<spring:message code='tblShipmentPrice.name'/>",--%>
                    align: "center",
                    hidden: true
                },
                {
                    name: "shipmentContractDate",
                    title: "<spring:message 	code='shipmentContract.shipmentContractDate'/>",
                    align: "center",
                    hidden: true

                },
                {
                    name: "tblContactByOwners.id",
                    title: "<spring:message code='shipmentContract.owners'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "tblContactByCharterer.id",
                    title: "<spring:message 	code='shipmentContract.charterer'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "tblContactByChainOfOwners.id", title: "<spring:message code='shipmentContract.chainOfOwners'/>", align: "center", width: "10%"

                },
                {
                    name: "tblCountryFlag.id", title: "<spring:message 	code='shipmentContract.countryFlag'/>", align: "center", width: "10%"

                },
                {
                        name: "no",
                        title: "<spring:message code='shipmentContract.no'/>",
                        align: "center",
                        width: "10%"
                },
                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "tblPortByLoadPort.port",
                    title: "<spring:message code='shipmentContract.loadPort'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "tblPortByDischargePort.port",
                    title: "<spring:message 	code='shipmentContract.dischargePort'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "loadingRate",
                    title: "<spring:message code='shipmentContract.loadingRate'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "dischargeRate",
                    title: "<spring:message code='shipmentContract.dischargeRate'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipmentContract.demurrage'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "dispatch",
                    title: "<spring:message code='shipmentContract.dispatch'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipmentContract.freight'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bale",
                    title: "<spring:message code='shipmentContract.bale'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "grain",
                    title: "<spring:message code='shipmentContract.grain'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipmentContract.grossWeight'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "vesselName",
                    title: "<spring:message code='shipmentContract.vesselName'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "yearOfBuilt",
                    title: "<spring:message code='shipmentContract.yearOfBuilt'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "imoNo",
                    title: "<spring:message code='shipmentContract.imoNo'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "officialNo",
                    title: "<spring:message code='shipmentContract.officialNo'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "loa",
                    title: "<spring:message code='shipmentContract.loa'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "beam",
                    title: "<spring:message code='shipmentContract.beam'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "cranes",
                    title: "<spring:message code='shipmentContract.cranes'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipmentContract.holds'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "hatch",
                    title: "<spring:message code='shipmentContract.hatch'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "classType",
                    title: "<spring:message code='shipmentContract.classType'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createUser",
                    title: "<spring:message code='global.createUser'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createDate",
                    title: "<spring:message code='global.createDate'/>",
                    align: "center",
                    width: "10%"
                },
            ],
        fetchDataURL: "rest/shipmentContract/list" //TODO
    });



/*Save*/
    var IButton_ShipmentContract_Save= isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
                DynamicForm_ShipmentContract.validate();
            if (DynamicForm_ShipmentContract.hasErrors())
                return;
            var data = DynamicForm_ShipmentContract.getValues();
            console.table(data);
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentContract", //TODO
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_ShipmentContract_refresh();
                            Window_ShipmentContract.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
/*Save*/


    var IButton_ShipmentContract_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_ShipmentContract.close();
        }
    });

    function ListGrid_ShipmentContract_refresh() {
        ListGrid_ShipmentContract.invalidateCache();
        var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_ShipmentContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentContract.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_ShipmentContract_edit() {
        var record = ListGrid_ShipmentContract.getSelectedRecord()
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
            DynamicForm_ShipmentContract.editRecord(record);
            Window_ShipmentContract.show();
        }
    }

    function ListGrid_ShipmentContract_remove() {

        var record = ListGrid_ShipmentContract.getSelectedRecord();
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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var shipmentContractId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/shipmentContract/remove/" + shipmentContractId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_ShipmentContract_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        });
                    }
                }
            });
        }
    }

    var Menu_ListGrid_ShipmentContract = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        DynamicForm_ShipmentContract.clearValues();
                        Window_ShipmentContract.show();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
                    }
                },
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_ShipmentContract_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_ShipmentContract_remove();
                    }
                }
            ]
    });


    /*فیلد های ویندو*/
    var DynamicForm_ShipmentContract = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        wrapItemTitles: false,
        autoDraw: false,
        autoFocus: "true",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        numCols: 8,
        requiredMessage: "<spring:message code='validator.field.is.required'/>", //فیلد اجباری است.
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                <%--{--%>
                <%--    name: "tblShipmentPrice.id",--%>
                <%--    title: "<spring:message code='shipment.Price'/>", //نتیجه ارزیابی--%>
                <%--    type: 'long',--%>
                <%--    editorType: "SelectItem",--%>
                <%--    colSpan: 2,--%>
                <%--    optionDataSource: RestDataSource_Shipment_PriceByContract, //change Data source -> shipmentContract TODO--%>
                <%--    displayField: "tblContact.nameFA",--%>
                <%--    valueField: "id",--%>
                <%--    pickListWidth: "500",--%>
                <%--    pickListHeight: "500",--%>
                <%--    pickListProperties: {showFilterEditor: true}  ,--%>
                <%--    pickListFields:--%>
                <%--        [--%>
                <%--            {--%>
                <%--                name: "capacity",--%>
                <%--                title: "<spring:message code='shipment.Price.capacity'/>", //ظرفیت--%>
                <%--                type: 'long',--%>
                <%--                align: "center"--%>
                <%--            },--%>
                <%--            &lt;%&ndash;{&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    name: "tblShipmentInquiry.tblShipmentResource.tblContact.id",&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    title: "<spring:message code='shipment.inquiry.id'/>", //کد مناقصه&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    type: 'text',&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    align: "center"&ndash;%&gt;--%>

                <%--            &lt;%&ndash;},&ndash;%&gt;--%>
                <%--            &lt;%&ndash;{&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    name: "tblShipmentInquiry.tblShipmentResource.tblContact.nameFA",&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    title: "<spring:message code='shipment.inquiry.id'/>", //کد مناقصه&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    type: 'text',&ndash;%&gt;--%>
                <%--            &lt;%&ndash;    align: "center"&ndash;%&gt;--%>
                <%--            &lt;%&ndash;},&ndash;%&gt;--%>
                <%--        ]--%>
                <%--    ,--%>


                <%--},--%>

                <%--{--%>
                <%--    name: "shipmentContractDate",--%>
                <%--    ID: "shipmentContractDate",--%>
                <%--    title: "<spring:message code='shipmentContract.shipmentContractDate'/>", //تاریخ قرارداد حمل--%>
                <%--    align: "right",--%>
                <%--    width: "10%"--%>
                <%--    , icons: [{--%>
                <%--        src: "pieces/pcal.png", click: function () {--%>
                <%--            displayDatePicker('createDate', this, 'ymd', '/');--%>
                <%--        }--%>
                <%--    }]--%>
                <%--    &lt;%&ndash;, defaultValue: "<%=dateUtil.todayDate()%>"&ndash;%&gt;--%>
                <%--    , blur: function () {--%>
                <%--        var value = DynamicForm_ShipmentContract.getItem('createDate').getValue();--%>
                <%--        if (value != null && value.length != 10 && value != "") {--%>
                <%--            DynamicForm_ShipmentContract.setValue('createDate', CorrectDate(value))--%>
                <%--        }--%>
                <%--    }, colSpan: 2--%>
                <%--},--%>

                {name: "tblContactByOwners.id", type: 'long', colSpan: 2, hidden: true},
                <%--{--%>
                <%--    name: "tblContactByOwners.nameFA",--%>
                <%--    title: "<spring:message code='shipmentContract.agant'/>", //نماینده--%>
                <%--    colSpan: 2,--%>
                <%--    canEdit: false--%>
                <%--},--%>
                <%--{--%>
                <%--    name: "tblContactByCharterer.id",--%>
                <%--    title: "<spring:message code='shipmentContract.charterer'/>", //منشور--%>
                <%--    type: 'long',--%>
                <%--    editorType: "SelectItem",--%>
                <%--    colSpan: 2 ,--%>
                <%--    // optionDataSource: RestDataSource_ContactByShipmentContract, //TODO--%>
                <%--    displayField: "tblContact.nameFA"  ,--%>
                <%--    valueField: "id",--%>
                <%--    pickListWidth: "500",--%>
                <%--    pickListHeight: "500",--%>
                <%--    pickListProperties: {showFilterEditor: true}--%>
                <%--    ,--%>
                <%--    pickListFields:--%>
                <%--        [--%>
                <%--            {--%>
                <%--                name: "nameFA",--%>
                <%--                title: "<spring:message code='contact.nameFa'/>" //نام کامل شخص(حقیقی،حقوقی)--%>
                <%--            },--%>
                <%--            {--%>
                <%--                name: "nameEN",--%>
                <%--                title: "<spring:message code='contact.nameEn'/>" //نام کامل لاتین شخص(حقیقی،حقوقی)--%>
                <%--            },--%>
                <%--        ]--%>
                <%--    ,--%>
                <%--    change: function () {--%>
                <%--    }--%>
                <%--},--%>
                <%--{--%>
                <%--    name: "tblContactByChainOfOwners.id",--%>
                <%--    title: "<spring:message code='shipmentContract.owners'/>", //صاحبان--%>
                <%--    type: 'long',--%>
                <%--    editorType: "SelectItem",--%>
                <%--    colSpan: 2,--%>
                <%--    // optionDataSource: RestDataSource_ContactByShipmentContract, //TODO--%>
                <%--    displayField: "tblContact.nameFA" ,--%>
                <%--    valueField: "id",--%>
                <%--    pickListWidth: "500",--%>
                <%--    pickListHeight: "500",--%>
                <%--    pickListProperties: {showFilterEditor: true} ,--%>
                <%--    pickListFields:--%>
                <%--        [--%>
                <%--            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"}, //نام کامل شخص(حقیقی،حقوقی)--%>
                <%--            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"}, //نام کامل لاتین شخص(حقیقی،حقوقی)--%>
                <%--        ]  ,--%>
                <%--    change: function () {--%>
                <%--    }--%>
                <%--},--%>

                <%--{--%>
                <%--      name: "tblCountryFlag.id",--%>
                <%--      title: "<spring:message code='shipmentContract.countryFlag'/>", //پرچم--%>
		        <%--      type: 'long',--%>
                <%--      editorType: "SelectItem" ,--%>
                <%--      optionDataSource: RestDataSource_CountryByShipmentContract, //TODO--%>
                <%--      displayField: "nameEn",--%>
                <%--      valueField: "id",--%>
                <%--      pickListProperties: {showFilterEditor: true}  ,--%>
                <%--      pickListFields: [--%>
                <%--        {--%>
                <%--            name: "nameEn",--%>
                <%--            width: 150,--%>
                <%--            align: "center"}--%>
                <%--    ]  ,--%>
                <%--    colSpan: 2--%>
                <%--},--%>

                {
                    name: "no",
                    title: "<spring:message code='shipmentContract.no'/>", //شماره
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>", //ظرفیت
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "laycanStart",
                    ID: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>", //شروع لغو تاریخ
                    align: "right",
                    width: "200"
                    , icons: [{
                        src: "pieces/pcal.png", click: function () {  displayDatePicker('laycanStart', this, 'ymd', '/');       }
                    }]
                    , blur: function () {
                        var value = DynamicForm_ShipmentContract.getItem('laycanStart').getValue();
                        if (value != null && value.length != 10 && value != "") {  DynamicForm_ShipmentContract.setValue('laycanStart', CorrectDate(value))     }
                    }, colSpan: 2
                },
                {
                    name: "laycanEnd",
                    ID: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>", //پایان لغو تاریخ
                    align: "right",
                    width: "200",
                     icons: [{
                        src: "pieces/pcal.png", click: function () { displayDatePicker('laycanEnd', this, 'ymd', '/'); }

                    }],
                     blur: function () {
                        var value = DynamicForm_ShipmentContract.getItem('laycanEnd').getValue();
                        if (value != null && value.length != 10 && value != "") {
                            DynamicForm_ShipmentContract.setValue('laycanEnd', CorrectDate(value))
                        }
                    },
                    colSpan: 2
                },
                {
                    name: "loadingRate",
                    title: "<spring:message code='shipmentContract.loadingRate'/>", //نرخ بارگیری
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "dischargeRate",
                    title: "<spring:message code='shipmentContract.dischargeRate'/>", //میزان تخلیه
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipmentContract.demurrage'/>", //جریمه
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "dispatch",
                    title: "<spring:message code='shipmentContract.dispatch'/>", //جایزه
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipmentContract.freight'/>", //کرایه
                    align: "center",
                    colSpan: 2
                },
                {
                        name: "bale",
                        title: "<spring:message code='shipmentContract.bale'/>", //فضای موجود برای محموله های اندازه گیری شده
                        align: "center",
                        colSpan: 2
                },
                {
                        name: "grain",
                        title: "<spring:message code='shipmentContract.grain'/>", //حداکثر فضای موجود برای محمول
                        align: "center",
                        colSpan: 2
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipmentContract.grossWeight'/>", //وزن ناخالص/مرطوب
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "vesselName",
                    title: "<spring:message code='shipmentContract.vesselName'/>", //نام کشتی
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "yearOfBuilt",
                    title: "<spring:message code='shipmentContract.yearOfBuilt'/>", //سال ساخت
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "imoNo",
                    title: "<spring:message code='shipmentContract.imoNo'/>", //(IMO)سازمان بین المللی دریایی
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "officialNo",
                    title: "<spring:message code='shipmentContract.officialNo'/>", //شماره رسمس
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "loa",
                    title: "<spring:message code='shipmentContract.loa'/>", //(LOA)طول ماكزيمم كشتي
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "beam",
                    title: "<spring:message code='shipmentContract.beam'/>", //(BEAM)عرض ماكزيمم عرش كشتي
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "cranes",
                    title: "<spring:message code='shipmentContract.cranes'/>", //جرثقیل
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipmentContract.holds'/>", //نگه دارنده
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "hatch",
                    title: "<spring:message code='shipmentContract.hatch'/>", //انبار كشتي
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "classType",
                    title: "<spring:message code='shipmentContract.classType'/>", //نوع کلاس
                    align: "center",
                    colSpan: 2
                },
                {
                    name: "createDate",
                    ID: "createDate",
                    title: "<spring:message code='global.createDate'/>", //تاریخ ایجاد
                    align: "right",
                    width: "200"
                    ,
                    icons: [{
                                src: "pieces/pcal.png",
                                click: function () {    displayDatePicker('createDate', this, 'ymd', '/'); }
                    }],

                    blur: function () {
                        var value = DynamicForm_ShipmentContract.getItem('createDate').getValue();
                        if (value != null && value.length != 10 && value != "") {
                            DynamicForm_ShipmentContract.setValue('createDate', CorrectDate(value))
                        }
                    },
                    colSpan: 2
                },
                {
                    name: "weighingMethodes",
                    title: "<spring:message code='shipmentContract.weighingMethodes'/>", //روش توزين
                    type: 'text',
                    width: "200"
                    ,
                    colSpan: 2
                    ,
                    valueMap: {
                        "draft survey": "<spring:message code='shipmentContract.draftSurvey'/>" //بازرسي درافت كشتي
                        , "weighbridge": "<spring:message code='shipmentContract.weighbridge'/>" //باسكول
                    }
                }

            ]
    });


    var ToolStripButton_ShipmentContract_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentContract_refresh();
        }
    });


    var ToolStripButton_ShipmentContract_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
                Window_ShipmentContract.show();
            }
    });


    var ToolStripButton_ShipmentContract_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentContract_edit();
        }
    });

    var ToolStripButton_ShipmentContract_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentContract_remove();
        }
    });


    var ToolStrip_Actions_ShipmentContract = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ShipmentContract_Refresh,
                ToolStripButton_ShipmentContract_Add,
                ToolStripButton_ShipmentContract_Edit,
                ToolStripButton_ShipmentContract_Remove,
            ]
    });


    var HLayout_ShipmentContract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ShipmentContract
            ]
    });



    var Window_ShipmentContract = isc.Window.create({
        title: "<spring:message code='shipmentContract.title'/>",
        width: "28%",
        height: "30%",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_ShipmentContract,
            isc.HLayout.create({
                width: "100%",
                members:
                    [
                IButton_ShipmentContract_Save,
                IButton_ShipmentContract_Cancel
                    ]
            })
        ]
    });




/*قرارداد حمل*/
    var ListGrid_ShipmentContract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentContract,
        contextMenu: Menu_ListGrid_ShipmentContract,
        fields:
            [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true ,
                    width:"10%"
                },
                {
                    name: "tblShipmentPrice.nameFA",
                    title: "<spring:message code='shipment.Price'/>",
                    align: "center"  ,
                    width:"10%"},
                {
                    name: "shipmentContractDate",
                    title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
                    align: "center" ,width:"10%"
                },
                {
                    name: "tblContactByOwners.nameFA",
                    title: "<spring:message  code='shipmentContract.owners'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "tblContactByCharterer.nameFA",
                    title: "<spring:message  code='shipmentContract.charterer'/>",
                    align: "center", width: "10%"

                },
                {
                    name: "tblContactByChainOfOwners.nameFA",
                    title: "<spring:message   code='shipmentContract.chainOfOwners'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "tblCountryFlag.nameFa",
                    title: "<spring:message code='shipmentContract.countryFlag'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "no",
                    title: "<spring:message code='shipmentContract.no'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "tblPortByLoadPort.port",
                    title: "<spring:message code='shipmentContract.loadPort'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "tblPortByDischargePort.port",
                    title: "<spring:message    code='shipmentContract.dischargePort'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>",
                    align: "center",
                    width: "10%"
                },

            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
        },
        dataArrived: function (startRow, endRow) {
        }
    });




    var HLayout_ShipmentContract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentContract
        ]
    });

    var VLayout_ShipmentContract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_ShipmentContract_Actions, HLayout_ShipmentContract_Grid
            ]
    });

    //-----------------------------------------SectionStack-----------------------------------------------------------------

    isc.SectionStack.create({
        ID: "Shipment_Section_Stack",
        sections:
            [
                 {
                title: "<spring:message code='shipmentContract.title'/>",
                items: VLayout_ShipmentContract_Body,
                expanded: true
                 }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });








 /*برای خط 613 بود */
//                     change: function () {
//                         var record = DynamicForm_ShipmentContract.getItem("tblShipmentPrice.id").getSelectedRecord();
//                         DynamicForm_ShipmentContract.setValue("tblContactByOwners.nameFA", record.tblShipmentInquiry.tblShipmentResource.tblContact.nameFA);
//                         DynamicForm_ShipmentContract.setValue("tblContactByOwners.id", record.tblShipmentInquiry.tblShipmentResource.tblContact.id);
//
// //DynamicForm_ShipmentContract.setValue("tblPortByLoadPort.port",ShipmentSelection[0].tblPortByLoading.port);
// //DynamicForm_ShipmentContract.setValue("tblPortByLoadPort.id",ShipmentSelection[0].tblPortByLoading.id);
// //DynamicForm_ShipmentContract.setValue("tblPortByDischargePort.port",ShipmentSelection[0].tblPortByDischarge.port);
// //DynamicForm_ShipmentContract.setValue("tblPortByDischargePort.id",ShipmentSelection[0].tblPortByDischarge.id);
//
//                         // DynamicForm_ShipmentContract.setValue("demurrage", record.demurrage);
//                         // DynamicForm_ShipmentContract.setValue("dispatch", record.dispatch);
//                         // DynamicForm_ShipmentContract.setValue("freight", record.freight);
//                         // DynamicForm_ShipmentContract.setValue("vesselName", record.vesselName);
//                         // DynamicForm_ShipmentContract.setValue("yearOfBuilt", record.yearOfBuilt);
//                         // DynamicForm_ShipmentContract.setValue("holds", record.holds);
//                         // DynamicForm_ShipmentContract.setValue("hatch", record.hatch);
//                         // DynamicForm_ShipmentContract.setValue("classType", record.classType);
//                         // DynamicForm_ShipmentContract.setValue("laycanStart", record.laycanStart);
//                         // DynamicForm_ShipmentContract.setValue("laycanEnd", record.laycanEnd);
//
//                     }
/*برای خط 613 بود */
















<%--var RestDataSource_ShipmentByContract = isc.MyRestDataSource.create({--%>
<%--    fields: [--%>
<%--        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},--%>
<%--        {--%>
<%--            name: "tblContractItemShipment.id",--%>
<%--            title: "<spring:message code='contact.name'/>",--%>
<%--            type: 'long',--%>
<%--            hidden: true--%>
<%--        },--%>
<%--        {name: "tblContact.id", type: 'long', hidden: true},--%>
<%--        {name: "tblContact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},--%>
<%--        {name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},--%>
<%--        {name: "tblMaterial.descl", title: "<spring:message code='material.descl'/>", type: 'text'},--%>
<%--        {name: "tblMaterial.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},--%>
<%--        {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},--%>
<%--        {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},--%>
<%--        {--%>
<%--            name: "tblPortByLoading.port",--%>
<%--            title: "<spring:message code='shipment.loading'/>",--%>
<%--            type: 'text',--%>
<%--            width: "10%"--%>
<%--        },--%>
<%--        {--%>
<%--            name: "tblPortByDischarge.port", title: "<spring:message code='shipment.discharge'/>", type: 'text', required: true, width: "10%"--%>

<%--        },--%>
<%--        {--%>
<%--            name: "tblPortByLoading.id",--%>
<%--            title: "<spring:message code='shipment.loading'/>",--%>
<%--            type: 'text',--%>
<%--            width: "10%"--%>
<%--        },--%>
<%--        {--%>
<%--            name: "tblPortByDischarge.id", title: "<spring:message code='shipment.discharge'/>", type: 'text', required: true, width: "10%"--%>

<%--        },--%>
<%--        {--%>
<%--            name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', required: true, width: "10%"--%>

<%--        },--%>
<%--        {--%>
<%--            name: "month",--%>
<%--            title: "<spring:message code='shipment.month'/>",--%>
<%--            type: 'text',--%>
<%--            required: true,--%>
<%--            width: "10%"--%>
<%--        },--%>
<%--        {--%>
<%--            name: "status", title: "<spring:message 	code='shipment.staus'/>",--%>
<%--             type: 'text', width: "10%", valueMap: {--%>
<%--                "Load Ready": "<spring:message code='shipment.loadReady'/>",--%>
<%--                "Resource": "<spring:message code='shipment.resource'/>"--%>
<%--            }--%>
<%--        },--%>
<%--        {--%>
<%--            name: "createDate",--%>
<%--            title: "<spring:message code='shipment.createDate'/>",--%>
<%--            type: 'text',--%>
<%--            required: true,--%>
<%--            width: "10%"--%>
<%--        },--%>
<%--        {--%>
<%--            name: "shipmentType", title: "<spring:message code='shipment.inquiry.type'/>", type: 'text', width: "10%", align: "center"--%>
<%--            , valueMap: {--%>
<%--                "bulk": "<spring:message code='shipment.inquiry.bulk'/>"--%>
<%--                , "container": "<spring:message code='shipment.inquiry.container'/>"--%>
<%--            }--%>
<%--        }--%>
<%--    ],--%>
<%--    fetchDataURL: "rest/shipment/list"--%>
<%--});--%>













<%--var ToolStripButton_ShipmentContract_print = isc.ToolStripButton.create({--%>
<%--    icon: "[SKIN]/actions/print.png",--%>
<%--    title: "<spring:message code='shipmentContract.print'/>",--%>
<%--    click: function () {--%>
<%--        var record = ListGrid_ShipmentContract.getSelectedRecord();--%>
<%--        if (record == null || record.id == null) {--%>
<%--            isc.Dialog.create({--%>
<%--                message: "<spring:message code='global.grid.record.not.selected'/>",--%>
<%--                icon: "[SKIN]ask.png",--%>
<%--                title: "<spring:message code='global.message'/>",--%>
<%--                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],--%>
<%--                buttonClick: function () {--%>
<%--                    this.hide();--%>
<%--                }--%>
<%--            });--%>
<%--        } else {--%>
<%--            window.open("shipmentContract/printDocx?data=" + record.id);--%>
<%--        }--%>
<%--    }--%>
<%--});--%>

<%--var ToolStripButton_ShipmentContract_print1 = isc.ToolStripButton.create({--%>
<%--    icon: "[SKIN]/actions/print.png",--%>
<%--    title: "<spring:message code='shipmentContract.print.letter'/>",--%>
<%--    click: function () {--%>
<%--        var record = ListGrid_ShipmentContract.getSelectedRecord();--%>
<%--        if (record == null || record.id == null) {--%>
<%--            isc.Dialog.create({--%>
<%--                message: "<spring:message code='global.grid.record.not.selected'/>",--%>
<%--                icon: "[SKIN]ask.png",--%>
<%--                title: "<spring:message code='global.message'/>",--%>
<%--                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],--%>
<%--                buttonClick: function () {--%>
<%--                    this.hide();--%>
<%--                }--%>
<%--            });--%>
<%--        } else {--%>
<%--            window.open("shipmentContract/printShipmentContractDocx?data=" + record.id);--%>
<%--        }--%>
<%--    }--%>
<%--});--%>












<%--{--%>
<%--    title: "<spring:message code='shipmentHeader.title'/>",--%>
<%--    items: VLayout_Body_Shipment_HeaderByShipContract, expanded: true--%>
<%--}--%>
<%--, {--%>
<%--title: "<spring:message code='Shipment.title'/>",--%>
<%--items: VLayout_Body_ShipmentByContract,--%>
<%--expanded: true--%>
<%-- }--%>



// ToolStripButton_ShipmentContract_print,
// ToolStripButton_ShipmentContract_print1





/*سربرگ حمل*/
<%--var ListGrid_Shipment_HeaderByShipContract = isc.ListGrid.create({--%>
<%--    width: "100%",--%>
<%--    height: "100%",--%>
<%--    dataSource: RestDataSource_Shipment_HeaderByShipContract,--%>

<%--    fields: [--%>
<%--        {name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},--%>
<%--        {name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},--%>
<%--        {name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}--%>
<%--    ],--%>
<%--    recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",--%>
<%--    updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {--%>
<%--        var record = this.getSelectedRecord();--%>

<%--        ListGrid_ShipmentByContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {--%>
<%--            ListGrid_ShipmentByContract.setData(data);--%>
<%--        }, {operationId: "00"});--%>

<%--        ListGrid_ShipmentContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {--%>
<%--            ListGrid_ShipmentContract.setData(data);--%>
<%--        }, {operationId: "00"});--%>
<%--    },--%>
<%--    dataArrived: function (startRow, endRow) {--%>
<%--    },--%>
<%--    sortField: 0,--%>
<%--    autoFetchData: true,--%>
<%--    showFilterEditor: true,--%>
<%--    filterOnKeypress: true--%>
<%--});--%>

// var HLayout_Grid_Shipment_HeaderByShipContract = isc.HLayout.create({
//     width: "100%",
//     height: "100%",
//     members: [
//         ListGrid_Shipment_HeaderByShipContract
//     ]
// });

// var VLayout_Body_Shipment_HeaderByShipContract = isc.VLayout.create({
//     width: "100%",
//     height: "100%",
//     members: [
//
//         HLayout_Grid_Shipment_HeaderByShipContract
//     ]
// });
//---------------------------------------------------------- Shipment By Contract--------------------------------------------------------------------------------------------
<%--var ListGrid_ShipmentByContract = isc.ListGrid.create({--%>
<%--    width: "100%",--%>
<%--    height: "100%",--%>
<%--    dataSource: RestDataSource_ShipmentByContract,--%>
<%--    fields: [--%>
<%--        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},--%>
<%--        {name: "tblContractItemShipment.id", hidden: true, type: 'long'},--%>
<%--        {name: "tblContact.id", type: 'long', hidden: true},--%>
<%--        {name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},--%>
<%--        {--%>
<%--            name: "tblContact.nameFA", title: "<spring:message 	code='contact.name'/>", type: 'text', width: "10%", align: "center",--%>
<%--        },--%>
<%--        {name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},--%>
<%--        {--%>
<%--            name: "tblMaterial.descl", title: "<spring:message 	code='material.descl'/>", type: 'text', width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "tblMaterial.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text', width: "10%", align: "center",--%>
<%--        },--%>
<%--        {--%>
<%--            name: "amount",--%>
<%--            title: "<spring:message code='global.amount'/>",--%>
<%--            type: 'float',--%>
<%--            width: "10%",--%>
<%--            align: "center",--%>
<%--        },--%>
<%--        {--%>
<%--            name: "noContainer", title: "<spring:message 	code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "tblPortByLoading.port", title: "<spring:message code='shipment.loading'/>", type: 'text', width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "tblPortByDischarge.port", title: "<spring:message code='shipment.discharge'/>", type: 'text', required: true, width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "description", title: "<spring:message 	code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center",--%>

<%--        },--%>
<%--        {--%>
<%--            name: "status",--%>
<%--            title: "<spring:message code='shipment.staus'/>",--%>
<%--            type: 'text',--%>
<%--            width: "10%",--%>
<%--            align: "center"--%>
<%--            ,--%>
<%--            valueMap: {--%>
<%--                "Load Ready": "<spring:message code='shipment.loadReady'/>"--%>
<%--                , "Resource": "<spring:message code='shipment.resource'/>"--%>
<%--            }--%>
<%--        },--%>
<%--        {--%>
<%--            name: "shipmentType", title: "<spring:message code='shipment.inquiry.type'/>", type: 'text', width: "10%", align: "center"--%>
<%--            , valueMap: {--%>
<%--                "bulk": "<spring:message code='shipment.inquiry.bulk'/>"--%>
<%--                , "container": "<spring:message code='shipment.inquiry.container'/>"--%>
<%--            }--%>
<%--        }--%>

<%--    ],--%>
<%--    recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",--%>
<%--    updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {--%>
<%--        /*var record = this.getSelectedRecord();--%>
<%--        contactId = record.tblContact.id;--%>
<%--        ListGrid_ShipmentContract.fetchData({"tblShipment.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentContract.setData(data);});*/--%>
<%--    },--%>
<%--    dataArrived: function (startRow, endRow) {--%>
<%--    },--%>
<%--    sortField: 0,--%>
<%--    autoFetchData: false,--%>
<%--    showFilterEditor: true,--%>
<%--    filterOnKeypress: true--%>
<%--});--%>

// var HLayout_Grid_ShipmentByContract = isc.HLayout.create({
//     width: "100%",
//     height: "100%",
//     members: [
//         ListGrid_ShipmentByContract
//     ]
// });

// var VLayout_Body_ShipmentByContract = isc.VLayout.create({
//     width: "100%",
//     height: "100%",
//     members: [
//         HLayout_Grid_ShipmentByContract
//     ]
// });
//-------------------------------------------Email----------------------------------------------------------------------