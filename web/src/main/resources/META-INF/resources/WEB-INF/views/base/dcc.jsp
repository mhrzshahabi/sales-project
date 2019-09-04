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
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "bottom",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
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
                        "contract": "<spring:message code='contract.title'/>"
                    }
                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'textArea',
                    width: 400,
                    height: "100"
                },
                {
                    ID: "fileDcc",
                    name: "fileDcc",
                    title: "<spring:message code='global.Attachment'/> ",
                    type: "file",
                    required: "true",
                    accept: ".pdf,.docx,.xlsx,.rar,.zip,image/*",
                    multiple: "",
                    width: "90%",
                }
            ]
    });
    var ToolStripButton_Dcc_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Dcc_refresh();
        }
    });
    var ToolStripButton_Dcc_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            dccDynamicForm.clearValues();
            dccCreateWindow.show();
        }
    });
    <%--var ToolStripButton_Dcc_Edit = isc.ToolStripButton.create({--%>
        <%--icon: "[SKIN]/actions/edit.png",--%>
        <%--title: "<spring:message code='global.form.edit'/>",--%>
        <%--click: function () {--%>
            <%--ListGrid_Dcc_edit();--%>
        <%--}--%>
    <%--});--%>

    var ToolStripButton_Dcc_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Dcc_remove();
        }
    });
    var ToolStrip_Actions_Dcc = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Dcc_Refresh,
                ToolStripButton_Dcc_Add,
                // ToolStripButton_Dcc_Edit,
                ToolStripButton_Dcc_Remove
            ]
    });

    function ListGrid_Dcc_edit() {
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
            dccDynamicForm.editRecord(record);
            dccCreateWindow.show();
        }
    }

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
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
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
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
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

    var dccActionsHLayout = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Dcc
            ]
    });
    var dccMenu = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Dcc_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    dccDynamicForm.clearValues();
                    dccCreateWindow.show();
                }
            },
            // {
                <%--title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",--%>
                // click: function () {
                //     ListGrid_Dcc_edit();
                // }
            // },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Dcc_remove();
                }
            },
            {isSeparator: true},
            {
                title: "<spring:message code='global.form.dcc.download'/>", icon: "icon/pdf.png",
                click: function () {
                    var record = ListGrid_Dcc.getSelectedRecord();
                    if (record.tblName1 != null && record.tblName1 == "TBL_CONTRACT")
                        window.open("dcc/downloadFile?table=" + "contract" + "&file=" + record.fileNewName);
                    else if (record.tblName1 != null && record.tblName1 == "TBL_CONTACT")
                        window.open("dcc/downloadFile?table=" + "contact" + "&file=" + record.fileNewName);
                    else if (record.tblName1 != null && record.tblName1 == "TBL_INSTRUCTION")
                        window.open("dcc/downloadFile?table=" + "instruction" + "&file=" + record.fileNewName);
                    else if (record.tblName1 != null && record.tblName1 == "TBL_SHIPMENT")
                        window.open("dcc/downloadFile?table=" + "shipment" + "&file=" + record.fileNewName);
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
                    "letter": "<spring:message code='dcc.letter'/>"
                }
            },
            {
                name: "description",
                title: "<spring:message code='global.description'/>",
                type: 'text',
                // required: true,
                width: 400
            },
            {
                name: "fileName",
                title: "<spring:message code='global.fileName'/>",
                type: 'text',
                required: true,
                width: 400
            },
            {name: "fileNewName", title: "<spring:message code='global.fileNewName'/>", type: 'text', width: 400}
        ],
        fetchDataURL: "${contextPath}/api/dcc/spec-list"
    });

    var dccSaveIButton = isc.IButton.create({
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

            if (dccTableName != null && dccTableName === 'TBL_CONTACT') {
                folder = "contact";
                dccDynamicForm.setValue("folder", "contact");
            } else if (dccTableName != null && dccTableName === 'TBL_CONTRACT') {
                folder = "contract";
                dccDynamicForm.setValue("folder", "contract");
            } else if (dccTableName != null && dccTableName === 'TBL_INSTRUCTION') {
                folder = "instruction";
                dccDynamicForm.setValue("folder", "instruction");
            } else if (dccTableName != null && dccTableName === 'TBL_SHIPMENT') {
                folder = "shipment";
                dccDynamicForm.setValue("folder", "shipment");
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
            request.timeout = 1000;
            request.ontimeout = function () {
                isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
            }
            request.onreadystatechange = function () {
                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status === 500)
                        isc.warn("<spring:message code='dcc.upload.error.message'/>");
                    if (request.status === 200 || request.status == 201) {
                        isc.say("<spring:message code='dcc.upload.success.message'/>");
                        ListGrid_Dcc_refresh();
                        dccCreateWindow.close();
                    } else if (request.responseText !== "" && JSON.parse(request.responseText).exceptionClass.includes("MaxUploadSizeExceededException"))
                        isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
                }
            }
        }
    });
    var dccCreateWindow = isc.Window.create({
        title: "<spring:message code='dcc.Attachment'/> ",
        width: 580,
        // height: 300,
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
                dccDynamicForm,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            dccSaveIButton,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "rateEditExitIButton",
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
        dataSource: RestDataSource_Dcc,
        contextMenu: dccMenu,
        sortField: 0,
        autoFetchData: true,
        initialCriteria: criteria,
        showFilterEditor: false,
        filterOnKeypress: true,
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
                        "contract": "<spring:message code='contract.title'/>"
                    }
                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'text',
                    width: "50%",
                    align: "center"
                }
            ]
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
            dccActionsHLayout, DccGridHLayout
        ]
    });