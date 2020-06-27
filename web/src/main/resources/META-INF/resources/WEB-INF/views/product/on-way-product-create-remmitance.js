// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
function giveMeAName() {
    const random = Math.random().toString().substr(-3);
    const selectedRecord = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord();
    if (!selectedRecord || selectedRecord === undefined || selectedRecord === null) {
        return Math.random().toString().substr(-11)
    }
    const codeKala = selectedRecord['codeKala'];
    const tozinId = selectedRecord['tozinId'];
    const now_date = new persianDate().format('YYYYMMDD');
    return (codeKala + '_f' + tozinId + '_rd' + now_date + '_' + random);
}

function onWayProductCreateRemittance() {

    const RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT = isc.MyRestDataSource.create({
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            },
            {
                name: "name",
                title: "<spring:message code='warehouseCad.yard'/>",
                width: "25%",
            },

        ],
        fetchDataURL: "${contextPath}/api/depot/spec-list"
    });

    const DynamicForm_warehouseCAD = isc.DynamicForm.create({
        // titleWidth: "150",
        numCols: 4,
        errorOrientation: "bottom",
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            },
            {
                name: "bijackNo",
                title: "<spring:message code='warehouseCad.bijackNo'/>",
                type: 'text',
                required: true,
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            },
            {
                name: "materialItemId",
                title: "<spring:message code='contractItem.material'/>",
                type: 'staticText',
            },
            {
                name: "plant",
                title: "<spring:message code='contractItem.plant'/>",
                type: 'staticText',
            },
            {
                name: "warehouseNo",
                title: "<spring:message code='warehouseCad.warehouseNo'/>",
                type: 'staticText',
            },

            {
                name: "warehouseYardId",
                required: true,
                // validators: [{
                //     type: "required",
                //     validateOnChange: true
                // }],
                colSpan: 1,
                titleColSpan: 1,
                showHover: true,
                autoFetchData: false,
                defaultValue: StorageUtil.get('onWayProduct_yardId'),
                title: "<spring:message code='warehouseCad.yard'/>",
                // type: 'string',
                // editorType: "SelectItem",
                // optionDataSource: RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT,
                displayField: "name",
                valueField: "id",
                // pickListWidth: "215",
                // pickListHeight: "215",
                pickListProperties: {
                    recordClick(pickList, record) {
                        StorageUtil.save('onWayProduct_yardId', record.id);
                        return this.Super("recordClick", arguments);
                    }
                },
                // pickListFields: [{
                //     name: "name"
                // }],
                /*
                changed: function (form, item, value) {
                    if (!item.getDisplayValue(value).includes("کاتد")) {
                        isc.warn("<spring:message code='warehouseYard.alert'/>");
                        form.getItem("warehouseYardId").setValue("");
                    }
                }

                 */
            },
            {
                name: "unit",
                title: "واحدشمارهش بسته کالا(ورق،بشکه،تن،..)",
                valueMap: SalesBaseParameters.getSavedUnitParameter().getValueMap('id', 'nameFA'),
                defaultValue: StorageUtil.get('DynamicForm_warehouseCAD_owp' + ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['codeKala'].toString()),
                changed(form, item, value) {
                    StorageUtil.save('DynamicForm_warehouseCAD_owp'
                        + ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['codeKala'].toString(),
                        value
                    )
                    try {
                        return this.Super('changed', arguments)
                    } catch (e) {
                    }
                }
            },
            {
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='bijack.title.destination.center'/>"
            },
            {
                type: "staticText",
                title: "<b><spring:message code='bijack.title.destination.right'/></b>",
                wrapTitle: true,
                width: 90,
            },
            {
                type: "staticText",
                title: "<b><spring:message code='bijack.title.destination.left'/></b>",
                wrapTitle: false,
                width: 90,
            },
            {
                name: "sourceBundleSum",
                title: "تعداد بسته(باندل، لات، ... ) مبدا",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationBundleSum",
                title: "تعداد بسته(باندل، لات، ... ) مقصد",
                colSpan: 1,
                titleColSpan: 1,
// type: "staticText",
            },
            {
                name: "sourceSheetSum",
                title: "مجموع تعداد واحد(بشکه، ورق، ... ) مبدا",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationSheetSum",
                title: "مجموع تعداد واحد(بشکه، ورق، ... ) مبدا",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "sourceWeight",
                title: "<spring:message code='warehouseCad.sourceWeight'/>",
                colSpan: 1,
                titleColSpan: 1,
                keyPressFilter: "[0-9]",
                type: "staticText",
            },
            {
                name: "destinationWeight",
                title: "<spring:message code='warehouseCad.destinationWeight'/>",
                colSpan: 1,
                titleColSpan: 1,
                keyPressFilter: "[0-9]",
                type: "staticText",
            },
            {
                name: "sourceSheetSumDelivery",
                title: "<spring:message code='warehouseCad.SheetNumber.Source'/>",
                colSpan: 1,
                titleColSpan: 1
            },
            {
                name: "destinationSheetSumDelivery",
                title: "<spring:message code='warehouseCad.SheetNumber.Destination'/>",
                colSpan: 1,
                titleColSpan: 1
            },
            {
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='warehouseCad.addBijackItem'/>"
            }
        ]
    });
    const DynamicForm_warehouseCAD_Desc = isc.DynamicForm.create({
        titleWidth: "200",
        fields: [
            {
                name: "bijakFirstDescription",
                title: "<spring:message code='warehouseCad.bijakFirstDescription'/>",
                type: "textarea",
                orientation: "right",
                length: 255,
                width: 650,
                rowSpan: 2,
                height: 40,
                canEdit: false
            },
            {
                name: "bijakSecondDescription",
                title: "<spring:message code='warehouseCad.bijakSecondDescription'/>",
                type: "textarea",
                orientation: "right",
                length: 255,
                width: 650,
                rowSpan: 2,
                height: 40,
                canEdit: false
            }
        ]
    });
    const IButton_warehouseCAD_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            isc.Dialog.create({
                title: "<spring:message code='global.warning'/>",
                message: "<spring:message code='warehouseCad.warning.save'/>",
                buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                okClick() {
                    this.close();
                    if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantId") == undefined && DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId") == undefined) {
                        isc.warn("<spring:message code='warehouseCad.tozinBandarAbbasErrors'/>");
                        DynamicForm_warehouseCAD.validate();
                        return;
                    }
                    if (ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.hasErrors()) {
                        isc.warn("<spring:message code='warehouseCadItem.tedadCADErrors'/>");
                        return;
                    }
                    DynamicForm_warehouseCAD.validate();
                    if (DynamicForm_warehouseCAD.hasErrors())
                        return;
                    DynamicForm_warehouseCAD.setValue("materialItemId",
                        ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().codeKala);
                    var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
                    if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantId") != undefined)
                        data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD.getValue("destinationTozinPlantId")
                    else if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId") != undefined) {
                        data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId")
                    }
                    var warehouseCadItems = [];

                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.selectAllRecords();
                    var notComplete = 0;
                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getAllEditRows().forEach(function (element) {
                        var record = ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getEditedRecord(JSON.parse(JSON.stringify(element)));
                        if (record.productLabel != undefined && record.sheetNumber != undefined && record.wazn != undefined &&
                            record.productLabel != null && record.sheetNumber != null && record.wazn != null) {
                            warehouseCadItems.add(record);
                        } else {
                            notComplete++;
                        }
                        ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.deselectRecord(ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getRecord(element));
                    });

                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getSelectedRecords().forEach(function (element) {
                        warehouseCadItems.add(JSON.parse(JSON.stringify(element)));
                    });

                    if (notComplete != 0) {
                        isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>");
                        return;
                    }

                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.deselectAllRecords();

                    warehouseCadItems.forEach(function (item) {
                        item.bundleSerial = item.productLabel;
                        delete item.productLabel;
                        item.sheetNo = item.sheetNumber;
                        delete item.sheetNumber;
                        item.weightKg = item.wazn;
                        delete item.wazn;
                    });

                    data_WarehouseCad.warehouseCadItems = warehouseCadItems;
                    data_WarehouseCad.bijakFirstDescription = DynamicForm_warehouseCAD_Desc.getValue("bijakFirstDescription");
                    data_WarehouseCad.bijakSecondDescription = DynamicForm_warehouseCAD_Desc.getValue("bijakSecondDescription");

                    var method = "PUT";
                    if (data_WarehouseCad.id == null)
                        method = "POST";
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/warehouseCad/",
                            httpMethod: method,
                            data: JSON.stringify(data_WarehouseCad),
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    isc.say("<spring:message code='global.form.request.successful'/>");
                                    ListGrid_Tozin_IN_ONWAYPRODUCT_refresh();
                                    Window_BijackOnWayProduct.close();
                                } else
                                    isc.say(RpcResponse_o.data);
                            }
                        })
                    );
                }
            })

        }
    });
    // ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData([]);
    const selectedSourceTozins = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords();
    DynamicForm_warehouseCAD.clearValues();
    DynamicForm_warehouseCAD.setValue("materialItemId",
        SalesBaseParameters
            .getSavedMaterialItemParameter()
            .find(m => m.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().codeKala).gdsName);
    const source = SalesBaseParameters.getSavedWarehouseParameter()
        .find(pp => pp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['sourceId'])
    const target = SalesBaseParameters.getSavedWarehouseParameter()
        .find(pp => pp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['targetId'])

    // console.log(source, 'source')
    DynamicForm_warehouseCAD.setValue("plant", source['name']);

    DynamicForm_warehouseCAD.setValue("warehouseNo", target['name']);

    DynamicForm_warehouseCAD.setValue("sourceTozinPlantId", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tozinId);

    DynamicForm_warehouseCAD.setValue("containerNo", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().containerId);

    DynamicForm_warehouseCAD_Desc.setValue("bijakFirstDescription", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().strSharh2);
    DynamicForm_warehouseCAD_Desc.setValue("bijakSecondDescription", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().ctrlDescOut);
    const windowDestinationTozinList = (function () {
        const datasource = isc.DataSource.create({
            fields: tozinLiteFields
        });
        const gridConfigs = {
            showRowNumbers: true,
            showFilterEditor: true,
            allowAdvancedCriteria: true,
            filterOnKeypress: true,
            autoFitHeaderHeights: true,
            headerHeight: 50,
            selectionType: "multiple",
            filterLocalData: true,
            wrapCells: true,
            wrapHeaderTitles: true,
            useClientFiltering: true,
            width: "100%",
            height: 570,
            dataSource: datasource,
            fields: [...tozinLiteFields,],
        };
        const extraGridConfigs = {
            recordDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                const grid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
                const sourceTozinId = grid.getSelectedRecord()['tozinId'];
                const gridData = grid.getData();
                gridData.find((d, i) => {
                    if (d['tozinId'] === sourceTozinId) {
                        grid.setEditValue(i, 'destTozinId', record['tozinId'])
                        // console.log('found selected record in listGridSetDestTozinHarasatPolompForSelectedTozin ',d,record)
                    }
                    return d['tozinId'] === sourceTozinId;
                })
                // console.log('found selected record in listGridSetDestTozinHarasatPolompForSelectedTozin ',gridData)
                // grid.setData(gridData)
                win.hide();
            }
        }
        const grid = isc.ListGrid.create({...extraGridConfigs, ...gridConfigs});
        const win = isc.Window.create({
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
            visibility: 'hidden',
            closeClick: function () {
                this.Super("closeClick", arguments)
            },
            items: [grid]
        });
        const returnVar = {
            w: win.getID(),
            g: grid.getID(),
            gc: gridConfigs,
            ds: datasource.getID(),
        };
        //console.log(returnVar);
        return returnVar;
    })()
    const listGridSetDestTozinHarasatPolompForSelectedTozin = (function () {

            const grid_source = isc.ListGrid.create({
                ...windowDestinationTozinList['gc'],
                ...{
                    alternateRecordStyles: true,
                    expansionFieldImageShowSelected: true,
                    canExpandRecords: true,
                    canExpandMultipleRecords: false,
                    getExpansionComponent: function (record, rowNum, colNum) {
                        function updateRecord(key, value, pkgRec) {
                            const recordPkgs = record['packages'];
                            recordPkgs.find(p => p.uid === pkgRec.uid)[key] = value;
                            const ggrid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
                            const rowNum = ggrid.getRecordIndex(record);
                            // console.log(rowNum,'pkgNum_destination',
                            //     recordPkgs.length)
                            const _3 = recordPkgs.map(rp => Number(rp.tedad)).reduce((i, j) => i + j);
                            ggrid.setEditValue(rowNum, 'tedad_destination',
                                recordPkgs.map(rp => Number(rp.tedad)).reduce((i, j) => i + j))
                            ggrid.setEditValue(rowNum, 'pkgNum_destination',
                                recordPkgs.length)
                        }

                        const ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT = isc.ListGrid.create({
                            showFilterEditor: false,
                            width: "100%",
                            // height: 500,
                            modalEditing: true,
                            showRowNumbers: false,
                            canEdit: true,
                            editEvent: "click",
                            editByCell: true,
                            canRemoveRecords: true,
                            autoSaveEdits: false,
                            deferRemoval: false,
                            saveLocally: true,
                            showGridSummary: true,
                            // visibility: 'hidden',
                            // gridComponents: ["header", "body",  ],
                            fields: [{
                                name: "label",
                                title: "<spring:message code='warehouseCadItem.bundleSerial'/>",
                                width: "20%",
                                editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                    record['packages'].find(p => p.uid === recordg.uid)['label'] = newValue
                                },
                                summaryFunction: "count",
                            },
                                {
                                    name: "uid",
                                    width: "20%",
                                    hidden: true,
                                },
                                {
                                    name: "tedad",
                                    title: "تعداد (ورق، بشگه، فله، ...)",
                                    width: "20%",
                                    validators: [{
                                        type: "regexp",
                                        expression: "^[0-9]*$",
                                        validateOnChange: true
                                    }],
                                    summaryFunction: "sum",
                                    editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                        // record['packages'].find(p => p.uid === recordg.uid)['tedad'] = Number(newValue)
                                        updateRecord('tedad', newValue, recordg);
                                    },
                                    editorProperties: {
                                        keyPressFilter: "[0-9]",
                                    },
                                },
                                {
                                    name: "wazn",
                                    title: "<spring:message code='warehouseCadItem.weightKg'/>",
                                    width: "20%",
                                    validators: [{
                                        type: "regexp",
                                        expression: "^[0-9]*$",
                                        validateOnChange: true
                                    }],
                                    editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                        record['packages'].find(p => p.uid === recordg.uid)['wazn'] = Number(newValue)
                                    },
                                    editorProperties: {
                                        keyPressFilter: "[0-9]",
                                    },
                                    summaryFunction: "sum"
                                },
                                {
                                    name: "description",
                                    title: "<spring:message code='warehouseCadItem.description'/>",
                                    width: "25%",
                                    editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                        record['packages'].find(p => p.uid === recordg.uid)['description'] = newValue
                                    },
                                }],
                            removeData: function (record) {

                                isc.Dialog.create({
                                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                                    icon: "[SKIN]ask.png",
                                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                                    buttons: [
                                        isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                                        isc.Button.create({title: "<spring:message code='global.no'/>"})
                                    ],
                                    buttonClick: function (button, index) {
                                        this.hide();

                                        if (index == 0) {
                                            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.data.remove(record);
                                        }

                                    }
                                });
                            }
                        });
                        const add_bundle_button = isc.IButton.create({
                            title: "<spring:message code='warehouseCad.addBundle'/>",
                            // width: 150,
                            click: () => {
                                // const grid_source = listGridSetDestTozinHarasatPolompForSelectedTozin['gs'];
                                // const grid = window[grid_source];
                                const gridData = record.packages;
                                const uid = giveMeAName();
                                gridData.add({
                                    label: uid,
                                    productId: null,
                                    tedad: 0,
                                    uid: uid,
                                    wazn: 0
                                })
                            }
                        });
                        ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData(record['packages']);
                        return isc.VLayout.create({
                            height: 300,
                            members: [ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT, add_bundle_button]
                        })
                    }
                },
                canEdit: true,
                autoSaveEdits: false,
                showFilterEditor: false,
                // height: "",
                editEvent: 'click',
                fields: [...windowDestinationTozinList['gc']['fields'].map(c => {
                    return {...c, canEdit: false}
                }),
                    {
                        name: "pkgNum_source",
                        canFilter: false,
                        title: 'بسته(لات، باندل، ...) مبدا',
                        canEdit: false
                    },
                    {
                        name: "tedad_source",
                        canFilter: false,
                        title: 'تعداد(ورق، بشکه، ...) مبدا',
                        canEdit: false
                    },
                    {
                        name: "pkgNum_destination",
                        canFilter: false,
                        editorProperties: {
                            type: 'number',
                            required: 'true',
                            keyPressFilter: "[0-9]",
                        },
                        title: 'بسته(لات، باندل، ...) مقصد',
                        canEdit: false
                    },
                    {
                        name: "tedad_destination",
                        editorProperties: {
                            type: 'number',
                            required: 'true',
                            keyPressFilter: "[0-9]",
                        },
                        canFilter: false,
                        title: 'تعداد(ورق، بشکه، ...) مقصد',
                        canEdit: false
                    },
                    {
                        name: "destTozinId", showHoverComponents: true,
                        showHover: true,
                        hoverHTML(record, value, rowNum, colNum, grid) {
                            console.log('hover html', arguments)
                            try {
                                const title = tozinFields.getValueMap('name', 'title')
                                const tbl = '<table border="1">' +
                                    Object.keys(record['destTozin']).map((k, i, list) => {
                                        const columns = 4;
                                        if (i % columns !== 0) return '\n';
                                        const startRow = '<tr>';
                                        const endRow = '</tr>';

                                        function rowMaker(num) {
                                            let rows = '\n';
                                            for (let j = 0; j < num; j++) {
                                                const title0 = title[list[i + j]] ? title[list[i + j]] : list[i + j];
                                                rows = rows + (i + j >= list.length ? '' : '<th>' + title0 + '</th>' +
                                                    '<td>' + record['destTozin'][list[i + j]] + '</td>');
                                            }
                                            return rows;
                                        }

                                        const rows = rowMaker(columns);
                                        // console.log('end rows', rows)

                                        return startRow + rows + endRow;
                                    }).join('\n') + '</table>';
                                return tbl;
                            } catch (e) {
                                console.error('destination tozin id hover error', e);
                                return 'شماره توزین مقصذ را وارد کنید   ';
                            }
                        },
                        title: 'توزین مقصد',
                        canFilter: false,
                        required: true,
                        editorType: "comboBox",
                        editorProperties: {
                            icons: [{
                                src: "pieces/16/icon_add.png",
                                click() {
                                    window[windowDestinationTozinList['w']].show()
                                }
                            }]
                        },
                        editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                            const grid_available_tozins_string = windowDestinationTozinList['g'];
                            const grid_available_tozins = window[grid_available_tozins_string];
                            const destTozin = grid_available_tozins.getData().find(g => g['tozinId'] === newValue);
                            if (newValue !== undefined && newValue !== null && newValue !== '' && destTozin) {
                                record['destTozin'] = destTozin;
                                console.log('updated destination Id', record, grid);
                                record['destTozinId'] = newValue;
                                return true
                            } else {
                                isc.warn('شماره توزین اشتباه است');
                                // grid.startEditing(rowNum,colNum,true)
                                return false;
                            }
                        }
                        // valueMap: window[windowDestinationTozinList['g']].getData().getValueMap('tozinId', 'tozinId')
                    },
                    {
                        name: "harasatId",
                        canFilter: false,
                        title: 'شماره پلمپ حراست',
                        /* editorExit (editCompletionEvent, record, newValue, rowNum, colNum, grid){
                             if(newValue===undefined || newValue === null || newValue === ''){
                                 isc.warn('شماره پلمپ حراست خالی می‌باشد');
                                 // grid.startEditing(rowNum,colNum,true)
                                 return false;
                             }
                            return true;

                         }*/

                    },
                    {
                        name: "rahAhanId",
                        title: 'شماره پلمپ راه‌آهن',
                        canFilter: false,


                        /* editorExit (editCompletionEvent, record, newValue, rowNum, colNum, grid){
                             if(newValue===undefined || newValue === null || newValue === ''){
                                 isc.warn('شماره پلمپ حراست خالی می‌باشد');
                                 // grid.startEditing(rowNum,colNum,true)
                                 return false;
                             }
                            return true;

                         }*/

                    },
                ]
            });
            const w = isc.Window.create({
                title: "توزین‌ها",
                width: window.innerWidth,
                height: 580,
                autoSize: true,
                autoCenter: true,
                isModal: true,
                showModalMask: true,
                align: "center",
                autoDraw: false,
                dismissOnEscape: true,
                visibility: 'hidden',
                closeClick: function () {
                    this.Super("closeClick", arguments)
                },
                items: [
                    grid_source,
                    // grid_destinetion,
                ]
            })
            return {
                w: w.getID(),
                gs: grid_source.getID(),
            }
        }
    )()
    const packages_button = isc.IButtonSave.create({
        title: "<spring:message code='warehouseStock.bundle'/>",
        width: 100,
        icon: "pieces/16/packages.png",
        orientation: "vertical",
        disabled: true,
        click: function () {
            const w = listGridSetDestTozinHarasatPolompForSelectedTozin['w'];
            window[w].show()
        }
    });
    isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        ID: "Window_BijackOnWayProduct",
        width: 1000,
        // height: 630,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        canDragReposition: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.VLayout.create({
                width: 830,
                // height: 700,
                padding: 10,
                margin: 10,
                members: [
                    DynamicForm_warehouseCAD,
                    // ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT,
                    DynamicForm_warehouseCAD_Desc,
                    isc.HLayout.create({
                        width: "100%",
                        // height:100,
                        align: "center",
                        margin: 10,
                        padding: 20,
                        members:
                            [
                                packages_button,
                                isc.Label.create({
                                    width: 5,
                                }),
                                IButton_warehouseCAD_Save,
                                isc.Label.create({
                                    width: 5,
                                }),
                                isc.IButtonCancel.create({
                                    title: "<spring:message code='global.cancel'/>",
                                    width: 100,
                                    icon: "pieces/16/icon_delete.png",
                                    orientation: "vertical",
                                    click: function () {
                                        isc.Dialog.create({
                                            title: "<spring:message code='global.warning'/>",
                                            message: "<spring:message code='warehouseCad.warning.close'/>",
                                            buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                                            okClick() {
                                                Window_BijackOnWayProduct.close();
                                                this.close();
                                            }
                                        })
                                    }
                                }),

                            ]
                    })
                ]
            })]
    }).show();
    const destinationTozinCriteria = {
        operator: "and",
        criteria: [
            {
                fieldName: "date",
                operator: "greaterOrEqual",
                value: selectedSourceTozins.map(s => s.date).reduce((i, j) => Number(i) <= Number(j) ? i : j)
            },
            {
                fieldName: "tozinId",
                operator: "iStartsWith",
                value: "3-"
            },
            {
                fieldName: "codeKala",
                operator: "equals",
                value: selectedSourceTozins[0]['codeKala']
            },
            {
                fieldName: "sourceId",
                operator: "equals",
                value: selectedSourceTozins[0]['sourceId']
            },
            {
                fieldName: "targetId",
                operator: "equals",
                value: selectedSourceTozins[0]['targetId']
            },

        ]
    }
    const criteria_cathode = {
        _constructor: "AdvancedCriteria", operator: "or",
        criteria: selectedSourceTozins.map(r => {
            return {
                fieldName: "tozinId",
                operator: "equals",
                value: r.tozinId
            }
        })
    };

    Promise.all([
        onWayProductFetch('tozin', 'and', destinationTozinCriteria.criteria),
        onWayProductFetch('tozin/lite', 'and', destinationTozinCriteria.criteria),
    ])
        .then(([tozin, tozinLite]) => {
            if (tozin && tozin.response && tozin.response.data && tozin.response.data.length > 0) {
                const tozinData = tozin.response.data
                // console.log('tozin',tozin);
                const grid = windowDestinationTozinList['g'];
                // const ds = windowDestinationTozinList['ds'];
                window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']]
                    .setValueMap('destTozinId', tozinData.getValueMap('tozinId', 'tozinId'))
                if (tozinLite && tozinLite.response && tozinLite.response.data && tozinLite.response.data.length > 0) {
                    const tozinLiteData = tozinLite.response.data;
                    tozinData.forEach(tz => {
                        try {
                            const fnd = tozinLiteData.find(tzl => tz['tozinId'] === tzl['tozinId']);
                            tz['driverName'] = fnd['driverName']
                        } catch (e) {
                            tz['driverName'] = ''
                        }
                    })
                }
                console.log(grid, 'all available dest')
                window[grid].setData(tozinData);
            }
        })
    Promise.all([
        onWayProductFetch('tozin', 'or', ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords()
            .map(tz => {
                return {fieldName: 'tozinId', operator: 'equals', value: tz['tozinId']}
            })),
        onWayProductFetch('cathodList', 'or', criteria_cathode.criteria)
    ]).then(([tozin, tozinPackagesData]) => {
        // console.log('tozin, tozinPackagesData', tozin, tozinPackagesData)
        if (tozin && tozin.response && tozin.response.data) {
            const grid_string = listGridSetDestTozinHarasatPolompForSelectedTozin['gs'];
            const grid = window[grid_string];
            const selected_records = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords();
            const tzn_data = tozin.response.data;
            const packageSample = {
                uid: giveMeAName(),
                label: giveMeAName(),
                productId: null,
                wazn: 0,
                tedad: 1,
                description: '',
            }
            const selectedTozinList = tzn_data.map(tzn => {
                tzn['driverName'] = selected_records.find(r => r['tozinId'] === tzn['tozinId'])['driverName'];
                const pkg_tmp = {...packageSample};
                pkg_tmp.tedad = !isNaN(tzn['tedad']) ? tzn['tedad'] : 1;
                pkg_tmp.wazn = tzn['vazn'];
                const uid = giveMeAName();
                pkg_tmp.uid = uid;
                pkg_tmp.label = uid;
                tzn['packages'] = [pkg_tmp];
                tzn['tedad_source'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                tzn['tedad_destination'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                tzn['pkgNum_source'] = 0;
                tzn['pkgNum_destination'] = 0;
                return tzn;
            })
            // console.log('selectedTozinList',selectedTozinList)
            grid.setData(selectedTozinList)
            if (tozinPackagesData && tozinPackagesData.response && tozinPackagesData.response.data && tozinPackagesData.response.data.length > 0) {
                const pkgs = tozinPackagesData.response.data;
                const totalSheetNumber = pkgs.map(d => d.sheetNumber).reduce((i, j) => i + j);
                // ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData(pkgs);
                DynamicForm_warehouseCAD.setValue("sourceSheetSum", totalSheetNumber);

                // const selectedTozinList = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords();
                const updatedSelectedTozinList = selectedTozinList.map(
                    tz => {
                        const pkg_update = {
                            tedad_source: null,
                            tedad_destination: null,
                            pkgNum_source: 0,
                            pkgNum_destination: 0,
                        }
                        const packages = pkgs.filter(pkg => pkg['tozinId'] === tz['tozinId'])
                        // console.log('packages', packages)
                        if (packages.length > 0) {
                            pkg_update['tedad_source'] = packages.map(p => Number(p.sheetNumber)).reduce((i, j) => i + j);
                            pkg_update['tedad_destination'] = packages.map(p => Number(p.sheetNumber)).reduce((i, j) => i + j);
                            pkg_update['pkgNum_source'] = packages.length;
                            pkg_update['pkgNum_destination'] = packages.length;
                            const updated_packages = packages.map(p => {
                                return {
                                    label: p['productLabel'],
                                    productId: p['productId'],
                                    uid: p['productId'],
                                    wazn: p['wazn'],
                                    tedad: p['sheetNumber']
                                }
                            })
                            tz['packages'] = updated_packages;
                        }
                        return {...pkg_update, ...tz}
                    }
                )
                // console.log('updatedSelectedTozinList', updatedSelectedTozinList, selectedTozinList)
                grid.setData(updatedSelectedTozinList)
            }

        }
        packages_button.enable();
    })
    DynamicForm_warehouseCAD.getItem('warehouseYardId').setOptionDataSource(RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT)
}