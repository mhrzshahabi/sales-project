//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="C:\isomorphic\system\development\smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
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
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
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
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.listGridWidget = new evaluation.ObjectHider(isc.ListGrid.create(listGrid));
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
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(isc.RestDataSource.create(restDataSource), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl = function (ownerWindow, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl2 = function (ownerWindow, width, height, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
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
            return isc.RestDataSource.create({
                fields: fields,
                jsonPrefix: "",
                jsonSuffix: "",
                dataFormat: "json",
                fetchDataURL: restApiUrl,
                // @ts-ignore
                transformRequest: function (dsRequest) {
                    // @ts-ignore
                    dsRequest.httpHeaders = BaseRPCRequest.httpHeaders;
                    return this.Super("transformRequest", arguments);
                }
            });
        };
        FindFormUtil.prototype.createListGrid = function (restDataSource, criteria, currentData, dataArrivedCallback) {
            var This = this;
            This.listGridWidget = new evaluation.ObjectHider(isc.ListGrid.create({
                width: "100%",
                height: window.innerHeight * .6,
                margin: 10,
                dataPageSize: 50,
                autoFetchData: true,
                // @ts-ignore
                currentData: currentData,
                initialCriteria: criteria,
                dataSource: restDataSource,
                canAutoFitFields: false,
                selectionType: (This.selectionMultiplicity.getObject() < 1 ? "none" : (This.selectionMultiplicity.getObject() === 1 ? "single" : "simple")),
                selectionAppearance: (This.selectionMultiplicity.getObject() > 1 ? "checkbox" : "rowStyle"),
                sortField: This.selectionMultiplicity.getObject() > 1 ? 1 : 0,
                fetchDelay: 1000,
                autoSaveEdits: false,
                showFilterEditor: true,
                validateOnChange: true,
                filterOnKeyPress: false,
                alternateRecordStyles: true,
                allowAdvancedCriteria: true,
                sortFieldAscendingText: '<spring:message code="global.grid.sortFieldAscendingText" />',
                sortFieldDescendingText: '<spring:message code="global.grid.sortFieldDescendingText" />',
                configureSortText: '<spring:message code="global.grid.configureSortText" />',
                autoFitAllText: '<spring:message code="global.grid.autoFitAllText" />',
                autoFitFieldText: '<spring:message code="global.grid.autoFitFieldText" />',
                filterUsingText: '<spring:message code="global.grid.filterUsingText" />',
                groupByText: '<spring:message code="global.grid.groupByText" />',
                freezeFieldText: '<spring:message code="global.grid.freezeFieldText" />',
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
            var vLayout = this.createVLayout(buttonLayout, listGrid);
            This.windowWidget = new evaluation.ObjectHider(isc.Window.create({
                title: title,
                width: width == null ? "50%" : width,
                height: height,
                align: "center",
                items: [vLayout],
                isModal: true,
                autoSize: true,
                autoDraw: false,
                autoCenter: true,
                showModalMask: true,
                dismissOnEscape: false,
                dismissOnOutsideClick: false,
                // @ts-ignore
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                }
            }));
        };
        FindFormUtil.prototype.createVLayout = function (buttonLayout, listGrid) {
            return isc.VLayout.create({
                width: "100%",
                members: [
                    listGrid,
                    buttonLayout
                ]
            });
        };
        return FindFormUtil;
    }());
    evaluation.FindFormUtil = FindFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//
