<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    var Menu_ListGrid_GoodsUnit = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_GoodsUnit_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_GoodsUnit.clearValues();
                    Window_GoodsUnit.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_GoodsUnit_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_GoodsUnit_remove();
                }
            },
            {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    window.open("/goodsUnit/print/pdf");
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    window.open("/goodsUnit/print/excel");
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    window.open("/goodsUnit/print/html");
                }
            }
        ]
    });

    var Menu_ListGrid_GoodsUnit_Print = isc.Menu.create({
        width: 150,
        data: [
            {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    window.open("/goodsUnit/print/pdf");
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    window.open("/goodsUnit/print/excel");
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    window.open("/goodsUnit/print/html");
                }
            }
        ]
    });


    var ValuesManager_GoodsUnit = isc.ValuesManager.create({});
    var DynamicForm_GoodsUnit = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
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
        numCols: 1,

        fields: [
            {name: "id", hidden: true,},
            {type: "RowSpacerItem"},
            {
                name: "code", title: "<spring:message code='goods.code'/>", type: 'long', required: true, width: 400,
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "nameFA",
                title: "<spring:message code='goods.nameFa'/>",
                required: true,
                readonly: true,
                width: 400
            },
            {name: "nameEN", title: "<spring:message code='goods.nameLatin'/>", type: 'text', width: 400},
            {name: "symbol", title: "<spring:message code='goods.symbol'/>", type: 'text', width: 400},
            {name: "decimalDigit", title: "<spring:message code='goods.decimalDigit'/>", width: 400},
            {type: "RowSpacerItem"}
        ]
    });

    var IButton_GoodsUnit_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ValuesManager_GoodsUnit.validate();
            DynamicForm_GoodsUnit.validate();
            if (DynamicForm_GoodsUnit.hasErrors()) {
                return;
            }
            var data = DynamicForm_GoodsUnit.getValues();
            isc.RPCManager.sendRequest({
                actionURL: "rest/goodsUnit/add",
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
//params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_GoodsUnit_refresh();
                        Window_GoodsUnit.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });

    var Window_GoodsUnit = isc.Window.create({
        title: "<spring:message code='goods.title'/> ",
        width: 580,
        height: 500,
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
            DynamicForm_GoodsUnit, IButton_GoodsUnit_Save
        ]
    });

    function ListGrid_GoodsUnit_refresh() {
        ListGrid_GoodsUnit.invalidateCache();
    };

    function ListGrid_GoodsUnit_remove() {

        var record = ListGrid_GoodsUnit.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    hide();
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

                        var goodsUnitId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/goodsUnit/remove/" + goodsUnitId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
// data: goodsUnitId,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_GoodsUnit.invalidateCache();
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
    };

    function ListGrid_GoodsUnit_edit() {

        var record = ListGrid_GoodsUnit.getSelectedRecord();

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
            DynamicForm_GoodsUnit.editRecord(record);
            Window_GoodsUnit.show();
        }
    };


    var ToolStripButton_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_GoodsUnit_refresh();
        }
    });

    var ToolStripButton_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_GoodsUnit.clearValues();
            Window_GoodsUnit.show();
        }
    });

    var ToolStripButton_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_GoodsUnit_edit();
        }
    });


    var ToolStripButton_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_GoodsUnit_remove();
        }
    });

    var ToolStripButton_Filter = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/search.png",
        title: "<spring:message code='global.form.filter'/>",
        click: function () {
//alert('Test');
//ListGrid_GoodsUnit.showFilterEditor(true);
//ListGrid_GoodsUnit.filterOnKeypress(true);
//ListGrid_GoodsUnit.redraw();
        }
    });

    var ToolStripButton_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            window.open("/goodsUnit/print/pdf");
        }
    });

    var ToolStrip_Actions = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Refresh,
            ToolStripButton_Add,
            ToolStripButton_Edit,
            ToolStripButton_Remove,
            ToolStripButton_Filter,
            ToolStripButton_Print
        ]
    });

    var HLayout_Actions = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions
        ]
    });

    var RestDataSource_GoodsUnit = isc.RestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='goods.code'/> "},
            {name: "nameFA", title: "<spring:message code='goods.nameFa'/> "},
            {name: "nameEN", title: "<spring:message code='goods.nameLatin'/> "},
            {name: "symbol", title: "<spring:message code='goods.symbol'/>"},
            {name: "decimalDigit", title: "<spring:message code='goods.decimalDigit'/>"}
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/goodsUnit/list"
    });

    var ListGrid_GoodsUnit = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_GoodsUnit,
        contextMenu: Menu_ListGrid_GoodsUnit,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='goods.code'/>", align: "center"},
            {name: "nameFA", title: "<spring:message code='goods.nameFa'/> ", align: "center"},
            {name: "nameEN", title: "<spring:message code='goods.nameLatin'/>", align: "center"},
            {name: "symbol", title: "<spring:message code='goods.symbol'/>", align: "center"},
            {name: "decimalDigit", title: "<spring:message code='goods.decimalDigit'/>", align: "center"},

        ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });


    var HLayout_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_GoodsUnit
        ]
    });

    var VLayout_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions, HLayout_Grid
        ]
    });