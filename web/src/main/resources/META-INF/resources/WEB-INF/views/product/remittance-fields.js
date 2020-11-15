//<%@ page contentType="text/html;charset=UTF-8" %>
//  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
// <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
if(!getRemittanceFields)
function getRemittanceFields(objTab) {
    objTab.Methods.setPackingContainerCriteria=function(){
        const shipmentId = objTab.DynamicForms.Forms.OutRemittance.getValue("shipmentId");
        if(!shipmentId)return;
        const packingContainerField = objTab.DynamicForms.Forms.OutRemittance.getField('packingContainerId');
        packingContainerField.enable();
        packingContainerField.setOptionCriteria({
            operator:"and",
            criteria:[
                {fieldName:"packingList.shipmentId",operator:"equals",value:shipmentId},
            ]
        })
    }
    objTab.Fields.PackingContainer=function (){return [
        {name: "id", editorProperties:{validateOnExit:true,}, type:"number", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "containerNo", summaryFunction:"count", editorProperties:{validateOnExit:true,}, type:"text", showHover: true,
            title: "<spring:message code ='warehouseCad.containerNo'/>"},
        {
            name: "packingList.bookingNo",title: "<spring:message code='shipment.bookingCat'/>",
        },
        {
            name: "packingList.shipment.automationLetterDate",canFilter:false,
            hidden:true,
            title: "<spring:message code='shipment.bDate'/>",
            formatCellValue(value, record, rowNum, colNum) {              if(!value)return null;
                return new persianDate(value).format('YYYYMMDD')},
        },
        {
            name: "packingList.shipment.automationLetterNo",
            title: "<spring:message code='shipment.loadingLetter'/>",
            type: 'text',
        },
        {name: "packingList.shipment.contractShipment.contract.no",title:"<spring:message code='contact.no'/>"},
        {name: "packingList.shipment.material.descFA",title:"<spring:message code='goods.title'/>",
            hidden:true,

        },
        {name:"description",title:"<spring:message code='shipment.description'/>"
        ,            hidden:true,

        },
        {name: "sealNo", editorProperties:{validateOnExit:true,}
            ,            hidden:true,

        type:"text",            hidden:true,
            showHover: true, title: "<spring:message code ='billOfLanding.seal.no'/>"},
        {name: "ladingDate", editorProperties:{validateOnExit:true,}, type:"number", showHover: true,formatCellValue(value, record, rowNum, colNum) {
                if(value) return value.toString();
                return null
            },
            showFilterEditor:false,
            title: "<spring:message code ='global.date'/> <spring:message code ='vesselAssignment.title'/>"},
        {name: "packageCount", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true,
            title: "<spring:message code ='Tozin.tedad.packages'/>"},
        {
            name: "subpackageCount", type:"number",

            showHover: true,
            editorProperties:{validateOnExit:true,},
            title: "<spring:message code ='Tozin.tedad.packages'/>"
        },
        {name: "strapWeight", hidden: true,summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.strapWeight'/>"},
        {name: "palletCount",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true, title: "<spring:message code='packing-container.palletCount'/>"},
        {name: "palletWeight",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.palletWeight'/>"},
        {name: "woodWeight", hidden: true,summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.woodWeight'/>"},
        {name: "barrelWeight",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.barrelWeight'/>"},
        {name: "containerWeight",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number",required:true, showHover: true, title: "<spring:message code='packing-container.containerWeight'/>"},
        {name: "contentWeight",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number",required:true, showHover: true, title: "<spring:message code='packing-container.contentWeight'/>"},
        {name: "vgmWeight", hidden: true,summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true, title: "<spring:message code='packing-container.vgmWeight'/>"},
        {name: "netWeight",hidden: true, summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float",required:true, showHover: true, title: "<spring:message code='packing-container.netWeight'/>"},
        {name: "description",hidden: true, editorProperties:{validateOnExit:true,},type:"text", showHover: true, title: "<spring:message code='packing-container.description'/>"},
    ].map(_=>Object.assign({},_));}
    objTab.Fields.TozinBase = function () {
        return [
            {
                name: "date",
                required: true,
                type: "text",
                filterEditorProperties: {
                    // defaultValue: new persianDate().subtract('d', 14).format('YYYYMMDD'),
                    keyPressFilter: "[0-9/]",
                    parseEditorValue: function (value, record, form, item) {
                        if (value === undefined || value == null || value === '') return value;
                        // return value.replace(/\//g, '').padEnd(8, "01");
                        return value.replaceAll("/", "");
                    },
                    icons: [{
                        src: "pieces/pcal.png",
                        click: function (form, item, icon) {
                            // console.log(form)
                            displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                        }
                    }],
                },
                keyPressFilter: "[0-9/]",
                parseEditorValue: function (value, record, form, item) {
                    if (value === undefined || value == null || value === '') return value;
                    // return value.replace(/\//g, '').padEnd(8, "01");
                    return value.replaceAll("/", "");
                },
                icons: [{
                    src: "pieces/pcal.png",
                    click: function (form, item, icon) {
                        // console.log(form)
                        displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                    }
                }],
                filterOperator: "greaterOrEqual",
                title: "<spring:message code='Tozin.date'/>",
                align: "center",
                formatCellValue(value, record, rowNum, colNum, grid) {
                    try {
                        return (value.substr(0, 4) + "/" + value.substr(4, 2) + "/" + value.substr(-2))
                    } catch (e) {
                        return value
                    }
                },
                validators:[{
                    type:"regexp",
                    expression:"(^[1-9][0-9]{3}((0[1-9])|(1[1-2]))(0[1-9]|[1-2][0-9]|30|31)$)|(^[1-9][0-9]{3}\\/[0-1][0-9]\\/[0-3][0-9]$)"
                }]
            },
            {
                name: "tozinId",
                required: true,
                showHover: true,
                width: "10%",
                title: "<spring:message code='Tozin.tozinPlantId'/>"
            },
            {
                name: "driverName",
                required: true,

                showHover: true,
                width: "10%",
                title: "<spring:message code='Tozin.driver'/>"
            },
            {
                name: "codeKala",
                type: "number",
                // filterEditorProperties: {editorType: "comboBox"},
                valueMap: {
                    11: '<spring:message code="Tozin.export.cathode"/>',
                    8: '<spring:message code="Tozin.copper.concentrate"/>',
                    97: '<spring:message code="invoice.molybdenum"/>'
                },
                title: "<spring:message code='goods.title'/>",
                parseEditorValue: function (value, record, form, item) {
                    StorageUtil.save('on_way_product_defaultCodeKala', value)
                    return value;
                },
                align: "center"
            },
            {
                name: "plak",
                required: true,

                title: "<spring:message code='Tozin.plak.container'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "vazn",
                required: true,
                title: "<spring:message code='Tozin.vazn'/>",
                // align: "center",
                showHover: true,
                // width: "10%"
            },
            {
                name: "sourceId",
                type: "number",
                required: true,
                // filterEditorProperties: {editorType: "comboBox"},
                // parseEditorValue: function (value, record, form, item) {
                //     StorageUtil.save('out_remittance_defaultSourceId', value)
                //     return value;
                // },
                valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                valueMap: {
                    2421: 'ايستگاه قطار تبريز',
                    1540: 'مجتمع مس شهربابك -ميدوك ',
                    1541: 'مجتمع مس سونگون ',
                    1000: 'مجتمع مس سرچشمه',
                    1021: 'مجتمع مس شهربابك - خاتون آباد ',
                    2509: 'شركت هاي خصوصي وتابع ',
                    2555: 'اسكله شهيد رجائي ',
                },
                title: "<spring:message code='Tozin.sourceId'/>",
                // align: "center",
                // changed: function (form, item, value) {
                //     StorageUtil.save('out_remittance_defaultSourceId', value);
                //     // return this.Super('changed', arguments)
                // },
                defaultValue: StorageUtil.get('out_remittance_defaultSourceId')
            },
            {
                name: "targetId",
                type: "number",
                // filterEditorProperties: {
                //     editorType: "comboBox",
                //     type: "number",
                //     // defaultValue: StorageUtil.get('out_remittance_defaultTargetId')
                // },
                //
                // parseEditorValue: function (value, record, form, item) {
                //     // StorageUtil.save('out_remittance_defaultTargetId', value);
                //     return value;
                // },
                changed(form, item, value) {
                    StorageUtil.save('out_remittance_defaultTargetId', value);
                },
                filterOperator: "equals",
                editorType: "ComboBoxItem",
                textMatchStyle: "substring",
                addUnknownValues: false,
                valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                // valueMap: {
                //     2320: 'بندر شهيد رجايي، روبروي اسكله شانزده ،محوطه فلزات آلياژي شركت تايد واتر',
                //     1000: 'مجتمع مس سرچشمه',
                //     2340: 'بندر شهيد رجايي ، انبار كالا شماره 20',
                //     2555: 'اسكله شهيد رجائي ',
                // },
                title: "<spring:message code='Tozin.targetId'/>",
                align: "center",
                defaultValue: StorageUtil.get('out_remittance_defaultTargetId')
            },
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.TozinTable = function () {
        return [
            ...objTab.Fields.TozinBase(),
            {
                name: 'isInView',
                title: "<spring:message code='warehouseCad.from.logistic'/>",
                defaultValue: false,
                valueMap: {true: "<spring:message code='global.yes'/>", false: "<spring:message code='global.no'/>"}
            },
            {name: 'haveCode', hidden: true},
            {name: 'cardId', hidden: true},
            {name: 'ctrlDescOut', title: "<spring:message code='global.description'/>"},
            {name: 'version', hidden: true},
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.TozinLite = function () {
        return [
            ...objTab.Fields.TozinBase(),
            {
                name: "containerNo1",
                title: "<spring:message code='Tozin.containerNo1'/>",
                align: "center", hidden: true,
            },
            {
                name: "containerNo3", hidden: true,
                title: "<spring:message code='Tozin.containerNo3'/> - <spring:message code='shipment.type'/>",
                align: "center",
                formatCellValue(value, record, rowNum, colNum, grid) {
                    return (value ? "ریلی  " + value : "جاده‌ای"
                    )
                },
                validOperators: ["equals", "isNull", "notNull"],
                filterEditorProperties: {
                    showPickerIcon: true,
                    // showPickerIconOnFocus:true,
                    picker: isc.FormLayout.create({
                        visibility: "hidden",
                        backgroundColor: "white",
                        items: [{
                            showTitle: false, type: "radioGroup",
                            valueMap: {notNull: "ریلی", isNull: "جاده‌ای"},
                            change: function (f, i, value) {
                                const criteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
                                criteria.criteria = criteria.criteria.filter(c => c.fieldName !== 'containerNo3');
                                criteria.criteria.add({
                                    fieldName: "containerNo3",
                                    operator: value
                                })
                                //  console.log(criteria)
                                ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(criteria);
                                return this.Super("change", arguments)
                            },
                        }]
                    })
                }
                // alwaysShowOperatorIcon:true,
            },
            {
                name: "havalehCode", hidden: true,
                title: "<spring:message code='Tozin.haveCode'/>",
                align: "center"
            },
            {name: "isRail", type: "boolean", title: "<spring:message code='warehouseCad.with.rail'/>"}
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.TozinFull = function () {
        return [
            ...objTab.Fields.TozinLite(),
            {
                name: "source",
                title: "<spring:message code='Tozin.source'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "nameKala",
                title: "<spring:message code='Tozin.nameKala'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "target",
                title: "<spring:message code='Tozin.target'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "cardId",
                title: "<spring:message code='Tozin.cardId'/>",
                align: "center"
            },
            {
                name: "carName",
                title: "<spring:message code='Tozin.carName'/>",
                align: "center"
            },
            {
                name: "containerId",
                title: "<spring:message code='Tozin.containerId'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "containerName",
                title: "<spring:message code='Tozin.containerName'/>",
                align: "center"
            },
            {
                name: "vazn1",
                title: "<spring:message code='Tozin.vazn1'/>",
                align: "center"
            },
            {
                name: "vazn2",
                title: "<spring:message code='Tozin.vazn2'/>",
                align: "center"
            },
            {
                name: "condition",
                title: "<spring:message code='Tozin.condition'/>",
                align: "center"
            },
            {
                name: "tedad",
                title: "<spring:message code='Tozin.tedad'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "unitKala",
                title: "<spring:message code='Tozin.unitKala'/>",
                align: "center"
            },
            {
                name: "packName",
                title: "<spring:message code='Tozin.packName'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "haveCode",
                title: "<spring:message code='Tozin.haveCode'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "tozinDate",
                showHover: true,
                width: "10%",
                title: "<spring:message code='Tozin.tozinDate'/>"
            },
            {
                name: "tozinTime",
                title: "<spring:message code='Tozin.tozinTime'/>",
                align: "center"
            },
            {
                name: "havalehName",
                title: "<spring:message code='Tozin.havalehName'/>",
                align: "center"
            },
            {
                name: "havalehFrom",
                title: "<spring:message code='Tozin.havalehFrom'/>",
                align: "center"
            },
            {
                name: "carNo1",
                title: "<spring:message code='Tozin.carNo1'/>",
                align: "center"
            },
            {
                name: "carNo3",
                title: "<spring:message code='Tozin.carNo3'/>",
                align: "center"
            },
            {
                name: "isFinal",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "ctrlDescOut",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "tznSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "strSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "tznSharh1",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "havalehDate",
                title: "<spring:message code='Tozin.havalehDate'/>",
                align: "center"
            },


        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.RemittanceDetail = function () {
        return [
            {name: "id", hidden: true, type: "number"},
            {
                name: "remittanceId", hidden: true,
                // optionDataSource: isc.MyRestDataSource.create({
                //     fetchDataURL: 'api/remittance/spec-list',
                //     fields: objTab.Fields.Remittance
                // }),
                // pickListProperties: {
                //     fields: objTab.Fields.Remittance
                // },
                displayField: "code",
                valueField: "id",
            },
            {name: "depot.id", hidden: true, title: "<spring:message code='warehouseCad.depot'/>",},
            {
                name: "unitId",
                editorType: "ComboBoxItem",
                textMatchStyle: "substring",
                addUnknownValues: false,
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                valueMap: SalesBaseParameters.getSavedUnitParameter().getValueMap('id', 'nameFA'),
                type: "number",
                title: "<spring:message code='global.unit'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                hidden: true,
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/> <spring:message code='goods.title'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                hidden: true,


            },
            {
                name: "weight",
                title: "<spring:message code='Tozin.vazn'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
            },
            {
                name: "sourceTozin.tozinId",
                title: "<spring:message code='Tozin.tozinPlantId'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                pickListFields: objTab.Fields.TozinLite(),
                showHover: true,
                hidden: true,
                showHoverComponents: false,
            },
            {
                name: "destinationTozin.tozinId",
                title: "<spring:message code='Tozin.target.tozin'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                showHover: true,
                hidden: true,
                showHoverComponents: false,
                pickListFields: objTab.Fields.TozinLite()

            },
            {
                name: "securityPolompNo", hidden: true,
                title: "<spring:message code='warehouseCad.herasatPolompNo'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,


            },
            {
                name: "railPolompNo", hidden: true,
                title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,


            },
            {
                name: "description",
                title: "<spring:message code='shipment.description'/> <spring:message code='global.package'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                hidden: true,


            },
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.RemittanceDetailFullFields = function () {
        return [
            {name: "sourceTozin.driverName", title: "<spring:message code='Tozin.driver'/>"},
            {
                name: "inventory.label",
                title: "<spring:message code='warehouseCadItem.inventory.Serial'/>",
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/inventory', objTab.Fields.Inventory(), "inventory",
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                }
            },
            {
                name: "tozin.date",
                title: "<spring:message code='global.date'/> <spring:message code='tozin.title'/>",
                // hidden: true,
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,


            },
            {
                name: "remittance.code", title: "<spring:message code='remittance.code'/>"
                , recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/remittance', objTab.Fields.Remittance, "remittance",
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                }
            },
            {
                name: "remittance.description",
                title: "<spring:message code='shipment.description'/> بیجک",
                recordDoubleClick() {
                    objTab.Methods.RecordDoubleClick("api/remittance", objTab.Fields.Remittance, 'remittance', ...arguments)
                }

            },
            {
                name: "inventory.materialItem.id",
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
                type: "number",
                title: "<spring:message code='goods.title'/>",
                hidden: false,
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/inventory', objTab.Fields.Inventory(), "inventory",
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                }
            },
            {
                name: "tozin.sourceId",
                type: "number",
                valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                title: "<spring:message code='Tozin.source'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
                // hidden: true,


            },
            {
                name: "tozin.targetId",
                type: "number",
                editorType: "ComboBoxItem",
                textMatchStyle: "substring",
                addUnknownValues: false,
                valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                title: "<spring:message code='shipment.Bol.tblPortByDischarge'/>",
                // hidden: true,
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,


            },
            {name: "tozin.plak", title: "<spring:message code='Tozin.plak.container'/>"},
            {
                name: "depot.name",
                showHover: true,
                title: "<spring:message code='warehouseCad.depot'/>",
                formatCellValue(value, record) {
                    //  console.log('name: "depot.id", hidden: true, disabled: true,title:"<spring:message code='warehouseCad.depot'/>",formatCellValue()', arguments);
                    // return this.Super('formatCellValue',arguments);
                    const title = record.depot.store.warehouse.name + " - " + record.depot.store.name + " - " + record.depot.name;
                    return title;
                },
                showHoverComponents: false,
                hidden: true,
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD
            },
            {
                name: "sourceTozin.vazn",
                showHover: true,
                title: "<spring:message code='Tozin.vazn'/> <spring:message code='warehouseCad.tozinOther'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
            },
            {
                name: "destinationTozin.vazn",
                showHover: true,

                title: "<spring:message code='Tozin.vazn'/> <spring:message code='Tozin.dest.tozin'/>",
                recordDoubleClick: objTab.Methods.RecordDoubleClickRD,
            },
            {
                name: "tozinWeightDiff", type: "summary", title: "<spring:message code='Tozin.wazn.diff'/>",
                baseStyle: "cell",
                recordSummaryFunction(_record, _grid, _value,) {
                    if (_record.destinationTozin)
                        return _record.destinationTozin.vazn - _record.sourceTozin.vazn
                    return 0
                },
                formatCellValue(value, record, rowNum, colNum, grid) {
                    if (!value || isNaN(value) || Number(value) > 0) return value;
                    return '<div style="color: red;  unicode-bidi: bidi-override;direction: ltr">' + value + '</div>'
                },
            },
            {name:"remittance.hasRemainedInventory",type:"boolean",
                title: "<spring:message code='remittance.has.remained.inventory'/>",
                hidden:true
            },
            ...objTab.Fields.RemittanceDetail(),

        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.Remittance = function () {
        return [
            {name: 'id', hidden: true, title: "<spring:message code='global.id'/>"},
            {
                name: 'code', title: "<spring:message code='remittance.code'/>",
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/remittance', objTab.Fields.Remittance().map(_ => {
                            if (record.remittanceDetails[0] && _.name.toLowerCase() === "shipmentId".toLowerCase() &&
                                !record.remittanceDetails[0].destinationTozin) {
                                dbg(true, record)
                                _.hidden = false;
                                _.disabled = false;
                                _.optionCriteria = {
                                    fieldName: "materialId",
                                    operator: "equals",
                                    value: record.remittanceDetails[0].inventory.materialItem.materialId
                                }
                            }

                            return _;
                        }), false,
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                },
                required: true,
            },
            {
                name: 'date', title: "<spring:message code='global.date'/> <spring:message code='bijack'/>",
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/remittance', objTab.Fields.Remittance().filter(_ => _.name !== 'date').map(_ => {

                            if (record.remittanceDetails[0] && _.name.toLowerCase() === "shipmentId".toLowerCase() &&
                                !record.remittanceDetails[0].destinationTozin) {
                                dbg(true, record)
                                _.hidden = false;
                                _.disabled = false;
                                _.optionCriteria = {
                                    fieldName: "materialId",
                                    operator: "equals",
                                    value: record.remittanceDetails[0].inventory.materialItem.materialId
                                }
                            }

                            return _;
                        }), false,
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                },
            },
            {
                name: 'description', title: "<spring:message code='remittance.description'/>",
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/remittance', objTab.Fields.Remittance().map(_ => {
                            if (_.name.toLowerCase() === "shipmentId".toLowerCase()) {
                                _.hidden = false;
                                _.disabled = false;
                                _.optionCriteria = {
                                    fieldName: "materialId",
                                    operator: "equals",
                                    value: record.remittanceDetails[0].inventory.materialItem.material.id
                                }
                            }

                            return _;
                        }), false,
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                },
            },
            {name: 'id', title: "<spring:message code='global.id'/>", hidden: true},
            {
                name: "shipmentId",
                recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    objTab.Methods.RecordDoubleClick('api/remittance', objTab.Fields.Remittance().map(_ => {
                            if (_.name.toLowerCase() === "shipmentId".toLowerCase()) {
                                _.hidden = false;
                                _.disabled = false;
                                _.optionCriteria = {
                                    fieldName: "materialId",
                                    operator: "equals",
                                    value: record.remittanceDetails[0].inventory.materialItem.material.id
                                }
                            }

                            return _;
                        }), false,
                        viewer, record, recordNum, field, fieldNum, value, rawValue)
                },
                title: "<spring:message code='Shipment.title'/>",
                disabled: true,
                hidden: true,
                displayField: "automationLetterNo",
                valueField: "id",
                pickListWidth: .7 * outerWidth,
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                    {name: "contractShipmentId", hidden: true, type: 'long'},
                    {name: "contactId", type: 'long', hidden: true},
                    {
                        name: "contact.name"+languageForm.getValue('languageName').toUpperCase(),
                        title: "<spring:message code='contact.name'/>",
                        type: 'text',
                        width: "10%",
                        align: "center",
                        showHover: true,
                        sortNormalizer: function (recordObject) {
                            return recordObject.contract.contact.nameFA
                        }
                    },
                    {name: "contractId", type: 'long', hidden: true},
                    {
                        name: "contractShipment.contract.no",
                        title: "<spring:message code='contract.contractNo'/>",
                        type: 'text',
                        width: "10%",
                        showHover: true,
                        sortNormalizer: function (recordObject) {
                            return recordObject.contract.contractNo
                        }
                    },
                    {
                        name: "automationLetterDate",
                        title: "<spring:message code='shipment.bDate'/>",
                        type: 'date',
                        width: "10%",
                        showHover: true,
                        formatCellValue: (value) => {
                            return new persianDate(value).format('YYYY/MM/DD')
                        },
                    },
                    {
                        name: "materialId",
                        title: "<spring:message code='contact.name'/>",
                        type: 'long',
                        hidden: true,
                        showHover: true
                    },
                    {
                        name: "material.desc"+languageForm.getValue('languageName').toUpperCase(),
                        title: "<spring:message code='material.title'/>",
                        type: 'text',
                        width: "10%",
                        align: "center",
                        showHover: true,
                        sortNormalizer: function (recordObject) {
                            return recordObject.material.descl
                        }
                    },
                    {
                        name: "amount",
                        title: "<spring:message code='global.amount'/>",
                        type: 'text',
                        width: "10%",
                        align: "center",
                        showHover: true
                    },
                    {
                        name: "dischargePort.country.name"+languageForm.getValue('languageName').toUpperCase(),
                        title: "<spring:message code='global.country'/>",
                        type: 'text',
                        width: "10%",
                        showHover: true,
                        required: true,
                        validators: [
                            {
                                type: "required",
                                validateOnChange: true
                            }]
                    },
                    {
                        name: "shipmentMethod.shipmentMethod",
                        title: "<spring:message code='shipment.shipmentMethod'/>",
                        type: 'text',
                        width: "10%",
                        showHover: true,
                        required: true,
                        validators: [
                            {
                                type: "required",
                                validateOnChange: true
                            }]
                    },
                    {
                        name: "automationLetterNo",
                        title: "<spring:message code='shipment.loadingLetter'/>",
                        type: 'text',
                        width: "10%",
                        showHover: true,
                    },
                    {
                        name: "contractShipment.sendDate",
                        title: "<spring:message code='global.sendDate'/>",
                        type: 'text',
                        required: true,
                        width: "10%",
                        align: "center",
                        showHover: true,
                        validators: [
                            {
                                type: "required",
                                validateOnChange: true
                            }],
                        sortNormalizer: function (recordObject) {
                            return recordObject.contractShipment.sendDate
                        }
                    },
                    {
                        name: "createDate.date",
                        title: "<spring:message code='global.createDate'/>",
                        type: 'text',
                        required: true,
                        width: "10%",
                        align: "center",
                        showHover: true,
                        validators: [
                            {
                                type: "required",
                                validateOnChange: true
                            }],
                        formatCellValue: (value) => {
                            return new persianDate(value).format('YYYY/MM/DD')
                        },
                    },
                    {
                        name: "contactAgent.name"+languageForm.getValue('languageName').toUpperCase(),
                        title: "<spring:message code='shipment.agent'/>",
                        type: 'text',
                        width: "10%",
                        align: "center",
                        showHover: true,
                        sortNormalizer: function (recordObject) {
                            return recordObject.contactAgent.nameFA
                        }
                    },
                    {
                        name: "vessel.name",
                        title: "<spring:message code='shipment.vesselName'/>",
                        type: 'text',
                        required: true,
                        width: "10%",
                        showHover: true,
                        validators: [
                            {
                                type: "required",
                                validateOnChange: true
                            }],
                        sortNormalizer: function (recordObject) {
                            return recordObject.vessel.name
                        }
                    },

                ],
                changed(){ objTab.Methods.setPackingContainerCriteria()},
                optionDataSource: isc.MyRestDataSource.create({
                    fields: [
                        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                        {name: "contractShipmentId", hidden: true, type: 'long'},
                        {name: "contactId", type: 'long', hidden: true},
                        {
                            name: "contact.nameFA",
                            title: "<spring:message code='contact.name'/>",
                            type: 'text',
                            width: "10%",
                            align: "center",
                            showHover: true,
                            sortNormalizer: function (recordObject) {
                                return recordObject.contract.contact.nameFA
                            }
                        },
                        {name: "contractId", type: 'long', hidden: true},
                        {
                            name: "contractShipment.contract.no",
                            title: "<spring:message code='contract.contractNo'/>",
                            type: 'text',
                            width: "10%",
                            showHover: true,
                            sortNormalizer: function (recordObject) {
                                return recordObject.contract.contractNo
                            }
                        },
                        {
                            name: "automationLetterDate",
                            title: "<spring:message code='shipment.bDate'/>",
                            type: 'date',
                            width: "10%",
                            showHover: true,
                            formatCellValue: (value) => {
                                return new persianDate(value).format('YYYY/MM/DD')
                            },
                        },
                        {
                            name: "materialId",
                            title: "<spring:message code='contact.name'/>",
                            type: 'long',
                            hidden: true,
                            showHover: true
                        },
                        {
                            name: "material.descl",
                            title: "<spring:message code='material.descl'/>",
                            type: 'text',
                            width: "10%",
                            align: "center",
                            showHover: true,
                            sortNormalizer: function (recordObject) {
                                return recordObject.material.descl
                            }
                        },
                        {
                            name: "amount",
                            title: "<spring:message code='global.amount'/>",
                            type: 'text',
                            width: "10%",
                            align: "center",
                            showHover: true
                        },
                        {
                            name: "shipmentType.shipmentType",
                            title: "<spring:message code='shipment.shipmentType'/>",
                            type: 'text',
                            width: "10%",
                            showHover: true,
                            required: true,
                            validators: [
                                {
                                    type: "required",
                                    validateOnChange: true
                                }]
                        },
                        {
                            name: "shipmentMethod.shipmentMethod",
                            title: "<spring:message code='shipment.shipmentMethod'/>",
                            type: 'text',
                            width: "10%",
                            showHover: true,
                            required: true,
                            validators: [
                                {
                                    type: "required",
                                    validateOnChange: true
                                }]
                        },
                        {
                            name: "automationLetterNo",
                            title: "<spring:message code='shipment.loadingLetter'/>",
                            type: 'text',
                            width: "10%",
                            showHover: true,
                        },
                        {
                            name: "contractShipment.sendDate",
                            title: "<spring:message code='global.sendDate'/>",
                            type: 'text',
                            required: true,
                            width: "10%",
                            align: "center",
                            showHover: true,
                            validators: [
                                {
                                    type: "required",
                                    validateOnChange: true
                                }],
                            sortNormalizer: function (recordObject) {
                                return recordObject.contractShipment.sendDate
                            }
                        },
                        {
                            name: "createDate.date",
                            title: "<spring:message code='global.createDate'/>",
                            type: 'text',
                            required: true,
                            width: "10%",
                            align: "center",
                            showHover: true,
                            validators: [
                                {
                                    type: "required",
                                    validateOnChange: true
                                }],
                            formatCellValue: (value) => {
                                return new persianDate(value).format('YYYY/MM/DD')
                            },
                        },
                        {
                            name: "contactAgent.nameFA",
                            title: "<spring:message code='shipment.agent'/>",
                            type: 'text',
                            width: "10%",
                            align: "center",
                            showHover: true,
                            sortNormalizer: function (recordObject) {
                                return recordObject.contactAgent.nameFA
                            }
                        },
                        {
                            name: "vessel.name",
                            title: "<spring:message code='shipment.vesselName'/>",
                            type: 'text',
                            required: true,
                            width: "10%",
                            showHover: true,
                            validators: [
                                {
                                    type: "required",
                                    validateOnChange: true
                                }],
                            sortNormalizer: function (recordObject) {
                                return recordObject.vessel.name
                            }
                        },

                    ],
                    fetchDataURL: 'api/shipment/spec-list'
                })
            },
            {name:"packingContainerId",
                title:"<spring:message code='warehouseCad.containerNo'/>",
                hidden: true,
                disabled: true,
                displayField: "containerNo",
                valueField: "id",
                pickListWidth: .7 * outerWidth,
                pickListHeight: 500,
                autoFetchData:false,
                optionDataSource: isc.MyRestDataSource.create({
                fetchDataURL: 'api/packing-container/spec-list',
                fields:objTab.Fields.PackingContainer(),
            },
                ),
                pickListProperties:{
                showFilterEditor: true,
                    recordClick (viewer, record, recordNum, field, fieldNum, value, rawValue){
                        const oldValuesTozinTable = objTab.DynamicForms.Forms.TozinTable.getValues();
                        objTab.DynamicForms.Forms.TozinTable.setValues({
                            ...oldValuesTozinTable,
                                tozinId:"3-"+record["packingList"]['bookingNo']+record['containerNo'],
                                date:record['ladingDate'],
                                driverName:record['containerNo'],
                                plak:record['containerNo'],
                                vazn:record['contentWeight'],
                                isInView:false,
                            }
                        )
                        return viewer.Super("recordClick",arguments)

                }
                },
                pickListFields: objTab.Fields.PackingContainer(),

            },
            {name:"hasRemainedInventory",type:"boolean",
                title: "<spring:message code='remittance.has.remained.inventory'/>",
                hidden:true
            }
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.RemittanceFull = function () {
        return [
            ...objTab.Fields.Remittance(),
            {
                name: "remittanceDetails.sourceTozin.tozinId",
                title: "<spring:message code='Tozin.tozinPlantId'/>",
                canSort: false,
            },
            {name: "tozinTable.tozinId", title: "<spring:message code='Tozin.target.tozin.id'/>"},
            {
                name: "remittanceDetails.inventory.materialItem.id",
                valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                canSort: false,
                type: "number",
                title: "<spring:message code='goods.title'/>",
            },
            {
                name: "tozinTable.sourceId",
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                type: "number",
                sortNormalizer(recordObject, fieldName, context) {
                    if (recordObject.tozinTable && recordObject.tozinTable.sourceId)
                        return recordObject.tozinTable.targetId
                },
                valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                title: "<spring:message code='Tozin.source'/>",
                filterOperator: "equals",
                sortByMappedValue: true,
                // canSort: false,
                // formatCellValue(value, record) {
                //     if (value) return value;
                //     else if (record.remittanceDetails[0])
                //         return SalesBaseParameters.getSavedWarehouseParameter().find(w => {
                //             return w.id == record.remittanceDetails[0].sourceTozin.sourceId;
                //         }).name;
                //     return ''
                // }
            },
            {
                ...objTab.Fields.TozinBase().find(t => t.name === 'date'),
                // filterEditorProperties: {
                //     editorType: "ComboBoxItem",
                textMatchStyle: "substring",
                addUnknownValues: false,
                // },
                canSort: true,
                sortNormalizer(recordObject, fieldName, context) {
                    if (recordObject.tozinTable && recordObject.tozinTable.date) return recordObject.tozinTable.date
                },
                name: "tozinTable.date",
                title: "<spring:message code='global.date'/> ",

            },
            // {name: "tozinTable.targetId",},
            {name: "tozinTable.vazn", title: "<spring:message code='Tozin.vazn'/>"},
            {name: "tozinTable.ctrlDescOut", title: "<spring:message code='invoiceSales.otherDescription'/>"},
            {name: "tozinTable.plak", title: "<spring:message code='Tozin.plak'/>"},
            {name: "tozinTable.driverName", title: "<spring:message code='Tozin.driver'/>"},
            {
                ...objTab.Fields.TozinBase().find(t => t.name === 'date'),
                // filterEditorProperties: {
                //     editorType: "ComboBoxItem",
                textMatchStyle: "substring",
                addUnknownValues: false,
                // },
                canSort: false,
                name: "remittanceDetails.sourceTozin.date",
                title: "<spring:message code='global.date'/> <spring:message code='warehouseCad.tozinOther'/>",

            },

            {
                ...objTab.Fields.TozinBase().find(t => t.name === 'date'),
                canSort: false,
                name: "remittanceDetails.destinationTozin.date",
                title: "<spring:message code='global.date'/> <spring:message code='Tozin.target.tozin'/>",
            },
            // {
            //     name: "tozinTable.targetId",
            //     filterEditorProperties: {
            //         editorType: "ComboBoxItem",
            //         textMatchStyle:"substring",
            //         addUnknownValues:false,
            //     },
            //     // canSort: false,
            //     valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
            //     type: "number",
            //     sortNormalizer(recordObject, fieldName, context) {
            //         if (recordObject.tozinTable && recordObject.tozinTable.targetId)
            //             return recordObject.tozinTable.targetId
            //     },
            //     title: "<spring:message code='shipment.Bol.tblPortByDischarge'/>",
            //     hidden: false,
            // },
            {
                name: "remittanceDetails.depot.name",
                canSort: false,
                // valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
                title: "<spring:message code='warehouseCad.depot'/>",
                showHover: true,
                formatCellValue(value, record) {

                    // console.log('name: "depot.id", hidden: true, disabled: true,title:"<spring:message code='warehouseCad.depot'/>",formatCellValue()', arguments);
                    // return this.Super('formatCellValue',arguments);
                    try {
                        const title = record.remittanceDetails[0].depot.store.warehouse.name +
                            " - " + record.remittanceDetails[0].depot.store.name +
                            " - " + record.remittanceDetails[0].depot.name;
                        if (record.shipment && record.shipment.contractShipment && record.shipment.contractShipment.contract)
                            return record.shipment.contractShipment.contract.no + " - " +
                                record.shipment.vessel.name + " - " +
                                record.shipment.dischargePort.port + " - " + title;
                        return title;
                    } catch (e) {
                        console.error("depot name in remittance listgrid\n", e);
                        return value;
                    }

                },
            },
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.Inventory = function () {
        return [
            {
                name: 'materialItemId',
                filterEditorProperties: {
                    editorType: "ComboBoxItem",
                    textMatchStyle: "substring",
                    addUnknownValues: false,
                },
                valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
                title: '<spring:message code="goods.title"/>',
                disabled: true,

            },
            {name: 'label', title: '<spring:message code="warehouseCadItem.inventory.Serial"/>'},
            {name: 'id', title: '<spring:message code="global.id"/>', hidden: true,},
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.Depot = function () {
        return [
            {name: "store.warehouse.name", title: "<spring:message code='dailyReportTransport.warehouseNo'/>"},
            {name: "store.name", title: "<spring:message code='warehouseCad.store'/>"},
            {name: "name", title: "<spring:message code='warehouseCad.yard'/>"}
        ].map(_=>Object.assign({},_));
    }
    objTab.Fields.Shipment = function () {
        return [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "commertialRole"},
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {
                name: "type", title: "<spring:message code='contact.type'/>",
                valueMap: {
                    "true": "<spring:message code='contact.type.real'/>",
                    "false": "<spring:message code='contact.type.legal'/>"
                }
            },
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {
                name: "status", title: "<spring:message code='contact.status'/>",
                valueMap: {
                    "true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"
                }
            },
            {name: "contactAccounts"},
            {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},

            {name: "bookingCat", title: "<spring:message code='shipment.bookingCat'/>", align: "center"}


        ].map(_=>Object.assign({},_));
    }
    return Object.assign({},objTab);
}
if(!newOutRemittance)
function newOutRemittance(objTab,selectedData,materialItemId) {
    objTab.DynamicForms.Forms.OutRemittance = isc.DynamicForm.create({
        selectOnFocus : true,
        shouldSaveValue : true,
        stopOnError : true,
        showErrorIcon : true,
        showErrorText : true,
        showErrorStyle : true,
        validateOnExit : true,
        errorOrientation : "bottom",
        align : "right",
        textAlign : "right",
        titleAlign : "right",
        numCols: 6,
        wrapItemTitles:false,
        fields: [
            {
                name: "materialItemId",
                title: "<spring:message code='goods.title'/>",
                changed(form, item, value) {
                    if (value) {
                        objTab.Layouts.ToolStripButtons.OutRemittanceAddTozin.enable();
                        objTab.Layouts.ToolStripButtons.OutRemittanceAdd.enable();
                        objTab.DynamicForms.Forms.TozinTable.setValue('codeKala', value);
                        objTab.Methods.setShipmentCriteria();

                    }
                },
                editorType: "ComboBoxItem",
                textMatchStyle:"substring",
                addUnknownValues:false,
                defaultValue:materialItemId,
                valueMap: objTab.Fields.Inventory().find(i => i.name === "materialItemId").valueMap,
            },
            ...objTab.Fields.Remittance().filter(_ => !["date","hasRemainedInventory".toLowerCase()].includes(_.name.toLowerCase())).map(_ => {
                if (['shipmentId'.toLowerCase(),"packingContainerId".toLowerCase()].includes(_.name.toLowerCase()))
                {
                    _.hidden = false;
                    _.disabled = true;
                }

                return _;
            }),


        ]
    });
    objTab.DynamicForms.Forms.TozinTable = isc.DynamicForm.create({
        selectOnFocus : true,
        shouldSaveValue : true,
        stopOnError : true,
        showErrorIcon : true,
        showErrorText : true,
        showErrorStyle : true,
        validateOnExit : true,
        errorOrientation : "bottom",
        wrapItemTitles:false,
        align : "right",
        textAlign : "right",
        titleAlign : "right",

        numCols: 6,
        fields: objTab.Fields.TozinTable().map(a => {
            const oldChanged = a.changed;
            a.changed = (form, item, value) => {
                if (typeof (oldChanged) === "function") oldChanged(form, item, value)
                const _item = form.getItem('isInView');
                _item.setValue(false);
                _item.disable();
                if(a.name === "sourceId"){
                    StorageUtil.save("out_remittance_defaultSourceId",value)
                }
            };
            if (a.name === 'codeKala') a.hidden = true;
            if (a.name === 'isInView') a.disabled = true;
            return a
        })
    });
    objTab.Layouts.ToolStripButtons.OutRemittanceAdd = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.add'/> <spring:message code='bijack'/> <spring:message code='global.vorodi'/>",
        disabled: true,
        click() {
            let selectRd;
            const win = isc.Window.create({
                ...objTab.Vars.defaultWindowConfig,
                members: [
                    isc.ToolStrip.create({
                        members: [
                            isc.ToolStripButtonAdd.create({
                                title: "<spring:message code='global.add'/>",
                                click() {
                                    const records = selectRd.getSelectedRecords();
                                    if (!records || records.length === 0)
                                        return isc.warn('<spring:message code="global.grid.record.not.selected"/>')
                                    records.forEach(d => {
                                        if (!objTab.Grids.RemittanceDetailOutRemittance.getData().find(rd => rd.id === d.id))
                                            objTab.Grids.RemittanceDetailOutRemittance.addData(d)
                                    });
                                    selectRd.deselectAllRecords();
                                    win.destroy();
                                }
                            }),
                            isc.ToolStripButtonRefresh.create({
                                title: "<spring:message code='global.select.all'/>",
                                click() {
                                    selectRd.selectAllRecords();
                                }
                            }),

                        ]
                    }),
                    selectRd = isc.ListGrid.create({
                        ...Object.assign({},objTab.Grids.RemittanceDetail()),
                        fields:objTab.Grids.RemittanceDetail().fields.map(field=>{delete field.recordDoubleClick;return field}),
                        // fields: [
                        //     {name: "remittance.code", title: "<spring:message code='global.number'/> <spring:message code='bijack'/>"},
                        //     {name: "remittance.description", title: "<spring:message code='remittance.description'/>"},
                        //     {name:"destinationTozin.driverName",headerTitle:"<spring:message code='Tozin.driver'/>"},
                        //     ...objTab.Fields.RemittanceDetailFullFields().map(f => {
                        //         const showFields = {
                        //             "remittance.code": {},
                        //             "remittance.description": {},
                        //             "inventory.label": {},
                        //             "description": {},
                        //             "weight": {},
                        //             "ampunt": {},
                        //             "unitId": {},
                        //             "depotId": {},
                        //         };
                        //         // f.hidden = true;
                        //         // if (Object.keys(showFields).contains(f.name)) f.hidden = false;
                        //         f.recordDoubleClick = _ => {
                        //         };
                        //         return f
                        //     }),],
                        initialCriteria: {
                            operator: "and",
                            criteria: [
                                {
                                    fieldName: "destinationTozin.sourceId",
                                    operator: "inSet",
                                    value: [1000, 1021, 1540, 1541, 2421, 2509]
                                },
                                {
                                    fieldName: "destinationTozin",
                                    operator: "notNull",
                                },
                                {
                                    fieldName: "inventory.materialItemId",
                                    operator: "equals",
                                    value: objTab.DynamicForms.Forms.OutRemittance.getValue("materialItemId")
                                },
                                {
                                    fieldName: "inventory.weight",
                                    operator: "greaterOrEqual",
                                    value: 1
                                }

                            ],
                        },
                        showHoverComponents: false,
                        height: "100%",
                        autoFetchData: true,
                        allowAdvancedCriteria: true,
                        showFilterEditor: true,
                        dataSource:isc.MyRestDataSource.create(Object.assign({},objTab.RestDataSources.RemittanceDetail())) ,

                    }),],
            })
        }
    });
    objTab.Layouts.ToolStripButtons.OutRemittanceAddTozin = isc.ToolStripButtonAdd.create({
        disabled: true,
        align: "center",
        title: "<spring:message code='remittance.select.from.logistic'/>",
        click() {
            objTab.Grids.TozinLite = isc.ListGrid.create({
                fields: objTab.Fields.TozinLite().map(_ => {
                    if (_.defaultValue) delete _.defaultValue;
                    return _;
                }),
                initialCriteria: {
                    operator: "and",
                    criteria: [
                        {
                            fieldName: "sourceId",
                            operator: "equals",
                            value: 2555
                        },
                        {
                            fieldName: "tozinId",
                            operator: "iStartsWith",
                            value: "3"
                        },
                        {
                            fieldName: "codeKala",
                            operator: "equals",
                            value: objTab.DynamicForms.Forms.OutRemittance.getValue("materialItemId")
                        },
                        {
                            fieldName: "date",
                            operator: "greaterOrEqual",
                            value: new persianDate().subtract('d', 10).format('YYYYMMDD')
                        },
                        {
                            fieldName: "tozinTable",
                            operator: "isNull",
                        },


                    ],
                },
                showHoverComponents: false,
                height: "100%",
                selectionType: "single",
                autoFetchData: true,
                allowAdvancedCriteria: true,
                showFilterEditor: true,
                recordDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                    if (!record) return isc.warn('<spring:message code="global.grid.record.not.selected"/>')
                    // console.log("objTab.DynamicForms.Forms.TozinTable", objTab.DynamicForms.Forms.TozinTable);
                    objTab.DynamicForms.Forms.TozinTable.setValues({
                        ...record,
                        isInView: true
                    });
                    win.destroy();
                    // viewer.deselectAllRecords();
                },
                dataSource: isc.MyRestDataSource.create(objTab.RestDataSources.TozinLite)
            });
            const win = isc.Window.create({
                ...objTab.Vars.defaultWindowConfig,
                members: [
                    isc.ToolStrip.create({
                        members: [
                            isc.ToolStripButtonAdd.create({
                                title: "<spring:message code='global.add'/>",
                                click: _ => objTab.Grids.TozinLite.recordDoubleClick(objTab.Grids.TozinLite, objTab.Grids.TozinLite.getSelectedRecord())
                            }),
                        ]
                    }),
                    objTab.Grids.TozinLite,],
            })
        }
    });
    objTab.Layouts.ToolStripButtons.AddTozinToRemittanceDetails = isc.ToolStripButtonAdd.create({
        // disabled: true,
        title: "<spring:message code='remittance.add.tozin'/>",
        click() {
            if (!objTab.DynamicForms.Forms.TozinTable.validate()) return;
            const outTozin = objTab.DynamicForms.Forms.TozinTable.getValues();
            objTab.Grids.RemittanceDetailOutRemittance.getSelectedRecords().forEach(rd => {
                if (!rd.outTozin) {
                    rd.outTozin = outTozin;
                }
            });
            objTab.Grids.RemittanceDetailOutRemittance.redraw();
            objTab.Methods.setRemittanceCode()

        }
    });
    objTab.Grids.RemittanceDetailOutRemittance = isc.ListGrid.create({
        canRemoveRecords: true,
        deferRemoval: false,
        canEdit: true,
        editEvent: "doubleClick",
        autoSaveEdits: false,
        fields: [
            ...objTab.Fields.RemittanceDetailFullFields().map(f => {
                const showFields = {
                    "remittance.code": {},
                    "remittance.description": {},
                    "inventory.label": {},
                    "description": {},
                    "weight": {},
                    "amount": {},
                    "unitId": {},
                    "depotId": {},
                };
                f.hidden = true;
                f.canEdit = false;
                if (Object.keys(showFields).contains(f.name)) f.hidden = false;
                f.recordDoubleClick = _ => {
                };
                return f
            }),
            {name: "outTozin.tozinId", title: "<spring:message code='remittance.dest.tozin'/>", canEdit: false},
            {
                name: "outDescription",
                title: "<spring:message code='global.description'/> <spring:message code='goods.title'/>",
                canEdit: true,
                editorExit(editCompletionEvent, record, newValue, rowNum, colNum, grid) {
                    record.outDescription = newValue
                }
            }
        ],
    })
    objTab.Layouts.Window.OutRemittance = isc.Window.create({
        ...objTab.Vars.defaultWindowConfig,
        members: [
            isc.VLayout.create({
                height: "100%",
                members: [
                    objTab.DynamicForms.Forms.OutRemittance,
                    isc.Label.create({
                        height: .06 * innerHeight,
                        align:"right",
                        contents: "<h3 style='text-align: right;padding-right:20px'>"
                            + "<spring:message code='remittance.dest.info'/>" +
                            "</h3>"
                    }),
                    isc.HLayout.create({
                        height: "15%",
                        members: [
                            isc.VLayout.create({
                                width: "85%",
                                members: [objTab.DynamicForms.Forms.TozinTable,]
                            }),
                            isc.VLayout.create({
                                members: [objTab.Layouts.ToolStripButtons.OutRemittanceAddTozin,]
                            }),
                        ]
                    }),
                    isc.ToolStrip.create({
                        members: [
                            objTab.Layouts.ToolStripButtons.OutRemittanceAdd,
                            objTab.Layouts.ToolStripButtons.AddTozinToRemittanceDetails,

                            // objTab.Layouts.ToolStripButtons.OutRemittanceAddTozin,
                        ]
                    }),
                    isc.Label.create({
                        height: .06 * innerHeight,
                        align:"right",
                        contents: "<h3 style='text-align: right;padding-right:20px'>"
                            + "پکیج‌ها" +
                            "</h3>"
                    }),
                    objTab.Grids.RemittanceDetailOutRemittance,

                ]
            })]
    });
    objTab.Methods.OutRemittanceSave = async function () {
        if (!objTab.DynamicForms.Forms.OutRemittance.validate()) return;
        const remittanceDetails = objTab.Grids.RemittanceDetailOutRemittance.getData();
        const __remittanceDetails = JSON.parse(JSON.stringify(remittanceDetails))
        const remittance = objTab.DynamicForms.Forms.OutRemittance.getValues();
        const remittanceDetailsWithoutTozin = remittanceDetails.filter(rd => {
                if (rd.outTozin) return false;
                return true;
            }
        )
        if (remittanceDetailsWithoutTozin && remittanceDetailsWithoutTozin.length > 0) {
            objTab.Grids.RemittanceDetailOutRemittance.deselectAllRecords();
            objTab.Grids.RemittanceDetailOutRemittance.selectRecords(remittanceDetailsWithoutTozin);
            return isc.warn('<spring:message code="remittance.records.does.not.have.target.tozin"/>.')
        }
        const remittanceDetailForSend = Object.assign([], remittanceDetails)
        remittanceDetailForSend.forEach(rd => {
            delete rd['destinationTozinId'];
            delete rd['destinationTozin'];
            delete rd['sourceTozinId'];
            delete rd['sourceTozin'];
            delete rd['remittance'];
            delete rd['securityPolompNo'];
            delete rd['railPolompNo'];
            delete rd['remittanceId'];
            delete rd['description'];
            delete rd['description'];
            rd['sourceTozin'] = Object.assign({}, rd['outTozin']);
            rd['sourceTozin']['date']=rd['sourceTozin']['date'].toString().replaceAll("/","");
            rd['description'] = rd['outDescription'];
            rd['inventoryId'] = rd['inventory']['id'];
            delete rd['inventory'];
            delete rd['outDescription'];
            delete rd['outTozin'];
        })
        // objTab.Vars.Method = "POST";
        const dataForSave = {
            remittanceDetails: remittanceDetails,
            remittance: remittance,
        };
        // objTab.Methods.Save(dataForSave, 'api/remittance-detail/out');
        const pleaseWait = isc.Dialog.create({message:"<spring:message code='global.please.wait'/>"})
        const __response =await fetch('api/remittance-detail/out',{
            headers:SalesConfigs.httpHeaders,
            method:"POST",
            body:JSON.stringify(dataForSave)
        })
        const response = await __response.text();
        pleaseWait.destroy();
        if(!__response.ok){
            objTab.Grids.RemittanceDetailOutRemittance.setData(__remittanceDetails);
           return isc.warn('<spring:message code="global.form.response.error"/>\n'+response)
        }
        if(__response.ok){
            isc.say('<spring:message code="global.form.request.successful"/>',_=>{

                objTab.DynamicForms.Forms.OutRemittance.setValue('code',null);
                objTab.DynamicForms.Forms.OutRemittance.setValue('packingContainerId',null);
                const oldValuesTozinTable = objTab.DynamicForms.Forms.TozinTable.getValues();
                objTab.DynamicForms.Forms.TozinTable.setValues({
                        ...oldValuesTozinTable,
                        tozinId:null,
                        date:null,
                        driverName:null,
                        plak:null,
                        vazn:null,
                        isInView:true,
                    }
                );
                objTab.Grids.RemittanceDetailOutRemittance.setData([]);

            })

        }


        // objTab.Vars.Method = "PUT";

    }
    objTab.Layouts.Window.OutRemittance.addMember(
        objTab.Methods.HlayoutSaveOrExit(objTab.Methods.OutRemittanceSave, objTab.Layouts.Window.OutRemittance.ID)
    )
    objTab.Grids.RemittanceDetailOutRemittance.setData(selectedData);
    // console.debug('out remittance detail', objTab.Grids.RemittanceDetailOutRemittance, objTab.DynamicForms.Forms.OutRemittance);
    if (selectedData.length > 0) {
        objTab.DynamicForms.Forms.OutRemittance.setValue("materialItemId", materialItemId);
        objTab.DynamicForms.Forms.TozinTable.setValue('codeKala', materialItemId)
        objTab.Layouts.ToolStripButtons.OutRemittanceAddTozin.enable();
        objTab.Layouts.ToolStripButtons.OutRemittanceAdd.enable();
        objTab.Methods.setShipmentCriteria();
    }
    if(materialItemId) {
        const ___form = objTab.DynamicForms.Forms.OutRemittance;
        const ___item = objTab.DynamicForms.Forms.OutRemittance.getField("materialItemId");
        const ___value = materialItemId;
        ___item.changed(___form,___item,___value)
    };

}