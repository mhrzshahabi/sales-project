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

function onWayProductCreateRemittance(criteriaBuildForListGrid) {


    function updateDestinationPackageTedadWeight() {
        function _styler(numberToSet, formItemStr) {
            const sourceNum = isNaN(DynamicForm_warehouseCAD.getValue("source" + formItemStr)) ? 0 :
                Number(DynamicForm_warehouseCAD.getValue("source" + formItemStr))
            const strToSet = ((sourceNum - numberToSet > 0) ? '<span style="color:red">' + numberToSet.toString() + "</span>" : numberToSet.toString());
            DynamicForm_warehouseCAD.setValue('destination' + formItemStr, strToSet);
        }

        const grid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
        console.log('listGridSetDestTozinHarasatPolompForSelectedTozin', grid);
        const sums = {
            totalPkg: 0,
            tedad: 0,
            vazn: 0
        }
        grid.getData().forEach(
            d => {
                if (d['destTozin']) sums['vazn'] += d['destTozin']['vazn'];
                const pkgs = d['packages'];
                if (pkgs && pkgs.length > 0) {
                    sums['totalPkg'] += pkgs.length;
                    sums['tedad'] += pkgs.map(p => Number(p['tedad'])).reduce((i, j) => i + j);
                }

            }
        )
        _styler(sums['vazn'] + " " + sums['vazn'].toPersianLetter(), "Weight");
        _styler(sums['tedad'], "SheetSum");
        _styler(sums['totalPkg'], "BundleSum");
        // DynamicForm_warehouseCAD.setValue('destinationWeight', ('<span style="color:red">' + sums['vazn']).toString() + "</span>");
        // DynamicForm_warehouseCAD.setValue('destinationSheetSum', sums['tedad']);
        // DynamicForm_warehouseCAD.setValue('destinationBundleSum', sums['totalPkg']);
    }

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
                name: "code",
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
                name: "depotId",
                width: 300,
                required: true,
                // validators: [{
                //     type: "required",
                //     validateOnChange: true
                // }],
                colSpan: 1,
                titleColSpan: 1,
                showHover: true,
                autoFetchData: false,
                defaultValue: StorageUtil.get('onWayProduct_depotId'),
                title: "<spring:message code='warehouseCad.yard'/>",
                displayField: "name",
                valueField: "id",
                pickListFields: [
                    {name: "store.warehouse.name", title: "انبار"},
                    {name: "store.name", title: "سوله/محوطه"},
                    {name: "name", title: "یارد"}
                ],
                pickListProperties: {
                    width: 300,
                    recordClick(pickList, record) {
                        StorageUtil.save('onWayProduct_depotId', record.id);
                        return this.Super("recordClick", arguments);
                    }
                },

            },
            {
                name: "unit",
                type: "number",
                title: "واحدشمارش بسته کالا(ورق،بشکه،تن،..)",
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
                title: "تعداد بسته(باندل، لات، ... ) ",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationBundleSum",
                title: "تعداد بسته(باندل، لات، ... ) ",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "sourceSheetSum",
                title: "مجموع تعداد واحد(بشکه، ورق، ... ) ",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationSheetSum",
                title: "مجموع تعداد واحد(بشکه، ورق، ... ) ",
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
                name: 'description',
                width: "100%",
                height: 80,
                editorType: "TextAreaItem",
                title: 'شرح بیجک',
                colSpan: 4
            }
        ]
    });
    const IButton_warehouseCAD_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        visibility: "hidden",
        click: function () {
            function dialog(message, okClick = function () {
            }, title = 'اطلاعات ناقص') {
                isc.Dialog.create({
                    title: title,
                    message: message,
                    buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                    okClick() {
                        this.close();
                        if (typeof (okClick) === 'function') okClick();
                    }
                })
            }

            isc.Dialog.create({
                title: "<spring:message code='global.warning'/>",
                message: "<spring:message code='warehouseCad.warning.save'/>",
                buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                okClick() {
                    this.close();
                    if (!DynamicForm_warehouseCAD.validate()) return;
                    const grid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']]
                    const remittanceDetail = grid.getData();
                    const recordWithoutDestTozinId = remittanceDetail.find(d => {
                        if (!d['destTozinId']) {
                            return true
                        }
                        return false
                    })
                    if (recordWithoutDestTozinId) {
                        isc.Dialog.create({
                            title: 'توزین مقصد ناقص',
                            message: 'به‌همه توزین‌های ورودی،توزین خروجی تعریف نشده.',
                            buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                            okClick() {
                                this.close();
                                const rowNum = grid.getRecordIndex(recordWithoutDestTozinId);
                                grid.startEditing(rowNum);
                                window[listGridSetDestTozinHarasatPolompForSelectedTozin['w']].show()
                            }
                        })
                        return;
                    }
                    const withoutPkg = remittanceDetail.find(tz => {
                        if (!tz['packages'] || tz['packages'].length === 0) return true;
                        return false
                    })
                    if (withoutPkg) return dialog('اطلاعات بسته ورودی به درسی ثبت نشده', function () {
                        grid.expandRecord(withoutPkg);
                        window[listGridSetDestTozinHarasatPolompForSelectedTozin['w']].show()
                    })
                    const withoutTedad = remittanceDetail.find(tz => {
                        const pkg = tz['packages'].find(p => {
                            if (!p.tedad || isNaN(p.tedad) || p.tedad < 1) {
                                return true
                            }
                            return false;
                        })
                        if (pkg) return true;
                        return false
                    })
                    if (withoutTedad) return dialog('نعداد بسته عدد بزرگتر از صفر نیست', function () {
                        grid.expandRecord(withoutTedad);
                        window[listGridSetDestTozinHarasatPolompForSelectedTozin['w']].show()
                    })
                    const dataForSave = {
                        remittance: DynamicForm_warehouseCAD.getValues(),
                        remittanceDetails: []
                    };


                    remittanceDetail.forEach(a => {
                        a.packages.forEach(b => {
                            const inventory = {...b, materialItemId: a['codeKala']};
                            const remittanceDetail = {inventory: inventory,}
                            if (!b['description']) remittanceDetail['description'] = null;
                            else {
                                remittanceDetail['description'] = inventory['description'];
                                delete inventory['description'];
                            }
                            remittanceDetail['unitId'] = Number(dataForSave.remittance['unit']);
                            remittanceDetail['amount'] = Number(inventory['tedad']);
                            remittanceDetail['weight'] = Number(inventory['wazn']);
                            remittanceDetail['depotId'] = Number(dataForSave.remittance['depotId']);
                            remittanceDetail['destinationTozin'] = {...a['destTozin']};
                            remittanceDetail['sourceTozin'] = {...a};
                            if (a['railPolompNo']) remittanceDetail['railPolompNo'] = a['railPolompNo'];
                            if (a['securityPolompNo']) remittanceDetail['securityPolompNo'] = a['securityPolompNo'];
                            delete remittanceDetail['sourceTozin']['packages'];
                            delete remittanceDetail['sourceTozin']['destTozin'];
                            delete remittanceDetail['sourceTozin']['destTozinId'];
                            delete inventory['tedad'];
                            delete inventory['wazn'];
                            dataForSave.remittanceDetails.add(remittanceDetail);
                        })
                    })
                    console.log('data for send', dataForSave)
                    fetch('api/remittance-detail/batch', {
                        headers: {...SalesConfigs.httpHeaders, "content-type": "application/json;charset=UTF-8",},
                        method: "POST",
                        body: JSON.stringify(dataForSave)
                    }).then(r => {
                        console.log('saved response', r)
                        if (r.status === 201) {
                            isc.say('عملیات با موفقیت انجام شد', () => {
                                windowRemittance.hide()
                            })
                        } else {

                            isc.say('مشکل در ذخیره اطلاعات. آیا اطلاعات تکرای فرستاده شده؟ شماره بیجک،توزین مبدا، توزین مقصد')

                        }
                        r.json().then(j => console.log('saved json response', j))
                    }).catch(
                        reject => {
                            isc.say('مشکل ارتباط')
                        }
                    ).finally(
                        () => criteriaBuildForListGrid()
                    )
                }
            })

        }
    });
    const packages_button = isc.IButtonSave.create({
        title: "جزئیات آیتم‌ها",
        // width: 100,
        icon: "pieces/16/packages.png",
        orientation: "vertical",
        visibility: "hidden",
        click: function () {
            const w = listGridSetDestTozinHarasatPolompForSelectedTozin['w'];
            window[w].show()
        }
    });
    const windowRemittance = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        // ID: "Window_BijackOnWayProduct",
        width: 1000,
        // height: 630,
        autoSize: true,
        showMinimizeButton: false,
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
                                                windowRemittance.close();
                                                this.close();
                                            }
                                        })
                                    }
                                }),

                            ]
                    })
                ]
            })]
    });
    windowRemittance.show();
    isc.Dialog.create({
        ID: "pls_wait_2",
        showTitle: false,
        message: "لطفا صبر کنید",
    });
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

    const windowDestinationTozinList = (function () {
        const datasource = isc.DataSource.create({
            fields: [...tozinLiteFields]
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
            fields: [...tozinLiteFields],
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
            width: .7 * innerWidth,
            height: 580,
            autoSize: true,
            autoCenter: true,
            showMinimizeButton: false,
            isModal: true,
            showModalMask: true,
            showTitle: false,
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
        const fieldsToHide = ["havalehCode", "targetId", "sourceId", "codeKala", "containerNo3", "containerNo1",];
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
                        width: .8 * innerWidth,
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
                            title: "سریال",
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
                                title: "تعداد (ورق، بشکه، گونی، ...)",
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
                                    return true;
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
            editEvent: 'doubleClick',
            getCellHoverComponent: function (record, rowNum, colNum) {
                const tozinId = grid_source.getFields()[colNum].name === 'destTozinId' ? record['destTozinId'] : record['tozinId']
                if (!tozinId) return false;
                this.rowHoverComponent = isc.DetailViewer.create({
                    dataSource: isc.MyRestDataSource.create({
                        fields: [...tozinFields],
                        fetchDataURL: 'api/tozin/spec-list'
                    }),
                    width: 250
                });

                this.rowHoverComponent.fetchData({
                    criteria: {
                        fieldName: "tozinId",
                        operator: "equals",
                        value: tozinId
                    }
                }, null, {showPrompt: false});

                return this.rowHoverComponent;
            },
            fields: [...windowDestinationTozinList['gc']['fields'].map(c => {
                if (c.name === 'tozinId') {
                    return {
                        name: "tozinId",
                        showHover: true,
                        width: "10%",
                        title: "<spring:message code='Tozin.tozinPlantId'/>",
                        showHoverComponents: true,
                        canEdit: false,
                    }
                }
                if (fieldsToHide.contains(c.name))
                    c['hidden'] = true;
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
                            const title = [...tozinFields].getValueMap('name', 'title')
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
                            return 'شماره توزین مقصد را وارد کنید   ';
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
                            // console.log('updated destination Id', record, grid);
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
                    name: "securityPolompNo",
                    canFilter: false,
                    title: 'شماره پلمپ حراست',
                    editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                        record['securityPolompNo'] = newValue;
                        return true;

                    }

                },
                {
                    name: "railPolompNo",
                    title: 'شماره پلمپ راه‌آهن',
                    canFilter: false,
                    editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                        record['railPolompNo'] = newValue;
                        return true;

                    }

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
            width: .8 * window.innerWidth,
            height: 580,
            autoSize: true,
            autoCenter: true,
            showMinimizeButton: false,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: false,
            showTitle: false,
            dismissOnEscape: true,
            visibility: 'hidden',
            closeClick: function () {
                try {
                    updateDestinationPackageTedadWeight()
                } catch (e) {
                    console.error('updateDestinationPackageTedadWeight() on close', e);
                }
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
    })()

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
            // {
            //     fieldName: "sourceId",
            //     operator: "equals",
            //     value: selectedSourceTozins[0]['sourceId']
            // },
            // {
            //     fieldName: "targetId",
            //     operator: "equals",
            //     value: selectedSourceTozins[0]['targetId']
            // },

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
    [...createdTozinList].filter(c => c.tozinId.startsWith('3')).forEach(c => {
        destinationTozinCriteria.criteria.add({fieldName: "tozinId", operator: "notEqual", value: c.tozinId})
    })
    // Promise.all([
    //     onWayProductFetch('tozin/lite', 'and', destinationTozinCriteria.criteria),
    //     onWayProductFetch('tozin/lite', 'and', destinationTozinCriteria.criteria),
    // ])
    onWayProductFetch('tozin/lite', 'and', destinationTozinCriteria.criteria).then((tozin) => {
            if (tozin && tozin.response && tozin.response.data && tozin.response.data.length > 0) {
                const tozinData = tozin.response.data
                // console.log('tozin',tozin);
                const grid = windowDestinationTozinList['g'];
                // const ds = windowDestinationTozinList['ds'];
                window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']]
                    .setValueMap('destTozinId', tozinData.getValueMap('tozinId', 'tozinId'))
                // if (tozinLite && tozinLite.response && tozinLite.response.data && tozinLite.response.data.length > 0) {
                //     const tozinLiteData = tozinLite.response.data;
                //     tozinData.forEach(tz => {
                //         try {
                //             const fnd = tozinLiteData.find(tzl => tz['tozinId'] === tzl['tozinId']);
                //             tz['driverName'] = fnd['driverName']
                //         } catch (e) {
                //             tz['driverName'] = ''
                //         }
                //     })
                // }
                // console.log(grid, 'all available dest')
                window[grid].setData(tozinData);
            }
            updateDestinationPackageTedadWeight()
            pls_wait_2.destroy()

        }
    )
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
            const vazn = (tzn_data.map(t => t.vazn).reduce((i, j) => j + i)).toString();
            DynamicForm_warehouseCAD.setValue('sourceWeight',
                vazn + " " + vazn.toPersianLetter());
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
                tzn['pkgNum_source'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                tzn['pkgNum_destination'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                tzn['tedad_source'] = 0;
                tzn['tedad_destination'] = 0;

                return tzn;
            })
            // console.log('selectedTozinList',selectedTozinList)
            grid.setData(selectedTozinList)
            DynamicForm_warehouseCAD.setValue('sourceBundleSum', 0)

            if (tozinPackagesData && tozinPackagesData.response && tozinPackagesData.response.data && tozinPackagesData.response.data.length > 0) {
                const pkgs = tozinPackagesData.response.data;
                DynamicForm_warehouseCAD.setValue('sourceBundleSum', pkgs.length);
                let sourceSheetSum = 0;
                try {
                    sourceSheetSum = pkgs.map(p => Number(p['sheetNumber'])).reduce((i, j) => i + j);
                    DynamicForm_warehouseCAD.setValue('sourceSheetSum', sourceSheetSum)
                } catch (e) {
                    console.error('sourceBundleSum', e);
                }
                /*
                * gdsCode: 177
                packingTypeId: 2
                productId: "1-486756"
                productLabel: "1399CSM5869"
                sheetNumber: 18
                storeId: "1-687472"
                tozinId: "1-1682691"
                wazn: 2176
                * */

                // const totalSheetNumber = pkgs.map(d => d.sheetNumber).reduce((i, j) => i + j);
                // // ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData(pkgs);
                // DynamicForm_warehouseCAD.setValue("sourceSheetSum", totalSheetNumber);

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
                            if (tz['packages'] && tz['packages'].length > 0) {
                                const hameshoon = tz['packages'].map(a => {
                                    console.log('aa', a);
                                    return a.tedad
                                }).reduce((i, j) => i + j);
                                // console.log("tzn['packages']", tzn, hameshoon);
                                tz['tedad_source'] = hameshoon;
                                tz['tedad_destination'] = hameshoon;
                            }
                        }
                        return {...pkg_update, ...tz}
                    }
                )
                // console.log('updatedSelectedTozinList', updatedSelectedTozinList, selectedTozinList)
                grid.setData(updatedSelectedTozinList)
            }

        }
        packages_button.show();
        IButton_warehouseCAD_Save.show()
        updateDestinationPackageTedadWeight()
        pls_wait_3.destroy()

    })
    DynamicForm_warehouseCAD.getItem('depotId').setOptionDataSource(RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT)
}