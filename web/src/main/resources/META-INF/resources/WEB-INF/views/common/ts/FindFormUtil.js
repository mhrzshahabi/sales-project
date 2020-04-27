//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var FindFormUtil = /** @class */ (function () {
        function FindFormUtil() {
            this.cancelCallBack = function () {
                return;
            };
            this.validate = function (selectedRecords) {
                return true;
            };
            this.okCallBack = function (selectedRecords) {
                return selectedRecords;
            };
        }
        FindFormUtil.prototype.showFindFormByData = function (ownerWindow, title, data, currentData, fields, selectionMultiplicityValue) {
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new nicico.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(null, null, null);
            var listGrid = this.listGridWidget.getObject();
            listGrid.setData(data);
            listGrid.setFields(fields);
            listGrid.setShowFilterEditor(false);
            if (currentData != null && currentData.length > 0) {
                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(function (p) { return p.primaryKey; });
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                    // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                else
                    primaryKeyField = { name: 'id' };
                var primaryKeyName_1 = primaryKeyField.name;
                var currentdataIds_1 = currentData.map(function (q) { return q[primaryKeyName_1]; });
                if (currentdataIds_1 == null || currentdataIds_1.length === 0)
                    return;
                // @ts-ignore
                listGrid.getOriginalData().forEach(function (q) {
                    if (currentdataIds_1.contains(q[primaryKeyName_1]))
                        listGrid.selectRecord(q);
                });
            }
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByListGrid = function (ownerWindow, title, currentData, listGrid, selectionMultiplicityValue) {
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new nicico.ObjectHider(selectionMultiplicityValue);
            this.listGridWidget = new nicico.ObjectHider(isc.ListGrid.create(listGrid));
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (currentData != null && currentData.length > 0) {
                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(function (p) { return p.primaryKey; });
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                    // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                else
                    primaryKeyField = { name: 'id' };
                var primaryKeyName_2 = primaryKeyField.name;
                var currentdataIds_2 = currentData.map(function (q) { return q[primaryKeyName_2]; });
                if (currentdataIds_2 == null || currentdataIds_2.length === 0)
                    return;
                // @ts-ignore
                listGrid.getOriginalData().forEach(function (q) {
                    if (currentdataIds_2.contains(q[primaryKeyName_2]))
                        listGrid.selectRecord(q);
                });
            }
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestDataSource = function (ownerWindow, title, currentData, restDataSource, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new nicico.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(isc.RestDataSource.create(restDataSource), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl = function (ownerWindow, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new nicico.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl2 = function (ownerWindow, width, height, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new nicico.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.getButtonLayout = function () {
            var This = this;
            // @ts-ignore
            var cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            // @ts-ignore
            var ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    var data = [];
                    if (This.selectionMultiplicity.getObject() === 1) {
                        data.add(This.listGridWidget.getObject().getSelectedRecord());
                    }
                    else {
                        var selectedRecords = This.listGridWidget.getObject().getSelectedRecords();
                        data = selectedRecords.slice(0, Math.min(selectedRecords.length, This.selectionMultiplicity.getObject()));
                    }
                    if (!This.validate(data))
                        return;
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.okCallBack(data);
                },
                icon: "pieces/16/approve.png",
                title: '<spring:message code="global.ok" />'
            });
            if (This.selectionMultiplicity.getObject() < 1)
                ok.hide();
            return isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        };
        FindFormUtil.prototype.getRestDataSource = function (restApiUrl, fields) {
            // @ts-ignore
            return isc.RestDataSource.nicico.getDefault(restApiUrl, fields);
        };
        FindFormUtil.prototype.createListGrid = function (restDataSource, criteria, currentData, dataArrivedCallback) {
            var This = this;
            // @ts-ignore
            This.listGridWidget = new nicico.ObjectHider(Object.assign(isc.ListGrid.nicico.getDefault(null, restDataSource, criteria), {
                height: window.innerHeight * .6,
                // @ts-ignore
                currentData: currentData,
                selectionType: (This.selectionMultiplicity.getObject() < 1 ? "none" : (This.selectionMultiplicity.getObject() === 1 ? "single" : "simple")),
                selectionAppearance: (This.selectionMultiplicity.getObject() > 1 ? "checkbox" : "rowStyle"),
                sortField: This.selectionMultiplicity.getObject() > 1 ? 1 : 0,
                autoSaveEdits: false,
                validateOnChange: true,
                dataArrived: function (startRow, endRow) {
                    var _this = this;
                    if (this.currentData != null && this.currentData.length > 0) {
                        // @ts-ignore
                        var primaryKeyField = this.getFields().find(function (p) { return p.primaryKey; });
                        // @ts-ignore
                        if (primaryKeyField == null && this.dataSource != null)
                            // @ts-ignore
                            primaryKeyField = Object.values(this.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                        else
                            primaryKeyField = { name: 'id' };
                        var primaryKeyName_3 = primaryKeyField.name;
                        var currentDataIds_1 = this.currentData.map(function (q) { return q[primaryKeyName_3]; });
                        if (currentDataIds_1 == null || currentDataIds_1.length === 0)
                            return;
                        // @ts-ignore
                        this.getOriginalData().localData.filter(function (q) { return q; }).forEach(function (q) {
                            if (currentDataIds_1.contains(q[primaryKeyName_3]))
                                _this.selectRecord(q);
                        });
                    }
                    if (dataArrivedCallback != null)
                        dataArrivedCallback(startRow, endRow);
                }
            }));
        };
        FindFormUtil.prototype.createWindow = function (title, buttonLayout, listGrid, width, height) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            var This = this;
            var vLayout = isc.VLayout.create({
                width: "100%",
                members: [
                    listGrid,
                    buttonLayout
                ]
            });
            // @ts-ignore
            This.windowWidget = new nicico.ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, [vLayout]), {
                height: height,
                width: width == null ? "50%" : width,
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                }
            }));
        };
        return FindFormUtil;
    }());
    nicico.FindFormUtil = FindFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
