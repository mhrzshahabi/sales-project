<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

//<script>

    <%--<spring:eval var="contextPath" expression="@environment.getProperty('nicico.rest-api.url')"/>--%>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var method = "POST";
    var Menu_ListGrid_skill_level = isc.Menu.create({
        width: 150,
        data: [{
            title: "بازخوانی اطلاعات", icon: "pieces/16/refresh.png", click: function () {
                ListGrid_skill_level_refresh();
            }
        }, {
            title: "ایجاد", icon: "pieces/16/icon_add.png", click: function () {
                method = "POST";
                DynamicForm_skill_level.clearValues();
                Window_skill_level.show();
            }
        }, {
            title: "ویرایش", icon: "pieces/16/icon_edit.png", click: function () {
                ListGrid_skill_level_edit();
            }
        }, {
            title: "حذف", icon: "pieces/16/icon_delete.png", click: function () {
                ListGrid_skill_level_remove();
            }
        }, {isSeparator: true}, {
            title: "ارسال به Pdf", icon: "icon/pdf.png", click: function () {
                window.open("/skill-level/print/pdf");
            }
        }, {
            title: "ارسال به Excel", icon: "icon/excel.png", click: function () {
                window.open("/skill-level/print/excel");
            }
        }, {
            title: "ارسال به Html", icon: "icon/html.jpg", click: function () {
                window.open("/skill-level/print/html");
            }
        }]
    });
    var RestDataSource_skill_level = isc.RestDataSource.create({
        fields: [{name: "id"}, {name: "titleFa"}, {name: "titleEn"},
            {
                name: "version"
            }
        ], dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "http://localhost:9090"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "http://localhost:9090/api/skill-level/spec-list"
    });
    var ListGrid_skill_level = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_skill_level,
        contextMenu: Menu_ListGrid_skill_level,
        doubleClick: function () {
            ListGrid_skill_level_edit();
        },
        fields: [{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true}
            , {name: "titleFa", title: "نام فارسی", align: "center"}, {
                name: "titleEn",
                title: "نام لاتین ",
                align: "center"
            }, {name: "version", align: "center"}],
        sortField: 1,
        sortDirection: "descending",
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی ",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا ",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",

    });
    var DynamicForm_skill_level = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        colWidths: ["30%", "*"],
        titleAlign: "right",
        requiredMessage: "فیلد اجباری است.",
        numCols: 2,
        margin: 10,
        newPadding: 5,
        fields: [{name: "id", hidden: true},
            {
                name: "titleFa",
                title: "نام فارسی",
                required: true,
                type: 'text',
                readonly: true,
                hint: "Persian/فارسی",
                keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9 ]",
                length: "20",
                validators: [{
                    type: "isString",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "نام مجاز بین چهار تا بیست کاراکتر است"
                }]
            }, {
                name: "titleEn",
                title: "نام لاتین ",
                type: 'text',
                keyPressFilter: "[a-z|A-Z|0-9 ]",
                length: "20",
                hint: "Latin",
                validators: [{
                    type: "isString",
                    validateOnExit: true,
                    type: "lengthRange",
                    min: 0,
                    max: 20,
                    stopOnError: true,
                    errorMessage: "نام مجاز بین چهار تا بیست کاراکتر است"
                }]

            }]
    });


    var IButton_skill_level_Save = isc.IButton.create({
        top: 260, title: "ذخیره", icon: "pieces/16/save.png", click: function () {

            DynamicForm_skill_level.validate();
            if (DynamicForm_skill_level.hasErrors()) {
                return;
            }
            var data = DynamicForm_skill_level.getValues();

            isc.RPCManager.sendRequest({
                actionURL: "http://localhost:9090/api/skill-level",
                httpMethod: method,
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (resp) {
                    if (resp.httpResponseCode == 201) {
                        var OK = isc.Dialog.create({
                            message: "عملیات با موفقیت انجام شد.",
                            icon: "[SKIN]say.png",
                            title: "انجام فرمان"
                        });
                        setTimeout(function () {
                            OK.close();
                        }, 3000);
                        ListGrid_skill_level_refresh();
                        Window_skill_level.close();
                    } else {
                        var ERROR = isc.Dialog.create({
                            message: ("اجرای عملیات با مشکل مواجه شده است!"),
                            icon: "[SKIN]stop.png",
                            title: "پیغام"
                        });
                        setTimeout(function () {
                            ERROR.close();
                        }, 3000);
                    }
                }
            });
        }
    });
    var skill_levelSaveOrExitHlayout = isc.HLayout.create({
        layoutMargin: 5,
        showEdges: false,
        edgeImage: "",
        width: "100%",
        alignLayout: "center",
        padding: 10,
        membersMargin: 10,
        members: [IButton_skill_level_Save, isc.IButton.create({
            ID: "courseEditExitIButton",
            title: "لغو",
            prompt: "",
            width: 100,
            icon: "pieces/16/icon_delete.png",
            orientation: "vertical",
            click: function () {
                Window_skill_level.close();
            }
        })]
    });
    var Window_skill_level = isc.Window.create({
        title: "سطح استاندارد مهارت",
        width: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: false,
        border: "1px solid gray",
        closeClick: function () {
            this.Super("closeClick", arguments);
        },
        items: [isc.VLayout.create({
            width: "100%",
            height: "100%",
            members: [DynamicForm_skill_level, skill_levelSaveOrExitHlayout]
        })]
    });

    function ListGrid_skill_level_refresh() {
        var record = ListGrid_skill_level.getSelectedRecord();
        if (record == null || record.id == null) {
        } else {
            ListGrid_skill_level.selectRecord(record);
        }
        ListGrid_skill_level.invalidateCache();
    };

    function ListGrid_skill_level_remove() {
        var records = ListGrid_skill_level.getSelectedRecords();
        if (records == null || records.size() < 1) {
            isc.Dialog.create({
                message: "رکوردی انتخاب نشده است. !",
                icon: "[SKIN]ask.png",
                title: "پیغام",
                buttons: [isc.Button.create({title: "تائید"})],
                buttonClick: function (button, index) {
                    this.close();
                }
            });
        } else {


        }

    };

    function ListGrid_skill_level_edit() {
        var record = ListGrid_skill_level.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "رکوردی انتخاب نشده است.",
                icon: "[SKIN]ask.png",
                title: "پیغام",
                buttons: [isc.Button.create({title: "تائید"})],
                buttonClick: function (button, index) {
                    this.close();
                }
            });
        } else {
            method = "PUT";
            DynamicForm_skill_level.editRecord(record);
            Window_skill_level.show();
        }
    };
    var ToolStripButton_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "بازخوانی اطلاعات",
        click: function () {
            ListGrid_skill_level_refresh();
        }
    });
    var ToolStripButton_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "ویرایش",
        click: function () {
            ListGrid_skill_level_edit();
        }
    });
    var ToolStripButton_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "ایجاد",
        click: function () {
            method = "POST";
            DynamicForm_skill_level.clearValues();
            Window_skill_level.show();
        }
    });
    var ToolStripButton_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "حذف",
        click: function () {
            ListGrid_skill_level_remove();
        }
    });
    var ToolStripButton_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/print.png",
        title: "چاپ",
        click: function () {
            window.open("/skill-level/print/pdf");
        }
    });
    var ToolStrip_Actions = isc.ToolStrip.create({
        width: "100%",
        members: [ToolStripButton_Add, ToolStripButton_Edit, ToolStripButton_Remove, ToolStripButton_Refresh, ToolStripButton_Print]
    });
    var HLayout_Actions = isc.HLayout.create({width: "100%", members: [ToolStrip_Actions]});
    var HLayout_Grid = isc.HLayout.create({width: "100%", height: "100%", members: [ListGrid_skill_level]});
    var VLayout_Body = isc.VLayout.create({width: "100%", height: "100%", members: [HLayout_Actions, HLayout_Grid]});