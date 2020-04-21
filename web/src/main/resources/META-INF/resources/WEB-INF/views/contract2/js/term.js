var termTab = {
    log: {},
    variable: {

        method: "POST",
        url: contextPath + "/api/term/",
    },
    method: {},
    restDataSource: {},
    tab: {},
    listGrid: {},
    menu: {},
    label: {},
    dialog: {

        notSelected: function () {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function (button, index) {
                    this.close();
                }
            });
        },
        moreSelected: function () {

            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.more-selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function (button, index) {
                    this.close();
                }
            });
        },
        question: function (clickCallBack, message = "<spring:message code='global.delete.ask'/>") {

            isc.Dialog.create({
                message: message,
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
                    title: "<spring:message code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0)
                        clickCallBack();
                }
            });
        },
        ok: function (warn = "") {

            var OkDialog;
            if (warn === "") {

                OkDialog = isc.Dialog.create({

                    message: "<spring:message code='global.form.request.successful'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.ok'/>",
                });
                setTimeout(function () {
                    OkDialog.close();
                }, 3000);
            } else {

                OkDialog = isc.Dialog.create({

                    message: "<spring:message code='global.form.request.successful'/><br><spring:message code='global.message'>:&nbsp;" + warn,
                    icon: "[SKIN]warn.png",
                    title: "<spring:message code='global.ok'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            }
        },
        error: function (response) {

            termTab.log["errorResponse"] = response;
            isc.RPCManager.handleError(response, null);
        },
        say: function (message, title) {

            isc.Dialog.create({

                message: message,
                icon: "[SKIN]say.png",
                title: title || "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function (button, index) {
                    this.close();
                }
            });
        }
    },
    dynamicForm: {
        FormItem: {}
    },
    button: {},
    window: {},
    toolStrip: {},
    hLayout: {},
    vLayout: {},
    hStack: {},
    vStack: {},
    chart: {}
};

//***************************************************** RESTDATASOURCE *************************************************

termTab.restDataSource.term = isc.MyRestDataSource.create({
    fields: [
        {name: "id", hidden: false, primaryKey: true, type: "number"},
        {name: "version", hidden: false, type: "number"},
        {name: "title", type: "string"},
        {name: "editable", type: "boolean"},
        {name: "eStatus", type: "number"},
        {name: "description", type: "string", showHover: true, hoverWidth: "300"}
    ],
    fetchDataURL: termTab.variable.url + "spec-list"
});
termTab.restDataSource.OperationUnit = isc.RestDataSource.create({
    fields: [
        {name: "id"},
        {name: "code"},
        {name: "name"},
        {name: "version"},
    ],
    dataFormat: "json",
    jsonPrefix: "",
    jsonSuffix: "",
    transformRequest: courseTab.method.transformRequest,
    fetchDataURL: courseTab.variable.operationUnitUrl + "get-valid-list"
});

//*************************************************** Componnents ******************************************************

