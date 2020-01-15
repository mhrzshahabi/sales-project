<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Country = isc.MyRestDataSource.create(
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
 		name: "nameFa",
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



    var RestDataSource_Bank = isc.MyRestDataSource.create(
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
	fetchDataURL: "${contextPath}/api/contact/spec-list"
});



var Menu_ListGrid_Contact = isc.Menu.create(
{
	width: 150,
	data: [
	{
		title: "<spring:message code='global.form.refresh'/>",
		icon: "pieces/16/refresh.png",
		click: function()
		{
			ListGrid_Contact_refresh();
		}
	},
	{
		title: "<spring:message code='global.form.new'/>",
		icon: "pieces/16/icon_add.png",
		click: function()
		{
			clearContactForms();
			Window_Contact.animateShow();
		}
	},
	{
		title: "<spring:message code='global.form.edit'/>",
		icon: "pieces/16/icon_edit.png",
		click: function()
		{
			ListGrid_Contact_edit();
		}
	},
	{
		title: "<spring:message code='global.form.remove'/>",
		icon: "pieces/16/icon_delete.png",
		click: function()
		{
			ListGrid_Contact_remove();
		}
	}]
});


    var ValuesManager_Contact = isc.ValuesManager.create({});

    var m = "****************************";

    var DynamicForm_Contact_GeneralInfo = isc.DynamicForm.create(
 {
 	valuesManager: ValuesManager_Contact,
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
 	cellPadding: 2,
 	numCols: 4,
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
 			type: "RowSpacerItem"
 		},
 		{
 			name: "nameFA",
 			title: "<spring:message code='contact.nameFa'/>",
 			required: true,
 			readonly: true,
 			width: 300,
			colSpan: 3,
			titleColSpan: 1,
 			wrapTitle: false,
 			hint: "Persian/فارسی"
 		},
 		{
 			required:true,
 			name: "nameEN",
 			title: "<spring:message code='contact.nameEn'/>",
 			type: 'text',
 			width: 300,
 			colSpan: 3,
 			titleColSpan: 1,
 			hint: "Latin",
 			wrapTitle: false
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
 			wrapTitle: false ,
 		},
		{
				autoCenter: true,
				align:"center" ,
				type: "Header",
				defaultValue: "--- <spring:message code='contact.role'/> --- ",

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
			defaultValue:true,
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
 			wrapTitle: false
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
			defaultValue:true,
 			colSpan: 3,
 			titleColSpan: 1,
 			valueMap:
 			{
 				"true": "<spring:message code='global.table.enabled'/>",
 				"false": "<spring:message code='global.table.disabled'/>"
 			}
 		},
 		{
 			type: "RowSpacerItem"
 		}
 	]
 });





    var DynamicForm_Contact_Connection = isc.DynamicForm.create({
        valuesManager: ValuesManager_Contact,
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
        numCols: 2,
        fields: [
            {type: "RowSpacerItem"},
            {
            	required:true,
                name: "phone",
                title: "<spring:message code='contact.phone'/>",
                width: 500,
                wrapTitle: false,
            },
            {
                name: "mobile",
                title: "<spring:message code='contact.mobile'/>",
                width: 500,
                wrapTitle: false,
            },

            {

                name: "fax",
                title: "<spring:message code='contact.fax'/>",
                width: 500,
                wrapTitle: false,
            },

            {
            	required:true,
                name: "countryId",
                title: "<spring:message code='country.nameFa'/>",
                type: 'long',
                width: 500,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Country,
                displayField: "nameFa",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", width: 500, align: "center" , hidden: true },
                    {name: "nameFa", width: 500, align: "center"},
                ]
            },
            {name: "address", title: "<spring:message code='contact.address'/>", width: 500, wrapTitle: false},

            {
                name: "webSite",
                title: "<spring:message code='contact.webSite'/>",
                width: 500,
                wrapTitle: false,
                validators:[
                	{
                type:"regexp",
                expression:"^(?:http(s)?:\\/\\/)?[\\w.-]+(?:\\.[\\w\\.-]+)+[\\w\\-\\._~:/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$",
                validateOnChange:true,
					}
                ],
             },

            {
                name: "email",
                title: "<spring:message code='contact.email'/>",
                width: 500,
                wrapTitle: false,
                validateOnExit: true,
                validators:[
                {
                type:"regexp",
                expression:".+\\@.+\\..+",
                validateOnChange:true,
                }
                ],
            },
            {type: "RowSpacerItem"}
        ],

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





    function saveContact(){

		/*let Val_seller 			= DynamicForm_Contact_GeneralInfo.getValue("seller");
		let Val_buyer           = DynamicForm_Contact_GeneralInfo.getValue("buyer");
		let	Val_agentSeller		= DynamicForm_Contact_GeneralInfo.getValue("agentSeller");
		let	Val_agentBuyer      = DynamicForm_Contact_GeneralInfo.getValue("agentBuyer");
		let	Val_transporter     = DynamicForm_Contact_GeneralInfo.getValue("transporter");
		let Val_shipper         = DynamicForm_Contact_GeneralInfo.getValue("shipper");
		let Val_inspector       = DynamicForm_Contact_GeneralInfo.getValue("inspector");
		let Val_insurancer      = DynamicForm_Contact_GeneralInfo.getValue("insurancer");
		let Val_all = [Val_seller , Val_buyer   , Val_agentSeller , Val_agentBuyer , Val_transporter , Val_shipper , Val_inspector , Val_insurancer ].values();
		console.log(Val_all);
		for(var i = 0 ; i < Val_all.length; i++)
		{
			if(Val_all[i].checked)
			{
				var result = Val_all.push(Val_all[i])
			}
		}
		if(result.length < 0 )
		{
		  isc.warn("<spring:message code='contact.record.commercialRole'/>")
		}else
			{*/

	ValuesManager_Contact.validate();

	if (DynamicForm_Contact_GeneralInfo.hasErrors())
		contactTabs.selectTab(0);

	else if (DynamicForm_Contact_Connection.hasErrors())
		contactTabs.selectTab(1);
	else

		var contactData = Object.assign(ValuesManager_Contact.getValues());

		var httpMethod = "PUT"; //update
		if (contactData.id == null)
			httpMethod = "POST"; //create
		isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
		{
			actionURL: "${contextPath}/api/contact",
			httpMethod: httpMethod,
			data: JSON.stringify(contactData),
			callback: function(RpcResponse_o)
			{
				if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201)
				{
					ListGrid_Contact.invalidateCache();
					isc.say("<spring:message code='global.form.request.successful'/>");
					Window_Contact.close();
				}
				else
					isc.say(RpcResponse_o.data);
			}
		}));


}

    function clearContactForms() {
        DynamicForm_Contact_GeneralInfo.clearValues();
        DynamicForm_Contact_Connection.clearValues();
    }

    var IButton_Contact_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
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
        //commercialParty.setTitle("<spring:message code='commercialParty.title'/>");
    }



     function ListGrid_Contact_remove()
 {
 	var record = ListGrid_Contact.getSelectedRecord();
 	if (record == null || record.id == null)
 	{
 		isc.Dialog.create(
 		{
 			message: "<spring:message code='global.grid.record.not.selected'/>",
 			icon: "[SKIN]ask.png",
 			title: "<spring:message code='global.message'/> ",
 			buttons: [isc.Button.create(
 			{
 				title: "<spring:message code='global.ok'/> "
 			})],
 			buttonClick: function()
 			{
 				this.hide();
 			}
 		});
 	}
 	else
 	{
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
 			buttonClick: function(button, index)
 			{
 				this.hide();
 				if (index === 0)
 				{
 					var contactId = record.id;
 					isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
 					{
 						actionURL: "${contextPath}/api/contact/" + contactId,
 						httpMethod: "DELETE",
 						callback: function(RpcResponse_o)
 						{
 							if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201)
 							{
 								ListGrid_Contact.invalidateCache();
 								isc.say("<spring:message code='global.grid.record.remove.success'/>");
 							}
 							else
 							{
 								isc.say("<spring:message code='global.grid.record.remove.failed'/>");
 							}
 						}
 					}));
 				}
 			}
 		});
 	}
 }


