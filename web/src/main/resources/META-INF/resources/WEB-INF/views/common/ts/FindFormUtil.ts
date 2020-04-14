//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>

// @ts-ignore
///<reference path="C:\isomorphic\system\development\smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace evaluation {

    //------------------------------------------ Classes -------------------------------------------

    export class FindFormUtil {

        private owner: ObjectHider<isc.Window>;
        private windowWidget: ObjectHider<isc.Window>;
        private listGridWidget: ObjectHider<isc.ListGrid>;
        private selectionMultiplicity: ObjectHider<number>;

        public cancelCallBack: any = function () {

            return;
        };
        public validate: any = function (selectedRecords: Array<any>) {

            return true;
        };
        public okCallBack: any = function (selectedRecords: Array<any>) {

            return selectedRecords;
        };

        showFindFormByData(ownerWindow: isc.Window, title: string, data: Array<any>, currentData: Array<any>, fields: Array<Partial<isc.ListGridField>>, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(null, null, null);
            let listGrid = this.listGridWidget.getObject();
            listGrid.setData(data);
            listGrid.setFields(fields);
            listGrid.setShowFilterEditor(false);

            if (currentData != null && currentData.length > 0) {

                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(p => p.primaryKey);
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(p => p.primaryKey);
                else
                    primaryKeyField = {name: 'id'};
                let primaryKeyName = primaryKeyField.name;
                let currentdataIds = currentData.map(q => q[primaryKeyName]);
                if (currentdataIds == null || currentdataIds.length === 0) return;

                // @ts-ignore
                listGrid.getOriginalData().forEach(q => {
                    if (currentdataIds.contains(q[primaryKeyName]))
                        listGrid.selectRecord(q);
                });
            }
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByListGrid(ownerWindow: isc.Window, title: string, currentData: Array<any>, listGrid: isc.ListGrid, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.listGridWidget = new ObjectHider(isc.ListGrid.create(listGrid));
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (currentData != null && currentData.length > 0) {

                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(p => p.primaryKey);
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(p => p.primaryKey);
                else
                    primaryKeyField = {name: 'id'};
                let primaryKeyName = primaryKeyField.name;
                let currentdataIds = currentData.map(q => q[primaryKeyName]);
                if (currentdataIds == null || currentdataIds.length === 0) return;

                // @ts-ignore
                listGrid.getOriginalData().forEach(q => {
                    if (currentdataIds.contains(q[primaryKeyName]))
                        listGrid.selectRecord(q);
                });
            }
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByRestDataSource(ownerWindow: isc.Window, title: string, currentData: Array<any>, restDataSource: isc.RestDataSource, dataArrivedCallback?: any, criteria: Criteria = null, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(isc.RestDataSource.create(restDataSource), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByRestApiUrl(ownerWindow: isc.Window, title: string, currentData: Array<any>, restApiUrl: string, fields: Array<Partial<isc.DataSourceField>>, dataArrivedCallback?: any, criteria: Criteria = null, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByRestApiUrl2(ownerWindow: isc.Window, width: string, height: string, title: string, currentData: Array<any>, restApiUrl: string, fields: Array<Partial<isc.DataSourceField>>, dataArrivedCallback?: any, criteria: Criteria = null, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        public getButtonLayout(): isc.HLayout {

            let This = this;
            // @ts-ignore
            let cancel = isc.IButtonCancel.create({

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
            let ok = isc.IButtonSave.create({

                // @ts-ignore
                click: function () {

                    let data = [];
                    if (This.selectionMultiplicity.getObject() === 1) {
                        data.add(This.listGridWidget.getObject().getSelectedRecord());
                    } else {
                        let selectedRecords = This.listGridWidget.getObject().getSelectedRecords();
                        data = selectedRecords.slice(0, Math.min(selectedRecords.length, This.selectionMultiplicity.getObject()))
                    }

                    if (!This.validate(data)) return;

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
        }

        public getRestDataSource(restApiUrl: string, fields: Array<Partial<isc.DataSourceField>>): isc.RestDataSource {

            return isc.RestDataSource.create({

                fields: fields,
                jsonPrefix: "",
                jsonSuffix: "",
                dataFormat: "json",
                fetchDataURL: restApiUrl,
                // @ts-ignore
                transformRequest: function (dsRequest) {

                    // @ts-ignore
                    dsRequest.httpHeaders = EvaluationConfigs.httpHeaders;
                    return this.Super("transformRequest", arguments);
                }
            });
        }

        public createListGrid(restDataSource: isc.RestDataSource, criteria: Criteria, currentData: Array<any>, dataArrivedCallback?: any): void {

            let This = this;
            This.listGridWidget = new ObjectHider(isc.ListGrid.create({

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

                    if (this.currentData != null && this.currentData.length > 0) {

                        // @ts-ignore
                        var primaryKeyField = this.getFields().find(p => p.primaryKey);
                        // @ts-ignore
                        if (primaryKeyField == null && this.dataSource != null)
                        // @ts-ignore
                            primaryKeyField = Object.values(this.dataSource.getFields()).find(p => p.primaryKey);
                        else
                            primaryKeyField = {name: 'id'};
                        let primaryKeyName = primaryKeyField.name;
                        let currentDataIds = this.currentData.map(q => q[primaryKeyName]);
                        if (currentDataIds == null || currentDataIds.length === 0) return;

                        // @ts-ignore
                        this.getOriginalData().localData.filter(q => q).forEach(q => {
                            if (currentDataIds.contains(q[primaryKeyName]))
                                this.selectRecord(q);
                        });
                    }

                    if (dataArrivedCallback != null) dataArrivedCallback(startRow, endRow);
                }
            }));
        }

        public createWindow(title: string, buttonLayout: isc.HLayout, listGrid: isc.ListGrid, width: string = null, height: string = null): void {

            let This = this;
            let vLayout = this.createVLayout(buttonLayout, listGrid);
            This.windowWidget = new ObjectHider(isc.Window.create({

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
        }

        public createVLayout(buttonLayout: isc.HLayout, listGrid: isc.ListGrid): isc.VLayout {

            return isc.VLayout.create({

                width: "100%",
                members: [
                    listGrid,
                    buttonLayout
                ]
            });
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