termTab.menu.term = isc.Menu.create({
    width: 150,
    data: [
        {
            icon: "pieces/16/refresh.png",
            title: '<spring:message code="global.form.refresh" />',
            click: function () {
                termTab.method.refresh();
            }
        },
        {
            icon: "pieces/16/icon_add.png",
            title: '<spring:message code="global.form.new" />',
            click: function () {
                termTab.method.add();
            }
        },
        {
            icon: "pieces/16/icon_edit.png",
            title: '<spring:message code="global.form.edit" />',
            click: function () {
                termTab.method.edit();
            }
        },
        {
            icon: "pieces/16/icon_delete.png",
            title: '<spring:message code="global.form.remove" />',
            click: function () {
                termTab.method.remove();
            }
        }
    ]
});
termTab.listGrid.term = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: termTab.restDataSource.term,
    contextMenu: termTab.menu.term,
    autoFetchData: true,
    showFilterEditor: true,
});
termTab.dynamicForm.term = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    align: "center",
    titleAlign: "right",
    colWidths: ["30%", "*"],
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required" />',
    fields: [
        {
            hidden: true,
            name: "id",
            type: "number",
            title: "<spring:message code='global.id'/>"
        },
        {
            hidden: true,
            name: "version",
            type: "number",
            title: "<spring:message code='global.version'/>"
        },
        {
            required: true,
            name: "title",
            title: "<spring:message code='global.title'/>"
        },
        {
            type: "textArea",
            name: "description",
            title: "<spring:message code='global.description'/>"
        }
    ]
});
termTab.hLayout.saveOrExitHlayout = isc.HLayout.create({

    height: "5%",
    width: "100%",
    showEdges: false,
    alignLayout: "center",
    padding: 10,
    layoutMargin: 5,
    membersMargin: 10,
    members: [
        isc.IButtonSave.create({

            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {

                // var evalHintForm = window[zoneIndexTab.dynamicForm.EvalHint.ID];
                // evalHintForm.validate();
                // if (evalHintForm.hasErrors())
                //     return;
                //
                // var data = evalHintForm.getValues();
                // var url = zoneIndexTab.variable.evalHintListUrl + (data.id == null ? "" : data.id);
                // isc.RPCManager.sendRequest({
                //
                //     actionURL: url,
                //     useSimpleHttp: true,
                //     contentType: zoneIndexTab.variable.contentType,
                //     httpHeaders: zoneIndexTab.variable.httpHeaders,
                //     httpMethod: zoneIndexTab.variable.evalHintMethod,
                //     showPrompt: true,
                //     data: JSON.stringify(data),
                //     callback: function (resp) {
                //
                //         if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                //
                //             zoneIndexTab.dialog.ok();
                //             zoneIndexTab.method.RefreshEvalHint();
                // termTab.window.term.close();
                //         } else
                //             zoneIndexTab.dialog.error(resp);
                //     }
                // });
            }
        }),
        isc.IButtonCancel.create({

            width: 100,
            prompt: "",
            orientation: "vertical",
            icon: "pieces/16/icon_delete.png",
            title: "<spring:message code='global.close'/>",
            click: function () {

                termTab.window.term.close();
            }
        })
    ]
});
termTab.window.term = isc.Window.create({

    width: 500,
    isModal: true,
    autoSize: true,
    autoDraw: false,
    autoCenter: true,
    showModalMask: true,
    dismissOnEscape: true,
    align: "center",
    title: '<spring:message code=""/>',
    closeClick: function () {

        this.Super("closeClick", arguments)
    },
    items: [
        isc.VLayout.create({

            width: "100%",
            height: "100%",
            members: [
                termTab.dynamicForm.term,
                termTab.hLayout.saveOrExitHlayout
            ]
        })
    ]
});

//*************************************************** Functions ********************************************************

termTab.method.remove = function () {

    const record = termTab.listGrid.term.getSelectedRecord();
    if (record != null && record.id != null) {
        termTab.dialog.question(
            () => {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: termTab.variable.url + record.id,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            termTab.method.refresh();
                            termTab.dialog.ok();
                        } else {
                            termTab.dialog.error(resp);
                        }
                    }
                }));
            });
    } else {
        termTab.dialog.notSelected();
    }
}
termTab.method.add = function () {
    termTab.variable.method = "POST";
    termTab.dynamicForm.term.clearValues();
    termTab.dynamicForm.term.show();
};
termTab.method.refresh = function () {
    termTab.listGrid.term.invalidateCache();
}
termTab.method.edit = function () {

    var record = termTab.listGrid.term.getSelectedRecord();
    if (record == null || record.id == null)
        termTab.dialog.notSelected();
    else {
        termTab.variable.method="PUT";
        termTab.dynamicForm.term.editRecord(JSON.parse(JSON.stringify(record)))
        termTab.window.term.show();
    }
};

//*************************************************** layout ***********************************************************

termTab.toolStrip.add = isc.ToolStripButtonAdd.create({
    title: "<spring:message code='global.form.new'/>",
    click: function () {
        termTab.method.add();
    }
});

termTab.toolStrip.refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        termTab.method.refresh();
    }
});

termTab.toolStrip.remove = isc.ToolStripButtonRemove.create({
    icon: "[SKIN]/actions/remove.png",
    title: '<spring:message code="evalution.form.freePerson" />',
    click: function () {
        termTab.method.remove();
    }
});
termTab.toolStrip.edit = isc.ToolStripButtonEdit.create({
    icon: "[SKIN]/actions/edit.png",
    title: "<spring:message code='global.form.edit'/>",
    click: function () {
        termTab.method.edit();
    }
});
termTab.toolStrip.actions = isc.ToolStrip.create({
    width: "100%",
    members: [
        termTab.toolStrip.add,
        termTab.toolStrip.edit,
        termTab.toolStrip.remove,
        isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                termTab.toolStrip.refresh,
            ]
        })
    ]
});
termTab.vLayout.body = isc.VLayout.create({

    width: "100%",
    height: "100%",
    members: [termTab.toolStrip.actions, termTab.listGrid.term]
});





