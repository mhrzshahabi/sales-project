<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<% DateUtil dateUtil = new DateUtil();%>
var contractId ;
var RestDataSource_ContractPerson;
var ListGrid_Person_EmailCC;
var RestDataSource_Contact = isc.RestDataSource.create({
fields:
[
{name: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "code", title: "<spring:message code='contact.code'/>"},
{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
{name: "commertialRole" },
{name: "phone", title: "<spring:message code='contact.phone'/>"},
{name: "mobile", title: "<spring:message code='contact.mobile'/>"},
{name: "email", title: "<spring:message code='contact.email'/>"},
{name: "type", title: "<spring:message code='contact.type'/>", valueMap: {"true": "<spring:message
		code='contact.type.real'/>", "false": "<spring:message code='contact.type.legal'/>"}},
{name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
{name: "status",title: "<spring:message code='contact.status'/>",valueMap: {"true": "<spring:message
		code='enabled'/>", "false": "<spring:message code='disabled'/>"}},
{name: "contactAccounts"}
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/contact/spec-list"
});
var RestDataSource_LoadingPort = isc.RestDataSource.create({
fields:
[
{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
{name: "port", title:"<spring:message code='port.port'/>" , width: 200},
{name: "country.nameFa", title:"<spring:message code='country.nameFa'/>" , width: 200}
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/port/spec-list1"
});
var RestDataSource_DischargePort = isc.RestDataSource.create({
fields:
[
{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
{name: "port", title:"<spring:message code='port.port'/>" , width: 200},
{name: "country.nameFa", title:"<spring:message code='country.nameFa'/>" , width: 200}
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/port/spec-list2"
});
var RestDataSource_SwitchPort = isc.RestDataSource.create({
fields:
[
{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
{name: "port", title:"<spring:message code='port.port'/>" , width: 200},
{name: "country.nameFa", title:"<spring:message code='country.nameFa'/>" , width: 200}
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/port/spec-list"
});
var RestDataSource_pickShipmentItem = isc.RestDataSource.create({
fields:
[
{name: "cisId", title: "id", primaryKey:true, canEdit:false, hidden: true},
{name: "contractNo", title: "<spring:message code='contract.contractNo'/> "},
{name: "fullname", title: "<spring:message code='contact.name'/> "},
{name: "amount", title: "<spring:message code='global.amount'/> "},
{name: "address", title: "<spring:message code='global.address'/> "},
{name: "plan", title: "<spring:message code='shipment.plan'/> "},
{name: "sendDate", title: "<spring:message code='global.sendDate'/> "},
{name: "duration", title: "<spring:message code='global.duration'/> "},
{name: "contactID", title: "contactId"},
{name: "contractID", title: "contractID"},
{name: "materialID", title: "materialId"},
{name: "dischargeID", title: "dischargeID"},
{name: "dischargeAddress", title: "materialId"},
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/shipment/pick-list"
});

var RestDataSource_Shipment = isc.RestDataSource.create({
fields: [
{name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},
{name: "contractShipmentId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },
{name: "contactId", type:'long', hidden: true },
{name: "contact.nameFA", title:"<spring:message code='contact.name'/>", type:'text' },
{name: "contractId", type:'long', hidden: true },
{name: "contract.contractNo", title:"<spring:message code='contract.contractNo'/>", type:'text' , width: 180},
{name: "contract.contractDate", title:"<spring:message code='contract.contractDate'/>", type:'text' , width: 180},
{name: "materialId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },
{name: "material.descl", title:"<spring:message code='material.descl'/>", type:'text' },
{name: "material.tblUnit.nameEN", title:"<spring:message code='unit.nameEN'/>", type:'text' },
{name: "amount", title:"<spring:message code='global.amount'/>", type:'float'},
{name: "noContainer", title:"<spring:message code='shipment.noContainer'/>", type:'integer'},
{name: "noPalete", title:"<spring:message code='shipment.noContainer'/>", type:'integer'},
{name: "laycan", title:"<spring:message
		code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",},
{name: "shipmentType", title:"<spring:message
		code='shipment.shipmentType'/>", type:'text', width: 400 ,valueMap:{"b":"bulk", "c":"container"}},
{name: "loading", title:"<spring:message code='global.address'/>", type:'text', width: "10%" },
{name: "portByLoadingId", title:"<spring:message code='shipment.loading'/>", type:'text', width: "10%" },
{name: "portByLoading.port", title:"<spring:message code='shipment.loading'/>", type:'text', width: "10%" },
{name: "portByDischargeId", title:"<spring:message code='shipment.discharge'/>", type:'text', width: "10%" },
{name: "portByDischarge.port", title:"<spring:message code='shipment.discharge'/>", type:'text', width: "10%" },
{name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', width: "10%" },
{name: "description", title:"<spring:message code='shipment.description'/>", type:'text', width: "10%" },
{name: "swb", title:"<spring:message code='shipment.SWB'/>", type:'text', width: "10%" },
{name: "switchPort.port", title:"<spring:message code='port.switchPort'/>", type:'text', width: "10%" },
{name: "month", title:"<spring:message code='shipment.month'/>", type:'text', width: "10%" },
{name: "status", title:"<spring:message
		code='shipment.staus'/>", type:'text', width: "10%" ,valueMap:{"Load Ready":"<spring:message
		code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"}},
{name: "createDate", title:"<spring:message code='shipment.createDate'/>", type:'text', width: "10%" },
],
dataFormat: "json",
jsonPrefix: "",
jsonSuffix: "",
// ######@@@@###&&@@###
transformRequest: function (dsRequest) {
dsRequest.httpHeaders = {
"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
"Access-Control-Allow-Origin": "http://localhost:9099"
};
return this.Super("transformRequest", arguments);
},
fetchDataURL: "http://localhost:9099/api/shipment/spec-list"
});

var Menu_ListGrid_Shipment = isc.Menu.create({
width:150,
data:[

{title:"<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
click: function(){
ListGrid_Shipment_refresh();
}
},
{title:"<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
click: function() {
DynamicForm_Shipment.clearValues();
Window_Shipment.animateShow();
}
},
{title:"<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
click: function() {
ListGrid_Shipment_edit();
}
},
{title:"<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
click: function() {
ListGrid_Shipment_remove();
}
}
]
});

var DynamicForm_Shipment = isc.DynamicForm.create({
width: "100%",
height: "100%",
setMethod: 'POST',
align: "center",
dataSource:RestDataSource_Shipment,
canSubmit: true,
showInlineErrors: true,
showErrorText: true,
showErrorStyle:true,
errorOrientation: "right",
titleWidth: "100",
titleAlign:"right",
requiredMessage: "<spring:message code='validator.field.is.required'/>",
numCols:2,backgroundImage:"backgrounds/leaves.jpg",

fields: [
{name:"id", hidden:true, },
{name:"contactId", hidden:true, },
{name:"contractId", hidden:true, },
{name:"materialId", hidden:true, },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "contractShipmentId", title:"<spring:message
		code='contact.name'/>", type:'long' , width: "100%" ,editorType: "SelectItem"
, optionDataSource:RestDataSource_pickShipmentItem ,displayField:"contractNo"
, valueField:"cisId" ,pickListWidth:"500",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
,pickListFields:[{name:"contractNo",width:50,align:"center"},{name:"fullname",width:200,align:"center"},
{name:"amount",width:150,align:"center"},{name:"sendDate",width:150,align:"center"},{name:"plan",width:150,align:"center"}]
,changed: function()
{
var record = DynamicForm_Shipment.getItem("contractShipmentId").getSelectedRecord();
Shipment_contact_name.setContents(record.fullname);
var d = new Date(record.sendDate);
DynamicForm_Shipment.setValue("createDateDumy",d);
DynamicForm_Shipment.setValue("amount",record.amount);
DynamicForm_Shipment1.setValue("dischargeAddress",record.address);
// DynamicForm_Shipment.setValue("createDate",record.plan);
DynamicForm_Shipment.setValue("contactId",record.contactID);
DynamicForm_Shipment.setValue("materialId",record.materialID);
DynamicForm_Shipment.setValue("contractNo",record.contractNo);
DynamicForm_Shipment.setValue("month",d.getMonthName());
DynamicForm_Shipment2.setValue("status","Load Ready");
DynamicForm_Shipment.setValue("contractId",record.contractID);
DynamicForm_Shipment.setValue("contractShipmentId",record.cisId);
DynamicForm_Shipment1.setValue("portByDischargeId",record.dischargeID);
DynamicForm_Shipment1.setValue("dischargeAddress",record.dischargeAddress);
// cisId,contractNo,fullname,amount,address,plan,sendDate,duration,contactID,materialID,contractID,dischargeID,dischargeAddress
}
},
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "createDateDumy", title:"<spring:message
		code='shipment.createDate'/>",defaultValue:"<%=dateUtil.todayDate()%>" , type:'date',format:'DD-MM-YYYY', required: true, width: "100%" },
{name: "createDate", hidden:true, },
{name: "month", title:"<spring:message code='shipment.month'/>", type:'text', width: "100%"
,valueMap:{"January":"January", "February":"February", "March":"March", "April":"April", "May":"May", "June":"June", "July":"July", "August":"August",
"September":"September", "October":"October", "November":"November" , "December":"December"}},
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "loadingLetter", title:"<spring:message
		code='shipment.loadingLetter'/>", type:'text', required: true, width: "100%" },
{name: "amount", title:"<spring:message code='global.amount'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "shipmentType", title:"<spring:message
		code='shipment.shipmentType'/>", type:'text', width: "100%" ,valueMap:{"b":"bulk", "c":"container"}},
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "noContainer", title:"<spring:message
		code='shipment.noContainer'/>", type:'integer', required: false, width: "100%" ,
validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "noBundle", title:"<spring:message code='shipment.noBundle'/>", type:'integer', required: false, width: "100%" ,
validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "noPalete", title:"<spring:message code='shipment.noPalete'/>", type:'integer', required: false, width: "100%" ,
validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "noBarrel", title:"<spring:message code='shipment.noBarrel'/>", type:'integer', required: false, width: "100%" ,
validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "status", title:"<spring:message
		code='shipment.staus'/>", type:'text', width: "100%" ,valueMap:{"Load Ready":"<spring:message
		code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"}}
// createDate,month,loadingLetter,amount,shipmentType,noContainer,noBundle,noPalete,noBarrel,blNumbers,blDate,SWB,switchPortId,switchBl,swBlDate,portByLoadingId
// portByDischargeId,consignee,contactByAgentId,vesselName,freight,demurrage,dispatch,status
]
});
var DynamicForm_Shipment1 = isc.DynamicForm.create({
width: "100%",
height: "100%",
setMethod: 'POST',
align: "center",
dataSource:RestDataSource_Shipment,
canSubmit: true,
showInlineErrors: true,
showErrorText: true,
showErrorStyle:true,
errorOrientation: "right",
titleWidth: "100",
titleAlign:"right",
requiredMessage: "<spring:message code='validator.field.is.required'/>",
numCols:2,backgroundImage:"backgrounds/leaves.jpg",

fields: [
{name:"id", hidden:true, },
{type: "Header",defaultValue:""},
{name: "numberOfBLs", title:"<spring:message
		code='shipment.numberOfBLs'/>", type:'integer', required: false, width: "100%" ,
validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "blNumbers", title:"<spring:message code='shipment.blNumbers'/>", type:'text', width: "300" , align: "center",},
{name: "blDate", hidden:true, },
{name: "blDateDumy", title:"<spring:message
		code='shipment.blDate'/>",defaultValue:"<%=dateUtil.todayDate()%>" , type:'date',format:'DD-MM-YYYY', required: true, width: "100%" },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "swb", title:"<spring:message
		code='shipment.SWB'/>", type:'text', width: "100%" ,defaultValue:"Yes" ,valueMap:{"Yes":"Yes", "No":"No"}},
{name: "switchPortId", title:"<spring:message
		code='port.switchPort'/>", type:'long' , width: "100%" ,editorType: "SelectItem", optionDataSource:RestDataSource_SwitchPort
,displayField:"port", valueField:"id" ,pickListWidth:"500",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
,pickListFields:[{name:"port",align:"center"},{name:"country.nameFa",align:"center"}]},
{name: "switchBl", title:"<spring:message code='shipment.switchBl'/>", type:'text', width: "300" , align: "center",},
{name: "swBlDate", hidden:true, },
{name: "swBlDateDumy", title:"<spring:message
		code='shipment.swBlDate'/>",defaultValue:"<%=dateUtil.todayDate()%>" , type:'date',format:'DD-MM-YYYY', required: true, width: "100%" },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "portByLoadingId", title:"<spring:message
		code='shipment.loading'/>", type:'long' , width: "100%",editorType: "SelectItem", optionDataSource:RestDataSource_LoadingPort
,displayField:"port", valueField:"id" ,pickListWidth:"500",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
,pickListFields:[{name:"port",align:"center"},{name:"country.nameFa",align:"center"}]},
{name: "portByDischargeId", title:"<spring:message
		code='shipment.discharge'/>", type:'long' , width: "100%" ,editorType: "SelectItem", optionDataSource:RestDataSource_DischargePort
,displayField:"port", valueField:"id" ,pickListWidth:"500",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
,pickListFields:[{name:"port",align:"center"},{name:"country.nameFa",align:"center"}]},
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "consignee", title:"<spring:message code='shipment.consignee'/>", type:'text', required: true, width: "100%" },
]
});
var DynamicForm_Shipment2 = isc.DynamicForm.create({
width: "100%",
height: "100%",
setMethod: 'POST',
align: "center",
dataSource:RestDataSource_Shipment,
canSubmit: true,
showInlineErrors: true,
showErrorText: true,
showErrorStyle:true,
errorOrientation: "right",
titleWidth: "100",
titleAlign:"right",
requiredMessage: "<spring:message code='validator.field.is.required'/>",
numCols:2,backgroundImage:"backgrounds/leaves.jpg",

fields: [
{name:"id", hidden:true, },
{type: "Header",defaultValue:""},
{name: "contactByAgentId", title:"<spring:message
		code='shipment.agent'/>", type:'long' , width: "100%" ,editorType: "SelectItem", optionDataSource:RestDataSource_Contact
,displayField:"nameFA", valueField:"id" ,pickListWidth:"500",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}
,pickListFields:[{name:"nameFA",align:"center"},{name:"nameEN",align:"center"},{name : "country.nameFa" ,align: "center" } ] },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "vesselName", title:"<spring:message code='shipment.vesselName'/>", type:'text', required: true, width: "100%" },
{type: "Header",defaultValue:"--------------------------------------------------------------"},
{name: "freight", title:"<spring:message code='shipment.freight'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "totalFreight", title:"<spring:message
		code='shipment.totalFreight'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{
name: "freightCurrency",
title: "<spring:message code='currency.title'/>",
type: 'text',
defaultValue: "DOLLAR", valueMap:{"EURO":"EURO", "DOLLAR":"DOLLAR"},
width: "100%" ,
},
{name: "dispatch", title:"<spring:message code='shipment.dispatch'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "demurrage", title:"<spring:message code='shipment.demurrage'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
{name: "detention", title:"<spring:message code='shipment.detention'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}] },
]
});
var shipmentTabs = isc.TabSet.create({
height: "500",
width: "100%",
showTabScroller: false,
tabs: [
{
title: "<spring:message code='shipment.tab.shipment'/>",
pane: DynamicForm_Shipment
},
{
title: "<spring:message code='shipment.tab.transport'/>",
pane: DynamicForm_Shipment1
},
{
title: "<spring:message code='shipment.tab.agent'/>",
pane: DynamicForm_Shipment2
}
]
});
var IButton_Shipment_Save = isc.IButton.create({
top: 260,
title:"<spring:message code='global.form.save'/>",
icon: "pieces/16/save.png",
click : function () {
DynamicForm_Shipment.validate();
if (DynamicForm_Shipment.hasErrors()) {
shipmentTabs.selectTab(0);
return;
}
DynamicForm_Shipment1.validate();
if (DynamicForm_Shipment1.hasErrors()) {
shipmentTabs.selectTab(1);
return;
}
DynamicForm_Shipment2.validate();
if (DynamicForm_Shipment2.hasErrors()) {
shipmentTabs.selectTab(2);
return;
}
var drs = DynamicForm_Shipment.getValue("createDateDumy");
var datestringRs =(drs.getFullYear()+"/"+ ("0"+(drs.getMonth()+1)).slice(-2) + "/" +("0" + drs.getDate()).slice(-2));
DynamicForm_Shipment.setValue("createDate",datestringRs);
drs = DynamicForm_Shipment1.getValue("swBlDateDumy");
datestringRs =(drs.getFullYear()+"/"+ ("0"+(drs.getMonth()+1)).slice(-2) + "/" +("0" + drs.getDate()).slice(-2));
DynamicForm_Shipment1.setValue("swBlDate",datestringRs);
drs = DynamicForm_Shipment1.getValue("blDateDumy");
datestringRs =(drs.getFullYear()+"/"+ ("0"+(drs.getMonth()+1)).slice(-2) + "/" +("0" + drs.getDate()).slice(-2));
DynamicForm_Shipment1.setValue("blDate",datestringRs);

DynamicForm_Shipment.setValue( "numberOfBLs",DynamicForm_Shipment1.getValue("numberOfBLs"));
DynamicForm_Shipment.setValue( "blNumbers",DynamicForm_Shipment1.getValue("blNumbers"));
DynamicForm_Shipment.setValue( "blDate",DynamicForm_Shipment1.getValue("blDate"));
DynamicForm_Shipment.setValue( "swb",DynamicForm_Shipment1.getValue("swb"));
DynamicForm_Shipment.setValue( "switchPortId",DynamicForm_Shipment1.getValue("switchPortId"));
DynamicForm_Shipment.setValue( "switchBl",DynamicForm_Shipment1.getValue("switchBl"));
DynamicForm_Shipment.setValue( "swBlDate",DynamicForm_Shipment1.getValue("swBlDate"));
DynamicForm_Shipment.setValue( "portByLoadingId",DynamicForm_Shipment1.getValue("portByLoadingId"));
DynamicForm_Shipment.setValue( "portByDischargeId",DynamicForm_Shipment1.getValue("portByDischargeId"));
DynamicForm_Shipment.setValue( "consignee",DynamicForm_Shipment1.getValue("consignee"));
DynamicForm_Shipment.setValue( "contactByAgentId",DynamicForm_Shipment2.getValue("contactByAgentId"));
DynamicForm_Shipment.setValue( "Header",DynamicForm_Shipment2.getValue("Header"));
DynamicForm_Shipment.setValue( "vesselName",DynamicForm_Shipment2.getValue("vesselName"));
DynamicForm_Shipment.setValue( "freight",DynamicForm_Shipment2.getValue("freight"));
DynamicForm_Shipment.setValue( "totalFreight",DynamicForm_Shipment2.getValue("totalFreight"));
DynamicForm_Shipment.setValue( "freightCurrency",DynamicForm_Shipment2.getValue("freightCurrency"));
DynamicForm_Shipment.setValue( "dispatch",DynamicForm_Shipment2.getValue("dispatch"));
DynamicForm_Shipment.setValue( "demurrage",DynamicForm_Shipment2.getValue("demurrage"));
DynamicForm_Shipment.setValue( "detention",DynamicForm_Shipment2.getValue("detention"));


var dataShipment = Object.assign(DynamicForm_Shipment.getValues());
// ######@@@@###&&@@###
var methodXXXX="PUT";if ((dataShipment.id == null) || (dataShipment.id == 'undefiend')) methodXXXX="POST";
isc.RPCManager.sendRequest({
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/shipment/" ,
httpMethod: methodXXXX,
httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
useSimpleHttp: true,
contentType: "application/json; charset=utf-8",
showPrompt:false,
data: JSON.stringify(dataShipment),
serverOutputAsString: false,
//params: { data:data1},
callback: function (RpcResponse_o) {
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
isc.say("<spring:message code='global.form.request.successful'/>");
ListGrid_Shipment_refresh();
Window_Shipment.close();
}
else {
isc.say(RpcResponse_o.data);
}
}
});
}
});
var Window_Shipment = isc.Window.create({
title: "<spring:message code='Shipment.title'/>. ",
width: 600,
height: 600,
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
isc.Label.create({
ID:"Shipment_contact_name",
title : "<spring:message code='contact.name'/>. ",
contents: "<spring:message code='contact.name'/>. ",
align : "center",
width:"100%",
height: 22
}),
shipmentTabs,
isc.HLayout.create({
width: "100%",
height: "20",
layoutMargin: 5,
membersMargin: 5,
members: [
IButton_Shipment_Save,
]
}),

]
});

function ListGrid_Shipment_refresh() {
ListGrid_Shipment.invalidateCache();
};
function ListGrid_Shipment_remove() {

var record = ListGrid_Shipment.getSelectedRecord();

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
buttons : [ isc.Button.create({ title:"<spring:message
		code='global.yes'/>" }), isc.Button.create({ title:"<spring:message code='global.no'/>" })],
buttonClick : function (button, index) {
this.hide();
if (index == 0) {

var shipmentId = record.id;
isc.RPCManager.sendRequest({
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/shipment/" + shipmentId,
httpMethod: "DELETE",
httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
// httpMethod: "POST",
useSimpleHttp: true,
contentType: "application/json; charset=utf-8",
showPrompt:true,
// data: shipmentId,
serverOutputAsString: false,
callback: function (RpcResponse_o) {
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201){
ListGrid_Shipment.invalidateCache();
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

function ListGrid_Shipment_edit() {

var record = ListGrid_Shipment.getSelectedRecord();

if(record == null || record.id == null){
isc.Dialog.create({
message : "<spring:message code='global.grid.record.not.selected'/>",
icon:"[SKIN]ask.png",
title : "<spring:message code='global.message'/>",
buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
buttonClick : function () {
this.hide();
}
});
} else {
DynamicForm_Shipment.editRecord(record);
DynamicForm_Shipment1.editRecord(record);
DynamicForm_Shipment2.editRecord(record);
DynamicForm_Shipment.setValue("createDateDumy",new Date(record.createDate));
DynamicForm_Shipment1.setValue("swBlDateDumy",new Date(record.swBlDate));
DynamicForm_Shipment1.setValue("blDateDumy",new Date(record.blDate));
if(!(record.contract.contact.nameFA==null || record.contract.contact.nameFA=='undefiend'))
Shipment_contact_name.setContents(record.contract.contact.nameFA);
Window_Shipment.animateShow();
}
};
var ToolStripButton_Shipment_Refresh = isc.ToolStripButton.create({
icon: "[SKIN]/actions/refresh.png",
title: "<spring:message code='global.form.refresh'/>",
click: function(){
ListGrid_Shipment_refresh();
}
});
var ToolStripButton_Shipment_Add = isc.ToolStripButton.create({
icon: "[SKIN]/actions/add.png",
title: "<spring:message code='global.form.new'/>",
click:function(){
DynamicForm_Shipment.clearValues();
Window_Shipment.animateShow();
}
});
var ToolStripButton_Shipment_Edit = isc.ToolStripButton.create({
icon: "[SKIN]/actions/edit.png",
title: "<spring:message code='global.form.edit'/>",
click: function(){
ListGrid_Shipment_edit();
}
});
var ToolStripButton_Shipment_Remove = isc.ToolStripButton.create({
icon: "[SKIN]/actions/remove.png",
title: "<spring:message code='global.form.remove'/>",
click:function(){
ListGrid_Shipment_remove();
}
});
var ToolStrip_Actions_Shipment = isc.ToolStrip.create({
width: "100%",
members: [
ToolStripButton_Shipment_Refresh,
ToolStripButton_Shipment_Add,
ToolStripButton_Shipment_Edit,
ToolStripButton_Shipment_Remove
]
});

var HLayout_Actions_Shipment = isc.HLayout.create({
width: "100%",
members: [
ToolStrip_Actions_Shipment
]
});

var ListGrid_Shipment = isc.ListGrid.create({
width: "100%",
height: "100%",
dataSource: RestDataSource_Shipment,
contextMenu: Menu_ListGrid_Shipment,
fields:[
{name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},
{name: "contractShipmentId", hidden: true, type:'long' },
{name: "contactId", type:'long', hidden: true },
{name: "contract.contact.nameFA", title:"<spring:message
		code='contact.name'/>", type:'text' , width: "20%" , align: "center",showHover:true},
{name: "contractId", type:'long', hidden: true },
{name: "contract.contractNo", title:"<spring:message
		code='contract.contractNo'/>", type:'text' , width: "10%",showHover:true},
{name: "contract.contractDate", title:"<spring:message
		code='contract.contractDate'/>", type:'text' , width: "10%",showHover:true},
{name: "materialId", title:"<spring:message code='contact.name'/>", type:'long', hidden: true ,showHover:true},
{name: "material.descl", title:"<spring:message
		code='material.descl'/>", type:'text' , width: "10%" , align: "center",showHover:true},
{name: "material.unit.nameEN", title:"<spring:message
		code='unit.nameEN'/>", type:'text' , width: "10%" , align: "center",showHover:true},
{name: "amount", title:"<spring:message
		code='global.amount'/>", type:'float', width: "10%" , align: "center",showHover:true},
{name: "shipmentType", title:"<spring:message
		code='shipment.shipmentType'/>", type:'text', width: "10%" ,showHover:true},
{name: "loadingLetter", title:"<spring:message
		code='shipment.loadingLetter'/>", type:'text', width: "10%" ,showHover:true},
{name: "noContainer", title:"<spring:message
		code='shipment.noContainer'/>", type:'integer', width: "10%" , align: "center",showHover:true},
<%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
{name: "portByLoading.port", title:"<spring:message
		code='shipment.loading'/>", type:'text', required: true, width: "10%" ,showHover:true},
{name: "portByDischarge.port", title:"<spring:message
		code='shipment.discharge'/>", type:'text', required: true, width: "10%" ,showHover:true},
// {name: "dischargeAddress", title:"<spring:message
		code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
{name: "description", title:"<spring:message
		code='shipment.description'/>", type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
{name: "contractShipment.sendDate", title:"<spring:message
		code='global.sendDate'/>",type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
{name: "createDate", title:"<spring:message
		code='global.createDate'/>",type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
{name: "month", title:"<spring:message
		code='shipment.month'/>", type:'text', required: true, width: "10%" , align: "center" ,showHover:true},
{name: "contactByAgent.nameFA", title:"<spring:message
		code='shipment.agent'/>", type:'text' , width: "20%" , align: "center",showHover:true},
{name: "vesselName", title:"<spring:message
		code='shipment.vesselName'/>", type:'text', required: true, width: "10%" ,showHover:true},
{name: "swb", title:"<spring:message code='shipment.SWB'/>", type:'text', required: true, width: "10%" ,showHover:true},
{name: "switchPort.port", title:"<spring:message
		code='port.switchPort'/>", type:'text', required: true, width: "10%" ,showHover:true},
{name: "status", title:"<spring:message
		code='shipment.staus'/>", type:'text', width: "10%" , align: "center", valueMap:{"Load Ready":"<spring:message
		code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"},showHover:true},

],
recordClick : "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
updateDetails : function (viewer, record1, recordNum, field, fieldNum, value, rawValue)
{
var record = this.getSelectedRecord();
var criteria1={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"shipmentId",operator:"equals",value:record.id}]};
ListGrid_Invoice.fetchData(criteria1,function (dsResponse, data, dsRequest) {
ListGrid_Invoice.setData(data); });
},
dataArrived : function (startRow, endRow) {
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
var HLayout_Grid_Shipment = isc.HLayout.create({
width: "100%",
height: "100%",
members: [
ListGrid_Shipment
]
});

var VLayout_Body_Shipment = isc.VLayout.create({
width: "100%",
height: "100%",
members: [
HLayout_Actions_Shipment, HLayout_Grid_Shipment
]
});
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


var RestDataSource_Invoice = isc.MyRestDataSource.create({
fields:
[
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "shipmentId", title: "id", canEdit: false, hidden: true},
],

fetchDataURL: "http://localhost:9099/api/invoice/spec-list"
});

function ListGrid_Invoice_refresh() {
ListGrid_Invoice.invalidateCache();
var record = ListGrid_Shipment.getSelectedRecord();
if (record==null || record.id==null)
return;
var criteria1={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"shipmentId",operator:"equals",value:record.id}]};
ListGrid_Invoice.fetchData(criteria1,function (dsResponse, data, dsRequest) {
ListGrid_Invoice.setData(data);
},{operationId:"00"});
}

function ListGrid_Invoice_edit() {
var record = ListGrid_Invoice.getSelectedRecord();

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
DynamicForm_Invoice.setValue("invoiceDateDumy",new Date(record.invoiceDate));
DynamicForm_Invoice.editRecord(record);
if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Copper Concentrate') {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").show();
DynamicForm_Invoice.getItem("gold").show();
DynamicForm_Invoice.getItem("silverUnitPrice").show();
DynamicForm_Invoice.getItem("silver").show();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
} else if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
DynamicForm_Invoice.getItem("copperUnitPrice").hide();
DynamicForm_Invoice.getItem("copper").hide();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
DynamicForm_Invoice.getItem("molybdenum").show();
} else {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
}
Window_Invoice.show();
}
}

function ListGrid_Invoice_remove() {

var record = ListGrid_Invoice.getSelectedRecord();

if (record == null || record.id == null) {
isc.Dialog.create({
message: "<spring:message code='global.grid.record.not.selected'/> !",
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
var InvoiceId = record.id;
isc.RPCManager.sendRequest({
actionURL: "http://localhost:9099/api/invoice/" + record.id,
httpMethod: "DELETE",
useSimpleHttp: true,
contentType: "application/json; charset=utf-8",
httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
showPrompt: true,
serverOutputAsString: false,
callback: function (resp) {
if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
ListGrid_Invoice_refresh();
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
var Menu_ListGrid_Invoice = isc.Menu.create({
width: 150,
data: [
{
title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
click: function () {
}
},
{
title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
click: function () {
DynamicForm_Invoice.clearValues();
if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Copper Concentrate') {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").show();
DynamicForm_Invoice.getItem("gold").show();
DynamicForm_Invoice.getItem("silverUnitPrice").show();
DynamicForm_Invoice.getItem("silver").show();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
} else if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
DynamicForm_Invoice.getItem("copperUnitPrice").hide();
DynamicForm_Invoice.getItem("copper").hide();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
DynamicForm_Invoice.getItem("molybdenum").show();
} else {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
}
Window_Invoice.show();
}
},
{
title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
click: function () {
if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Copper Concentrate') {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").show();
DynamicForm_Invoice.getItem("gold").show();
DynamicForm_Invoice.getItem("silverUnitPrice").show();
DynamicForm_Invoice.getItem("silver").show();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
} else if (ListGrid_Shipment.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
DynamicForm_Invoice.getItem("copperUnitPrice").hide();
DynamicForm_Invoice.getItem("copper").hide();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
DynamicForm_Invoice.getItem("molybdenum").show();
} else {
DynamicForm_Invoice.getItem("copperUnitPrice").show();
DynamicForm_Invoice.getItem("copper").show();
DynamicForm_Invoice.getItem("goldUnitPrice").hide();
DynamicForm_Invoice.getItem("gold").hide();
DynamicForm_Invoice.getItem("silverUnitPrice").hide();
DynamicForm_Invoice.getItem("silver").hide();
DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
DynamicForm_Invoice.getItem("molybdenum").hide();
}
ListGrid_Invoice_edit();
}
},
{
title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
click: function () {
ListGrid_Invoice_remove();
}
}
]
});

var DynamicForm_Invoice = isc.DynamicForm.create({
width: "100%",
height: "100%",
setMethod: 'POST',
align: "center",
canSubmit: true,
showInlineErrors: true,
showErrorText: true,
showErrorStyle: true,
errorOrientation: "right",
titleWidth: "100",margin: '10px',
titleAlign: "right",
requiredMessage: "<spring:message code='validator.field.is.required'/>.",
numCols: 4 , backgroundImage:"backgrounds/leaves.jpg",
fields:
[
{name: "id", hidden: true,},
{name: "shipmentId", hidden: true,},
{type: "Header",defaultValue:" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"},
{name: "invoiceType", title:"<spring:message
		code='invoice.invoiceType'/>", type:'text', width: "100%" , required: true ,valueMap:{"PROVISIONAL":"PROVISIONAL", "FINAL":"FINAL","PREPAID":"PREPAID"}},
{name: "paidStatus", title:"<spring:message
		code='invoice.paidStatus'/>", type:'text', width: "100%" ,defaultValue:"UNPAID" ,valueMap:{"PAID":"PAID", "UNPAID":"UNPAID"}},
{type: "Header",defaultValue:" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"},
{ name: "invoiceNo",title: "<spring:message
		code='invoice.invoiceNo'/>", required: true, width: "100%",colSpan: 1,titleColSpan: 1},
{name: "invoiceDateDumy", title:"<spring:message
		code='invoice.invoiceDate'/>",defaultValue:"<%=dateUtil.todayDate()%>" , type:'date',format:'DD-MM-YYYY HH:mm:ss', required: true, width: "100%" },
{type: "Header",defaultValue:" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"},
{name: "grass", title:"<spring:message code='global.grass'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "net", title:"<spring:message code='global.net'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "unitPrice", title:"<spring:message code='global.unitPrice'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "unitPriceCurrency", title:"<spring:message
		code='invoice.unitPriceCurrency'/>", type:'text', width: "100%" ,defaultValue:"DOLLAR" ,valueMap:{"EURO":"EURO", "DOLLAR":"DOLLAR"}},
{name: "paidPercent", title:"<spring:message
		code='invoice.paidPercent'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "Depreciation", title:"<spring:message
		code='invoice.Depreciation'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "otherCost", title:"<spring:message code='invoice.otherCost'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "beforePaid", title:"<spring:message code='invoice.beforePaid'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "invoiceValue", title:"<spring:message
		code='invoice.invoiceValue'/>", type:'float', required: true, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "invoiceValueCur", title:"<spring:message
		code='invoice.invoiceValueCur'/>", type:'text', width: "100%" ,defaultValue:"DOLLAR" ,valueMap:{"EURO":"EURO", "DOLLAR":"DOLLAR"}},
{type: "Header",defaultValue:" - - - - - - - - - - - - - - - - - - - - - - - - - - - محتوی - - - - - - - - - - - - - - - - - - - - - - - -"},
{name: "copperUnitPrice", title:"<spring:message
		code='invoice.copperUnitPrice'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "copper", title:"<spring:message code='invoice.copper'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "goldUnitPrice", title:"<spring:message
		code='invoice.goldUnitPrice'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "gold", title:"<spring:message code='invoice.gold'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "silverUnitPrice", title:"<spring:message
		code='invoice.silverUnitPrice'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "silver", title:"<spring:message code='invoice.silver'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "molybdJenumUnitPrice", title:"<spring:message
		code='invoice.molybdJenumUnitPrice'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},
{name: "molybdenum", title:"<spring:message code='invoice.molybdenum'/>", type:'float', required: false, width: "100%" ,
validators : [{type: "isFloat", validateOnExit : true, stopOnError : true, errorMessage: "لطفا مقدار عددی وارد نمائید."}]},

]
});

var ToolStripButton_Invoice_Refresh = isc.ToolStripButton.create({
icon: "[SKIN]/actions/refresh.png",
title: "<spring:message code='global.form.refresh'/>",
click: function () {
ListGrid_Invoice_refresh();
}
});

var ToolStripButton_Invoice_Add = isc.ToolStripButton.create({
icon: "[SKIN]/actions/add.png",
title: "<spring:message code='global.form.new'/>",
click: function () {
var record = ListGrid_Shipment.getSelectedRecord();

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
} else {
DynamicForm_Invoice.clearValues();
DynamicForm_Invoice.setValue("shipmentId",record.id);
Window_Invoice.show();
}
}
});

var ToolStripButton_Invoice_Edit = isc.ToolStripButton.create({
icon: "[SKIN]/actions/edit.png",
title: "<spring:message code='global.form.edit'/>",
click: function () {
ListGrid_Invoice_edit();
}
});

var ToolStripButton_Invoice_Remove = isc.ToolStripButton.create({
icon: "[SKIN]/actions/remove.png",
title: "<spring:message code='global.form.remove'/>",
click: function () {
ListGrid_Invoice_remove();
}
});

var ToolStrip_Actions_Invoice = isc.ToolStrip.create({
width: "100%",
members:
[
ToolStripButton_Invoice_Refresh,
ToolStripButton_Invoice_Add,
ToolStripButton_Invoice_Edit,
ToolStripButton_Invoice_Remove
]
});

var HLayout_Invoice_Actions = isc.HLayout.create({
width: "100%",
members:
[
ToolStrip_Actions_Invoice
]
});

var IButton_Invoice_Save = isc.IButton.create({
top: 260,
title: "<spring:message code='global.form.save'/>",
icon: "pieces/16/save.png",
click: function () {
/*ValuesManager_GoodsUnit.validate();*/
DynamicForm_Invoice.validate();
if (DynamicForm_Invoice.hasErrors())
return;
var drs = DynamicForm_Invoice.getValue("invoiceDateDumy");
var datestringRs =(drs.getFullYear()+"/"+ ("0"+(drs.getMonth()+1)).slice(-2) + "/" +("0" + drs.getDate()).slice(-2));
DynamicForm_Invoice.setValue("invoiceDate",datestringRs);
DynamicForm_Invoice.setValue("shipmentId",ListGrid_Shipment.getSelectedRecord().id);

var data = DynamicForm_Invoice.getValues();
var method="PUT";
if (data.id==null)
method="POST";
isc.RPCManager.sendRequest({
actionURL: "http://localhost:9099/api/invoice/" ,
httpMethod: method,
useSimpleHttp: true,
contentType: "application/json; charset=utf-8",
httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
showPrompt: true,
serverOutputAsString: false,
data: JSON.stringify(data),
//params: { data:data1},
callback: function (resp) {

if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201){
isc.say("<spring:message code='global.form.request.successful'/>.");
ListGrid_Invoice_refresh();
Window_Invoice.close();
} else
isc.say(RpcResponse_o.data);
}
});
}
});
var Window_Invoice = isc.Window.create({
title: "<spring:message code='issuedInvoices.title'/> ",
width: 580,
hight: 500,
margin: '10px',
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
DynamicForm_Invoice,
isc.HLayout.create({
width: "100%",
members:
[
IButton_Invoice_Save,
isc.Label.create({
width: 5,
}),
isc.IButton.create({
ID: "invoiceEditExitIButton",
title: "<spring:message code='global.cancel'/>",
width: 100,
icon: "pieces/16/icon_delete.png",
orientation: "vertical",
click: function () {
Window_Invoice.close();
}
})
]
})
]
});
var ListGrid_Invoice = isc.ListGrid.create({
width: "100%",
height: "100%",
dataSource: RestDataSource_Invoice,
contextMenu: Menu_ListGrid_Invoice,
fields:
[
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "invoiceNo",title: "<spring:message code='invoice.invoiceNo'/>", width: "10%"},
{name: "invoiceDate", title:"<spring:message code='invoice.invoiceDate'/>" , type:'text', width: "10%" },
{name: "invoiceType", title:"<spring:message code='invoice.invoiceType'/>", type:'text', width: "10%" },
{name: "net", title:"<spring:message code='global.net'/>", type:'float', width: "10%" },
{name: "grass", title:"<spring:message code='global.grass'/>", type:'float', width: "10%" },
{name: "unitPrice", title:"<spring:message code='global.unitPrice'/>", type:'float', width: "10%"},
{name: "unitPriceCurrency", title:"<spring:message code='invoice.unitPriceCurrency'/>", type:'text', width: "10%" },
{name: "invoiceValue", title:"<spring:message code='invoice.invoiceValue'/>", type:'float', width: "10%"},
{name: "invoiceValueCur", title:"<spring:message code='invoice.invoiceValueCur'/>", type:'text', width: "10%" },
{name: "paidPercent", title:"<spring:message code='invoice.paidPercent'/>", type:'float', width: "10%" },
{name: "paidStatus", title:"<spring:message code='invoice.paidStatus'/>", type:'text', width: "10%" },
{name: "Depreciation", title:"<spring:message code='invoice.Depreciation'/>", type:'float', width: "10%" },
{name: "otherCost", title:"<spring:message code='invoice.otherCost'/>", type:'float', width: "10%" },
{name: "copperUnitPrice", title:"<spring:message code='invoice.copperUnitPrice'/>", type:'float', width: "10%" },
{name: "copper", title:"<spring:message code='invoice.copper'/>", type:'float', width: "10%" },
{name: "goldUnitPrice", title:"<spring:message code='invoice.goldUnitPrice'/>", type:'float', width: "10%"},
{name: "gold", title:"<spring:message code='invoice.gold'/>", type:'float', width: "10%"},
{name: "silverUnitPrice", title:"<spring:message code='invoice.silverUnitPrice'/>", type:'float', width: "10%"},
{name: "silver", title:"<spring:message code='invoice.silver'/>", type:'float', width: "10%"},
{name: "molybdJenumUnitPrice", title:"<spring:message
		code='invoice.molybdJenumUnitPrice'/>", type:'float', width: "10%" },
{name: "molybdenum", title:"<spring:message code='invoice.molybdenum'/>", type:'float', width: "10%"},
],
sortField: 0,
dataPageSize: 50,
autoFetchData: false,
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
startsWithTitle: "tt",
recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
},
dataArrived: function (startRow, endRow) {
}

});
var HLayout_Invoice_Grid = isc.HLayout.create({
width: "100%",
height: "100%",
members: [
ListGrid_Invoice
]
});

var VLayout_Invoice_Body = isc.VLayout.create({
width: "100%",
height: "100%",
members: [
HLayout_Invoice_Actions, HLayout_Invoice_Grid
]
});

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


isc.SectionStack.create({
ID:"Shipment_Section_Stack",
sections:
[
{title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_Shipment ,expanded:true}
,{title:"<spring:message code='issuedInvoices.title'/>", items:VLayout_Invoice_Body ,expanded:true}
],
visibilityMode:"multiple",
animateSections:true,
height:"100%",
width:"100%",
overflow:"hidden"
});
