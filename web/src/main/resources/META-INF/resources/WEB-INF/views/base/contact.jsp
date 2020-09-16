<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.nicico.copper.core.SecurityUtil" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    var c_record = "${SecurityUtil.hasAuthority('C_CONTACT')}";
    var d_record = "${SecurityUtil.hasAuthority('U_CONTACT')}";

    var RestDataSource_Country_IN_CONTACT = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='goods.code'/> "
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='global.country'/> "
                }],
            fetchDataURL: "${contextPath}/api/country/spec-list"
        });

    var RestDataSource_ContactAccount = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contactId",
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='contactAccount.code'/>"
                },
                {
                    name: "bankId",
                    title: "<spring:message code='contactAccount.nameFA'/>"
                },
                {
                    name: "bank.bankName",
                    title: "<spring:message code='contactAccount.nameFA'/>"
                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contactAccount.accountNumber'/>",
                    type: "number"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contactAccount.shabaAccount'/>"
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contactAccount.bankSwift'/>"
                },
                {
                    name: "accountOwner",
                    title: "<spring:message code='contactAccount.accountOwner'/>"
                },
                {
                    name: "status",
                    title: "<spring:message code='contactAccount.status'/>",
                    valueMap:
                        {
                            "true": "<spring:message code='enabled'/>",
                            "false": "<spring:message code='disabled'/>"
                        }
                },
                {
                    name: "isDefault",
                    title: "<spring:message code='contactAccount.isDefault'/>",
                    defaultValue: false,
                    valueMap:
                        {
                            "true": "<spring:message code='contactAccount.isDefault'/>",
                            "false": "<spring:message code='contactAccount.notDefault'/>"
                        }
                }],
            fetchDataURL: "${contextPath}/api/contactAccount/spec-list"
        });

    var RestDataSource_Bank_IN_CONTACT = isc.MyRestDataSource.create(
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
                    name: "bankCode",
                    title: "<spring:message code='bank.bankCode'/>",
                    width: 200
                },
                {
                    name: "bankName",
                    title: "<spring:message code='bank.nameFa'/>",
                    width: 200
                },
                {
                    name: "enBankName",
                    title: "<spring:message code='bank.nameEn'/>",
                    width: 200
                },
                {
                    name: "address",
                    title: "<spring:message code='bank.address'/>",
                    width: 200
                },
                {
                    name: "coreBranch",
                    title: "<spring:message code='bank.coreBranch'/>",
                    width: 200
                },
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 200
                }],
            fetchDataURL: "${contextPath}/api/bank/spec-list"
        });

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
                    name: "nationalCode",
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
                    name: "ceoPassportNo"
                },
                {
                    name: "ceo"
                },
                {
                    name: "commercialRole"
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
                    name: "tradeMark"
                },
                {
                    name: "commercialRegistration"
                },
                {
                    name: "branchName"
                },
                {
                    name: "countryId",
                    title: "<spring:message code='country.nameFa'/>",
                    type: 'long'
                },
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>"
                },
                {
                    name: "contactAccounts"
                }],
            fetchDataURL: "${contextPath}/api/contact/spec-list-mainContact"
        });

    var Menu_ListGrid_Contact = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Contact_refresh();
                    }
                },
                <sec:authorize access="hasAuthority('C_CONTACT')">
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        clearContactForms();
                        Window_Contact.animateShow();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_CONTACT')">
                {
                    title: "<spring:message code='global.form.edit'/>",
                    icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Contact_edit();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_CONTACT')">
                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Contact_remove();
                    }
                }
                </sec:authorize>
            ]
        });

    var ValuesManager_Contact = isc.ValuesManager.create({});

    var DynamicForm_Contact_GeneralInfo = isc.DynamicForm.create(
        {
            overflow: "hidden",
            autoScroller: false,
            valuesManager: ValuesManager_Contact,
            requiredMessage: "<spring:message code='validator.field.is.required'/>",
            cellPadding: 2,
            numCols: 4,
            width: "100%",
            height: "100%",
            layoutMargin: 4,
            membersMargin: 4,
            align: "center",
            fields: [
                {
                    name: "id",
                    hidden: true
                },
                {
                    name: "contactAccounts",
                    hidden: true
                },
                {
                    name: "bankAccount",
                    hidden: true
                },
                {
                    name: "bankShaba",
                    hidden: true
                },
                {
                    name: "bankSwift",
                    hidden: true
                },

                {
                    name: "createdDate",
                    hidden: true
                },
                {
                    name: "createdBy",
                    hidden: true
                },
                {
                    name: "lastModifiedDate",
                    hidden: true
                },
                {
                    name: "lastModifiedBy",
                    hidden: true
                },
                {
                    name: "version",
                    hidden: true
                },
                {

                    name: "nameFA",
                    title: "<spring:message code='contact.nameFa'/>",
                    required: true,
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    wrapTitle: false,
                    hint: "Persian/فارسی",
                    keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9 ]",
                    validators: [{
                        type: "regexp",
                        expression: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9 ]",
                        validateOnChange: true
                    }]
                },
                {
                    required: true,
                    name: "nameEN",
                    title: "<spring:message code='contact.nameEn'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    hint: "Latin",
                    wrapTitle: false,
                    keyPressFilter: "^[A-Za-z0-9 ]",
                    validators: [{
                        type: "regexp",
                        expression: "^[A-Za-z0-9 ]",
                        validateOnChange: true
                    }]
                },
                {
                    name: "tradeMark",
                    title: "<spring:message code='contact.tradeMark'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "ceo",
                    title: "<spring:message code='contact.ceo'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "ceoPassportNo",
                    title: "<spring:message code='contact.ceoPassportNo'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    keyPressFilter: "[0-9.]",
                    wrapTitle: false
                },
                {
                    name: "commercialRegistration",
                    title: "<spring:message code='contact.commercialRegistration'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    keyPressFilter: "[0-9.]",
                    wrapTitle: false
                },

                {
                    name: "branchName",
                    title: "<spring:message code='contact.branchName'/>",
                    type: 'text',
                    width: 300,
                    colSpan: 3,
                    titleColSpan: 1,
                    wrapTitle: false,
                },
                {
                    required: true,
                    type: "Header",
                    defaultValue: " ",
                    redrawOnChange: true,
                    mask: "required",
                    hint: "<p style='color: black ; left: 386% ; white-space: pre; position: relative; top:5px;'><b style='color:red;'>*</b><spring:message
code='contact.role'/></p>",
                },
                {
                    ID: "check_box_alert",
                    hidden: true,
                    type: "staticText",
                },
                {

                    name: "seller",
                    title: "<spring:message code='contact.commercialRole.seller'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "buyer",
                    title: "<spring:message code='contact.commercialRole.buyer'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "agentSeller",
                    title: "<spring:message code='contact.commercialRole.agentSeller'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "agentBuyer",
                    title: "<spring:message code='contact.commercialRole.agentBuyer'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "transporter",
                    title: "<spring:message code='contact.commercialRole.transporter'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "shipper",
                    title: "<spring:message code='contact.commercialRole.shipper'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "inspector",
                    title: "<spring:message code='contact.commercialRole.inspector'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "insurancer",
                    title: "<spring:message code='contact.commercialRole.insurancer'/>",
                    type: 'checkbox',
                    width: 50,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    defaultValue: true,
                    name: "type",
                    title: "<spring:message code='contact.type'/>",
                    width: 200,
                    wrapTitle: false,
                    type: "boolean",
                    colSpan: 3,
                    titleColSpan: 1,
                    valueMap:
                        {
                            "true": "<spring:message code='contact.type.real'/>",
                            "false": "<spring:message code='contact.type.legal'/>"
                        }
                },
                {
                    name: "nationalCode",
                    title: "<spring:message code='contact.nationalCode'/>",
                    width: 200,
                    keyPressFilter: "[0-9.]",
                    wrapTitle: false,
                    textAlign: "left",
                },
                {
                    name: "economicalCode",
                    title: "<spring:message code='contact.economicalCode'/>",
                    width: 200,
                    colSpan: 3,
                    titleColSpan: 1,
                    keyPressFilter: "[0-9.]",
                    wrapTitle: false
                },
                {
                    name: "status",
                    title: "<spring:message code='contact.status'/>",
                    width: 200,
                    wrapTitle: false,
                    type: "boolean",
                    defaultValue: true,
                    colSpan: 3,
                    titleColSpan: 1,
                    valueMap:
                        {
                            "true": "<spring:message code='global.table.enabled'/>",
                            "false": "<spring:message code='global.table.disabled'/>"
                        }
                },
            ]
        });

    async function checkContactWithThisProperty(prop_name, prop_value, contact_id, warnMsg) {
        if (prop_value == null)
            return true;
        const resp = await fetch("${contextPath}/api/contact/spec-list?criteria=" + JSON.stringify({
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: prop_name, operator: "equals", value: prop_value}]
        }), {
            headers: SalesConfigs.httpHeaders,
        })
        if (!resp.ok) {
            return false
        }
        const respdata = await resp.json()
        const resData = respdata.response.data
        if (resData == null || resData.length == 0)
            return true;
        let x = resData.find(d => (d != null && (d.id != contact_id)));
        if (x != null && x.id != null) {
            let msg = "<spring:message code='contact.property.repeated.warning'/> " + warnMsg + " " + prop_value;
            isc.warn(msg, "");
            return false;
        } else
            return true;

        return false
    }

    var DynamicForm_Contact_Connection = isc.DynamicForm.create({
        valuesManager: ValuesManager_Contact,
        width: "100%",
        height: "100%",
        titleWidth: "100",
        numCols: 2,
        fields: [
            {
                required: true,
                name: "phone",
                title: "<spring:message code='contact.phone'/>",
                width: 500,
                length: 15,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^[0-9|+]?[0-9]+[-]?[0-9]+$",
                        validateOnChange: true,
                    },
                ],
                editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                    let contact_values = ValuesManager_Contact.getValues();
                    if (newValue != null && newValue.length > 1)
                        checkContactWithThisProperty("phone", newValue, contact_values.id, "<spring:message code='contact.phone'/>");
                    return true;
                }
            },
            {
                name: "mobile",
                title: "<spring:message code='contact.mobile'/>",
                width: 500,
                length: 15,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^[0-9|+]?[0-9]+[-]?[0-9]+$",
                        validateOnChange: true,
                    },
                ],
                editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                    let contact_values = ValuesManager_Contact.getValues();
                    if (newValue != null && newValue.length > 1)
                        checkContactWithThisProperty("mobile", newValue, contact_values.id, "<spring:message code='contact.mobile'/>");
                    return true;
                }
            },
            {
                name: "fax",
                title: "<spring:message code='contact.fax'/>",
                width: 500,
                length: 15,
                wrapTitle: false,
                textAlign: "left",
                validators: [
                    {
                        type: "regexp",
                        expression: "^[0-9|+]?[0-9]+[-]?[0-9]+$",
                        validateOnChange: true,
                    },
                ],
                editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                    let contact_values = ValuesManager_Contact.getValues();
                    if (newValue != null && newValue.length > 1)
                        checkContactWithThisProperty("fax", newValue, contact_values.id, "<spring:message code='contact.fax'/>");
                    return true;
                }
            },
            {
                required: true,
                name: "countryId",
                title: "<spring:message code='global.country'/>",
                type: 'long',
                width: 500,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Country_IN_CONTACT,
                displayField: "nameEn",
                valueField: "id",
                pickListWidth: 500,
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", width: 480, align: "center", hidden: true},
                    {name: "nameEn", width: 480, align: "center"},
                ],
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {name: "address", title: "<spring:message code='contact.address'/>", width: 500, wrapTitle: false},
            {
                name: "webSite",
                title: "<spring:message code='contact.webSite'/>",
                width: 500,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^(?:http(s)?:\\/\\/)?[\\w.-]+(?:\\.[\\w\\.-]+)+[\\w\\-\\._~:/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$",
                        validateOnChange: true,
                    },
                    {
                        type: "regexp",
                        expression: "^[A-Za-z0-9].+$",
                        validateOnChange: true,
                    },
                ]

            },
            {
                name: "email",
                title: "<spring:message code='contact.email'/>",
                width: 500,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^[a-zA-Z0-9]+@[a-zA-Z0-9]+([.][a-zA-Z0-9]+)+$",
                        validateOnChange: true,
                    }
                ]
            },
            {
                name: "postalCode",
                title: "<spring:message code='contact.postalCode'/>",
                width: 500,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^[0-9|+]?([0-9]+[-]?[0-9]+[\\s]?)*$",
                        validateOnChange: true,
                    }
                ]
            },
            {
                name: "registerNumber",
                title: "<spring:message code='contact.registerNumber'/>",
                width: 500,
                wrapTitle: false,
                validators: [
                    {
                        type: "regexp",
                        expression: "^[a-zA-Z0-9]*$",
                        validateOnChange: true,
                    }
                ]
            },


        ]
    });

    var contactTabs = isc.TabSet.create({
        height: 550,
        width: 700,
        showTabScroller: true,
        tabs: [
            {
                title: "<spring:message code='contact.tab.generalInfo'/>",
                pane: DynamicForm_Contact_GeneralInfo
            },
            {
                title: "<spring:message code='contact.tab.connectionInfo'/>",
                pane: DynamicForm_Contact_Connection
            }
        ]
    });

    var contactHttpMethod = "POST";

    function saveContact() {
        const values = DynamicForm_Contact_GeneralInfo.getValues();
        const bools = ['seller', 'buyer', 'agentSeller', 'agentBuyer', 'transporter', 'shipper', 'inspector', 'insurancer'];
        const selectedBool = bools.find(a => values[a]);
        let selectedBoolValid = true;
        if (selectedBool === undefined || selectedBool === null) {
            isc.say("<spring:message code='global.form.request.checkbox'/>");
            selectedBoolValid = false;
        }
        if (ValuesManager_Contact != null) {
            ValuesManager_Contact.validate();
            if (DynamicForm_Contact_GeneralInfo.hasErrors() || !selectedBoolValid) {
                contactTabs.selectTab(0);
            } else if (DynamicForm_Contact_Connection.hasErrors()) {
                contactTabs.selectTab(1);
            } else {
                check_box_alert.hide();
                var contactData = Object.assign(ValuesManager_Contact.getValues());
                isc.RPCManager.sendRequest(
                    Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/contact",
                        httpMethod: contactHttpMethod,
                        data: JSON.stringify(contactData),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                ListGrid_Contact.invalidateCache();
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                Window_Contact.close();
                            }
                        },
                    })
                );
            }
        }
    }

    function clearContactForms() {
        DynamicForm_Contact_GeneralInfo.clearValues();
        DynamicForm_Contact_Connection.clearValues();
    }

    var IButton_Contact_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        autoFit: false,
        click: async function () {
            let contact_id = ValuesManager_Contact.getValues().id;

            let valid = await checkContactWithThisProperty("phone", DynamicForm_Contact_Connection.getValues().phone,
                contact_id, "<spring:message code='contact.phone'/>");

            if (!valid) return false;

            valid = await checkContactWithThisProperty("mobile", DynamicForm_Contact_Connection.getValues().mobile,
                contact_id, "<spring:message code='contact.mobile'/>");

            if (!valid) return false;

            valid = await checkContactWithThisProperty("fax", DynamicForm_Contact_Connection.getValues().fax,
                contact_id, "<spring:message code='contact.fax'/>");

            if (!valid) return false;

            saveContact();
        }
    });

    var contactCancelBtn = isc.IButtonCancel.create({
        top: 260,
        title: "<spring:message code='global.close'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Contact.close();
        }
    });

    var contactFormButtonLayout = isc.HLayout.create({
        width: "100%",
        height: "20",
        layoutMargin: 5,
        membersMargin: 5,
        autoDraw: false,
        isModal: true,
        showModalMask: true,
        align: "center",
        members: [
            IButton_Contact_Save,
            contactCancelBtn
        ]
    });

    var Window_Contact = isc.Window.create({
        title: "<spring:message code='contact.title'/>",
        width: 700,
        height: 580,
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
            contactTabs,
            contactFormButtonLayout
        ]
    });

    function ListGrid_Contact_refresh() {
        ListGrid_Contact.invalidateCache();
    }

    function ListGrid_Contact_remove() {
        var record = ListGrid_Contact.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/> ",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/> "
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        } else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/> ",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/> ",
                    buttons: [
                        isc.IButtonSave.create(
                            {
                                title: "<spring:message code='global.yes'/>"
                            }),
                        isc.IButtonCancel.create(
                            {
                                title: "<spring:message code='global.no'/> "
                            })
                    ],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var contactId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contact/" + contactId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_Contact.invalidateCache();
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

    function ListGrid_Contact_edit() {
        check_box_alert.hide();
        var record = ListGrid_Contact.getSelectedRecord();

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
            clearContactForms();
            DynamicForm_Contact_GeneralInfo.editRecord(record);
            DynamicForm_Contact_Connection.editRecord(record);
            Window_Contact.animateShow();
        }
    }

    var ToolStripButton_Contact_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Contact_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_CONTACT')">
    var ToolStripButton_Contact_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            contactHttpMethod = "POST";
            clearContactForms();
            Window_Contact.animateShow();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_CONTACT')">
    var ToolStripButton_Contact_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            contactHttpMethod = "PUT";
            ListGrid_Contact_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_CONTACT')">
    var ToolStripButton_Contact_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Contact_remove();
        }
    });
    </sec:authorize>

    var ListGrid_ContactAccount = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_ContactAccount,
            autoDraw: false,
            warnOnRemoval: "true",
            warnOnRemovalMessage: "<spring:message code='global.grid.record.remove.ask'/> ",
            fields: [
                {
                    name: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contactId",
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='contactAccount.code'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bank.bankName",
                    title: "<spring:message code='contactAccount.nameFA'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contactAccount.accountNumber'/>",
                    align: "center",
                    width: "10%",
                    type: "number"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contactAccount.shabaAccount'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contactAccount.bankSwift'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "accountOwner",
                    title: "<spring:message code='contactAccount.accountOwner'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "status",
                    title: "<spring:message code='contactAccount.status'/>",
                    align: "center",
                    width: "10%",
                    filterEditorProperties: {
                        operator: "equals", type: "boolean",
                        valueMap: {
                            true: "<spring:message code='contact.type.real'/>",
                            false: "<spring:message code='contact.type.legal'/>"
                        }
                    }
                },
                {
                    name: "isDefault",
                    title: "<spring:message code='contactAccount.isDefault'/>",
                    hidden: true,
                    defaultValue: false
                }],
            sortField: 2,
            autoFetchData: false,
            getCellCSSText: function (record, rowNum, colNum) {
                if (this.getFieldName(colNum) == "bankAccount") {
                    if (record.isDefault == 1) {
                        return "font-weight:bold; color:#0fed30;";
                    }
                }
                if (this.getFieldName(colNum) == "bank.bankName") {
                    if (record.isDefault == 1) {
                        return "font-weight:bold; color:#0fed30;";
                    }
                }
            },
            <sec:authorize access="hasAuthority('U_CONTACT')">
            recordClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                if (record != null) {
                    contactAccountTabs.enableTab("edit");
                    ContactAccount_EditDynamicForm.editRecord(record);
                }
            },
            dataChanged: function () {
                contactAccountTabs.selectTab("create");
                contactAccountTabs.disableTab("edit");
            }
            </sec:authorize>
        });

    var ContactAccountGridHeaderForm = isc.DynamicForm.create({
        titleWidth: "200",
        width: "100%",
        numCols: 10,
        fields: [
            {name: "id", type: "hidden", title: "", hidden: true},
            {
                name: "nameFA",
                type: "staticText",
                title: "<spring:message code='contact.nameFa'/>",
                wrapTitle: false,
                width: 250
            },
            {
                name: "nationalCode",
                type: "staticText",
                title: "<spring:message code='contact.nationalCode'/>",
                wrapTitle: false,
                width: 100,

            },
            {
                name: "economicalCode",
                type: "staticText",
                title: "<spring:message code='contact.economicalCode'/>",
                wrapTitle: false,
                width: 100
            }
        ]
    });

    function setContactAccountListGridHeaderFormData(record) {
        ContactAccountGridHeaderForm.setValue("id", record.id);
        ContactAccountGridHeaderForm.setValue("nameFA", record.nameFA);
        ContactAccountGridHeaderForm.setValue("nationalCode", record.nationalCode);
        ContactAccountGridHeaderForm.setValue("economicalCode", record.economicalCode);
    }

    var ContactAccountGridHeaderHLayout = isc.HLayout.create({
        width: "100%",
        height: 25,
        border: "0px solid yellow",
        layoutMargin: 5,
        members: [
            ContactAccountGridHeaderForm
        ]
    });

    var gridVLayout = isc.VLayout.create({
        width: "100%",
        height: 290,
        autoDraw: false,
        border: "0px solid red",
        layoutMargin: 5,
        members: [
            ContactAccountGridHeaderHLayout,
            ListGrid_ContactAccount
        ]
    });


    var ContactAccount_CreateDynamicForm = isc.DynamicForm.create({
        width: "100%",
        numCols: 2,
        autoDraw: false,
        titleWidth: "100",
        fields: [{
            type: "header",
            defaultValue: "<spring:message code='contactAccount.title'/>"
        },
            {
                name: "id",
                hidden: true
            },
            {
                name: "contactId",
                hidden: true
            },
            {
                name: "code",
                title: "<spring:message code='contactAccount.code'/>",
                type: 'integer',
                width: 300,
                colSpan: "2",
                required: true,
                validators: [{
                    type: "isInteger",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>",
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }
                ]
            },
            {
                name: "bankId",
                title: "<spring:message code='contactAccount.nameFA'/>",
                type: 'long',
                width: 300,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Bank_IN_CONTACT,
                displayField: "bankName",
                valueField: "id",
                pickListWidth: "300",
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [{
                    name: "bankName",
                    width: 295,
                    align: "center",
                },
                    {
                        name: "bankCode",
                        width: 295,
                        align: "center",
                        hidden: true,
                    }
                ]
            },
            {
                name: "bankAccount",
                title: "<spring:message code='contactAccount.accountNumber'/>",
                type: 'text',
                width: 300,
                colSpan: "2",
                required: true,
                validators: [{
                    type: "isInteger",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>",
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }
                ],
                textAlign: "left"
            },
            {
                name: "bankShaba",
                title: "<spring:message code='contactAccount.shabaAccount'/>",
                type: 'text',
                required: true,
                width: 300,
                colSpan: "2",
                validators: [
                    {
                        type: "regexp",
                        expression: "^(?:IR)(?=.{24}$)[0-9]*$",
                        validateOnChange: true,
                    }
                ]
            },
            {
                name: "bankSwift",
                title: "<spring:message code='contactAccount.bankSwift'/>",
                required: true,
                width: 300,
                colSpan: "2",
            },
            {
                name: "accountOwner",
                title: "<spring:message code='contactAccount.accountOwner'/>",
                type: 'text',
                width: 300,
                colSpan: "2"
            },
            {
                name: "status",
                title: "<spring:message code='global.table.isEnabled'/>",
                width: 300,
                wrapTitle: false,
                type: "boolean",
                defaultValue: true,
                valueMap: {
                    "true": "<spring:message code='global.table.enabled'/>",
                    "false": "<spring:message code='global.table.disabled'/>"
                }
            },
            {
                name: "isDefault",
                defaultValue: false,
                title: "<spring:message code='contactAccount.isDefault'/>",
                type: "boolean",
                width: 300
            }
        ]
    });

    var ContactAccount_EditDynamicForm = isc.DynamicForm.create(
        {
            width: "100%",
            numCols: 2,
            titleWidth: "100",
            autoDraw: false,
            fields: [
                {
                    type: "header",
                    defaultValue: "<spring:message code='contactAccount.title'/>"
                },
                {
                    name: "id",
                    hidden: true
                },
                {
                    name: "contactId",
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='contactAccount.code'/>",
                    type: 'integer',
                    colSpan: "2",
                    required: true,
                    width: 300,
                    validators: [
                        {
                            type: "isInteger",
                            validateOnChange: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "bankId",
                    title: "<spring:message code='contactAccount.nameFA'/>",
                    type: 'long',
                    width: 300,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Bank_IN_CONTACT,
                    displayField: "bankName",
                    valueField: "id",
                    pickListWidth: 300,
                    pickListHeight: "500",
                    pickListProperties:
                        {
                            showFilterEditor: true
                        },
                    pickListFields: [
                        {
                            name: "bankName",
                            width: 295,
                            align: "center"
                        },
                        {
                            name: "bankCode",
                            width: 295,
                            align: "center",
                            hidden: true,
                        }]
                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contactAccount.accountNumber'/>",
                    type: 'text',
                    width: 300,
                    colSpan: "2",
                    required: true,
                    validators: [
                        {
                            type: "isInteger",
                            validateOnChange: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    textAlign: "left"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contactAccount.shabaAccount'/>",
                    type: 'text',
                    required: true,
                    width: 300,
                    colSpan: "2",
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        },
                        {
                            type: "regexp",
                            expression: "^(?:IR)(?=.{24}$)[0-9]*$",
                            validateOnChange: true
                        }]
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contactAccount.bankSwift'/>",
                    type: 'text',
                    required: true,
                    width: 300,
                    colSpan: "2",
                },
                {
                    name: "accountOwner",
                    title: "<spring:message code='contactAccount.accountOwner'/>",
                    type: 'text',
                    width: 300,
                    colSpan: "2"
                },
                {
                    name: "status",
                    title: "<spring:message code='global.table.isEnabled'/>",
                    width: 300,
                    wrapTitle: false,
                    type: "boolean",
                    valueMap:
                        {
                            "true": "<spring:message code='global.table.enabled'/>",
                            "false": "<spring:message code='global.table.disabled'/>"
                        }
                },
                {
                    name: "isDefault",
                    defaultValue: false,
                    width: 300,
                    title: "<spring:message code='contactAccount.isDefault'/>",
                    type: "boolean"
                }]
        });


    var ContactAccount_CreateSaveButton = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ContactAccount_CreateDynamicForm.validate();
            if (ContactAccount_CreateDynamicForm.hasErrors()) {
                return;
            }
            var data = ContactAccount_CreateDynamicForm.getValues();
            data["contactId"] = ContactAccountGridHeaderForm.getValue('id');

            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contactAccount",
                httpMethod: "POST",
                data: JSON.stringify(data),
                params: {
                    parentId: data["contactId"]
                },
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                        ContactAccount_CreateDynamicForm.clearValues();
                        ListGrid_ContactAccount.invalidateCache();
                        //ListGrid_Contact.invalidateCache();
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_ContactAccount.fetchData({
                            _constructor: "AdvancedCriteria",
                            operator: "and",
                            criteria: [{
                                fieldName: "contactId",
                                operator: "equals",
                                value: ContactAccountGridHeaderForm.getValue('id')
                            }]
                        });
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });

    var ContactAccount_EditSaveButton = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        autoDraw: false,
        icon: "pieces/16/save.png",
        click: function () {
            ContactAccount_EditDynamicForm.validate();
            if (ContactAccount_EditDynamicForm.hasErrors()) {
                return;
            }
            var data = ContactAccount_EditDynamicForm.getValues();
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contactAccount",
                httpMethod: "PUT",
                data: JSON.stringify(data),
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                        ListGrid_ContactAccount.invalidateCache();
                        //ListGrid_Contact.invalidateCache();
                        ListGrid_ContactAccount.fetchData({
                            _constructor: "AdvancedCriteria",
                            operator: "and",
                            criteria: [{
                                fieldName: "contactId",
                                operator: "equals",
                                value: ContactAccountGridHeaderForm.getValue('id')
                            }]
                        });
                        isc.say("<spring:message code='global.form.request.successful'/>");
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });

    var ContactAccountCancelBtn = isc.IButtonCancel.create({
        top: 260,
        title: "<spring:message code='global.form.close'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            ListGrid_Contact.invalidateCache();
            Window_AccountsContact.close();
        }
    });

    var HLayout_EditFormButton = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            ContactAccount_EditSaveButton
        ]
    });

    var HLayout_CreateFormButton = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            ContactAccount_CreateSaveButton
        ]
    });

    var editPane = isc.VLayout.create({
        autoDraw: true,
        members: [
            ContactAccount_EditDynamicForm,
            HLayout_EditFormButton
        ]
    });

    var createPane = isc.VLayout.create({
        autoDraw: true,
        members: [
            ContactAccount_CreateDynamicForm,
            HLayout_CreateFormButton
        ]
    });

    var contactAccountTabs = isc.TabSet.create({
        height: "100%",
        width: "100%",
        autoDraw: true,
        tabs: [{
            name: "create",
            title: "<spring:message code='global.form.new'/>",
            icon: "pieces/16/icon_add.png",
            pane: createPane
        },
            {
                name: "edit",
                title: "<spring:message code='global.form.edit'/>",
                icon: "pieces/16/icon_edit.png",
                pane: editPane,
                disabled: true
            }
        ]
    });


    var Button_Delete_Account = isc.IButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            {
                var record = ListGrid_ContactAccount.getSelectedRecord();
                if (record == null || record.id == null) {
                    isc.Dialog.create({
                        message: "<spring:message code='global.grid.record.not.selected'/>",
                        icon: "[SKIN]ask.png",
                        title: "<spring:message code='global.message'/>",
                        buttons: [
                            isc.Button.create({
                                title: "<spring:message code='global.ok'/>"
                            })
                        ],
                        buttonClick: function (button, index) {
                            this.hide();
                        }
                    });
                } else {
                    isc.Dialog.create({
                        message: "<spring:message code='global.grid.record.remove.ask'/>",
                        icon: "[SKIN]ask.png",
                        title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                        buttons: [
                            isc.IButtonSave.create({
                                title: "<spring:message code='global.yes'/>"
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.no'/>"
                            })
                        ],
                        buttonClick: function (button, index) {
                            this.hide();
                            if (index === 0) {
                                if (record.isDefault) {
                                    isc.warn("<spring:message code='exception.DeleteDefaultAccount'/>");
                                    return;
                                }
                                var contactAccountId = record.id;
                                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                    actionURL: "${contextPath}/api/contactAccount/" + contactAccountId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                            ListGrid_ContactAccount.invalidateCache();
                                            ListGrid_ContactAccount.refreshData();
                                            ListGrid_Contact.invalidateCache();
                                            ContactAccount_EditDynamicForm.clearValues();
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
        }
    });


    var HLayout_ContactAccountDeleteActions = isc.HLayout.create({
        width: "100%",
        height: 35,
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            Button_Delete_Account
        ]
    });

    var HLayout_ContactAccountCancelActions = isc.HLayout.create({
        width: "100%",
        height: 35,
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            ContactAccountCancelBtn
        ]
    });

    var bodyVLayout = isc.VLayout.create({
        width: "100%",
        height: 340,
        border: "0px solid blue",
        autoDraw: false,
        layoutMargin: 5,
        members: [
            contactAccountTabs
        ]
    });

    var Window_AccountsContact = isc.Window.create({
        title: "<spring:message code='contact.accounts'/>",
        width: 820,
        height: 730,
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
            gridVLayout,
            HLayout_ContactAccountDeleteActions,
            bodyVLayout,
            HLayout_ContactAccountCancelActions
        ]
    });


    var ToolStripButton_Contact_Accounts = isc.ToolStripButton.create({
        icon: "icon/accountContact.png",
        title: "<spring:message code='contact.accounts'/>",
        click: function () {
            var record = ListGrid_Contact.getSelectedRecord();
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
                contactAccountTabs.selectTab(0);
                ContactAccount_CreateDynamicForm.clearValues();
                ContactAccount_EditDynamicForm.clearValues();
                setContactAccountListGridHeaderFormData(record);
                Window_AccountsContact.animateShow();
                contactAccountTabs.disableTab("edit");
                var criteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{
                        fieldName: "contactId",
                        operator: "equals",
                        value: ListGrid_Contact.getSelectedRecord().id.toString()
                    }]
                };
                ListGrid_ContactAccount.fetchData(criteria);
            }
        }
    });


    var ToolStrip_Actions_Contact = isc.ToolStrip.create({
        width: "100%",
        members: [

            <sec:authorize access="hasAuthority('C_CONTACT')">
            ToolStripButton_Contact_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_CONTACT')">
            ToolStripButton_Contact_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_CONTACT')">
            ToolStripButton_Contact_Remove,
            </sec:authorize>

            ToolStripButton_Contact_Accounts,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Contact_Refresh,
                ]
            })

        ]
    });
    var HLayout_Actions_Contact = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Contact
        ]
    });

    var contactAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: ""
    });

    var hLayoutViewLoader = isc.HLayout.create({
        width: "100%",
        height: 200,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            contactAttachmentViewLoader
        ]
    });
    hLayoutViewLoader.hide();

    var ListGrid_Contact = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Contact,
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
            contextMenu: Menu_ListGrid_Contact,
            fields: [
                {
                    name: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true, showIf: "false",
                },
                {
                    name: "code",
                    title: "<spring:message code='contact.code'/>",
                    align: "center",
                    width: 100, showIf: "false",

                },
                {
                    name: "nameEN",
                    title: "<spring:message code='contact.nameEn'/>",
                    align: "center"
                },
                {
                    name: "tradeMark",
                    title: "<spring:message code='contact.tradeMark'/>",
                    type: 'text',
                    width: "10%",
                    wrapTitle: false,
                    align: "center"
                },
                {
                    name: "commercialRegistration",
                    title: "<spring:message code='contact.commercialRegistration'/>",
                    type: 'text',
                    width: "10%",
                    wrapTitle: false,
                    align: "center", showIf: "false",
                },
                {
                    name: "branchName",
                    title: "<spring:message code='contact.branchName'/>",
                    type: 'text',
                    width: "10%",
                    wrapTitle: false,
                    align: "center", showIf: "false",
                },
                {
                    name: "commercialRole",
                    title: "<spring:message code='contact.commercialRole'/>",
                    type: 'text',
                    width: "10%",
                    wrapTitle: false,
                    align: "center",
                },
                {
                    name: "phone",
                    title: "<spring:message code='contact.phone'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "mobile",
                    title: "<spring:message code='contact.mobile'/>",
                    align: "center",
                    width: "10%", showIf: "false",
                },
                {
                    name: "fax",
                    title: "<spring:message code='contact.fax'/>",
                    align: "center",
                    width: "10%", showIf: "false",
                },
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: "10%", showIf: "false",
                    sortNormalizer: function (recordObject) {
                        return recordObject.country.nameFa;
                    }
                },
                {
                    name: "address",
                    title: "<spring:message code='contact.address'/>",
                    align: "center",
                    hidden: true, type: 'text'
                },
                {
                    name: "webSite",
                    title: "<spring:message code='contact.webSite'/>",
                    align: "center",
                    hidden: true,
                },
                {
                    name: "email",
                    title: "<spring:message code='contact.email'/>",
                    align: "center",
                    hidden: true,
                },
                {
                    name: "type",
                    title: "<spring:message code='contact.type'/>",
                    align: "center",
                    width: "10%",
                    filterEditorProperties: {
                        operator: "equals", type: "boolean",
                        valueMap: {
                            true: "<spring:message code='contact.type.real'/>",
                            false: "<spring:message code='contact.type.legal'/>"
                        }
                    }
                },
                {
                    name: "nationalCode",
                    title: "<spring:message code='contact.nationalCode'/>",
                    align: "center",
                    width: "10%", showIf: "false",
                },
                {
                    name: "economicalCode",
                    title: "<spring:message code='contact.economicalCode'/>",
                    align: "center",
                    width: "10%", showIf: "false",

                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contact.bankAccount'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contact.bankShaba'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contactAccount.bankSwift'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "status",
                    title: "<spring:message code='contact.status'/>",
                    align: "center",
                    width: "10%",
                    filterEditorProperties: {
                        operator: "equals", type: "boolean",
                        valueMap: {
                            true: "<spring:message code='global.table.enabled'/>",
                            false: "<spring:message code='global.table.disabled'/>"
                        }
                    }
                }

            ],
            getExpansionComponent: function (record) {
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
                var dccTableName = "TBL_CONTACT";
                contactAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId + "?d_record=" + d_record + "&c_record=" + c_record);
                hLayoutViewLoader.show();
                var layoutContact = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [hLayoutViewLoader]
                });
                return layoutContact;
            }
        });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Contact, ListGrid_Contact
        ]
    });

    <sec:authorize access="!hasAuthority('C_CONTACT')">
    ContactAccount_CreateSaveButton.hide();
    contactAccountTabs.animateHide("create");
    Button_Delete_Account.hide();
    </sec:authorize>
    <sec:authorize access="!hasAuthority('U_CONTACT')">
    ContactAccount_EditSaveButton.hide();
    </sec:authorize>
