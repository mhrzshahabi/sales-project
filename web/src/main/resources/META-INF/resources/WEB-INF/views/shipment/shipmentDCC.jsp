<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    var dccTableName = "TBL_SHIPMENT";
    var dccDocumentType = "pattern";
    var criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "tblName1", operator: "equals", value: dccTableName},
            {fieldName: "documentType", operator: "equals", value: dccDocumentType}

        ]
    };

    function ListGrid_Shipment_Dcc_refresh() {
        ListGrid_Shipment_Dcc.fetchData(criteria, function (dsResponse, data, dsRequest) {
            ListGrid_Shipment_Dcc.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_Shipment_Dcc_remove() {
        var record = ListGrid_Shipment_Dcc.getSelectedRecord();
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
                buttons: [
                    isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                    isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var dccId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/shipmentDcc/" + dccId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Shipment_Dcc_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

    var RestDataSource_Shipment_Dcc = isc.MyRestDataSource.create({
        fields: [
            {name: "id", hidden: true, primaryKey: true, canEdit: false},
            {
                name: "description",
                title: "<spring:message code='global.description'/>",
                type: 'text',
                width: 400
            },
            {
                name: "fileName",
                title: "<spring:message code='global.fileName'/>",
                type: 'text',
                required: true,
                width: 400,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {name: "fileNewName", title: "<spring:message code='global.fileNewName'/>", type: 'text', width: 400}
        ],
        transformResponse: function (dsResponse, dsRequest, data) {
            let extractNumber = function (ix, letter) {
                if (!letter.startsWith("ShipOrder_"))
                    return "-";
                return letter.split("ShipOrder_")[1].split("_")[ix];
            };
            data.response.data.forEach(d => d.material = extractNumber(0, d.fileNewName));
            data.response.data.forEach(d => d.shipmentType = extractNumber(1, d.fileNewName));
            return this.Super("transformResponse", arguments);
        },
        fetchDataURL: "${contextPath}/api/shipmentDcc/spec-list"
    });
    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descEN"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });
    var RestDataSource_ShipmentTypeInShipmentDcc = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentType", title: "<spring:message code='shipment.type'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentType/spec-list"
    });

    var shipmentDccMenu = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_Dcc_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>",
                icon: "pieces/16/icon_add.png",
                click: function () {
                    shipmentDccDynamicForm.clearValues();
                    shipmentDccCreateWindow.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>",
                icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Shipment_Dcc_remove();
                }
            },
            {isSeparator: true},
            {
                title: "<spring:message code='global.form.dcc.download'/>",
                icon: "icon/pdf.png",
                click: function () {
                    var record = ListGrid_Shipment_Dcc.getSelectedRecord();
                    if (record.tblName1 != null)
                        window.open("dcc/downloadFile?table=" + "shipment" + "&file=" + record.fileNewName);
                }
            }
        ]
    });
    var ListGrid_Shipment_Dcc = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        styleName: "listgrid-child",
        dataSource: RestDataSource_Shipment_Dcc,
        contextMenu: shipmentDccMenu,
        autoFetchData: true,
        initialCriteria: criteria,
        showFilterEditor: false,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        fields:
            [
                {name: "id", hidden: true},
                {
                    name: "fileName",
                    title: "<spring:message code='global.fileName'/>",
                    type: 'text',
                    width: "25%",
                    align: "center"
                },
                {
                    name: "material",
                    title: "<spring:message code='material.title'/>",
                    width: "20%",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descEN",
                    valueField: "id",
                },
                {
                    name: "shipmentType",
                    title: "<spring:message code='shipment.shipmentType'/>",
                    width: "15%",
                    displayField: "shipmentType",
                    valueField: "id",
                    optionDataSource: RestDataSource_ShipmentTypeInShipmentDcc,

                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'text',
                    width: "25%",
                    align: "center"
                },
                {
                    name: "editIcon",
                    width: "4%",
                    hidden: true,
                    align: "center",
                    showTitle: false
                },
                {
                    name: "download",
                    width: "4%",
                    align: "center",
                    showTitle: false,
                },
                {
                    name: "removeIcon",
                    width: "4%",
                    align: "center",
                    showTitle: false
                },
            ],
        createRecordComponent: function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            if (fieldName == "removeIcon") {
                var removeImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_delete.png",
                    prompt: "حذف",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {
                        ListGrid_Shipment_Dcc.selectSingleRecord(record);
                        ListGrid_Shipment_Dcc_remove()
                    }
                });
                return removeImg;
            } else if (fieldName == "download") {
                var downloadImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/download.png",
                    prompt: "دانلود",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {
                        var record = ListGrid_Shipment_Dcc.getSelectedRecord();
                        ListGrid_Shipment_Dcc.selectSingleRecord(record);
                        if (record.tblName1 != null)
                            window.open("dcc/downloadFile?table=" + "shipment" + "&file=" + record.fileNewName);
                    }
                });
                return downloadImg;
            } else {
                return null;
            }
        }
    });
    var shipmentDccDynamicForm = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: "100",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false},
                {
                    type: "RowSpacerItem"
                },
                {
                    name: "materialId",
                    title: "<spring:message code='material.title'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descEN",
                    valueField: "id",
                    width: 300,
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                        {
                            name: "code",
                            title: "<spring:message code='material.code'/>",
                            showHover: true
                        },
                        {
                            name: "descEN",
                            title: "<spring:message code='material.descEN'/>",
                            showHover: true
                        }
                    ]
                },
                {
                    name: "shipmentTypeId",
                    displayField: "shipmentType",
                    valueField: "id",
                    title: "<spring:message code='shipment.shipmentType'/>",
                    width: 300,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ShipmentTypeInShipmentDcc,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {
                            name: "shipmentType",
                            width: "10%",
                            align: "center"
                        }],
                    pickListHeight: "500",
                    required: true,
                    validators: [{
                        type: "required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'textArea',
                    required: true,
                    width: 400,
                    height: "100",
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    ID: "fileShipmentDcc",
                    name: "fileShipmentDcc",
                    title: "<spring:message code='global.file'/> ",
                    type: "file",
                    required: true,
                    accept: "doc/*,docx/*",
                    multiple: "",
                    width: 200,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },

            ]
    });
    var shipmentDccAddIButton = isc.IButtonSave.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.attach.file'/>",
        click: function () {
            shipmentDccDynamicForm.clearValues();
            shipmentDccCreateWindow.animateShow();
        }
    });
    var shipmentDccSaveIButton = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            shipmentDccDynamicForm.validate();
            if (shipmentDccDynamicForm.hasErrors()) {
                return;
            }
            var fileBrowserId = document.getElementById(window.fileShipmentDcc.uploadItem.getElement().id);
            var file = fileBrowserId.files[0];
            let fileExtensionIsValid = RegExp(".+(.doc|.docx)$", "i").test(file.name);
            if (!fileExtensionIsValid) {
                isc.warn("<spring:message code='dcc.upload.fileType.error'/>");
                return false;
            }

            shipmentDccDynamicForm.setValue("tblName1", dccTableName);
            let fileName = shipmentDccDynamicForm.getItem("fileShipmentDcc").getValue().replace(RegExp("(.doc|.docx)$"), "");
            let dccFileNewName = "ShipOrder_" + shipmentDccDynamicForm.getItem("materialId").getValue() + "_" + shipmentDccDynamicForm.getItem("shipmentTypeId").getValue() + "_" + fileName.substr(fileName.lastIndexOf("\\")).replace("\\", "");
            console.log("dccFileNewName", dccFileNewName);
            shipmentDccDynamicForm.setValue("fileNewName", dccFileNewName);
            shipmentDccDynamicForm.setValue("documentType", "pattern");
            shipmentDccDynamicForm.setValue("folder", "shipment");

            var formData = new FormData();
            formData.append("file", file);
            formData.append("folder", "shipment");
            formData.append("data", JSON.stringify(shipmentDccDynamicForm.getValues()));

            var request = new XMLHttpRequest();

            request.open("POST", "${contextPath}/api/shipmentDcc/");
            request.setRequestHeader("Authorization", "Bearer " + "<%= (String) session.getAttribute(ConstantVARs.ACCESS_TOKEN) %>");
            request.setRequestHeader("contentType", "application/json; charset=utf-8");
            request.send(formData);
            request.onreadystatechange = function () {
                if (request.readyState == XMLHttpRequest.DONE) {
                    if (request.status == 0)
                        isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
                    else if (request.status == 500)
                        isc.warn("<spring:message code='dcc.upload.error.message'/>");
                    else if (request.status == 200 || request.status == 201) {
                        isc.say("<spring:message code='dcc.upload.success.message'/>");
                        ListGrid_Shipment_Dcc_refresh();
                        shipmentDccCreateWindow.close();
                    } else if (request.status == 400) {
                        isc.warn(JSON.parse(request.response).errors.map(re => re.message).reduce((a, b) => (a + "\n" + b)));
                    }
                }
            }
        }
    });
    var shipmentDccCreateWindow = isc.Window.create({
        title: "<spring:message code='dcc.Attachment'/> ",
        width: 550,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        canDragReposition: false,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                shipmentDccDynamicForm,
                isc.HLayout.create({
                    width: "100%",
                    align: "center",
                    members:
                        [
                            shipmentDccSaveIButton,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    shipmentDccCreateWindow.close();
                                }
                            })
                        ]
                })
            ]
    });
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_Dcc,
            isc.HLayout.create({
                width: "100%",
                layoutMargin: 10,
                membersMargin: 5,
                textAlign: "center",
                align: "center",
                members:
                    [
                        shipmentDccAddIButton,
                        isc.IButtonCancel.create({
                            top: 260,
                            layoutMargin: 5,
                            membersMargin: 5,
                            width: 120,
                            title: "<spring:message code='global.cancel'/>",
                            icon: "pieces/16/icon_delete.png",
                            click: function () {
                                Window_Shipment_Dcc.close();
                            }
                        })
                    ]
            })
        ]
    });