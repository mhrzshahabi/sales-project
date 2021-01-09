//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

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

        showFindFormByData(ownerWindow: isc.Window, width: string, height: string, title: string, data: Array<any>, currentData: Array<any>, fields: Array<Partial<isc.ListGridField>>, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(null, null, null);
            let listGrid = this.listGridWidget.getObject();
            listGrid.setData(data);
            listGrid.setFields(fields);
            listGrid.setShowFilterEditor(false);

            if (currentData != null && currentData.length > 0) {

                // @ts-ignore
                let primaryKeyField = listGrid.getFields().find(p => p.primaryKey);
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
            this.createWindow(title, this.getButtonLayout(), listGrid, width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByListGrid(ownerWindow: isc.Window, width: string, height: string, title: string, currentData: Array<any>, listGrid: isc.ListGrid, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.listGridWidget = new ObjectHider(isc.ListGrid.create(listGrid));
            this.createWindow(title, this.getButtonLayout(), listGrid, width, height);
            if (currentData != null && currentData.length > 0) {

                // @ts-ignore
                let primaryKeyField = listGrid.getFields().find(p => p.primaryKey);
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

        // @ts-ignore
        showFindFormByRestDataSource(ownerWindow: isc.Window, width: string, height: string, title: string, currentData: Array<any>, restDataSource: isc.MyRestDataSource, dataArrivedCallback?: any, criteria: Criteria = null, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            // @ts-ignore
            this.createListGrid(isc.MyRestDataSource.create(restDataSource), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        showFindFormByRestApiUrl(ownerWindow: isc.Window, width: string, height: string, title: string, currentData: Array<any>, restApiUrl: string, fields: Array<Partial<isc.DataSourceField>>, dataArrivedCallback?: any, criteria: Criteria = null, selectionMultiplicityValue: number = 1): void {

            this.owner = new ObjectHider(ownerWindow);
            this.selectionMultiplicity = new ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        public setOwner(owner: isc.Window): void {

            this.owner = new ObjectHider(owner);
        }

        public setWindowWidget(window: isc.Window): void {

            this.windowWidget = new ObjectHider(window);
        }

        public setListGridWidget(listGrid: isc.ListGrid): void {

            this.listGridWidget = new ObjectHider(listGrid);
        }

        public setSelectionMultiplicity(selectionMultiplicity: number): void {

            this.selectionMultiplicity = new ObjectHider(selectionMultiplicity);
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

        // @ts-ignore
        public getRestDataSource(restApiUrl: string, fields: Array<Partial<isc.DataSourceField>>): isc.MyRestDataSource {

            // @ts-ignore
            return isc.MyRestDataSource.nicico.getDefault(restApiUrl, fields);
        }

        // @ts-ignore
        public createListGrid(restDataSource: isc.MyRestDataSource, criteria: Criteria, currentData: Array<any>, dataArrivedCallback?: any): void {

            let This = this;
            // @ts-ignore
            This.listGridWidget = new ObjectHider(isc.ListGrid.nicico.getDefault(null, restDataSource, criteria, {

                // @ts-ignore
                currentData: currentData,
                selectionType: (This.selectionMultiplicity.getObject() < 1 ? "none" : (This.selectionMultiplicity.getObject() === 1 ? "single" : "simple")),
                selectionAppearance: (This.selectionMultiplicity.getObject() > 1 ? "checkbox" : "rowStyle"),
                sortField: This.selectionMultiplicity.getObject() > 1 ? 2 : 1, // showRowNumbers and selectionAppearance
                autoSaveEdits: false,
                validateOnChange: true,
                dataArrived: function (startRow, endRow) {

                    if (this.currentData != null && this.currentData.length > 0) {

                        // @ts-ignore
                        let primaryKeyField = this.getFields().find(p => p.primaryKey);
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
            width = width == null ? "50%" : width;
            height = height == null ? "500" : height;
            // @ts-ignore
            This.windowWidget = new ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, [listGrid, buttonLayout], width, height), {

                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                }
            }));
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