function ListGrid_Contact_edit()
{
	var record = ListGrid_Contact.getSelectedRecord();

	if (record == null || record.id == null)
	{
		isc.Dialog.create(
		{
			message: "<spring:message code='global.grid.record.not.selected'/>",
			icon: "[SKIN]ask.png",
			title: "<spring:message code='global.message'/>",
			buttons: [isc.Button.create(
			{
				title: "<spring:message code='global.ok'/>"
			})],
			buttonClick: function()
			{
				this.hide();
			}
		});
	}
	else
	{
		clearContactForms();
		DynamicForm_Contact_GeneralInfo.editRecord(record);
		DynamicForm_Contact_Connection.editRecord(record);
		Window_Contact.animateShow();

	}
}


    var ToolStripButton_Contact_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Contact_refresh();
        }
    });

    var ToolStripButton_Contact_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            clearContactForms();
            Window_Contact.animateShow();
        }
    });

    var ToolStripButton_Contact_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Contact_edit();
        }
    });

    var ToolStripButton_Contact_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Contact_remove();
        }
    });

    var ListGrid_ContactAccount = isc.ListGrid.create(
    {
	width: "100%",
	height: "100%",
	dataSource: RestDataSource_ContactAccount,
	autoDraw: false,
	warnOnRemoval: "true",
	warnOnRemovalMessage: "<spring:message code='global.grid.record.remove.ask'/> ",
	recordClick: "ContactAccount_EditDynamicForm.editRecord(record)",
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
		filterEditorProperties:{ operator:"equals",type:"boolean",
								 valueMap: {true: "<spring:message code='contact.type.real'/>", false: "<spring:message code='contact.type.legal'/>"}}
	},
	{
		name: "isDefault",
		title: "<spring:message code='contactAccount.isDefault'/>",
		hidden: true,
		defaultValue: false
	}],
	sortField: 2,
	dataPageSize: 50,
	autoFetchData: false,
	showFilterEditor: true,
	filterOnKeypress: true,
	getCellCSSText: function(record, rowNum, colNum)
	{
		if (this.getFieldName(colNum) == "bankAccount")
		{
			if (record.isDefault == 1)
			{
				return "font-weight:bold; color:#0fed30;";
			}
		}
		if (this.getFieldName(colNum) == "bank.bankName")
		{
			if (record.isDefault == 1)
			{
				return "font-weight:bold; color:#0fed30;";
			}
		}
	},
});

    var ContactAccountGridHeaderForm = isc.DynamicForm.create({
        titleWidth: "200",
        width: "100%",
        numCols: 10,
        fields: [
            {name: "id", type: "hidden", title: "" , hidden: true},
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
                width: 100
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

function setContactAccountListGridHeaderFormData(record)
  {
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
        border: "0px solid red", layoutMargin: 5,
        members: [
            ContactAccountGridHeaderHLayout,
            ListGrid_ContactAccount
        ]
    });


    var ContactAccount_CreateDynamicForm = isc.DynamicForm.create(
     {
 	width: "100%",
 	numCols: 2,
 	setMethod: 'POST',
 	canSubmit: true,
 	showInlineErrors: true,
 	showErrorText: true,
 	showErrorStyle: true,
 	autoDraw: false,
 	errorOrientation: "right",
 	titleWidth: "100",
 	titleAlign: "right",
 	requiredMessage: "<spring:message code='validator.field.is.required'/>",
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
 		width: 300,
 		colSpan: "2",
 		required: true,
 		validators: [
 		{
 			type: "isInteger",
 			validateOnExit: true,
 			stopOnError: true,
 			errorMessage: "<spring:message code='global.form.correctType'/>"
 		}]
 	},
 	{
 		name: "bankId",
 		title: "<spring:message code='contactAccount.nameFA'/>",
 		type: 'long',
		width: 300,
 		editorType: "SelectItem",
 		optionDataSource: RestDataSource_Bank,
 		displayField: "bankName",
 		valueField: "id",
 		pickListWidth: "300",
 		pickListHeight: "500",
 		pickListProperties:
 		{
 			showFilterEditor: true
 		},
 		pickListFields: [
 		{
 			name: "bankName",
 			width: 295,
 			align: "center",
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
 			validateOnExit: true,
 			width: 300,
 			stopOnError: true,
 			errorMessage: "<spring:message code='global.form.correctType'/>"
 		}]
 	},
 	{
 		name: "bankShaba",
 		title: "<spring:message code='contactAccount.shabaAccount'/>",
 		type: 'text',
 		required: true,
 		width: 300,
 		colSpan: "2",
 		format: ""
 	},
 	{
 		name: "bankSwift",
 		title: "<spring:message code='contactAccount.bankSwift'/>",
 		type: 'text',
 		required: true,
 		width: 300,
 		colSpan: "2",
 		format: ""
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
		defaultValue:true,
 		valueMap:
 		{
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
 	}]
 });


    var ContactAccount_EditDynamicForm = isc.DynamicForm.create(
{
	width: "100%",
	numCols: 2,
	setMethod: 'POST',
	canSubmit: true,
	showInlineErrors: true,
	showErrorText: true,
	showErrorStyle: true,
	errorOrientation: "right",
	titleWidth: "100",
	autoDraw: false,
	titleAlign: "right",
	requiredMessage: "<spring:message code='validator.field.is.required'/>",
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
			validateOnExit: true,
			stopOnError: true,
			errorMessage: "<spring:message code='global.form.correctType'/>"
		}]
	},
	{
		name: "bankId",
		title: "<spring:message code='contactAccount.nameFA'/>",
		type: 'long',
		width: 300,
		editorType: "SelectItem",
		optionDataSource: RestDataSource_Bank,
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
			validateOnExit: true,
			stopOnError: true,
			errorMessage: "<spring:message code='global.form.correctType'/>"
		}]
	},
	{
		name: "bankShaba",
		title: "<spring:message code='contactAccount.shabaAccount'/>",
		type: 'text',
		required: true,
		width: 300,
		colSpan: "2"
	},
	{
		name: "bankSwift",
		title: "<spring:message code='contactAccount.bankSwift'/>",
		type: 'text',
		required: true,
		width: 300,
		colSpan: "2"
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



    var ContactAccount_CreateSaveButton = isc.IButtonSave.create(
     {
 	top: 260,
 	title: "<spring:message code='global.form.save'/>",
 	icon: "pieces/16/save.png",
 	click: function()
 	{
 		ContactAccount_CreateDynamicForm.validate();
 		if (ContactAccount_CreateDynamicForm.hasErrors())
 		{
 			return;
 		}
 		var data = ContactAccount_CreateDynamicForm.getValues();
 		data["contactId"] = ContactAccountGridHeaderForm.getValue('id');

 		isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
 		{
 			actionURL: "${contextPath}/api/contactAccount",
 			httpMethod: "POST",
 			data: JSON.stringify(data),
 			params:
 			{
 				parentId: data["contactId"]
 			},
 			callback: function(RpcResponse_o)
 			{
 				if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201)
 				{
 					ContactAccount_CreateDynamicForm.clearValues();
 					ListGrid_ContactAccount.invalidateCache();
 					ListGrid_Contact.invalidateCache();
 					isc.say("<spring:message code='global.form.request.successful'/>");
 				}
 				else
 					isc.say(RpcResponse_o.data);
 			}
 		}));
 	}
 });



    var ContactAccount_EditSaveButton = isc.IButtonSave.create(
    {
	top: 260,
	title: "<spring:message code='global.form.save'/>",
	autoDraw: false,
	icon: "pieces/16/save.png",
	click: function()
	{
		ContactAccount_EditDynamicForm.validate();
		if (ContactAccount_EditDynamicForm.hasErrors())
		{
			return;
		}
		var data = ContactAccount_EditDynamicForm.getValues();
		isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
		{
			actionURL: "${contextPath}/api/contactAccount",
			httpMethod: "PUT",
			data: JSON.stringify(data),
			callback: function(RpcResponse_o)
			{
				if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201)
				{
					ListGrid_ContactAccount.invalidateCache();
					ListGrid_Contact.invalidateCache();
					isc.say("<spring:message code='global.form.request.successful'/>");
									}
				else
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


  var contactAccountTabs = isc.TabSet.create(
    {
	height: "100%",
	width: "100%",
	autoDraw: true,
	tabs: [
	{
		title: "<spring:message code='global.form.edit'/>",
		icon: "pieces/16/icon_edit.png",
		pane: editPane
	},
	{
		title: "<spring:message code='global.form.new'/>",
		icon: "pieces/16/icon_add.png",
		pane: createPane
	}]
});


  var Button_Delete_Account = isc.IButton.create(
    {
	icon: "[SKIN]/actions/remove.png",
	title: "<spring:message code='global.form.remove'/>",
	click: function()
	{
		{
			var record = ListGrid_ContactAccount.getSelectedRecord();
			if (record == null || record.id == null)
			{
				isc.Dialog.create(
				{
					message: "<spring:message code='global.grid.record.not.selected'/>",
					icon: "[SKIN]ask.png",
					title: "<spring:message code='global.message'/>",
					buttons: [
						isc.Button.create(
						{
							title: "<spring:message code='global.ok'/>"
						})
					],
					buttonClick: function(button, index)
					{
						this.hide();
					}
				});
			}
			else
			{
				isc.Dialog.create(
				{
					message: "<spring:message code='global.grid.record.remove.ask'/>",
					icon: "[SKIN]ask.png",
					title: "<spring:message code='global.grid.record.remove.ask.title'/>",
					buttons: [
						isc.IButtonSave.create(
						{
							title: "<spring:message code='global.yes'/>"
						}),
						isc.IButtonCancel.create(
						{
							title: "<spring:message code='global.no'/>"
						})
					],
					buttonClick: function(button, index)
					{
						this.hide();
						if (index === 0)
						{
							if (record.isDefault)
							{
								isc.warn("<spring:message code='exception.DeleteDefaultAccount'/>");
								return;
							}
							var contactAccountId = record.id;
							isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
							{
								actionURL: "${contextPath}/api/contactAccount/" + contactAccountId,
								httpMethod: "DELETE",
								callback: function(RpcResponse_o)
								{
									if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201)
									{
										ListGrid_ContactAccount.invalidateCache();
										ListGrid_Contact.invalidateCache();
										isc.say("<spring:message code='global.grid.record.remove.success'/>");
									}
									else
									{
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
            ToolStripButton_Contact_Add,
            ToolStripButton_Contact_Edit,
            ToolStripButton_Contact_Remove,
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
	width:"100%",
	height: 180,
	align: "center",padding: 5,
	membersMargin: 20,
	members: [
		contactAttachmentViewLoader
	]
	});
  hLayoutViewLoader.hide();

var ListGrid_Contact = isc.ListGrid.create(
{
	width: "100%",
	height: "100%",
	dataSource: RestDataSource_Contact,
	styleName:'expandList',
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
			hidden: true , showIf:"false",
		},
		{
			name: "code",
			title: "<spring:message code='contact.code'/>",
			align: "center",
			width: 100 ,  showIf:"false",

		},
		{
			name: "nameFA",
			title: "<spring:message code='contact.nameFa'/>",
			align: "center",
			width: "10%"
		},
		{
			name: "nameEN",
			title: "<spring:message code='contact.nameEn'/>",
			align: "center",
			hidden: true
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
			align: "center" , showIf:"false",
		},
		{
			name: "branchName",
			title: "<spring:message code='contact.branchName'/>",
			type: 'text',
			width: "10%",
			wrapTitle: false,
			align: "center" , showIf:"false",
		},
		{
			name: "commercialRole",
			title: "<spring:message code='contact.commercialRole'/>",
			type: 'text',
			width: "10%",
			wrapTitle: false,
			align: "center" ,
		},
		{
			name: "phone",
			title: "<spring:message code='contact.phone'/>",
			align: "center",
			width: "10%" ,
		},
		{
			name: "mobile",
			title: "<spring:message code='contact.mobile'/>",
			align: "center",
			width: "10%" , showIf:"false",
		},
		{
			name: "fax",
			title: "<spring:message code='contact.fax'/>",
			align: "center",
			width: "10%" , showIf:"false",
		},
		{
			name: "country.nameFa",
			title: "<spring:message code='country.nameFa'/>",
			width: "10%", showIf:"false",
			sortNormalizer: function(recordObject)
			{
				return recordObject.country.nameFa;
			}
		},
		{
			name: "address",
			title: "<spring:message code='contact.address'/>",
			align: "center",
			hidden: true , type:'text'
		},
		{
			name: "webSite",
			title: "<spring:message code='contact.webSite'/>",
			align: "center",
			hidden: true ,
		},
		{
			name: "email",
			title: "<spring:message code='contact.email'/>",
			align: "center",
			hidden: true ,
		},
		{
			name: "type",
			title: "<spring:message code='contact.type'/>",
			align: "center",
			width: "10%",
			filterEditorProperties:{ operator:"equals",type:"boolean",
									 valueMap: {true: "<spring:message code='contact.type.real'/>", false: "<spring:message code='contact.type.legal'/>"}}
		},
		{
			name: "nationalCode",
			title: "<spring:message code='contact.nationalCode'/>",
			align: "center",
			width: "10%" , showIf:"false",
		},
		{
			name: "economicalCode",
			title: "<spring:message code='contact.economicalCode'/>",
			align: "center",
			width: "10%" , showIf:"false",

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
			filterEditorProperties:{ operator:"equals",type:"boolean",
								     valueMap: {true: "<spring:message code='global.table.enabled'/>", false: "<spring:message code='global.table.disabled'/>"}}
		}

	],
	sortField: 0,
	dataPageSize: 50,
	showFilterEditor: true,
	getExpansionComponent : function (record) {
			if (record == null || record.id == null)
			{
				isc.Dialog.create( {
				message: "<spring:message code='global.grid.record.not.selected'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.message'/>",
				buttons: [isc.Button.create({
					title: "<spring:message code='global.ok'/>"
				})],
				buttonClick: function()
				{
					this.hide();
				}
				});
				record.id = null;
			}
				var dccTableId = record.id;
				var dccTableName = "TBL_CONTACT";
				contactAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId);
				hLayoutViewLoader.show();
				var layout = isc.VLayout.create({
				padding: 5,
				membersMargin: 10,
				members: [ hLayoutViewLoader ]
				});
			return layout;
		}
});




  isc.VLayout.create({
        ID:"VLayout_Parameters_Body",
		width: "100%",
		height: "100%",
		members: [
			HLayout_Actions_Contact, ListGrid_Contact
		]
		});

