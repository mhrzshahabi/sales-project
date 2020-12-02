<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page  import="com.nicico.copper.core.SecurityUtil" %>
//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    var c_record = "${SecurityUtil.hasAuthority('C_PERSON')}";
    var d_record = "${SecurityUtil.hasAuthority('U_PERSON')}";

    var RestDataSource_Contact = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='contact.code'/>"
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='contact.nameFa'/>"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='contact.nameEn'/>"
                },
                {
                    name: "tblCountry.id",
                    title: "<spring:message code='country.nameFa'/>",
                    type: 'long'
                },
                {
                    name: "tblCountry.nameFa",
                    title: "<spring:message code='country.nameFa'/>"
                },
                {
                    name: "tradeMark"
                },
                {
                    name: "ceoPassportNo"
                },
                {
                    name: "ceo"
                },
                {
                    name: "commercialRegistration"
                },
                {
                    name: "branchName"
                },
                {
                    name: "phone",
                    title: "<spring:message code='contact.phone'/>"
                },
                {
                    name: "mobile",
                    title: "<spring:message code='contact.mobile'/>"
                },
                {
                    name: "fax",
                    title: "<spring:message code='contact.fax'/>"
                },
                {
                    name: "address",
                    title: "<spring:message code='contact.address'/>"
                },
                {
                    name: "webSite",
                    title: "<spring:message code='contact.webSite'/>"
                },
                {
                    name: "email",
                    title: "<spring:message code='contact.email'/>"
                },
                {
                    name: "type",
                    title: "<spring:message code='contact.type'/>",
                    valueMap:
                        {
                            "true": "<spring:message code='contact.type.real'/>",
                            "false": "<spring:message code='contact.type.legal'/>"
                        }
                },
                {
                    name: "nationalcode",
                    title: "<spring:message code='contact.nationalCode'/>"
                },
                {
                    name: "economicalCode",
                    title: "<spring:message code='contact.economicalCode'/>"
                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contact.bankAccount'/>"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contact.bankShaba'/>"
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contact.bankShaba'/>"
                },
                {
                    name: "bankName",
                    title: "<spring:message code='contact.bankName'/>"
                },
                {
                    name: "status",
                    title: "<spring:message code='contact.status'/>",
                    valueMap:
                        {
                            "true": "<spring:message code='enabled'/>",
                            "false": "<spring:message code='disabled'/>"
                        }
                },
                {
                    name: "contactAccounts"
                }],
            fetchDataURL: "${contextPath}/api/contact/spec-list"
        });

    var Menu_ListGrid_Person = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Person_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_PERSON')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Person.clearValues();
                    Window_Person.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_PERSON')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Person_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_PERSON')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Person_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var ValuesManager_Person = isc.ValuesManager.create({});
    var DynamicForm_Person = isc.DynamicForm.create({
        valuesManager: ValuesManager_Person,
        width: 500,
        height: "100%",
        titleWidth: "100",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,
        fields: [
            {name: "id", hidden: true},
            {
                name: "contactId",
                title: "<spring:message code='commercialParty.title'/>",
                width: 500, wrapTitle: false,
                errorOrientation: "bottom",
                editorType: "SelectItem",
                hidden: true,
                type: 'text',
                sortField: 1,
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: 500,
                pickListHeight: 400,
                pickListProperties: {showFilterEditor: true}

                ,
                pickListFields: [{name: "id", width: "10%", align: "center", hidden: true}, {
                    name: "nameFA",
                    width: "10%",
                    align: "center"
                }, {name: "nameEN", width: "10%", align: "center"},
                ],
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text', wrapTitle: false,
                required: true,
                length: "200",
                errorOrientation: "bottom",
                width: 500,
                keyPressFilter : "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z| ]",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    },
                    {
                      type: "regexp",
                      expression:"^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z][\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z| ]*$",
                      validateOnChange: true
                    } ]
            },
            {
                name: "jobTitle",
                title: "<spring:message code='person.jobTitle'/>",
                required: true,
                length: "200",
                type: 'text',
                width: 500,
                wrapTitle: false,
                keyPressFilter : "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z| ]",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    },
                    {
                      type: "regexp",
                      expression:"^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z][\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|a-zA-Z| ]*$",
                      validateOnChange: true
                    }
                ]
            },
            {
                name: "title",hidden: true,
                title: "<spring:message code='person.title.gender'/>",
                type: 'text', wrapTitle: false,
                width: 500,
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {
                name: "email",
                hidden: true,
                title: "<spring:message code='person.email'/>",
                type: 'text',
                required: false, errorOrientation: "bottom",
                width: 500,
                wrapTitle: false,
                validateOnExit: true,
                length: 20,
                validators: [
                    {
                        type: "regexp",
                        expression: ".+\\@.+\\..+",
                        validateOnChange: true
                    },
                    {
                        type: "required",
                        validateOnChange: true
                    }
                ]
            },
            {
                name: "email1",hidden: true,
                title: "<spring:message code='person.email1'/>",
                type: 'text',
                width: 500,
                wrapTitle: false,
                length: 20,
                validators: [
                    {
                        type: "regexp",
                        expression: ".+\\@.+\\..+",
                    }
                ]
            },
            {
                name: "email2",hidden: true,
                title: "<spring:message code='person.email2'/>",
                type: 'text',
                width: 500,
                wrapTitle: false,
                length: 20,
                validators: [
                    {
                        type: "regexp",
                        expression: ".+\\@.+\\..+",
                    }
                ]
            },
            {
                name: "webAddress",hidden: true,
                title: "<spring:message code='person.webAddress'/>",
                type: 'text',
                width: 500,
                length: 20,
                wrapTitle: false,
                id: "emailtest",
                textAlign: "left"
            },
            {
                name: "phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: 500,hidden: true,
                wrapTitle: false, length: "20", keyPressFilter: "[0-9.+]"
            },
            {
                name: "faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: 500,hidden: true,
                wrapTitle: false, length: "20", keyPressFilter: "[0-9.+]"
            },
            {
                name: "mobileNo", title: "<spring:message code='person.mobileNo'/>", length: "20", type: 'text',hidden: true,
                width: 500, wrapTitle: false, keyPressFilter: "[0-9.+]"
            },
            {
                name: "mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text',hidden: true,
                width: 500, wrapTitle: false, length: "20", keyPressFilter: "[0-9.+]", textAlign: "left"
            },
            {
                name: "mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text',hidden: true,
                width: 500, wrapTitle: false, length: "20", keyPressFilter: "[0-9.+]"
            },
            {
                name: "whatsApp",hidden: true,
                title: "<spring:message code='person.whatsApp'/>",
                type: 'text',
                width: 500,
                wrapTitle: false
            },
            {
                name: "weChat",hidden: true,
                title: "<spring:message code='person.weChat'/>",
                type: 'text',
                width: 500,
                wrapTitle: false
            },
            {
                name: "address",hidden: true,
                title: "<spring:message code='person.address'/>",
                type: 'text',
                width: 500,
                wrapTitle: false,
                length: "1000"
            },
        ]
    });

    var IButton_Person_Save = isc.IButtonSave.create({
        click: function () {
            ValuesManager_Person.validate();
            DynamicForm_Person.validate();
            if (DynamicForm_Person.hasErrors()) {
                return;
            }

            var data = DynamicForm_Person.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/person",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_Person_refresh();
                        Window_Person.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            }));
        }
    });

    var PersonCancelBtn = isc.IButtonCancel.create({
        click: function () {
            Window_Person.close();
        }
    });

    var HLayout_Person_IButton = isc.HLayout.create({
        width: 650,
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_Person_Save,
            PersonCancelBtn
        ]
    });


    var VLayout_saveButton_person = isc.VLayout.create({
        width: 650,
        textAlign: "center",
        align: "center",
        members: [
            HLayout_Person_IButton

        ]
    });


    var Window_Person = isc.Window.create({
        title: "<spring:message code='person.title'/>",
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
            DynamicForm_Person,
            VLayout_saveButton_person
        ]
    });

    function ListGrid_Person_refresh() {
        ListGrid_Person.invalidateCache();
    }

    function ListGrid_Person_remove() {

        var record = ListGrid_Person.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {

                        var personId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/person/" + personId,
                            httpMethod: "DELETE",
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_Person.invalidateCache();
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

    function ListGrid_Person_edit() {

        var record = ListGrid_Person.getSelectedRecord();

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
            DynamicForm_Person.editRecord(record);
            Window_Person.show();
        }
    }


    var ToolStripButton_Person_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Person_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_PERSON')">
    var ToolStripButton_Person_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Person.clearValues();
            Window_Person.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_PERSON')">
    var ToolStripButton_Person_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Person.clearValues();
            ListGrid_Person_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_PERSON')">
    var ToolStripButton_Person_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Person_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Person = isc.ToolStrip.create({
        width: "100%",
        members: [
            <sec:authorize access="hasAuthority('C_PERSON')">
            ToolStripButton_Person_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_PERSON')">
            ToolStripButton_Person_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_PERSON')">
            ToolStripButton_Person_Remove,
            </sec:authorize>

            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Person_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_Person = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Person
        ]
    });

    var RestDataSource_Person = isc.MyRestDataSource.create(
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
                    name: "contactId"
                },
                {
                    name: "contact.nameFA",
                    type: 'text',
                },
                {
                    name: "fullName",
                    title: "<spring:message code='person.fullName'/>",
                    type: 'text',
                    required: true, errorOrientation: "bottom",
                    width: 400,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
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
                    valueMap:
                        {
                            "MR": "<spring:message code='global.MR'/>",
                            "MIS": "<spring:message code='global.MIS'/>",
                            "MS": "<spring:message code='global.MRS'/>",
                        }
                },
                {
                    name: "email",
                    title: "<spring:message code='person.email'/>",
                    type: 'text',
                    required: true, errorOrientation: "bottom",
                    width: 400,
                    regex: "^([a-zA-Z0-9_.\\-+])+@(([a-zA-Z0-9\\-])+\\.)+[a-zA-Z0-9]{2,4}$",
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
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
                {
                    name: "webAddress",
                    title: "<spring:message code='person.webAddress'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "phoneNo",
                    title: "<spring:message code='person.phoneNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "faxNo",
                    title: "<spring:message code='person.faxNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo",
                    title: "<spring:message code='person.mobileNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo1",
                    title: "<spring:message code='person.mobileNo1'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo2",
                    title: "<spring:message code='person.mobileNo2'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "whatsApp",
                    title: "<spring:message code='person.whatsApp'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "weChat",
                    title: "<spring:message code='person.weChat'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "address",
                    title: "<spring:message code='person.address'/>",
                    type: 'text',
                    width: 400
                }],

            fetchDataURL: "${contextPath}/api/person/spec-list"
        });

    var personAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: ""
    });
    var hLayoutViewLoader = isc.HLayout.create({
        width: "100%",
        height: 180,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            personAttachmentViewLoader
        ]
    });
    hLayoutViewLoader.hide();

    var ListGrid_Person = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Person,
            contextMenu: Menu_ListGrid_Person,
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
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contact.nameFA",hidden: true,
                    title: "<spring:message code='commercialParty.title'/>",
                    type: 'text',
                    width: "10%",
                    align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.contact.nameFA;
                    }
                },
                {
                    name: "fullName",
                    title: "<spring:message code='person.fullName'/>",
                    type: 'text',
                    required: true,
                    errorOrientation: "bottom",
                    width: "10%",
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "jobTitle",
                    title: "<spring:message code='person.jobTitle'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "title",hidden: true,
                    title: "<spring:message code='person.title'/>",
                    type: 'text',
                    width: "10%",
                    valueMap:
                        {
                            "MR": "<spring:message code='global.MR'/>",
                            "MIS": "<spring:message code='global.MIS'/>",
                            "MS": "<spring:message code='global.MRS'/>",
                        }
                },
                {
                    name: "email",hidden: true,
                    title: "<spring:message code='person.email'/>",
                    type: 'text',
                    errorOrientation: "bottom",
                    width: "10%",
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "webAddress",hidden: true,
                    title: "<spring:message code='person.webAddress'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "phoneNo",hidden: true,
                    title: "<spring:message code='person.phoneNo'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "faxNo",hidden: true,
                    title: "<spring:message code='person.faxNo'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "mobileNo",hidden: true,
                    title: "<spring:message code='person.mobileNo'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "whatsApp",hidden: true,
                    title: "<spring:message code='person.whatsApp'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "weChat",hidden: true,
                    title: "<spring:message code='person.weChat'/>",
                    type: 'text',
                    width: "10%",
                },
                {
                    name: "address",hidden: true,
                    title: "<spring:message code='person.address'/>",
                    type: 'text',
                    width: "10%",
                },
            ],getExpansionComponent: function (record) {
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
                    record.id = null;
                }
                var dccTableId = record.id;
                var dccTableName = "TBL_PERSON";
                personAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId + "?d_record=" + d_record + "&c_record=" + c_record);
                hLayoutViewLoader.show();
                var layoutPerson = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [hLayoutViewLoader]
                });
                return layoutPerson;
            },
            sortField: 2,
            sortDirection: "descending",
            autoFetchData: true
        });

    var HLayout_Grid_Person = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Person
            ]
        });

    isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Actions_Person, HLayout_Grid_Person
            ]
        });