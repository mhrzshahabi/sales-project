// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
function giveMeAName() {
    const random = Math.random().toString().substr(-4);
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
    function updateDestinationPackageTedadWeight() {
        function _styler(numberToSet, formItemStr) {
            const sourceNum = isNaN(DynamicForm_warehouseCAD.getValue("source" + formItemStr)) ? 0 :
                Number(DynamicForm_warehouseCAD.getValue("source" + formItemStr))
            const strToSet = ((sourceNum - numberToSet > 0) ? '<span style="color:red">' + numberToSet.toString() + "</span>" : numberToSet.toString());
            DynamicForm_warehouseCAD.setValue('destination' + formItemStr, strToSet);
        }

        const grid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
        // //console.log('listGridSetDestTozinHarasatPolompForSelectedTozin', grid);
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
        _styler(sums['vazn'] + " " + (languageForm.getValue("languageName") === 'en' ? numberToEnglish(sums['vazn']) : sums['vazn'].toPersianLetter()), "Weight");
        _styler(sums['tedad'], "SheetSum");
        _styler(sums['totalPkg'], "BundleSum");
        // DynamicForm_warehouseCAD.setValue('destinationWeight', ('<span style="color:red">' + sums['vazn']).toString() + "</span>");
        // DynamicForm_warehouseCAD.setValue('destinationSheetSum', sums['tedad']);
        // DynamicForm_warehouseCAD.setValue('destinationBundleSum', sums['totalPkg']);
    }

    let canEditVazTedad = false;
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
                // defaultValue: StorageUtil.get('onWayProduct_depotId'),
                title: "<spring:message code='warehouseCad.yard'/>",
                displayField: "name",
                valueField: "id",
                pickListFields: [
                    {name: "store.warehouse.name", title: "<spring:message code='dailyWarehouse.warehouse'/>"},
                    {name: "store.name", title: "<spring:message code='warehouseCad.store'/>"},
                    {name: "name", title: "<spring:message code='warehouseCad.yard'/>"}
                ],
                pickListProperties: {
                    width: 300,
                    recordClick(pickList, record) {
                        // StorageUtil.save('onWayProduct_depotId', record.id);
                        const depotName = record.store.warehouse.name + " " + record.store.name + " " + record.name;
                        DynamicForm_warehouseCAD.setValue('depotName', depotName)
                        return this.Super("recordClick", arguments);
                    }
                },
                defaultValue: (_ => {
                    const selectedRecord = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord();
                    const defaultValue = StorageUtil.get("defaultDepotForCodeKala" + selectedRecord['codeKala'].toString()
                        + "AndSource" + selectedRecord['sourceId'].toString());
                    return defaultValue ? defaultValue : null
                })(),
                editorExit(form, item, value) {
                    const selectedRecord = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord();
                    StorageUtil.save("defaultDepotForCodeKala" + selectedRecord['codeKala'].toString()
                        + "AndSource" + selectedRecord['sourceId'].toString(), value)
                    return true;
                }

            },
            {
                name: "unit",
                type: "number",
                required: true,
                title: "<spring:message code='unit.count.package'/>",
                valueMap: SalesBaseParameters.getSavedUnitParameter().filter(u => u.categoryUnit.toLowerCase() === EnumCategoryUnit.string.Weight.toLowerCase()).getValueMap('id', 'name'),
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
                name: "depotName",
                type: "staticText",
                title: '<spring:message code="person.fullName"/> <spring:message code="warehouseCad.yard"/>',
                colSpan: 4,
                shouldSaveValue: false,
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
                type: "staticText",
                name: "s_driver",
                title: "<b><spring:message code='Tozin.driver'/></b>",
                wrapTitle: false,
                width: 90,
                defaultValue: ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().driverName
            },
            {
                type: "staticText",
                name: "d_driver",
                title: "<b><spring:message code='Tozin.driver'/></b>",
                wrapTitle: false,
                width: 90,
            },
            {
                type: "staticText",
                name: "s_plak",
                title: "<b><spring:message code='Tozin.plak.container'/></b>",
                wrapTitle: false,
                width: 90,
                defaultValue: ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().plak
            },

            {
                type: "staticText",
                name: "d_plak",
                title: "<b><spring:message code='Tozin.plak.container'/></b>",
                wrapTitle: false,
                width: 90,
            },


            {
                name: "sourceBundleSum",
                title: "<spring:message code='Tozin.tedad.packages'/>",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationBundleSum",
                title: "<spring:message code='Tozin.tedad.packages'/>",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "sourceSheetSum",
                title: "<spring:message code='Tozin.tedad.all'/>",
                colSpan: 1,
                titleColSpan: 1,
                type: "staticText",
            },
            {
                name: "destinationSheetSum",
                title: "<spring:message code='Tozin.tedad.all'/>",
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
                title: "<spring:message code='remittance.description'/>",
                colSpan: 4
            }
        ]
    });
    const IButton_warehouseCAD_Save = isc.IButtonSave.create({
            top: 260,
            visibility: "hidden",
            click: function () {
                function dialog(message, okClick = function () {
                }, title = "<spring:message code='incoterm.exception.required-info'/>",) {
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
                                title: "<spring:message code='Tozin.destination.tozin.problem'/>",
                                message: "<spring:message code='Tozin.destination.target.tozin.not.found'/>",
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
                        if (withoutPkg) return dialog("<spring:message code='Tozin.package.not.found'/>", function () {
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
                            if (pkg) {
                                // //console.log(tz)
                                if (tz.codeKala === 8 && DynamicForm_warehouseCAD.getValues().unit !== 3) return false;
                                return true;
                            }
                            return false
                        })
                        const withoutLabel = remittanceDetail.find(tz => {

                            const pkg = tz['packages'].find(p => {
                                if (!p.label) {
                                    return true
                                }
                                return false;
                            })
                            return pkg;
                        })

                        if (withoutTedad) return dialog("<spring:message code='Tozin.package.bigger.zero'/>",
                            function () {
                                grid.expandRecord(withoutTedad);
                                window[listGridSetDestTozinHarasatPolompForSelectedTozin['w']].show()
                            })

                        if (withoutLabel) return dialog("<spring:message code='Tozin.inventory.label.not.saved'/>",
                            function () {
                                grid.expandRecord(withoutLabel);
                                window[listGridSetDestTozinHarasatPolompForSelectedTozin['w']].show()
                            })

                        /**@type {InRemittance}****/
                        const dataForSave = {
                            remittance: DynamicForm_warehouseCAD.getValues(),
                            remittanceDetails: []
                        };
                        if (!dataForSave.remittance.description)
                            dataForSave.remittance.description = ' ';
                        if (modifiedPackages.add > 0)
                            dataForSave.remittance.description += " ??????????" +
                                modifiedPackages.add.toString() +
                                " ???????? ???????? ???? ????????????????? ???????????? ?????????? ???? "
                        if (modifiedPackages.remove > 0)
                            dataForSave.remittance.description += " ??????????" +
                                modifiedPackages.remove.toString() +
                                " ???????? ???????? ???? ????????????????? ???????????? ??????  ???? "


                        remittanceDetail.forEach(a => {
                            a.packages.forEach(b => {
                                const inventory = {...b, materialItemId: a['codeKala']};
                                /**@type {RemittanceDetail} remittanceDetail***/
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
                        // //console.log('data for send', dataForSave)
                        const cathodeTozin = {}
                        dataForSave.remittanceDetails
                            .filter(r =>/**@type {RemittanceDetail}*/ r.inventory.materialItemId === 8
                            ).forEach(r => {
                                if (!Object.keys(cathodeTozin).includes(r.destinationTozin.tozinId))
                                    cathodeTozin[r.destinationTozin.tozinId] = []
                                cathodeTozin[r.destinationTozin.tozinId].add(r)
                            }
                        )
                        const remittanceDetailNeedToChange = Object.keys(cathodeTozin).filter(r => cathodeTozin[r].length === 1)
                            .map(r => cathodeTozin[r])
                        const remittanceDetailDoesNotNeedToChange = dataForSave.remittanceDetails.filter(r => {
                            const tozin = r.destinationTozin
                            return tozin.codeKala !== 8 ||
                                !Object.keys(cathodeTozin).filter(r => cathodeTozin[r].length === 1).includes(tozin.tozinId)
                        })

                        /**@param {RemittanceDetail} remittanceDetail***/
                        function sliceCathodeRemittanceDetail(remittanceDetail) {
                            /**
                             * @param {number} _weight**
                             * @param {number} _number**
                             * @param {Object}_pkg_sum
                             * @param {RemittanceDetail[]} _array**/
                            function weight_number(_weight, _number, _array, _pkg_sum) {
                                if (isNaN(_number)) return
                                const amount_all = remittanceDetail.amount
                                let first_amount = 1
                                let amount = 1
                                if (amount_all > 1 && _weight === 10000) {
                                    dbg(arguments)
                                    const _all_amount = amount_all + _number - _pkg_sum._sum
                                    amount = Math.floor(_all_amount / _number)
                                    const remained_amount = _all_amount - (amount * _number)
                                    first_amount = amount + remained_amount
                                }
                                for (let i = 0; i < _number; i++) {

                                    /**@type {RemittanceDetail} rd*/
                                    const rd = {
                                        sourceTozin: sourceTozin,
                                        destinationTozin: destinationTozin,
                                        inventory: {label: giveMeAName(), materialItemId: 8},
                                        unitId: remittanceDetail.unitId,
                                        weight: _weight,
                                        amount: _weight !== 10000 ? amount : i !== 0 ? amount : first_amount
                                    }
                                    _array.add(rd)
                                }
                            }

                            const weight = remittanceDetail.destinationTozin.vazn
                            const sourceTozin = remittanceDetail.sourceTozin;
                            const destinationTozin = remittanceDetail.destinationTozin;
                            const pkg_10t = Math.floor(weight / 10000)
                            const pkg_2t = Math.floor((weight % 10000) / 2000)
                            const pkg_500k = Math.floor((weight % 2000) / 500)
                            const under_500k = weight % 500
                            const pkg_sum = {
                                _sum: 0,
                                pkg: [],
                            }
                            const j=pkg_sum.pkg
                            if (!isNaN(under_500k)) {
                                pkg_sum._sum += 1;
                                j.add('under_500k')
                            }
                            if (!isNaN(pkg_10t)) {
                                pkg_sum._sum += pkg_10t;
                                j.add('pkg_10t')
                            }
                            if (!isNaN(pkg_2t)) {
                                pkg_sum._sum += pkg_2t;
                                j.add('pkg_2t')
                            }
                            if (!isNaN(pkg_500k)) {
                                pkg_sum._sum += pkg_500k;
                                j.add('pkg_500k')
                            }
                            weight_number(10000, pkg_10t, remittanceDetailDoesNotNeedToChange, pkg_sum)
                            weight_number(2000, pkg_2t, remittanceDetailDoesNotNeedToChange, pkg_sum)
                            weight_number(500, pkg_500k, remittanceDetailDoesNotNeedToChange, pkg_sum)
                            weight_number(under_500k, 1, remittanceDetailDoesNotNeedToChange, pkg_sum)

                        }

                        remittanceDetailNeedToChange
                            .forEach(_remittanceDetail => sliceCathodeRemittanceDetail(_remittanceDetail[0]))
                        dataForSave.remittanceDetails = remittanceDetailDoesNotNeedToChange
                        fetch('api/remittance-detail/batch',
                            {
                                headers: {
                                    ...
                                        SalesConfigs.httpHeaders, "content-type":
                                        "application/json;charset=UTF-8",
                                }
                                ,
                                method: "POST",
                                body: JSON.stringify(dataForSave)
                            }
                        ).then(r => {
                            //console.log('saved response', r)
                            if (r.status === 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>",
                                    () => {
                                        windowRemittance.hide();
                                        ListGrid_Tozin_IN_ONWAYPRODUCT.invalidateCache();
                                    })
                            } else {
                                r.json().then(
                                    j =>
                                        isc.warn("<spring:message code='Tozin.error.message'/>", +
                                                '\n' +
                                            JSON.stringify(j)
                                        )
                                )


                            }
                            r.json().then(j => {
                            })////console.log('saved json response', j)

                        }).catch(
                            reject => {
                                isc.say("<spring:message code='global.form.response.error'/>")
                            }
                        ).finally(
                            // () => criteriaBuildForListGrid()
                        )
                    }
                })

            }
        })
    ;
    const packages_button = isc.IButtonSave.create({
        title: "<spring:message code='Tozin.package.details'/>",
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
        // canDragReposition: false,
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
                                    width: 100,
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
        message: "<spring:message code='global.please.wait'/>",
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

// //console.log(source, 'source')
    DynamicForm_warehouseCAD.setValue("plant", source['name']);

    DynamicForm_warehouseCAD.setValue("warehouseNo", target['name']);

    DynamicForm_warehouseCAD.setValue("sourceTozinPlantId", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tozinId);

    DynamicForm_warehouseCAD.setValue("containerNo", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().containerId);
    const modifiedPackages = {
        add: 0, remove: 0
    }
    const windowDestinationTozinList = (function () {
        const datasource = isc.DataSource.create({
            fields: [...tozinLiteFields()]
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
            fields: [...tozinLiteFields()],
        };
        const extraGridConfigs = {
            recordDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                const grid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
                const sourceTozinId = grid.getSelectedRecord()['tozinId'];
                const gridData = grid.getData();
                gridData.find((d, i) => {
                    if (d['tozinId'] === sourceTozinId) {
                        grid.setEditValue(i, 'destTozinId', record['tozinId'])
                        // //console.log('found selected record in listGridSetDestTozinHarasatPolompForSelectedTozin ',d,record)
                    }
                    return d['tozinId'] === sourceTozinId;
                })
                // //console.log('found selected record in listGridSetDestTozinHarasatPolompForSelectedTozin ',gridData)
                // grid.setData(gridData)
                win.hide();
            }
        }
        const grid = isc.ListGrid.create({
            ...extraGridConfigs, ...gridConfigs,
            showRowNumbers: true,
        });
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
        ////console.log(returnVar);
        return returnVar;
    })()
    const listGridSetDestTozinHarasatPolompForSelectedTozin = (function () {

        const fieldsToHide = ["havalehCode", "targetId", "sourceId", "codeKala", "containerNo3", "containerNo1",];
        const grid_source = isc.ListGrid.create({
            ...windowDestinationTozinList['gc'],
            ...{
                alternateRecordStyles: true, showRowNumbers: true,

                expansionFieldImageShowSelected: true,
                canExpandRecords: true,
                canExpandMultipleRecords: false,
                getExpansionComponent: function (record, rowNum, colNum) {
                    function updateRecord(key, value, pkgRec) {
                        // debugger;
                        const recordPkgs = record['packages'];
                        recordPkgs.find(p => p.uid === pkgRec.uid)[key] = value;
                        const ggrid = window[listGridSetDestTozinHarasatPolompForSelectedTozin['gs']];
                        const rowNum = ggrid.getRecordIndex(record);
                        // //console.log(rowNum,'pkgNum_destination',
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
                        showRowNumbers: true,
                        canEdit: true,
                        editEvent: "click",
                        editByCell: true,
                        // <sec:authorize access="hasAuthority('D_E_REMITTANCE_DETAIL')">
                        canRemoveRecords: true,
                        deferRemoval: false,
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
                                        modifiedPackages.remove = modifiedPackages.remove + 1;
                                        ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.data.remove(record);
                                    }

                                }
                            });

                        },
                        // </sec:authorize>
                        autoSaveEdits: false,
                        saveLocally: true,
                        showGridSummary: true,
                        // visibility: 'hidden',
                        // gridComponents: ["header", "body",  ],
                        fields: [{
                            name: "label",
                            title: "<spring:message code='invoice.shomarehSoratHesab'/>",
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
                                // canEdit:canEditVazTedad,
                                title: "<spring:message code='Tozin.tedad.all'/>",
                                width: "20%",
                                validators: [{
                                    type: "regexp",
                                    expression: "^[0-9]*$",
                                    validateOnChange: true
                                }],
                                summaryFunction: "sum",
                                editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                    // record['packages'].find(p => p.uid === recordg.uid)['tedad'] = Number(newValue)
                                    if (newValue) {
                                        updateRecord('tedad', newValue, recordg);
                                        // const _tedadString = 'remitance_inventory_default_tedad_' + record.codeKala.toString()
                                        //     + '_' +
                                        //     record.sourceId.toString();
                                        // StorageUtil.save(_tedadString,Number(newValue))
                                    }
                                    return true;
                                },
                                editorProperties: {
                                    keyPressFilter: "[0-9]",
                                },
                            },
                            {
                                name: "wazn",
                                canEdit: canEditVazTedad,
                                headerTitle: "<spring:message code='warehouseCadItem.weightKg'/>",
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
                                summaryFunction: function (records, field) {
                                    const prefix = "<spring:message code='billOfLanding.total.net.weight' /> " +
                                        "<spring:message code='invoice.shomarehSoratHesab' />: ";
                                    if (!records || records.length === 0) return prefix + "0";
                                    try {
                                        return prefix + records.map(record => Number(record[field.name])).reduce((_1, _2) => _1 + _2)
                                    } catch (e) {
                                        return 0
                                    }
                                }
                            },
                            {
                                name: "description",
                                title: "<spring:message code='warehouseCadItem.description'/>",
                                width: "25%",
                                editorExit(editCompletionEvent, recordg, newValue, rowNum, colNum, grid) {
                                    record['packages'].find(p => p.uid === recordg.uid)['description'] = newValue
                                },
                            }],
                    });
                    const add_bundle_button = isc.IButton.create({
                        title: "<spring:message code='warehouseCad.addBundle'/>",
                        visibility: "hidden",
                        // <sec:authorize access="hasAuthority('C_E_REMITTANCE_DETAIL')">
                        visibility: "visible",
                        // </sec:authorize>

                        // width: 150,
                        click: () => {
                            // const grid_source = listGridSetDestTozinHarasatPolompForSelectedTozin['gs'];
                            // const grid = window[grid_source];
                            const gridData = record.packages;
                            const uid = giveMeAName();
                            gridData.add({
                                label: uid,
                                productId: null,
                                tedad: 34,
                                uid: uid,
                                wazn: 1
                            });
                            modifiedPackages.add = modifiedPackages.add + 1;
                            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getField('wazn').canEdit = true;

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
                        fields: [...tozinFields().filter(_ => [
                            "source",
                            "nameKala",
                            "target",
                            "carName",
                            "containerId",
                            "containerName",
                            "vazn",
                            // "vazn1",
                            // "vazn2",
                            "tedad",
                            "packName",
                            "haveCode",
                            "tozinDate",
                            "havalehName",
                            "ctrlDescOut",
                            "tznSharh2",
                            "strSharh2",
                            "tznSharh1",
                        ].includes(_.name))].reverse(),
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
                    title: '<spring:message code="Tozin.package.tozin.number.source"/>',
                    canEdit: false
                },
                {
                    name: "tedad_source",
                    canFilter: false,
                    title: '<spring:message code="Tozin.unit.tozin.number.target.source"/>',
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
                    title: '<spring:message code="Tozin.package.tozin.number.target"/>',
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
                    title: '<spring:message code="Tozin.unit.tozin.number.target"/>',
                    canEdit: false
                },
                {
                    name: "destTozinId", showHoverComponents: true,
                    showHover: true,
                    hoverHTML(record, value, rowNum, colNum, grid) {
                        // //console.log('hover html', arguments)
                        try {
                            const title = [...tozinFields()].getValueMap('name', 'title')
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
                                    // //console.log('end rows', rows)

                                    return startRow + rows + endRow;
                                }).join('\n') + '</table>';
                            return tbl;
                        } catch (e) {
                            //console.debug('destination tozin id hover error', e);
                            return '<spring:message code="Tozin.enter.tozin.number"/>';
                        }
                    },
                    title: '<spring:message code="Tozin.target.tozin"/>',
                    canFilter: false,
                    required: true,
                    editorType: "comboBox",
                    // formatCellValue(value, record, rowNum, colNum, grid) {
                    //     if (!record['destTozin']) return grid.Super("formatCellValue",arguments)
                    //     dbg(true,record)
                    //     return record['destTozin']['wazn'];
                    // },
                    editorProperties: {
                        addUnknownValues: false,
                        // allowEmptyValue:false,
                        textMatchStyle: "substring",
                        icons: [{
                            src: "pieces/16/icon_add.png",
                            click() {
                                window[windowDestinationTozinList['w']].show()
                                if (grid_source.getSelectedRecord().plak)
                                    window[windowDestinationTozinList['g']].setFilterEditorCriteria({
                                        fieldName: 'plak',
                                        operator: "contains",
                                        value: grid_source.getSelectedRecord().plak
                                    })
                            }
                        }]
                    },
                    editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                        if (!newValue) return true;
                        const grid_available_tozins_string = windowDestinationTozinList['g'];
                        const grid_available_tozins = window[grid_available_tozins_string];
                        const destTozin = grid_available_tozins.getData().find(g => g['tozinId'] === newValue);
                        if (newValue !== undefined && newValue !== null && newValue !== '' && destTozin) {
                            record['destTozin'] = destTozin;
                            DynamicForm_warehouseCAD.setValue("d_plak", destTozin.plak);
                            DynamicForm_warehouseCAD.setValue("d_d_driver", destTozin.driverName);
                            // //console.log('updated destination Id', record, grid);
                            record['destTozinId'] = newValue;
                            return true
                        } else {
                            isc.warn('<spring:message code="Tozin.id.wrong"/>');
                            // grid.startEditing(rowNum,colNum,true)
                            return false;
                        }
                    }
                    // valueMap: window[windowDestinationTozinList['g']].getData().getValueMap('tozinId', 'tozinId')
                },
                {
                    name: 'destTozin.vazn',
                    canEdit: false,
                    headerTitle: "<spring:message code='warehouseCad.destinationWeight'/>"
                },
                {
                    name: "securityPolompNo",
                    canFilter: false,
                    title: '<spring:message code="warehouseCad.herasatPolompNo"/>',
                    editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                        record['securityPolompNo'] = newValue;
                        return true;

                    }

                },
                {
                    name: "railPolompNo",
                    title: '<spring:message code="warehouseCad.rahahanPolompNo"/>',
                    canFilter: false,
                    editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                        record['railPolompNo'] = newValue;
                        return true;

                    }

                    /* editorExit (editCompletionEvent, record, newValue, rowNum, colNum, grid){
                         if(newValue===undefined || newValue === null || newValue === ''){
                             isc.warn('<spring:message code='global.number'/> <spring:message code='warehouseCad.herasatPolompNo'/> ???????? ???????????????');
                             // grid.startEditing(rowNum,colNum,true)
                             return false;
                         }
                        return true;

                     }*/

                },
            ]
        });
        const w = isc.Window.create({
            title: "<spring:message code='dailyWarehouse.tozins'/>",
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
                    //console.debug('updateDestinationPackageTedadWeight() on close', e);
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
            {
                fieldName: "tozinTable",
                operator: "isNull",
            },
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
            if (tozin && tozin.response && tozin.response.data && tozin.response.data.length === 0) {
                isc.warn('<spring:message code="Tozin.no.tozin"/>', _ => {
                    windowRemittance.destroy();
                })

            }
            if (tozin && tozin.response && tozin.response.data && tozin.response.data.length > 0) {
                const tozinData = tozin.response.data
                // //console.log('tozin',tozin);
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
                // //console.log(grid, 'all available dest')
                window[grid].setData(tozinData);
            }
            // updateDestinationPackageTedadWeight()
            pls_wait_2.destroy()

        }
    )
    const pls_wait_3 = isc.Dialog.create({
        showTitle: false,
        message: "<spring:message code='global.please.wait'/>",
    });
    Promise.all([
        onWayProductFetch('tozin', 'or', ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords()
            .map(tz => {
                return {fieldName: 'tozinId', operator: 'equals', value: tz['tozinId']}
            })),
        onWayProductFetch('cathodList', 'or', criteria_cathode.criteria)
    ]).then(([tozin, tozinPackagesData]) => {
        // //console.log('tozin, tozinPackagesData', tozin, tozinPackagesData)
        if (tozin && tozin.response && tozin.response.data) {
            const grid_string = listGridSetDestTozinHarasatPolompForSelectedTozin['gs'];
            const grid = window[grid_string];
            const selected_records = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords();
            const tzn_data = tozin.response.data;
            const vazn = (tzn_data.map(t => t.vazn).reduce((i, j) => j + i)).toString();
            DynamicForm_warehouseCAD.setValue('sourceWeight',
                vazn + " " + (languageForm.getValue("languageName") === 'en' ? numberToEnglish(vazn) : vazn.toPersianLetter()));
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
                tzn['pkgNum_source'] = 0;
                tzn['pkgNum_destination'] = 0;
                tzn['tedad_source'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                tzn['tedad_destination'] = !isNaN(tzn['tedad']) ? tzn['tedad'] : 0;
                if (tzn.codeKala === 11 && !isNaN(tzn['tedad']) && Number(tzn['tedad']) > 1) {
                    DynamicForm_warehouseCAD.setValue("sourceBundleSum", tzn["tedad"])
                    canEditVazTedad = true;
                    const _packages = [];
                    //dbg(true,tzn)
                    const _tedadString = 'remitance_inventory_default_tedad_' + tzn.codeKala.toString()
                        + '_' +
                        tzn.sourceId.toString();
                    let _tedad = 34;//StorageUtil.get(_tedadString);
                    if (!_tedad || Number(_tedad) < 3)
                        _tedad = 18
                    const _vazn = 1;//Number(tzn['vazn'])/Number(tzn['tedad']);

                    Array.from({length: Number(tzn['tedad'])}, (_, i) => {
                        _packages.add({
                            uid: giveMeAName(),
                            label: giveMeAName(),
                            productId: null,
                            wazn: _vazn,
                            tedad: _tedad,
                            description: '',
                        })
                    })
                    tzn['packages'] = _packages;
                }


                return tzn;
            })
            //dbg(true,selectedTozinList)
            // //console.log('selectedTozinList',selectedTozinList)
            grid.setData(selectedTozinList)
            DynamicForm_warehouseCAD.setValue('sourceBundleSum', 0)
            //dbg(true, selectedTozinList)
            const tedadList = selectedTozinList.filter(tzn => tzn['tedad'] && !isNaN(tzn['tedad']) && tzn['codeKala'] === 11)
                .map(tzn => Number(tzn['tedad']));
            const boshkehList = selectedTozinList.filter(tzn => tzn['tedad'] && !isNaN(tzn['tedad']) && tzn['codeKala'] === 97)
                .map(tzn => Number(tzn['tedad']));

            const __sourceBundleSum = tedadList.length > 0 ? tedadList.reduce((_1, _2) => _1 + _2) : 0;
            const __sourceBoshkehSum = boshkehList.length > 0 ? boshkehList.reduce((_1, _2) => _1 + _2) : 0;
            if (__sourceBundleSum && !isNaN(__sourceBundleSum) && __sourceBundleSum > 0)
                DynamicForm_warehouseCAD.setValue("sourceBundleSum", __sourceBundleSum)
            if (__sourceBoshkehSum && !isNaN(__sourceBoshkehSum) && __sourceBoshkehSum > 0)
                DynamicForm_warehouseCAD.setValue("sourceSheetSum", __sourceBoshkehSum)


            if (tozinPackagesData && tozinPackagesData.response && tozinPackagesData.response.data && tozinPackagesData.response.data.length > 0) {
                canEditVazTedad = false;
                const pkgs = tozinPackagesData.response.data;
                DynamicForm_warehouseCAD.setValue('sourceBundleSum', pkgs.length);
                let sourceSheetSum = 0;
                try {
                    sourceSheetSum = pkgs.map(p => Number(p['sheetNumber'])).reduce((i, j) => i + j);
                    DynamicForm_warehouseCAD.setValue('sourceSheetSum', sourceSheetSum)
                } catch (e) {
                    //console.debug('sourceBundleSum', e);
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
                        // //console.log('packages', packages)
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
                                    tedad: p['sheetNumber'] * 2
                                }
                            })
                            tz['packages'] = updated_packages;
                            if (tz['packages'] && tz['packages'].length > 0) {
                                const hameshoon = tz['packages'].map(a => {
                                    return a.tedad
                                }).reduce((i, j) => i + j);
                                // //console.log("tzn['packages']", tzn, hameshoon);
                                tz['tedad_source'] = hameshoon;
                                tz['tedad_destination'] = hameshoon;
                            }
                        }
                        tz['pkgNum_source'] = packages.length;
                        tz['pkgNum_destination'] = packages.length;
                        return {...pkg_update, ...tz}
                    }
                )
                // //console.log('updatedSelectedTozinList', updatedSelectedTozinList, selectedTozinList)
                grid.setData(updatedSelectedTozinList)
            }
            if (tozinPackagesData && tozinPackagesData.response) {
            }

        }
        packages_button.show();
        IButton_warehouseCAD_Save.show()
        // updateDestinationPackageTedadWeight()
        pls_wait_3.destroy();

    })


    DynamicForm_warehouseCAD.getItem('depotId').setOptionDataSource(RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT)
    const __material = SalesBaseParameters.getSavedMaterialItemParameter().find(materialItem => materialItem.id === selectedSourceTozins[0].codeKala);
    const __source = SalesBaseParameters.getSavedWarehouseParameter().find(warehouse => warehouse.id === selectedSourceTozins[0].sourceId);
    let remittanceCode = "i-" + __material.shortName ? __material.shortName : __material.id.toString();
    remittanceCode += __source.shortName ? __source.shortName : __source.id.toString();
    remittanceCode += selectedSourceTozins[0].isRail ? "RAIL" : "ROAD";
    remittanceCode += new Date().toLocaleString('fa', {
        numberingSystem: 'latn',
        month: "2-digit",
        day: '2-digit',
        year: 'numeric'
    })
        .replaceAll("/", "");
    fetch('api/remittance/spec-list?_startRow=0&_endRow=1&_sortBy=-id', {headers: SalesConfigs.httpHeaders})
        .then(res => {
            res.json().then(
                _json => {
                    remittanceCode += (++_json.response.data.pop().id).toString();
                    DynamicForm_warehouseCAD.setValue('code', remittanceCode
                    )
                }
            )
        })

    DynamicForm_warehouseCAD.setValue('code', 'i-' + selectedSourceTozins[0].codeKala
        + '-'
        + selectedSourceTozins.length
        + '-'
        + selectedSourceTozins[0].tozinId.toString()
        + '-'
        + selectedSourceTozins[0].date.toString())


}