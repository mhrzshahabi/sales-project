<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_PersonByInspectionContract_EmailCC_In_InspectionContract = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
            {
                name: "contactId"
            },
            {
                name: "contact.nameFA"
            },
            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 400
            },
            {
                name: "jobTitle",
                title: "<spring:message code='person.jobTitle'/>",
                type: 'text',
                width: 400
            },
            {
                name: "title",
                title: "<spring:message code='person.title'/>",
                type: 'text',
                width: 400,
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {
                name: "email",
                title: "<spring:message code='person.email'/>",
                type: 'text',
                required: true,
                width: 400,
                regex: "^([a-zA-Z0-9_.\\-+])+@(([a-zA-Z0-9\\-])+\\.)+[a-zA-Z0-9]{2,4}$"
            },
            {
                name: "email1",
                title: "<spring:message code='person.email1'/>",
                type: 'text',
                width: 400
            },
            {
                name: "email2",
                title: "<spring:message code='person.email2'/>",
                type: 'text',
                width: 400
            },
        ],

        fetchDataURL: "${contextPath}/api/person/spec-list"
    });

    var RestDataSource_Inspection = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
            {
                name: "contractShipmentId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true
            },
            {
                name: "contactId",
                type: 'long',
                hidden: true
            },
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text'
            },
            {
                name: "contractId",
                type: 'long',
                hidden: true
            },
            {
                name: "contract.contractNo",
                type: 'text',
                width: 180
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: 180
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true
            },
            {
                name: "material.descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text'
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text'
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'float'
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer'
            },
            {
                name: "noPalete",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer'
            },
            {
                name: "laycan",
                title: "<spring:message code='shipmentContract.laycanStart'/>",
                type: 'integer',
                width: "10%",
                align: "center",
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: 400,
                valueMap: {
                    "bulk": "bulk",
                    "container": "container"
                }
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "loading",
                title: "<spring:message code='global.address'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByLoadingId",
                title: "<spring:message code='shipment.loading'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByLoading.port",
                title: "<spring:message code='shipment.loading'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByDischargeId",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "dischargeAddress",
                title: "<spring:message code='global.address'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                width: "50%"
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "status",
                title: "<spring:message code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "createDate",
                title: "<spring:message code='shipment.createDate'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    var ToolStripButton_InspectionContract_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",

        click: function () {
            ListGrid_PersonByInspectionContract_EmailCC.invalidateCache();
            var record = ListGrid_Inspection.getSelectedRecord();
            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({
                        title: "<spring:message code='global.ok'/>"
                    })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else {
                DynamicForm_InspectionContract.clearValues();
                DynamicForm_InspectionContract.setValue("shipmentId", record.id);
                DynamicForm_InspectionContract.setValue("emailType", "Inspection Contract");
                DynamicForm_InspectionContract.setValue("emailSubject", "ORDER FOR REPRESENTATION ");
                Window_InspectionContract.show();
            }
        }
    });


    var ToolStripButton_InspectionContract_PrintWord = isc.ToolStripButtonPrint.create({
        icon: "pieces/512/word.png",
        title: "<spring:message code='global.form.print.inspection'/>",
        click: function () {
            check_Insp_Print();
        }
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

    function setCriteria_ListGrid_InsperctionContract(record) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{
                fieldName: "shipmentId",
                operator: "equals",
                value: record
            }]
        };

        ListGrid_InspectionContract.fetchData(criteria1, function (dsResponse, data, dsRequest) {

            if (data.length === 0) {
                recordNotFound.show();
                ListGrid_InspectionContract.hide()
            } else {
                recordNotFound.hide();
                ListGrid_InspectionContract.setData(data);
                ListGrid_InspectionContract.show();
            }
        }, {operationId: "00"});
    }

    function getExpandedComponent_Inspection(record) {

        setCriteria_ListGrid_InsperctionContract(record.id);
        contractId = record.contractId;

        var hLayout = isc.HLayout.create({
            align: "center", padding: 5,
            membersMargin: 20,
            members: [
                ToolStripButton_InspectionContract_Add, ToolStripButton_InspectionContract_PrintWord
            ]
        });

        HLayout_InspectionContract_Grid.show();
        ToolStripButton_InspectionContract_Add.show();
        ToolStripButton_InspectionContract_PrintWord.show();
        var layoutInspectionContract = isc.VLayout.create({
            styleName: "expand-layout",
            padding: 5,
            membersMargin: 10,
            members: [HLayout_InspectionContract_Grid, recordNotFound, hLayout]
        });

        return layoutInspectionContract;
    }


    var ListGrid_PersonByInspectionContract_EmailCC = isc.ListGrid.create({
        width: "800",
        height: "400",
        dataSource: RestDataSource_PersonByInspectionContract_EmailCC_In_InspectionContract,
        fields: [{
            name: "contact.nameFA",
            title: "<spring:message code='contact.name'/>",
            type: 'text',
            required: true,
            width: "10%"
        },
            {
                name: "title",
                title: "<spring:message code='person.title'/>",
                type: 'text',
                width: "10%",
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {
                name: "email",
                title: "<spring:message code='person.email'/>",
                type: 'text',
                required: true,
                width: "10%",
                regex: "^([a-zA-Z0-9_.\\-+])+@(([a-zA-Z0-9\\-])+\\.)+[a-zA-Z0-9]{2,4}$"
            },
            {
                name: "email1",
                title: "<spring:message code='person.email1'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "email2",
                title: "<spring:message code='person.email2'/>",
                type: 'text',
                width: "10%"
            }
        ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        selectionAppearance: "checkbox"
    });

    var RestDataSource_InspectionContract = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },

            {
                name: "shipment.id",
                title: "<spring:message code='contact.name'/>",
                align: "right",
                hidden: true
            },
            {
                name: "contactByInspectionId",
                type: 'long',
                hidden: true
            },
            {
                name: "contactByInspection.nameEN",
            },
            {
                name: "shipment.contact.nameEN",
                title: "<spring:message code='contact.name'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailType",
                title: "<spring:message code='shipment.emailType'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailSubject",
                title: "<spring:message code='global.emailSubject'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailTo",
                title: "<spring:message code='global.emailTo'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailCC",
                title: "<spring:message code='global.emailCC'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailBody",
                title: "<spring:message code='global.emailBody'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "emailRespond",
                title: "<spring:message code='global.emailRespond'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "createUser",
                title: "<spring:message code='global.createUser'/>",
                align: "right",
                width: "10%"
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                align: "right",
                width: "10%"
            },
        ],
        fetchDataURL: "${contextPath}/api/inspectionContract/spec-list"
    });

    var IButton_InspectionContract_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_InspectionContract.validate();
            if (DynamicForm_InspectionContract.hasErrors())
                return;
            var data = DynamicForm_InspectionContract.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                {
                    actionURL: "${contextPath}/api/inspectionContract/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            Window_InspectionContract.hide();
                            ListGrid_InspectionContract.invalidateCache();
                            setCriteria_ListGrid_InsperctionContract(data.shipmentId)

                        } else
                            isc.say(RpcResponse_o.data);
                    }
                }));
        }
    });

    var IButton_InspectionContract_Cancel = isc.IButtonCancel.create({
        top: 300,
        title: "<spring:message code='global.cancel'/>",
        layoutMargin: 5,
        membersMargin: 5,
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_InspectionContract.close();
        }
    });


    var hLayout_saveButton = isc.HLayout.create({
        width: "100%",
        height: "100%",
        layoutMargin: 30,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_InspectionContract_Save,
            IButton_InspectionContract_Cancel
        ]
    });

    var VLayout_saveButton = isc.VLayout.create({
        width: "100%",
        height: "100%",
        textAlign: "center",
        align: "center",
        members: [
            hLayout_saveButton

        ]
    });

    function ListGrid_InspectionContract_remove() {

        var record = ListGrid_InspectionContract.getSelectedRecord();
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

        } else {
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
                            title: "<spring:message code='global.no'/>"
                        })],
                    buttonClick: function (button, index) {
                        this.hide();

                        if (index === 0) {
                            var inspectionContractId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/inspectionContract/" + inspectionContractId,
                                    httpMethod: "DELETE",
                                    serverOutputAsString: false,
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                            ListGrid_InspectionContract.invalidateCache();
                                            setCriteria_ListGrid_InsperctionContract(record.shipmentId)
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        } else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }

    function check_Insp_Print() {
        var record = ListGrid_InspectionContract.getSelectedRecord();

        if (record === null) {
            isc.say("<spring:message code='global.grid.print.inspection'/>");
        } else {
            "<spring:url value="/inspectionContract/print/" var="printUrl"/>";
            window.open('${printUrl}' + record.id);
        }
    }

    var Menu_ListGrid_InspectionContract = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_PersonByInspectionContract_EmailCC.invalidateCache();
                        DynamicForm_InspectionContract.clearValues();
                        Window_InspectionContract.show();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        ListGrid_PersonByInspectionContract_EmailCC.invalidateCache();
                        DynamicForm_InspectionContract.clearValues();
                        Window_InspectionContract.show();
                    }
                },
                <%--{--%>
                <%--	title: "<spring:message code='global.form.edit'/>",--%>
                <%--	icon: "pieces/16/icon_edit.png",--%>
                <%--	click: function()--%>
                <%--	{--%>

                <%--		ListGrid_InspectionContract_edit();--%>
                <%--	}--%>
                <%--},--%>
                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_InspectionContract_remove();
                    }
                },
                {
                    title: "<spring:message code='global.form.print.inspection'/>",
                    click: function () {
                        check_Insp_Print();
                    }
                }]
        });

    var Window_InspectionContractEmailCC = isc.Window.create({
        title: "<spring:message code='person.title'/> ",
        textAlign: "center",
        width: "800",
        height: "100",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.VLayout.create({
                width: "800",
                height: "100",
                members: [
                    ListGrid_PersonByInspectionContract_EmailCC,

                    hLayout_saveButton = isc.HLayout.create({
                        width: "800",
                        height: "100",
                        layoutMargin: 30,
                        membersMargin: 5,
                        textAlign: "center",
                        align: "center",
                        members: [

                            isc.Button.create({
                                title: "<spring:message code='global.ok'/>",
                                click: function () {
                                    var selectedPerson = ListGrid_PersonByInspectionContract_EmailCC.getSelection();
                                    if (selectedPerson.length === 0) {

                                        Window_InspectionContractEmailCC.close();
                                        return;
                                    }
                                    var persons = "";
                                    var oldPersons;
                                    var check = false;
                                    if (typeof (DynamicForm_InspectionContract.getValue("emailCC")) != 'undefined' && DynamicForm_InspectionContract.getValue("emailCC") != null) {
                                        persons = DynamicForm_InspectionContract.getValue("emailCC");
                                        oldPersons = persons.split(",");
                                        check = true;
                                    }
                                    for (i = 0; i < selectedPerson.length; i++) {
                                        notIn = true;
                                        if (notIn)
                                            persons = (persons === "" ? persons : persons + ",") + selectedPerson[i].email;
                                    }
                                    DynamicForm_InspectionContract.setValue("emailCC", persons);
                                    Window_InspectionContractEmailCC.close();
                                }
                            })


                        ]
                    }),
                ]
            })

        ]
    });

    var DynamicForm_InspectionContract = isc.DynamicForm.create({
        height: "400",
        setMethod: 'POST',
        align: "center",
        textAlign: "left",
        canSubmit: true,
        errorOrientation: "bottom",
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        titleWidth: "100",
        titleAlign: "center",
        autoFocus: "true",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields: [

            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            },
            {
                name: "shipment.id",
                title: "<spring:message code='contact.name'/>",
                align: "right",
                hidden: true,
                textAlign: "left"
            },
            {
                autoCenter: true,
                align: "center",
                type: "Header",
                defaultValue: "<spring:message code='inspection.Contract.header'/>",

            },
            {
                name: "superviseWeighing",
                title: "<spring:message code='inspectionContract.superviseWeighing'/>",
                type: 'checkbox',
                width: "650",

                styleName: "customCheckboxTitle",
            },
            {
                name: "sampling",
                title: "<spring:message code='inspectionContract.sampling'/>",
                type: 'checkbox',
                width: "650",

            },
            {
                name: "moistureDetermination",
                title: "<spring:message code='inspectionContract.moistureDetermination'/>",
                type: 'checkbox',
                width: "650",

            },
            {
                name: "emailType",
                title: "<spring:message code='shipment.emailType'/>",
                required: true,
                width: "650",
            },
            {
                name: "emailSubject",
                title: "<spring:message code='global.emailSubject'/>",
                width: "650",
                required: true
            },

            {
                name: "emailTo",
                title: "<spring:message code='global.emailTo'/>",
                type: 'text',
                width: "650",
                align: "left",
                textAlign: "left",
                required: true,
                validators: [{
                    type: "regexp",
                    expression: ".+\\@.+\\..+",
                }],

            },

            {
                name: "emailCC",
                title: "<spring:message code='global.emailCC'/>",
                width: "650",
                type: "text",
                align: "left",
                textAlign: "left",
                required: true,
                icons: [{
                    src: "icon/loupe.png",
                    click: function (form, item) {

                        Window_InspectionContractEmailCC.show();
                    }
                }]
            },

            {
                name: "emailBody",
                title: "<spring:message code='global.emailBody'/>",
                align: "left",
                width: "650",
                type: "textArea",
                height: 200,
                required: true
            },
            {
                name: "emailRespond",
                title: "<spring:message code='global.emailRespond'/>",
                align: "left",
                width: "500",
                required: true
            },

            {
                name: "createDate",
                type: "date",
                title: "<spring:message code='global.createDate'/>",
                width: "650",
                required: true,
                align: "left",
            },
        ]
    });

    var Window_InspectionContract = isc.Window.create({
        height: "400",
        title: "<spring:message code='inspectionContract.title'/> ",
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
            isc.VStack.create({
                autoCenter: true,
                members: [
                    DynamicForm_InspectionContract,
                    isc.HStack.create({
                        styleName: "testjalal",
                        backgroundColor: "#fefffd",
                        width: "800",
                        members: [
                            VLayout_saveButton
                        ]
                    }),
                ]
            })
        ]
    });

    var ListGrid_InspectionContract = isc.ListGrid.create({
        width: "100%",
        height: 200,
        styleName: "listgrid-child",
        dataSource: RestDataSource_InspectionContract,
        contextMenu: Menu_ListGrid_InspectionContract,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        autoFetchData: false,
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
            {
                name: "shipment.id",
                title: "<spring:message code='contact.name'/>",
                align: "center",
                hidden: true
            },
            {
                name: "shipment.contact.nameEN",
                title: "<spring:message code='contact.name'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "emailType",
                title: "<spring:message code='shipment.emailType'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "emailSubject",
                title: "<spring:message code='global.emailSubject'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "emailTo",
                title: "<spring:message code='global.emailTo'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "emailCC",
                title: "<spring:message code='global.emailCC'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "removeIcon",
                width: "4%",
                align: "center",
                showTitle: false
            }


        ],
        sortField: 0,
        dataPageSize: 50,
       filterOnKeypress: true,
        createRecordComponent: function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            if (fieldName == "removeIcon") {
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
                            ListGrid_InspectionContract.selectSingleRecord(record);
                            ListGrid_InspectionContract_remove();
                        }
                    });
                return removeImg;
            } else {
                return null;
            }
        }
    });

    ListGrid_InspectionContract.hide();

    var ListGrid_Inspection = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Inspection,
        styleName: 'expandList',
        autoFetchData: true,
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
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
            {
                name: "contractShipmentId",
                hidden: true,
                type: 'long'
            },
            {
                name: "contactId",
                type: 'long',
                hidden: true
            },
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "contractId",
                type: 'long',
                hidden: true
            },
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },

            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },

            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },

            {
                name: "portByLoading.port",
                title: "<spring:message	code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },

            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "status",
                title: "<spring:message	code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            }
        ],
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: false,
        getExpansionComponent: function (record) {
            return getExpandedComponent_Inspection(record)
        }
    });

    var criteria1 = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "material.code",
            operator: "equals",
            value: "26030090"
        }]
    };

    ListGrid_Inspection.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        ListGrid_Inspection.setData(data);
    });

    var HLayout_InspectionContract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_InspectionContract
        ]
    });
    HLayout_InspectionContract_Grid.hide();

    var HLayout_Inspection_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Inspection
        ]
    });

    var ToolStripButton_ListGrid_Inspection_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Inspection.invalidateCache();
            ListGrid_InspectionContract.setData([]);
        }
    });
    var ToolStrip_Actions_ListGrid_Inspection = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ListGrid_Inspection_Refresh
                ]
            })
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_ListGrid_Inspection,
            HLayout_Inspection_Grid
        ]
    });
    ToolStripButton_InspectionContract_Add.hide();
    ToolStripButton_InspectionContract_PrintWord.hide();