<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

var ViewLoader_createTozinSales = isc.ViewLoader.create({
width: "100%",
height: "100%",
autoDraw: false,
loadingMessage: " در حال بارگذاری ..."
});
var Window_TozinSales_ViewLoader = isc.Window.create({
title: "<spring:message code='dailyReport.DailyReportBandarAbbas'/> ",
width: "1560",
height: "95%",
autoCenter: true,
align: "center",
autoDraw: false,
dismissOnEscape: true,
closeClick: function () {
this.Super("closeClick", arguments)
},
items:
[
ViewLoader_createTozinSales
]
});

function ListGrid_TozinSales_refresh() {
ListGrid_TozinSales.invalidateCache();
}

var RestDataSource_TozinSales = isc.MyRestDataSource.create({
fields:
[
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
{name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
{name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
{name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
{name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
{name: "customer", title: "<spring:message code='Tozin.customer'/>", align: "center"},
{name: "seller", title: "<spring:message code='Tozin.seller'/>", align: "center"},
{name: "vazn1", title: "<spring:message code='Tozin.vazn1'/>", align: "center"},
{name: "vazn2", title: "<spring:message code='Tozin.vazn2'/>", align: "center"},
{name: "condition", title: "<spring:message code='Tozin.condition'/>", align: "center"},
{name: "vazn", title: "<spring:message code='Tozin.vazn'/>", align: "center"},
{name: "tedad", title: "<spring:message code='Tozin.tedad'/>", align: "center"},
{name: "unitKala", title: "<spring:message code='Tozin.unitKala'/>", align: "center"},
{name: "packName", title: "<spring:message code='Tozin.packName'/>", align: "center"},
{name: "haveCode", title: "<spring:message code='Tozin.haveCode'/>", align: "center"},
{name: "date", title: "<spring:message code='Tozin.date'/>", align: "center"},
{name: "tozinId", title: "<spring:message code='Tozin.tozinId'/>", align: "center"},
{name: "tozinDate", title: "<spring:message code='Tozin.tozinDate'/>", align: "center"},
{name: "tozinTime", title: "<spring:message code='Tozin.tozinTime'/>", align: "center"},
{name: "codeKala", title: "<spring:message code='Tozin.codeKala'/>", align: "center"},
{name: "nameKala", title: "<spring:message code='Tozin.nameKala'/>", align: "center"},
{name: "sourceId", title: "<spring:message code='Tozin.sourceId'/>", align: "center"},
{name: "source", title: "<spring:message code='Tozin.source'/>", align: "center"},
{name: "targetId", title: "<spring:message code='Tozin.targetId'/>", align: "center"},
{name: "target", title: "<spring:message code='Tozin.target'/>", align: "center"},
{name: "havalehName", title: "<spring:message code='Tozin.havalehName'/>", align: "center"},
{name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
{name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},
{name: "targetPlantId"},
{name: "sourcePlantId"},
],
// ######@@@@###&&@@###
fetchDataURL: "http://localhost:9099/api/tozinSales/spec-list"
});


var fltTozinSales = isc.FilterBuilder.create({dataSource: RestDataSource_TozinSales});
var HLayout_TozinSales_labels = isc.HLayout.create({
width: "100%",
layoutMargin: 5,
height: 22,
showEdges: false,
members: [
isc.Label.create({width: 10}),
isc.IButton.create({
width: 50,
height: 22,
title: "",
prompt: "جستحو",
icon: "search.png",
click: function () {
ListGrid_TozinSales.fetchData(fltTozinSales.getCriteria());
}
}),
isc.Label.create({width: "100%"}),
isc.Label.create({
contents: "رکورد",
align: "center",
width: 50,
height: 22
}),
isc.Label.create({
ID: "TozinSales_labels_NavigationAz",
contents: "0",
border: "1px blue solid",
align: "center",
width: 40,
height: 22
}),
isc.Label.create({
contents: "از",
align: "center",
width: 50,
height: 22
}),

isc.Label.create({
ID: "TozinSales_labels_NavigationTa",
border: "1px blue solid",
align: "center",
contents: "0",
width: 40,
height: 22
})
]
});


var DynamicForm_DailyReport_TozinSales = isc.DynamicForm.create({
width: "300",
wrapItemTitles: false,
height: "100%",
setMethod: 'POST',
align: "center",
action: "report/printDailyReportBandarAbbas",
target: "_Blank",
canSubmit: true,
showInlineErrors: true,
showErrorText: true,
showErrorStyle: true,
errorOrientation: "right",
titleWidth: "200",
titleAlign: "right",
requiredMessage: "<spring:message code='validator.field.is.required'/>.",
numCols: 4,
fields:
[
{
name: "toDay",
ID: "toDayDate",
title: "<spring:message code='dailyWarehouse.toDay'/>",
type: 'text',
align: "center",
width: 150,
colSpan: 1,
titleColSpan: 1
,
icons: [{
src: "pieces/pcal.png", click: function () {
displayDatePicker('toDayDate', this, 'ymd', '/');
}
}],
defaultValue: "1398/01/26",
},
]
});

var Menu_ListGrid_TozinSales = isc.Menu.create({
width: 150,
data: [
{
title: "بین مجامع", icon: "pieces/16/refresh.png",
click: function () {
var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
ViewLoader_createTozinSales.setViewURL("<spring:url value="tozinSales/showTransport2Plants"/>" + "/" + toDay);
Window_TozinSales_ViewLoader.show();
}
},
{
title: "مبدا/مقصد سرجشمه", icon: "pieces/16/search.png",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "1"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
},
{
title: "مبدا/مقصد ميدوک", icon: "pieces/16/search.png",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "2"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
},
{
title: "مبدا/مقصد بندرعباس", icon: "pieces/16/search.png",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "3"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
},
{
title: "مبدا/مقصد خاتون آباد", icon: "pieces/16/search.png",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "4"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
},
{
title: "مبدا/مقصد سونگون", icon: "pieces/16/search.png",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "5"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
},
{
title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
click: function () {
}
},
{
title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
click: function () {
ListGrid_TozinSales_edit();
}
},
{
title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
click: function () {
ListGrid_TozinSales_remove();
}
},
{isSeparator: true},
{
title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
click: function () {
window.open("/tozinSales/print/pdf");
}
},
{
title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
click: function () {
window.open("/tozinSales/print/excel");
}
},
{
title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
click: function () {
window.open("/tozinSales/print/html");
}
}
]
});

var MenuButton_TozinSales = isc.MenuButton.create({
ID: "MenuButton_TozinSales",
autoDraw: false,
title: "گزارش",
width: 100,
menu: Menu_ListGrid_TozinSales
});

function ListGrid_TozinSales_edit() {

var record = ListGrid_TozinSales.getSelectedRecord();

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
DynamicForm_TozinSales.editRecord(record);
Window_TozinSales.show();
}
}

function ListGrid_TozinSales_remove() {

var record = ListGrid_TozinSales.getSelectedRecord();

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
buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({title: "<spring:message
		code='global.no'/>"})],
buttonClick: function (button, index) {
this.hide();
if (index == 0) {
var TozinSalesId = record.id;
// ######@@@@###&&@@###
var methodXXXX = "PUT";
if (data.id == null) methodXXXX = "POST";
isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/tozinSales/" + TozinSalesId,
httpMethod: "DELETE",
callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
ListGrid_TozinSales_refresh();
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

var DynamicForm_TozinSales = isc.DynamicForm.create({
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
requiredMessage: "<spring:message code='validator.field.is.required'/>.",
numCols: 1,
fields:
[

{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
{name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
{name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
{name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
{name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
{name: "customer", title: "<spring:message code='Tozin.customer'/>", align: "center"},
{name: "seller", title: "<spring:message code='Tozin.seller'/>", align: "center"},
{name: "vazn1", title: "<spring:message code='Tozin.vazn1'/>", align: "center"},
{name: "vazn2", title: "<spring:message code='Tozin.vazn2'/>", align: "center"},
{name: "condition", title: "<spring:message code='Tozin.condition'/>", align: "center"},
{name: "vazn", title: "<spring:message code='Tozin.vazn'/>", align: "center"},
{name: "tedad", title: "<spring:message code='Tozin.tedad'/>", align: "center"},
{name: "unitKala", title: "<spring:message code='Tozin.unitKala'/>", align: "center"},
{name: "packName", title: "<spring:message code='Tozin.packName'/>", align: "center"},
{name: "haveCode", title: "<spring:message code='Tozin.haveCode'/>", align: "center"},
{name: "date", title: "<spring:message code='Tozin.date'/>", align: "center"},
{name: "tozinId", title: "<spring:message code='Tozin.tozinId'/>", align: "center"},
{name: "tozinDate", title: "<spring:message code='Tozin.tozinDate'/>", align: "center"},
{name: "tozinTime", title: "<spring:message code='Tozin.tozinTime'/>", align: "center"},
{name: "codeKala", title: "<spring:message code='Tozin.codeKala'/>", align: "center"},
{name: "nameKala", title: "<spring:message code='Tozin.nameKala'/>", align: "center"},
{name: "sourceId", title: "<spring:message code='Tozin.sourceId'/>", align: "center"},
{name: "source", title: "<spring:message code='Tozin.source'/>", align: "center"},
{name: "targetId", title: "<spring:message code='Tozin.targetId'/>", align: "center"},
{name: "target", title: "<spring:message code='Tozin.target'/>", align: "center"},
{name: "havalehName", title: "<spring:message code='Tozin.havalehName'/>", align: "center"},
{name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
{name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},

]
});

var ToolStripButton_TozinSales_Refresh = isc.ToolStripButton.create({
icon: "[SKIN]/actions/refresh.png",
title: "<spring:message code='global.form.refresh'/>",
click: function () {
ListGrid_TozinSales_refresh();
}
});

var ToolStripButton_TozinSales_Add = isc.ToolStripButton.create({
icon: "[SKIN]/actions/add.png",
title: "<spring:message code='global.form.new'/>",
click: function () {
DynamicForm_TozinSales.clearValues();
Window_TozinSales.show();
}
});

var ToolStripButton_TozinSales_Edit = isc.ToolStripButton.create({
icon: "[SKIN]/actions/edit.png",
title: "<spring:message code='global.form.edit'/>",
click: function () {
ListGrid_TozinSales_edit();
}
});

var ToolStripButton_TozinSales_Remove = isc.ToolStripButton.create({
icon: "[SKIN]/actions/remove.png",
title: "<spring:message code='global.form.remove'/>",
click: function () {
// ListGrid_TozinSales_remove();
}
});
var ToolStripButton_TozinSales_Sarcheshmeh = isc.ToolStripButton.create({
icon: "pieces/16/search.png",
title: "مبدا/مقصد سرجشمه",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "1"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
});

var ToolStripButton_TozinSales_Miduk = isc.ToolStripButton.create({
icon: "pieces/16/search.png",
title: "مبدا/مقصد ميدوک",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "2"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
});

var ToolStripButton_TozinSales_Bandar = isc.ToolStripButton.create({
icon: "pieces/16/search.png",
title: "مبدا/مقصد بندرعباس",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "3"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
});

var ToolStripButton_TozinSales_Khaton = isc.ToolStripButton.create({
icon: "pieces/16/search.png",
title: "مبدا/مقصد خاتون آباد",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "4"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
});

var ToolStripButton_TozinSales_sungun = isc.ToolStripButton.create({
icon: "pieces/16/search.png",
title: "مبدا/مقصد سونگون",
click: function () {
var criteria = {
_constructor: "AdvancedCriteria",
operator: "and",
criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "5"}]
};
ListGrid_TozinSales.fetchData(criteria, function (dsResponse, data, dsRequest) {
ListGrid_TozinSales.setData(data);
});
}
});

var ToolStripButton_TozinSales_sum2 = isc.ToolStripButton.create({
icon: "product/sum.png",
title: "<spring:message code='Tozin.sum2'/>",
click: function () {
var sum = 0;
var selectedAtFirst = ListGrid_TozinSales.getSelection().length;
if (selectedAtFirst == 0) {
ListGrid_TozinSales.selectAllRecords();
}
var record = ListGrid_TozinSales.getSelection();
for (var i = 0; i < record.length; i++) {
var str = record.get(i).condition;
if (str.startsWith("2")) {
sum += record.get(i).vazn;
}
}
if (selectedAtFirst == 0) {
ListGrid_TozinSales.deselectAllRecords();
}

alert(sum);
}
});
var ToolStripButton_TozinSales_sum1 = isc.ToolStripButton.create({
icon: "product/sum.png",
title: "<spring:message code='Tozin.sum1'/>",
click: function () {
var sum = 0;
var selectedAtFirst = ListGrid_TozinSales.getSelection().length;
if (selectedAtFirst == 0) {
ListGrid_TozinSales.selectAllRecords();
}
var record = ListGrid_TozinSales.getSelection();
for (var i = 0; i < record.length; i++) {
var str = record.get(i).condition;
if (str.startsWith("1")) {
sum += record.get(i).vazn;
}
}
if (selectedAtFirst == 0) {
ListGrid_TozinSales.deselectAllRecords();
}

alert(sum);
}
});

var ToolStripButton_TozinSales_Print = isc.ToolStripButton.create({
icon: "[SKIN]/RichTextEditor/print.png",
title: "<spring:message code='global.form.print'/>",
click: function () {
// window.open( "/tozinSales/print/pdf");
}
});

var ToolStrip_Actions_TozinSales = isc.ToolStrip.create({
width: "100%",
members:
[
DynamicForm_DailyReport_TozinSales, MenuButton_TozinSales,
ToolStripButton_TozinSales_Refresh,
ToolStripButton_TozinSales_Add,
ToolStripButton_TozinSales_Edit,
ToolStripButton_TozinSales_Remove,
ToolStripButton_TozinSales_Print,
ToolStripButton_TozinSales_Sarcheshmeh,
ToolStripButton_TozinSales_Miduk,
ToolStripButton_TozinSales_Bandar,
ToolStripButton_TozinSales_Khaton,
ToolStripButton_TozinSales_sungun,
ToolStripButton_TozinSales_sum1,
ToolStripButton_TozinSales_sum2
]
});

var HLayout_TozinSales_Actions = isc.HLayout.create({
width: "100%",
members:
[
ToolStrip_Actions_TozinSales
]
});

var IButton_TozinSales_Save = isc.IButton.create({
top: 260,
title: "<spring:message code='global.form.save'/>",
icon: "pieces/16/save.png",
click: function () {
/*ValuesManager_GoodsUnit.validate();*/
DynamicForm_TozinSales.validate();
if (DynamicForm_TozinSales.hasErrors())
return;

var data = DynamicForm_TozinSales.getValues();
// ######@@@@###&&@@###
var methodXXXX = "PUT";
if (data.id == null) methodXXXX = "POST";
isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/tozinSales/",
httpMethod: methodXXXX,
data: JSON.stringify(data),
callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
isc.say("<spring:message code='global.form.request.successful'/>.");
ListGrid_TozinSales_refresh();
Window_TozinSales.close();
} else
isc.say(RpcResponse_o.data);
}
})
);
}
});
var IButton_TozinSales_Cancel = isc.IButton.create({
top: 260,
title: "<spring:message code='global.cancel'/>",
icon: "pieces/16/icon_delete.png",
click: function () {
Window_TozinSales.close();
}
});
var Window_TozinSales = isc.Window.create({
title: "<spring:message code='warehouses.title'/> ",
width: 580,
hight: 500,
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
DynamicForm_TozinSales,
isc.HLayout.create({
width: "100%",
members:
[

IButton_TozinSales_Save,
isc.Label.create({width: 5,})
, IButton_TozinSales_Cancel
]
})

]
});
var ListGrid_TozinSales = isc.ListGrid.create({
width: "100%",
height: "100%",
dataSource: RestDataSource_TozinSales,
contextMenu: Menu_ListGrid_TozinSales,
fields:
[
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
// {name:"carNo1", title:"<spring:message code='Tozin.carNo1'/>",align:"center",showHover:true,width:"1%"},
// {name:"carNo3", title:"<spring:message code='Tozin.carNo3'/>",align:"center",showHover:true,width:"1%"},
{
name: "plak",
title: "<spring:message code='Tozin.plak'/>",
align: "center",
showHover: true,
canEdit: true,
width: "15%"
},
{
name: "carName",
title: "<spring:message code='Tozin.carName'/>",
align: "center",
showHover: true,
width: "25%"
},
{
name: "seller",
title: "<spring:message code='Tozin.seller'/>",
align: "center",
showHover: true,
width: "15%"
},
{
name: "customer",
title: "<spring:message code='Tozin.customer'/>",
align: "center",
showHover: true,
width: "15%"
},
// {name:"vazn1", title:"<spring:message code='Tozin.vazn1'/>",align:"center",showHover:true,width:"1%"},
// {name:"vazn2", title:"<spring:message code='Tozin.vazn2'/>",align:"center",showHover:true,width:"1%"},
{
name: "condition",
title: "<spring:message code='Tozin.condition'/>",
align: "center",
showHover: true,
width: "15%"
},
{
name: "vazn",
title: "<spring:message code='Tozin.vazn'/>",
align: "center",
showHover: true,
width: "15%"
},
{
name: "tedad",
title: "<spring:message code='Tozin.tedad'/>",
align: "center",
showHover: true,
width: "15%"
},
// {name:"unitKala", title:"<spring:message code='Tozin.unitKala'/>",align:"center",showHover:true,width:"1%"},
// {name:"date", title:"<spring:message code='Tozin.date'/>",align:"center",showHover:true,width:"1%"},
{
name: "tozinId",
title: "<spring:message code='Tozin.tozinId'/>",
align: "center",
showHover: true,
width: "15%"
},
{
name: "tozinDate",
title: "<spring:message code='Tozin.tozinDate'/>",
align: "center",
showHover: true,
width: "15%"
},
// {name:"codeKala", title:"<spring:message code='Tozin.codeKala'/>",align:"center",showHover:true,width:"15%"},
{
name: "nameKala",
title: "<spring:message code='Tozin.nameKala'/>",
align: "center",
showHover: true,
width: "25%"
},
// {name:"sourceId", title:"<spring:message code='Tozin.sourceId'/>",align:"center",showHover:true,width:"1%"},
{
name: "source",
title: "<spring:message code='Tozin.source'/>",
align: "center",
showHover: true,
width: "15%"
},
// {name:"targetId", title:"<spring:message code='Tozin.targetId'/>",align:"center",showHover:true,width:"1%"},
{
name: "target",
title: "<spring:message code='Tozin.target'/>",
align: "center",
showHover: true,
width: "15%"
},
{
name: "haveCode",
title: "<spring:message code='Tozin.haveCode'/>",
align: "center",
showHover: true,
canEdit: true,
width: "5%"
},
{
name: "havalehName",
title: "<spring:message code='Tozin.havalehName'/>",
align: "center",
showHover: true,
width: "5%"
},
{
name: "tozinPlantId",
title: "<spring:message code='Tozin.tozinPlantId'/>",
align: "center",
showHover: true,
width: "1%"
},
// {name:"isFinal", title:"<spring:message code='Tozin.isFinal'/>",align:"center",showHover:true,width:"1%"},
{
name: "cardId",
title: "<spring:message code='Tozin.cardId'/>",
align: "center",
showHover: true,
width: "1%"
},
{
name: "packName",
title: "<spring:message code='Tozin.packName'/>",
align: "center",
showHover: true,
width: "1%"
},
{
name: "tozinTime",
title: "<spring:message code='Tozin.tozinTime'/>",
align: "center",
showHover: true,
width: "1%"
},
{
name: "havalehDate",
title: "<spring:message code='Tozin.havalehDate'/>",
align: "center",
showHover: true,
width: "1%"
},
{name: "targetPlantId", showHover: true, width: "1%"},
{name: "sourcePlantId", showHover: true, width: "1%"},
],

allowAdvancedCriteria: true,
allowFilterExpressions: true,
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
startsWithTitle: "tt",
recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
TozinSales_labels_NavigationAz.setContents(this.getFocusRow() + 1);
},
dataArrived: function (startRow, endRow) {
TozinSales_labels_NavigationTa.setContents(ListGrid_TozinSales.getData().getLength());
if (ListGrid_TozinSales.getRecord(0) != null) {
TozinSales_labels_NavigationAz.setContents(startRow + 1);
} else
TozinSales_labels_NavigationAz.setContents("0");
}

});

var VLayout_fltTozinSales = isc.VLayout.create({members: [fltTozinSales]});


var VLayout_TozinSales_Grid = isc.VLayout.create({
width: "100%",
height: "100%",
members: [
VLayout_fltTozinSales,
HLayout_TozinSales_labels,
ListGrid_TozinSales
]
});
var VLayout_TozinSales_Body = isc.VLayout.create({
width: "100%",
height: "100%",
members: [
HLayout_TozinSales_Actions, VLayout_TozinSales_Grid
]
});



