<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    var Menu_ListGrid_FiscalYear = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "بازخوانی اطلاعات", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_FiscalYear_refresh();
                }
            },
            {
                title: "ایجاد رکورد", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_FiscalYear.clearValues();
                    Window_FiscalYear.show();
                }
            },
            {
                title: "ویرایش رکورد", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_FiscalYear_edit();
                }
            },
            {
                title: "حذف رکورد", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_FiscalYear_remove();
                }
            },
            {isSeparator: true},
            {
                title: "ارسال به PDF", icon: "icon/pdf.png",
                click: function () {
                    window.open("/fiscalYear/print/pdf");
                }
            },
            {
                title: "ارسال به Excel", icon: "icon/excel.png",
                click: function () {
                    window.open("/fiscalYear/print/excel");
                }
            },
            {
                title: "ارسال به HTML", icon: "icon/html.jpg",
                click: function () {
                    window.open("/fiscalYear/print/html");
                }
            }
        ]
    });

    var RestDataSource_FiscalYear = isc.RestDataSource.create({
        fields: [
            {name: "id"},
            {name: "code"},
            {name: "nameFA"},
            {name: "nameEN"},
            {name: "startDate"},
            {name: "endDate"},
            {name: "isActive", valueMap: {"true": "فعال", "false": "غیرفعال"}}
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/fiscalYear/list"
    });

    var ListGrid_FiscalYear = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_FiscalYear,
        contextMenu: Menu_ListGrid_FiscalYear,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "کد سال مالی", align: "center"},
            {name: "nameFA", title: "نام سال مالی", align: "center"},
            {name: "nameEN", title: "نام لاتین سال مالی", align: "center"},
            {name: "startDate", title: "تاریخ شروع سال مالی", align: "center"},
            {name: "endDate", title: "تاریخ پایان سال مالی", align: "center"},
            {name: "isActive", title: "وضعیت فعال بودن", align: "center"}
        ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    });

    var Menu_ListGrid_FiscalYear_Print = isc.Menu.create({
        width: 150,
        data: [
            {isSeparator: true},
            {
                title: "ارسال به PDF", icon: "icon/pdf.png",
                click: function () {
                    window.open("/fiscalYear/print/pdf");
                }
            },
            {
                title: "ارسال به Excel", icon: "icon/excel.png",
                click: function () {
                    window.open("/fiscalYear/print/excel");
                }
            },
            {
                title: "ارسال به HTML", icon: "icon/html.jpg",
                click: function () {
                    window.open("/fiscalYear/print/html");
                }
            }
        ]
    });


    var ValuesManager_FiscalYear = isc.ValuesManager.create({});

    var DynamicForm_FiscalYear = isc.DynamicForm.create({
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
        requiredMessage: "فیلد اجباری است.",
        numCols: 1,

        fields: [
            {name: "id", hidden: true,},
            {
                name: "code", title: "کد سال مالی", type: 'integer', required: true,
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {name: "nameFA", title: "نام سال مالی", required: true, readonly: true},
            {name: "nameEN", title: "نام لاتین سال مالی", type: 'text'},
            {
                name: "startDate", title: "تاریخ شروع", type: 'text', ID: "startDate",
                icons: [{
                    src: "pieces/pcal.png", click: function () {
                        displayDatePicker('startDate', this, 'ymd', '/');
                    }
                }]
            },
            {
                name: "endDate", title: "تاریخ خاتمه", type: 'text', ID: "endDate",
                icons: [{
                    src: "pieces/pcal.png", click: function () {
                        displayDatePicker('endDate', this, 'ymd', '/');
                    }
                }]
            },
            {name: "isActive", title: "فعال", type: "boolean"}
        ]
    });

    var IButton_FiscalYear_Save = isc.IButton.create({
        top: 260,
        title: "ذخیره",
        icon: "pieces/16/save.png",
        click: function () {
            ValuesManager_FiscalYear.validate();
            DynamicForm_FiscalYear.validate();
            if (DynamicForm_FiscalYear.hasErrors()) {
                return;
            }
            var data = DynamicForm_FiscalYear.getValues();

            isc.RPCManager.sendRequest({
                /*willHandleError: true,
                timeout: 500,*/
                actionURL: "rest/fiscalYear/add",
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.status < 0) {
                        isc.say('خطا در اتصال به سرور !!!');
                    }
// isc.say(RpcResponse_o);
                    if (RpcResponse_o.data == 'success') {
                        isc.say("عملیات با موفقیت انجام شد.");
                        ListGrid_FiscalYear_refresh();
                        Window_FiscalYear.close();
                    } else if (RpcResponse_o.data == 'failed') {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });

    var Window_FiscalYear = isc.Window.create({
        title: "سال مالی",
        width: 500,
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
            DynamicForm_FiscalYear, IButton_FiscalYear_Save
        ]
    });

    function ListGrid_FiscalYear_refresh() {
        ListGrid_FiscalYear.invalidateCache();
    };

    function ListGrid_FiscalYear_remove() {

        var records = ListGrid_FiscalYear.getSelectedRecords();
        if (records == null || records.size() < 1) {
            isc.Dialog.create({
                message: "رکوردی انتخاب نشده است !",
                icon: "[SKIN]ask.png",
                title: "پیغام",
                buttons: [isc.Button.create({title: "تائید"})],
                buttonClick: function (button, index) {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "آیا رکوردهای انتخاب شده حذف گردد؟",
                icon: "[SKIN]ask.png",
                title: "حذف تائید",
                buttons: [isc.Button.create({title: "<spring:message code='yes'/>"}), isc.Button.create({title: "خیر"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/fiscalYear/remove/",
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            data: records.map(r = > r.id),
                            serverOutputAsString
                    :
                        false,
                            callback
                    :

                        function (RpcResponse_o) {
                            if (RpcResponse_o.data == 'success') {
                                ListGrid_FiscalYear.invalidateCache();
                                isc.say("حذف رکورد با موفقیت انجام شد.");
                            } else {
                                isc.say("!خطا در حذف");
                            }
                        }
                    })
                        ;
                    }
                }
            });
        }
    };

    function ListGrid_FiscalYear_edit() {

        var record = ListGrid_FiscalYear.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                }
            });
        } else {
            DynamicForm_FiscalYear.editRecord(record);
            Window_FiscalYear.show();
        }
    };

    var ToolStripButton_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_FiscalYear_refresh();
        }
    });

    var ToolStripButton_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_FiscalYear_edit();
        }
    });

    var ToolStripButton_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_FiscalYear.clearValues();
            Window_FiscalYear.show();
        }
    });

    var ToolStripButton_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_FiscalYear_remove();
        }
    });

    var ToolStripButton_Filter = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/search.png",
        title: "<spring:message code='global.form.filter'/>",
        click: function () {
// TODO: implement later
        }
    });

    var ToolStripButton_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            Menu_ListGrid_FiscalYear_Print.show();
        }
    });

    var ToolStrip_Actions = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Refresh,
            ToolStripButton_Edit,
            ToolStripButton_Add,
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

    var HLayout_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_FiscalYear
        ]
    });

    var VLayout_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions, HLayout_Grid
        ]
    });