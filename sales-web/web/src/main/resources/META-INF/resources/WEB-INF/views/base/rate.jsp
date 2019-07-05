<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

var Menu_ListGrid_Rate = isc.Menu.create({
width: 150,
data: [

{
title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
click: function () {
ListGrid_Rate_refresh();
}
},
{
title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
click: function () {
DynamicForm_Rate.clearValues();
Window_Rate.show();
}
},
{
title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
click: function () {
ListGrid_Rate_edit();
}
},
{
title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
click: function () {
ListGrid_Rate_remove();
}
}
]
});

var ValuesManager_Rate = isc.ValuesManager.create({});
var DynamicForm_Rate = isc.DynamicForm.create({
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
{name: "code", title: "<spring:message code='rate.code'/>", type: 'text', required: true, width: 400},
{name: "nameFA", title: "<spring:message code='rate.nameFa'/>", required: true, readonly: true, width: 400},
{name: "nameEN", title: "<spring:message code='rate.nameEN'/>", type: 'text', width: 400},
{name: "symbol", title: "<spring:message code='feature.symbol'/>", type: 'text', width: 400},
{
name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>", width: 400,
validators: [{
type: "isInteger",
validateOnExit: true,
stopOnError: true,
errorMessage: "<spring:message code='global.form.correctType'/>"
}]
},
]
});

var IButton_Rate_Save = isc.IButton.create({
top: 260,
title: "<spring:message code='global.form.save'/>",
icon: "pieces/16/save.png",
click: function () {
ValuesManager_Rate.validate();
DynamicForm_Rate.validate();
if (DynamicForm_Rate.hasErrors()) {
return;
}
var data = DynamicForm_Rate.getValues();
// ######@@@@###&&@@###
var methodXXXX = "PUT";
if (data.id == null) methodXXXX = "POST";
isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/rate/",
httpMethod: methodXXXX,
data: JSON.stringify(data),
callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
isc.say("<spring:message code='global.form.request.successful'/>");
ListGrid_Rate_refresh();
Window_Rate.close();
} else {
isc.say(RpcResponse_o.data);
}
}
})
);
}
});

var Window_Rate = isc.Window.create({
title: "<spring:message code='rate.title'/>. ",
width: 580,
hight: 500,
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
DynamicForm_Rate,

isc.HLayout.create({
width: "100%",
members:
[
IButton_Rate_Save,
isc.Label.create({
width: 5,
}),
isc.IButton.create({
ID: "rateEditExitIButton",
title: "<spring:message code='global.cancel'/>",
width: 100,
icon: "pieces/16/icon_delete.png",
orientation: "vertical",
click: function () {
Window_Rate.close();
}
})
]
})
]
});

function ListGrid_Rate_refresh() {
ListGrid_Rate.invalidateCache();
};

function ListGrid_Rate_remove() {

var record = ListGrid_Rate.getSelectedRecord();

if (record == null || record.id == null) {
isc.Dialog.create({
message: "<spring:message code='global.grid.record.not.selected'/>. !",
icon: "[SKIN]ask.png",
title: "<spring:message code='global.message'/>.",
buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
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

var rateId = record.id;
// ######@@@@###&&@@###
isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
actionURL: "http://localhost:9099/api/rate/" + rateId,
httpMethod: "DELETE",
callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
ListGrid_Rate.invalidateCache();
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
};

function ListGrid_Rate_edit() {

var record = ListGrid_Rate.getSelectedRecord();

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
DynamicForm_Rate.editRecord(record);
Window_Rate.show();
}
};


var ToolStripButton_Rate_Refresh = isc.ToolStripButton.create({
icon: "[SKIN]/actions/refresh.png",
title: "<spring:message code='global.form.refresh'/>",
click: function () {
ListGrid_Rate_refresh();
}
});

var ToolStripButton_Rate_Add = isc.ToolStripButton.create({
icon: "[SKIN]/actions/add.png",
title: "<spring:message code='global.form.new'/>",
click: function () {
DynamicForm_Rate.clearValues();
Window_Rate.show();
}
});

var ToolStripButton_Rate_Edit = isc.ToolStripButton.create({
icon: "[SKIN]/actions/edit.png",
title: "<spring:message code='global.form.edit'/>",
click: function () {
ListGrid_Rate_edit();
}
});


var ToolStripButton_Rate_Remove = isc.ToolStripButton.create({
icon: "[SKIN]/actions/remove.png",
title: "<spring:message code='global.form.remove'/>",
click: function () {
ListGrid_Rate_remove();
}
});


var ToolStrip_Actions_Rate = isc.ToolStrip.create({
width: "100%",
members: [
ToolStripButton_Rate_Refresh,
ToolStripButton_Rate_Add,
ToolStripButton_Rate_Edit,
ToolStripButton_Rate_Remove
]
});

var HLayout_Actions_Rate = isc.HLayout.create({
width: "100%",
members: [
ToolStrip_Actions_Rate
]
});

var RestDataSource_Rate = isc.MyRestDataSource.create({
fields: [
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "code", title: "<spring:message code='rate.code'/> "},
{name: "nameFA", title: "<spring:message code='rate.nameFa'/> "},
{name: "nameEN", title: "<spring:message code='rate.nameEN'/> "},
{name: "symbol", title: "<spring:message code='rate.symbol'/>"},
{name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
],
// ######@@@@###&&@@###
fetchDataURL: "http://localhost:9099/api/rate/spec-list"
});

var ListGrid_Rate = isc.ListGrid.create({
width: "100%",
height: "100%",
dataSource: RestDataSource_Rate,
contextMenu: Menu_ListGrid_Rate,
fields: [
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
{name: "code", title: "<spring:message code='rate.code'/> ", align: "center"},
{name: "nameFA", title: "<spring:message code='rate.nameFa'/> ", align: "center"},
{name: "nameEN", title: "<spring:message code='rate.nameEN'/> ", align: "center"},
{name: "symbol", title: "<spring:message code='rate.symbol'/>", align: "center"},
{name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>", align: "center"}

],
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


var HLayout_Grid_Rate = isc.HLayout.create({
width: "100%",
height: "100%",
members: [
ListGrid_Rate
]
});

var VLayout_Body_Rate = isc.VLayout.create({
width: "100%",
height: "100%",
members: [
HLayout_Actions_Rate, HLayout_Grid_Rate
]
});
