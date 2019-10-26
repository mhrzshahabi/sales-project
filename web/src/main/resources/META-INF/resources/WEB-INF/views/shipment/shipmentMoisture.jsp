<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

var MyRestDataSource_ShipmentMoistureHeader = isc.MyRestDataSource.create({
    fields:
    [
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentId", title: "id", canEdit:false},
		{name: "shipment.tblContract.contractNo", title: "contractNo", canEdit:false, hidden: true},
		{name: "inspectionByContactId", title:"<spring:message code='shipment.MoistureInspectionCompany'/>", type:'text' },
		{name: "inspectionByContact.nameEn", title:"<spring:message code='shipment.Moisture.inspectionCompany'/>", type:'text', canEdit:false },
		{name: "description", title:"<spring:message code='shipment.Moisture.capacity'/>", type:'text' },
		{name: "location", title:"<spring:message code='shipment.Moisture.location'/>", type:'text' },
		{name: "inspectionDate", title:"<spring:message code='shipment.Moisture.inspectionDate'/>", type:'text' },
		{name: "totalWetWeight", title:"<spring:message code='shipment.Moisture.totalWetWeight'/>", type:'text' },
		{name: "averageMoisturePercent", title:"<spring:message code='shipment.Moisture.averageMoisturePercent'/>", type:'text' },
		{name: "totalDryWeight", title:"<spring:message code='shipment.Moisture.totalDryWeight'/>", type:'text' },
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>", type:'text' },
    ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/shipmentMoistureHeader/spec-list"
});
var MyRestDataSource_ShipmentMoistureItem = isc.MyRestDataSource.create({
    fields:
    [
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentMoistureHeaderId", title: "id", canEdit:false, hidden:true},
		{name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>", type:'text' },
		{name: "wetWeight", title:"<spring:message code='shipment.Moisture.wetWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "moisturePercent", title:"<spring:message code='shipment.Moisture.moisturePercent'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "dryWeight", title:"<spring:message code='shipment.Moisture.dryWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
		  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
    ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/shipmentMoistureItem/spec-list"
});

    var MyRestDataSource_Contact = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "tradeMark" },
            {name: "ceoPassportNo" },
            {name: "ceo" },
            {name: "commercialRegistration" },
            {name: "branchName" },
            {name: "commertialRole" },
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {name: "fax", title: "<spring:message code='contact.fax'/>"},
            {name: "address", title: "<spring:message code='contact.address'/>"},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},
            {name: "email", title: "<spring:message code='contact.email'/>"},
            {
                name: "type",
                title: "<spring:message code='contact.type'/>",
                valueMap: {"true": "<spring:message code='contact.type.real'/>", "false": "<spring:message code='contact.type.legal'/>"}
            },
            {name: "nationalcode", title: "<spring:message code='contact.nationalcode'/>"},
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankName", title: "<spring:message code='contact.bankName'/>"},
            <%--{name: "bankId", title:"<spring:message code='global.country'/>", type:'long' , width: 400,editorType: "SelectItem"--%>
                <%--, optionDataSource:MyRestDataSource_Country ,displayField:"nameFa"--%>
                <%--, valueField:"id" ,pickListWidth:"300",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}--%>
                <%--,pickListFields:[{name:"nameFa",width:150,align:"center"},{name:"code",width:150,align:"center"}] --%>
            <%--},--%>
            {
                name: "status",
                title: "<spring:message code='contact.status'/>",
                valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
            },
            {name: "contactAccounts"}
        ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
//*******************************************************************************
    var MyRestDataSource_ShipmentByMoistureHeader = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
        {name: "contractItemShipmentId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },
        {name: "contactId",  type:'long', hidden: true },
        {name: "contact.nameFA", title:"<spring:message code='contact.name'/>", type:'text' },
        {name: "contractId",  type:'long', hidden: true },
        {name: "contract.contractNo", title:"<spring:message code='contract.contractNo'/>", type:'text' , width: 180},
        {name: "contract.contractDate", title:"<spring:message code='contract.contractDate'/>", type:'text' , width: 180},
        {name: "materialId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },
        {name: "material.descl", title:"<spring:message code='material.descl'/>", type:'text' },
        {name: "material.tblUnit.nameEN", title:"<spring:message code='unit.nameEN'/>", type:'text' },
        {name: "amount", title:"<spring:message code='global.amount'/>", type:'float'},
        {name: "noContainer", title:"<spring:message code='shipment.noContainer'/>", type:'integer'},
        {name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",},
        {name: "shipmentType", title:"<spring:message code='shipment.shipmentType'/>", type:'text', width: 400  ,valueMap:{"b":"bulk", "c":"container"}},
        {name: "loading", title:"<spring:message code='global.address'/>", type:'text', width: "10%" },
        {name: "portByLoadingId", title:"<spring:message code='shipment.loading'/>", type:'text', required: true, width: "10%" },
        {name: "portByLoading.port", title:"<spring:message code='shipment.loading'/>", type:'text', required: true, width: "10%" },
        {name: "portByDischargeId", title:"<spring:message code='shipment.discharge'/>", type:'text', required: true, width: "10%" },
        {name: "portByDischarge.port", title:"<spring:message code='shipment.discharge'/>", type:'text', required: true, width: "10%" },
        {name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', required: true, width: "10%" },
        {name: "description", title:"<spring:message code='shipment.description'/>", type:'text', required: true, width: "10%" },
        {name: "SWB", title:"<spring:message code='shipment.SWB'/>", type:'text', required: true, width: "10%" },
        {name: "switchPort.port", title:"<spring:message code='port.switchPort'/>", type:'text', required: true, width: "10%" },
        {name: "month", title:"<spring:message code='shipment.month'/>", type:'text', required: true, width: "10%" },
        {name: "status", title:"<spring:message code='shipment.staus'/>", type:'text', width: "10%" ,valueMap:{"Load Ready":"<spring:message code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"}},
        {name: "createDate", title:"<spring:message code='shipment.createDate'/>", type:'text', required: true, width: "10%" },
    ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

var ShipmentMoistureItemData = [];
for (i = 0; i < 100; i++) {
    ShipmentMoistureItemData.add({id:i});
}

var ClientDataSource_ShipmentMoistureItem = isc.MyRestDataSource.create({
    fields:
    [
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentMoistureHeaderId", title: "id", canEdit:false, hidden:true},
		{name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>", type:'text' },
		{name: "wetWeight", title:"<spring:message code='shipment.Moisture.wetWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "moisturePercent", title:"<spring:message code='shipment.Moisture.moisturePercent'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "dryWeight", title:"<spring:message code='shipment.Moisture.dryWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
		  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
    ],
    testData: ShipmentMoistureItemData,
    clientOnly:true
});
/* ****************** */

function pasteText (text) {
    var fieldNames = [];
    ListGrid_ShipmentMoistureItemPaste.selectAllRecords();
    for (var col = 0; col < 13; col++) {
        fieldNames.add(ListGrid_ShipmentMoistureItemPaste.getFieldName(col));
    }
    var settings = {
        fieldList: fieldNames,
        fieldSeparator: "\t",
        escapingMode: "double"
    };
    var dataSource = ListGrid_ShipmentMoistureItemPaste.dataSource;
    var records = dataSource.recordsFromText(text, settings);
    ListGrid_ShipmentMoistureItemPaste.applyRecordData(records);
}


function createPasteDialog () {
		var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
		if(record == null || record.id == null){
			isc.Dialog.create({
				message : "<spring:message code='global.grid.record.not.selected'/>. !",
				icon:"[SKIN]ask.png",
				title : "<spring:message code='global.message'/>.",
				buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>." })],
				buttonClick : function () {
					hide();
				}
			});
		return;
		}
		var ShipmentMoistureHeaderId=record.id;
        var PasteDialogShipmentMoistureItem_windows= isc.Window.create({
                title: "Import From Excle",
                autoSize :false,
                width:"100%",
                height:"70%",
                isModal: true,
                showModalMask: true,
                showMaximizeButton:true,
                canDragResize:true,
                autoCenter : true ,
                closeClick : function () {
                this.Super("closeClick", arguments);
                },
                items:[
                    isc.HLayout.create({
                        membersMargin  : 3,
                        width          :"100%",
                        alignLayout    :"center",
                        members        : [

                                isc.DynamicForm.create({
                                    ID:"resultsForm",
                                    numCols: 6,
                                    width: 600,
                                    height: 300,
                                    autoFocus: true,
                                    fields: [
                                                {type: "text", name: "guidance",colSpan:6, showTitle: false,  editorType: "StaticTextItem", value: "Press Ctrl-V (\u2318V on Mac) or right click (Control-click on Mac) to paste values, then click \"Apply\"."},
                                                {type: "text", name: "textArea", canEdit: true,colSpan:6, showTitle: false,  height: "*",  width: "*", editorType: "TextAreaItem" },
                                                {type : "text", name : "apply" , editorType: "ButtonItem", title: "Apply",
                                                   click: function (form) {
                                                        pasteText(form.getValue("textArea"));
                                                        ListGrid_ShipmentMoistureItemPaste.saveAllEdits();
                                                    }
                                                 }
                                             ]


                                    }) /* dynamic Form */
                                ,ListGrid_ShipmentMoistureItemPaste = isc.ListGrid.create({
                                    dataSource				: ClientDataSource_ShipmentMoistureItem ,
                                    sortDirection			: "descending",
                                    width                   : "100%",
                                    height                  : "90%",
                                    canEdit                 : true,
                                    autoFetchData           : true,
                                    canDragSelect           : true,
                                    canSelectCells          : true,
                                    autoSaveData			:true,
                                    fields                  : [
										{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true,align:"center" },
										{name: "shipmentMoistureHeaderId", title: "id", canEdit:false, hidden:true,align:"center" },
										{name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>", type:'text' ,align:"center" },
										{name: "wetWeight", title:"<spring:message code='shipment.Moisture.wetWeight'/>"
										   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
										{name: "moisturePercent", title:"<spring:message code='shipment.Moisture.moisturePercent'/>"
										   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
										{name: "dryWeight", title:"<spring:message code='shipment.Moisture.dryWeight'/>"
										   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
										{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
										  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
                                     ]
                                })

                        ]
                    }),
                    isc.ToolStripButton.create({
                      title:"<spring:message code='global.form.save'/>",
                      icon: "pieces/16/save.png",
                      click:function() {
						resultsForm.validate();
						if (resultsForm.hasErrors())
							return;
						var selected = ListGrid_ShipmentMoistureItemPaste.getSelection();

                            resultsForm.setValue("selected",selected)

                            resultsForm.setValue("ShipmentMoistureHeaderId",ShipmentMoistureHeaderId);
                            var data = resultsForm.getValues();

 // ######@@@@###&&@@###
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentMoistureItem/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                                            ListGrid_ShipmentMoistureItem_refresh();
                                            PasteDialogShipmentMoistureItem_windows.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );


                        }
                    })

                ]
     }); /* windows*/


}

/* ****************** */
var ToolStripButton_ShipmentMoistureItem_Paste = isc.ToolStripButton.create({
    icon: "[SKIN]/RichTextEditor/paste.png",
    title: "Paste Cells",
    click: function()
    {
        createPasteDialog();
    }
});

    var ListGrid_ShipmentByMoistureHeader = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentByMoistureHeader,
    fields:[
        {name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},
        {name: "contractItemShipmentId", hidden: true, type:'long' ,align:"center" },
        {name: "contractItemShipment.tblContractItem.tblContractId",  type:'long', hidden: true ,align:"center" },
        {name: "contactId",  type:'long', hidden: true },
        {name: "contact.nameFA", title:"<spring:message code='contact.name'/>", type:'text' , width: "20%" , align: "center",showHover:true},
        {name: "contractId",  type:'long', hidden: true },
        {name: "contract.contractNo", title:"<spring:message code='contract.contractNo'/>", type:'text' , width: "10%",showHover:true,align:"center" },
        {name: "contract.contractDate", title:"<spring:message code='contract.contractDate'/>", type:'text' , width: "10%",showHover:true,align:"center" },
        {name: "materialId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true ,showHover:true,align:"center" },
        {name: "material.descl", title:"<spring:message code='material.descl'/>", type:'text' , width: "10%" , align: "center",showHover:true},
        {name: "material.tblUnit.nameEN", title:"<spring:message code='unit.nameEN'/>", type:'text' , width: "10%" , align: "center",showHover:true},
        {name: "amount", title:"<spring:message code='global.amount'/>", type:'float', width: "10%" , align: "center",showHover:true},
        {name: "shipmentType", title:"<spring:message code='shipment.shipmentType'/>", type:'text', width: "10%"  ,valueMap:{"b":"bulk", "c":"container"},showHover:true,align:"center" },
        {name: "noContainer", title:"<spring:message code='shipment.noContainer'/>", type:'integer', width: "10%" , align: "center",showHover:true},
        {name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},
        {name: "portByLoading.port", title:"<spring:message code='shipment.loading'/>", type:'text', required: true, width: "10%" ,showHover:true,align:"center" },
        {name: "portByDischarge.port", title:"<spring:message code='shipment.discharge'/>", type:'text', required: true, width: "10%" ,showHover:true,align:"center" },
        {name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true,align:"center" },
        {name: "description", title:"<spring:message code='shipment.description'/>", type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
        {name: "month", title:"<spring:message code='shipment.month'/>", type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
        {name: "SWB", title:"<spring:message code='shipment.SWB'/>", type:'text', required: true, width: "10%" ,showHover:true,align:"center" },
        {name: "switchPort.port", title:"<spring:message code='port.switchPort'/>", type:'text', required: true, width: "10%" ,showHover:true,align:"center" },
        {name: "status", title:"<spring:message code='shipment.staus'/>", type:'text', width: "10%" , align: "center", valueMap:{"Load Ready":"<spring:message code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"},showHover:true},
    ],
    recordClick 			:	"this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
    updateDetails 			: function (viewer, record1, recordNum, field, fieldNum, value, rawValue)
    {
        var record = this.getSelectedRecord();
        ListGrid_ShipmentMoistureHeader.fetchData({"shipment.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentMoistureHeader.setData(data);});
    },
    dataArrived 			: 	function (startRow, endRow) {
    },
    sortField: 0,
    dataPageSize: 50,
    autoFetchData: true,
    showFilterEditor: true,
    filterOnKeypress: true,
    sortFieldAscendingText: "مرتب سازی صعودی",
    sortFieldDescendingText: "مرتب سازی نزولی",
    configureSortText: "تنظیم مرتب سازی",
    autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
    autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
    filterUsingText: "فیلتر کردن",
    groupByText: "گروه بندی",
    freezeFieldText: "ثابت نگه داشتن",
    startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentByMoistureHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
                ListGrid_ShipmentByMoistureHeader
        ]
    });

    var VLayout_Body_ShipmentByMoistureHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByMoistureHeader
        ]
    });
//*******************************************************************************
var Menu_ListGrid_ShipmentMoistureHeader = isc.Menu.create({
    width:150,
    data:[

        {title:"<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
            click: function(){
            ListGrid_ShipmentMoistureHeader_refresh();
        }
        },
        {title:"<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
            click: function() {
            DynamicForm_ShipmentMoistureHeader.clearValues();
            Window_ShipmentMoistureHeader.show();
        }
        },
        {title:"<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
            click: function() {
            ListGrid_ShipmentMoistureHeader_edit();
        }
        },
        {title:"<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
            click: function() {
            ListGrid_ShipmentMoistureHeader_remove();
        }
        }
        ]
    });

    var ValuesManager_ShipmentMoistureHeader = isc.ValuesManager.create({
    });

  var DynamicForm_ShipmentMoistureHeader = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    setMethod: 'POST',
    align: "center",
    canSubmit: true,
    showInlineErrors: true,
    showErrorText: true,
    showErrorStyle:true,
    errorOrientation: "right",
    requiredMessage: "<spring:message code='validator.field.is.required'/>",
    cellPadding:2,
    numCols  :4,
    fields:
    [
        {name:"id", hidden:true },
        {name:"shipmentId", hidden:true },
        {type:"RowSpacerItem"},
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentId", title: "id", canEdit:false, hidden:true},
		{name: "inspectionByContactId", title:"<spring:message code='shipment.MoistureInspectionCompany'/>", type:'long'
			 ,editorType: "SelectItem",colSpan :1 ,titleColSpan :1
			, optionDataSource:MyRestDataSource_Contact ,displayField:"nameEN",wrapTitle: false,optionCriteria:{"inspector":"1"}
			, valueField:"id" ,pickListWidth:"450",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
			,pickListFields:[{name:"nameFA",width:150,align:"center"},{name:"nameEN",width:150,align:"center"},{name:"code",width:150,align:"center"}] },
		{name: "location", title:"<spring:message code='shipment.Moisture.location'/>", type:'text' ,
                valueMap: {"source": "source", "destination": "destination"}},
		{name: "inspectionDate", title:"<spring:message code='shipment.Moisture.inspectionDate'/>", type:'text',hidden:true },
		{name: "inspectionDateDummy", title:"<spring:message code='shipment.Moisture.inspectionDate'/>", type:'date' },
		{name: "totalWetWeight", title:"<spring:message code='shipment.Moisture.totalWetWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "averageMoisturePercent", title:"<spring:message code='shipment.Moisture.averageMoisturePercent'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "totalDryWeight", title:"<spring:message code='shipment.Moisture.totalDryWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
		  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "description", title:"<spring:message code='shipment.Moisture.description'/>", type:'textArea',width:"400",colSpan:4 },
	]
    });
    var IButton_Shipment_Save_MoistureHeader = isc.IButton.create({
    top: 260,
    title:"<spring:message code='global.form.save'/>",
    icon: "pieces/16/save.png",
    click : function () {

        var d = DynamicForm_ShipmentMoistureHeader.getValue("inspectionDateDummy");
        var datestring =(d.getFullYear()+"/"+  ("0"+(d.getMonth()+1)).slice(-2) + "/" +("0" + d.getDate()).slice(-2))
        DynamicForm_ShipmentMoistureHeader.setValue("inspectionDate",datestring)

        DynamicForm_ShipmentMoistureHeader.validate();
        if (DynamicForm_ShipmentMoistureHeader.hasErrors()) {
        return;
        }

        var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();
        DynamicForm_ShipmentMoistureHeader.setValue("shipment.id",record.id);

        var data = DynamicForm_ShipmentMoistureHeader.getValues();

 // ######@@@@###&&@@###
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";

            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentMoistureHeader/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_ShipmentMoistureHeader_refresh();
                            Window_ShipmentMoistureHeader.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );

    }
    });
    var Window_ShipmentMoistureHeader = isc.Window.create({
    title: "<spring:message code='shipment.MoistureHeader'/>",
    width: "28%",
    hight: "30%",
    autoSize:true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    margin: '10px',
    closeClick : function () { this.Super("closeClick", arguments)},
    items: [
        DynamicForm_ShipmentMoistureHeader,
        IButton_Shipment_Save_MoistureHeader
    ]
    });

    function ListGrid_ShipmentMoistureHeader_refresh() {
        ListGrid_ShipmentMoistureHeader.invalidateCache();
        var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();
        if (record==null || record.id==null)
        return;
        ListGrid_ShipmentMoistureHeader.fetchData({"shipment.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentMoistureHeader.setData(data);});
    };
	function ListGrid_ShipmentMoistureHeader_remove() {
		var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
		if(record == null || record.id == null){
			isc.Dialog.create({
			message : "<spring:message code='global.grid.record.not.selected'/>. !",
			icon:"[SKIN]ask.png",
			title : "<spring:message code='global.message'/>.",
			buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>." })],
			buttonClick : function () {
			hide();
			}
			});
		} else {
			isc.Dialog.create({
				message : "<spring:message code='global.grid.record.remove.ask'/>",
				icon:"[SKIN]ask.png",
				title : "<spring:message code='global.grid.record.remove.ask.title'/>",
				buttons : [ isc.Button.create({ title:"<spring:message code='global.yes'/>" }), isc.Button.create({ title:"<spring:message code='global.no'/>" })],
				buttonClick : function (button, index) {
					this.hide();
					if (index == 0) {

						var shipmentId = record.id;
 // ######@@@@###&&@@###
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
						isc.RPCManager.sendRequest({
 // ######@@@@###&&@@### pls correct callback
actionURL: "${contextPath}/api/shipmentMoistureHeader/" + shipmentId,
httpMethod: "DELETE",
							callback: function (RpcResponse_o) {
 // ######@@@@###&&@@###
 // 								if(RpcResponse_o.data == 'success'){
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_ShipmentMoistureHeader.invalidateCache();
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

    function ListGrid_ShipmentMoistureHeader_edit() {

        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();

        if(record == null || record.id == null){
            isc.Dialog.create({
				message : "<spring:message code='global.grid.record.not.selected'/> !",
				icon:"[SKIN]ask.png",
				title : "<spring:message code='global.message'/>",
				buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
				buttonClick : function () {
					this.hide();
					}
            });
        } else if(record.tblShipment != null )
        {
            DynamicForm_ShipmentMoistureHeader.editRecord(record);
            DynamicForm_ShipmentMoistureHeader.setValue("inspectionDateDummy",new Date(record.inspectionDate));
            Window_ShipmentMoistureHeader.show();
        }
    };
    var ToolStripButton_ShipmentMoistureHeader_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function(){
            ListGrid_ShipmentMoistureHeader_refresh();
    }
    });
    var ToolStripButton_ShipmentMoistureHeader_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click:function(){

            var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();

            if(record == null || record.id == null){
				isc.Dialog.create({
					message : "<spring:message code='global.grid.record.not.selected'/>",
					icon:"[SKIN]ask.png",
					title : "<spring:message code='global.message'/>",
					buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
					buttonClick : function (){
						this.hide();
					}
				});
            } else	{
                DynamicForm_ShipmentMoistureHeader.clearValues();
                Window_ShipmentMoistureHeader.show();
				}
        }
    });
    var ToolStripButton_ShipmentMoistureHeader_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function(){
            var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
            if(record.tblShipment !=null ){
                ListGrid_ShipmentMoistureHeader_edit();
            }
        }
    });
    var ToolStripButton_ShipmentMoistureHeader_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click:function(){
            ListGrid_ShipmentMoistureHeader_remove();
        }
    });
    var ToolStripButton_ShipmentMoistureHeader_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click:function(){
                var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_ShipmentMoistureHeader = isc.ToolStrip.create({
    width: "100%",
    members: [
        ToolStripButton_ShipmentMoistureHeader_Refresh,
        ToolStripButton_ShipmentMoistureHeader_Add,
        ToolStripButton_ShipmentMoistureHeader_Edit,
        ToolStripButton_ShipmentMoistureHeader_Remove,
        ToolStripButton_ShipmentMoistureHeader_Print,
    ]
    });

    var HLayout_Actions_ShipmentMoistureHeader = isc.HLayout.create({
    width: "100%",
    members: [
        ToolStrip_Actions_ShipmentMoistureHeader
    ]
    });

    var ListGrid_ShipmentMoistureHeader = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentMoistureHeader,
    contextMenu: Menu_ListGrid_ShipmentMoistureHeader,
    autoFetchData : false,
    fields:[
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentId", title: "id", canEdit:false, hidden: true},
		{name: "shipment.tblContract.contractNo", title: "contractNo", canEdit:false, hidden: true},
		{name: "inspectionByContactId", title:"<spring:message code='shipment.MoistureInspectionCompany'/>", type:'text',hidden:true },
		{name: "inspectionByContact.nameEN", title:"<spring:message code='shipment.Moisture.inspectionCompany'/>", type:'text',align:"center" },
		{name: "description", title:"<spring:message code='shipment.Moisture.description'/>", type:'text' ,align:"center" },
		{name: "location", title:"<spring:message code='shipment.Moisture.location'/>", type:'text' ,align:"center" },
		{name: "inspectionDate", title:"<spring:message code='shipment.Moisture.inspectionDate'/>", type:'text' ,align:"center" },
		{name: "totalWetWeight", title:"<spring:message code='shipment.Moisture.totalWetWeight'/>", type:'text' ,align:"center" },
		{name: "averageMoisturePercent", title:"<spring:message code='shipment.Moisture.averageMoisturePercent'/>", type:'text' ,align:"center" },
		{name: "totalDryWeight", title:"<spring:message code='shipment.Moisture.totalDryWeight'/>", type:'text' ,align:"center" },
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>", type:'text' ,align:"center" },
    ],
    recordClick 			:	"this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
    updateDetails 			: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        var record = this.getSelectedRecord();
        ListGrid_ShipmentMoistureItem.fetchData({"shipmentMoistureHeader.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentMoistureItem.setData(data);});
    },
    dataArrived 			: 	function (startRow, endRow) {},
    sortField: 0,
    dataPageSize: 50,
    showFilterEditor: true,
    filterOnKeypress: true,
    sortFieldAscendingText: "مرتب سازی صعودی",
    sortFieldDescendingText: "مرتب سازی نزولی",
    configureSortText: "تنظیم مرتب سازی",
    autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
    autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
    filterUsingText: "فیلتر کردن",
    groupByText: "گروه بندی",
    freezeFieldText: "ثابت نگه داشتن",
    startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentMoistureHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentMoistureHeader
        ]
    });

    var VLayout_Body_ShipmentMoistureHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
        [
            HLayout_Actions_ShipmentMoistureHeader, HLayout_Grid_ShipmentMoistureHeader
        ]
    });

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//*******************************************************************************
var Menu_ListGrid_ShipmentMoistureItem = isc.Menu.create({
    width:150,
    data:[

        {title:"<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
            click: function(){
            ListGrid_ShipmentMoistureItem_refresh();
        }
        },
        {title:"<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
            click: function() {
            DynamicForm_ShipmentMoistureItem.clearValues();
            Window_ShipmentMoistureItem.show();
        }
        },
        {title:"<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
            click: function() {
            ListGrid_ShipmentMoistureItem_edit();
        }
        },
        {title:"<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
            click: function() {
            ListGrid_ShipmentMoistureItem_remove();
        }
        }
        ]
    });

    var ValuesManager_ShipmentMoistureItem = isc.ValuesManager.create({
    });

  var DynamicForm_ShipmentMoistureItem = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    setMethod: 'POST',
    align: "center",
    canSubmit: true,
    showInlineErrors: true,
    showErrorText: true,
    showErrorStyle:true,
    errorOrientation: "right",
    requiredMessage: "<spring:message code='validator.field.is.required'/>",
    cellPadding:2,
    numCols  :4,
    fields:
    [
        {type:"RowSpacerItem"},
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentMoistureHeaderId", title: "id", canEdit:false, hidden:true},
		{name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>", type:'text' },
		{name: "wetWeight", title:"<spring:message code='shipment.Moisture.wetWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "moisturePercent", title:"<spring:message code='shipment.Moisture.moisturePercent'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "dryWeight", title:"<spring:message code='shipment.Moisture.dryWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
		  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
	]
    });
    var IButton_Shipment_Save_MoistureItem = isc.IButton.create({
    top: 260,
    title:"<spring:message code='global.form.save'/>",
    icon: "pieces/16/save.png",
    click : function () {
        DynamicForm_ShipmentMoistureItem.validate();
        if (DynamicForm_ShipmentMoistureItem.hasErrors()) {
        return;
        }

        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
        DynamicForm_ShipmentMoistureItem.setValue("shipmentMoistureHeader.id",record.id);

        var data = DynamicForm_ShipmentMoistureItem.getValues();

 // ######@@@@###&&@@###
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
        isc.RPCManager.sendRequest({
 // ######@@@@###&&@@### pls correct callback
actionURL: "${contextPath}/api/shipmentMoistureItem/" ,
httpMethod: methodXXXX,
            data: JSON.stringify(data),
            callback: function (RpcResponse_o) {
 // ######@@@@###&&@@###
 //             if(RpcResponse_o.data == 'success'){
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    ListGrid_ShipmentMoistureItem_refresh();
                    Window_ShipmentMoistureItem.close();
                }
                else {
                    isc.say(RpcResponse_o.data);
                }
            }
            });
    }
    });
    var Window_ShipmentMoistureItem = isc.Window.create({
    title: "<spring:message code='shipment.MoistureItem'/>",
    width: "28%",
    hight: "30%",
    autoSize:true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    margin: '10px',
    closeClick : function () { this.Super("closeClick", arguments)},
    items: [
        DynamicForm_ShipmentMoistureItem,
        IButton_Shipment_Save_MoistureItem
    ]
    });

    function ListGrid_ShipmentMoistureItem_refresh() {
        ListGrid_ShipmentMoistureItem.invalidateCache();
        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
        if (record==null || record.id==null)
        return;
        ListGrid_ShipmentMoistureItem.fetchData({"shipmentMoistureHeader.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentMoistureItem.setData(data);});
    };
	function ListGrid_ShipmentMoistureItem_remove() {
		var record = ListGrid_ShipmentMoistureItem.getSelectedRecord();
		if(record == null || record.id == null){
			isc.Dialog.create({
			message : "<spring:message code='global.grid.record.not.selected'/>. !",
			icon:"[SKIN]ask.png",
			title : "<spring:message code='global.message'/>.",
			buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>." })],
			buttonClick : function () {
			hide();
			}
			});
		} else {
			isc.Dialog.create({
				message : "<spring:message code='global.grid.record.remove.ask'/>",
				icon:"[SKIN]ask.png",
				title : "<spring:message code='global.grid.record.remove.ask.title'/>",
				buttons : [ isc.Button.create({ title:"<spring:message code='global.yes'/>" }), isc.Button.create({ title:"<spring:message code='global.no'/>" })],
				buttonClick : function (button, index) {
					this.hide();
					if (index == 0) {

						var shipmentId = record.id;
 // ######@@@@###&&@@###
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
						isc.RPCManager.sendRequest({
 // ######@@@@###&&@@### pls correct callback
actionURL: "${contextPath}/api/shipmentMoistureItem/" + shipmentId,
httpMethod: "DELETE",
							callback: function (RpcResponse_o) {
 // ######@@@@###&&@@###
 // 								if(RpcResponse_o.data == 'success'){
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_ShipmentMoistureItem.invalidateCache();
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

    function ListGrid_ShipmentMoistureItem_edit() {

        var record = ListGrid_ShipmentMoistureItem.getSelectedRecord();

        if(record == null || record.id == null){
            isc.Dialog.create({
				message : "<spring:message code='global.grid.record.not.selected'/> !",
				icon:"[SKIN]ask.png",
				title : "<spring:message code='global.message'/>",
				buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
				buttonClick : function () {
					this.hide();
					}
            });
        } else
        {
            DynamicForm_ShipmentMoistureItem.editRecord(record);
            DynamicForm_ShipmentMoistureItem.setValue("inspectionDateDummy",new Date(record.inspectionDate));
            Window_ShipmentMoistureItem.show();
        }
    };
    var ToolStripButton_ShipmentMoistureItem_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function(){
            ListGrid_ShipmentMoistureItem_refresh();
    }
    });
    var ToolStripButton_ShipmentMoistureItem_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click:function(){

            var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();

            if(record == null || record.id == null){
				isc.Dialog.create({
					message : "<spring:message code='global.grid.record.not.selected'/>",
					icon:"[SKIN]ask.png",
					title : "<spring:message code='global.message'/>",
					buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
					buttonClick : function (){
						this.hide();
					}
				});
            } else	{
                DynamicForm_ShipmentMoistureItem.clearValues();
                Window_ShipmentMoistureItem.show();
				}
        }
    });
    var ToolStripButton_ShipmentMoistureItem_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function(){
            var record = ListGrid_ShipmentMoistureItem.getSelectedRecord();
            if(record.id !=null ){
                ListGrid_ShipmentMoistureItem_edit();
            }
        }
    });
    var ToolStripButton_ShipmentMoistureItem_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click:function(){
            ListGrid_ShipmentMoistureItem_remove();
        }
    });
    var ToolStripButton_ShipmentMoistureItem_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click:function(){
                var record = ListGrid_ShipmentMoistureItem.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_ShipmentMoistureItem = isc.ToolStrip.create({
    width: "100%",
    members: [
        ToolStripButton_ShipmentMoistureItem_Refresh,
        ToolStripButton_ShipmentMoistureItem_Add,
        ToolStripButton_ShipmentMoistureItem_Edit,
        ToolStripButton_ShipmentMoistureItem_Remove,
        ToolStripButton_ShipmentMoistureItem_Paste,
        ToolStripButton_ShipmentMoistureItem_Print,
    ]
    });

    var HLayout_Actions_ShipmentMoistureItem = isc.HLayout.create({
    width: "100%",
    members: [
        ToolStrip_Actions_ShipmentMoistureItem
    ]
    });

    var ListGrid_ShipmentMoistureItem = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentMoistureItem,
    contextMenu: Menu_ListGrid_ShipmentMoistureItem,
    autoFetchData : false,
    fields:[
		{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
		{name: "shipmentMoistureHeaderId", title: "id", canEdit:false, hidden:true},
		{name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>", type:'text' ,align:"center" },
		{name: "wetWeight", title:"<spring:message code='shipment.Moisture.wetWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
		{name: "moisturePercent", title:"<spring:message code='shipment.Moisture.moisturePercent'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
		{name: "dryWeight", title:"<spring:message code='shipment.Moisture.dryWeight'/>"
		   , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
		{name: "totalH2oWeight", title:"<spring:message code='shipment.Moisture.totalH2oWeight'/>"
		  , type:'float', validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}],align:"center" },
    ],
    recordClick 			:	"this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
    updateDetails 			: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {},
    dataArrived 			: 	function (startRow, endRow) {},
    sortField: 0,
    dataPageSize: 50,
    showFilterEditor: true,
    filterOnKeypress: true,
    sortFieldAscendingText: "مرتب سازی صعودی",
    sortFieldDescendingText: "مرتب سازی نزولی",
    configureSortText: "تنظیم مرتب سازی",
    autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
    autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
    filterUsingText: "فیلتر کردن",
    groupByText: "گروه بندی",
    freezeFieldText: "ثابت نگه داشتن",
    startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentMoistureItem = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentMoistureItem
        ]
    });

    var VLayout_Body_ShipmentMoistureItem = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
        [
            HLayout_Actions_ShipmentMoistureItem, HLayout_Grid_ShipmentMoistureItem
        ]
    });

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

isc.SectionStack.create({
    ID:"ShipmentMoistureHeader_Section_Stack",
    sections:
    [
         {title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentByMoistureHeader  ,expanded:true}
        ,{title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentMoistureHeader ,expanded:true}
        ,{title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentMoistureItem ,expanded:true}
    ],
    visibilityMode:"multiple",
    animateSections:true,
    height:"100%",
    width:"100%",
    overflow:"hidden"
});
