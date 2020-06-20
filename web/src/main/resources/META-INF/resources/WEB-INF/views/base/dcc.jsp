<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var dccTableName = "${dccTableName}";
    var dccTableId = "${dccTableId}";
    var criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "tblId1", operator: "equals", value: dccTableId},
            {fieldName: "tblName1", operator: "equals", value: dccTableName}
        ]
    };

    function ListGrid_Dcc_refresh() {
        if (dccTableId != null) {
            ListGrid_Dcc.fetchData(criteria, function (dsResponse, data, dsRequest) {
                ListGrid_Dcc.setData(data);
            }, {operationId: "00"});
        }
    }

    var dccDynamicForm = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: "100",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false},
                {
                    name: "documentType",
                    title: "<spring:message code='dcc.documentType'/>",
                    type: 'text',
                    required: true,
                    width: 400,
                    valueMap: {
                        "letter": "<spring:message code='dcc.letter'/>",
                         "image": "<spring:message code='dcc.image'/>"
                    },
                    validators: [
                    {
                        type:"required",
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
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    ID: "fileDcc",
                    name: "fileDcc",
                    title: "<spring:message code='global.Attachment'/> ",
                    type: "file",
                    required: true,
                    accept: ".pdf,.docx,.xlsx,.rar,.zip,image/*",
                    multiple: "",
                    width: "90%",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                }
            ]
    });

    var ToolStripButton_Dcc_Add = isc.ToolStripButtonAddLarge.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.attach.file'/>",
        click: function () {
            dccDynamicForm.clearValues();
            dccCreateWindow.show();
        }
    });

    function ListGrid_Dcc_remove() {
        var record = ListGrid_Dcc.getSelectedRecord();
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
                                actionURL: "${contextPath}/api/dcc/" + dccId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Dcc_refresh();
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

    var dccMenu = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Dcc_refresh();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        dccDynamicForm.clearValues();
                        dccCreateWindow.show();
                    }
                },

                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Dcc_remove();
                    }
                },
                {
                    isSeparator: true
                },
                {
                    title: "<spring:message code='global.form.dcc.download'/>",
                    icon: "icon/pdf.png",
                    click: function () {
                        var record = ListGrid_Dcc.getSelectedRecord();
                        if (record.tblName1 != null && record.tblName1 == "TBL_CONTRACT")
                            window.open("dcc/downloadFile?table=" + "contract" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_PERSON")
                            window.open("dcc/downloadFile?table=" + "person" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_CONTACT")
                            window.open("dcc/downloadFile?table=" + "contact" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_INSTRUCTION")
                            window.open("dcc/downloadFile?table=" + "instruction" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_SHIPMENT")
                            window.open("dcc/downloadFile?table=" + "shipment" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_INVOICE")
                            window.open("dcc/downloadFile?table=" + "invoice" + "&file=" + record.fileNewName);
                        else if (record.tblName1 != null && record.tblName1 == "TBL_WAREHOUSE_CAD")
                            window.open("dcc/downloadFile?table=" + "warehouse_cad" + "&file=" + record.fileNewName);
                    }
                }
            ]
        });

    var RestDataSource_Dcc = isc.MyRestDataSource.create({
        fields: [
            {name: "id", hidden: true, primaryKey: true, canEdit: false,},
            {
                name: "documentType",
                title: "<spring:message code='dcc.documentType'/>",
                type: 'text',
                required: true,
                width: 400
                ,
                valueMap: {
                    "letter": "<spring:message code='dcc.letter'/>",
                    "image": "<spring:message code='dcc.image'/>"
                },
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {name: "fileNewName", title: "<spring:message code='global.fileNewName'/>", type: 'text', width: 400}
        ],
        fetchDataURL: "${contextPath}/api/dcc/spec-list"
    });

    var dccSaveIButton = isc.IButtonSave.create(
        {
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {

                dccDynamicForm.validate();
                if (dccDynamicForm.hasErrors()) {
                    return;
                }

                var fileBrowserId = document.getElementById(window.fileDcc.uploadItem.getElement().id);
                var file = fileBrowserId.files[0];
                var folder;
                dccDynamicForm.setValue("tblName1", dccTableName);
                dccDynamicForm.setValue("tblId1", dccTableId);

                if (dccTableName != null && dccTableName == 'TBL_CONTACT') {
                    folder = "contact";
                    dccDynamicForm.setValue("folder", "contact");
                }
                else if (dccTableName != null && dccTableName == 'TBL_CONTRACT') {
                    folder = "contract";
                    dccDynamicForm.setValue("folder", "contract");
                }
                else if (dccTableName != null && dccTableName == 'TBL_PERSON') {
                    folder = "person";
                    dccDynamicForm.setValue("folder", "person");
                }
                else if (dccTableName != null && dccTableName == 'TBL_INSTRUCTION') {
                    folder = "instruction";
                    dccDynamicForm.setValue("folder", "instruction");
                }
                else if (dccTableName != null && dccTableName == 'TBL_SHIPMENT') {
                    folder = "shipment";
                    dccDynamicForm.setValue("folder", "shipment");
                }
                else if (dccTableName != null && dccTableName == 'TBL_INVOICE') {
                    folder = "invoice";
                    dccDynamicForm.setValue("folder", "invoice");
                }
                else if (dccTableName != null && dccTableName == 'TBL_WAREHOUSE_CAD') {
                    folder = "warehouse_cad";
                    dccDynamicForm.setValue("folder", "warehouse_cad");
                }

                var formData = new FormData();
                formData.append("file", file);
                formData.append("folder", folder);
                formData.append("data", JSON.stringify(dccDynamicForm.getValues()));

                var request = new XMLHttpRequest();

                request.open("POST", "${contextPath}/api/dcc/");
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
                            ListGrid_Dcc_refresh();
                            dccCreateWindow.close();
                        }
                    }
                }
            }
        });

    var dccCreateWindow = isc.Window.create({
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
                dccDynamicForm,
                isc.HLayout.create({
                    width: "100%",
                    align: "center",
                    members:
                        [
                            dccSaveIButton,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    dccCreateWindow.close();
                                }
                            })
                        ]
                })
            ]
    });

    var ListGrid_Dcc = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        styleName: "listgrid-child",
        dataSource: RestDataSource_Dcc,
        contextMenu: dccMenu,
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
                    name: "documentType",
                    title: "<spring:message code='dcc.documentType'/>",
                    type: 'text',
                    required: true,
                    width: 400
                    ,
                    valueMap: {
                        "letter": "<spring:message code='dcc.letter'/>",
                        "image": "<spring:message code='dcc.image'/>"
                    },
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'text',
                    width: "50%",
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
                        ListGrid_Dcc.selectSingleRecord(record);
                        ListGrid_Dcc_remove()
                    }
                });
                return removeImg;
            }
            else {
                return null;
            }
        }
    });

    var DccGridHLayout = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Dcc
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            DccGridHLayout,
            isc.HLayout.create({
                width: "100%", align: "center", margin: 10, height: "30",
                members:
                    [
                        ToolStripButton_Dcc_Add
                    ]
            })
        ]
    });