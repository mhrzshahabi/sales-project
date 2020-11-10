// <%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<script>
// isc.DataSource.addSearchOperator({...isc.DataSource.getSearchOperators()['equals'],ID:"bagher",title:"bagher"})

const tozinLiteFields = _ => [
    {
        name: "date",
        type: "text",
        filterEditorProperties: {
            // ID: "bagherrr",
            // defaultValue: new persianDate().subtract('d', 14).format('YYYYMMDD'),
            keyPressFilter: "[0-9/]",

            // parseEditorValue: function (value, record, form, item) {
            //     debugger
            //     if (value === undefined || value == null || value === '') return value;
            //     return value.replace(/\//g, '').padEnd(8, "01");
            // },
            icons: [{
                src: "pieces/pcal.png",
                click: function (form, item, icon) {
                    // // console.log(form)
                    displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                }
            }],
        },
        filterOperator: "greaterOrEqual",
        title: "<spring:message code='Tozin.date'/>",
        align: "center",
        canFilter:false,
        summaryFunction:"count",
        formatCellValue(value, record, rowNum, colNum, grid) {
            try {
                const valStr = value.toString();
                // console.log("date", value);
                return (valStr.substr(0, 4) + "/" + valStr.substr(4, 2) + "/" + valStr.substr(-2))
            } catch (e) {
                return value
            }
        }
    },
    {
        name: "tozinId",
        showHover: true,
        width: "10%",
        filterEditorProperties: {},
        title: "<spring:message code='Tozin.tozinPlantId'/>",

    },
    {
        name: "driverName",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.driver'/>"
    },
    {
        name: "codeKala",showGridSummary:false,
        type: "number",
        filterEditorProperties: {editorType: "comboBox",textMatchStyle:"substring"},
        // valueMap: {11: '<spring:message code="Tozin.export.cathode"/>', 8: '<spring:message code="Tozin.copper.concentrate"/>', 97: '<spring:message code="invoice.molybdenum"/>'},
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().filter(m=>m.shouldShowInFilter).getValueMap('id','gdsName'),
        title: "<spring:message code='goods.title'/>",
        parseEditorValue: function (value, record, form, item) {
            // console.log("        parseEditorValue: function (value, record, form, item) ", value)
            StorageUtil.save('on_way_product_defaultCodeKala', value)
            const selectionType = value === 8 ? "multiple" : "single";
            ListGrid_Tozin_IN_ONWAYPRODUCT.setSelectionType(selectionType);
            return value;
        },
        align: "center"
    },
    {
        name: "plak",
        title: "<spring:message code='Tozin.plak.container'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "containerNo1",hidden:true,
        title: "<spring:message code='Tozin.containerNo1'/>",
        align: "center"
    },
    {
        name: "containerNo3",hidden:true,
        title: "<spring:message code='Tozin.containerNo3'/> - <spring:message code='shipment.type'/>",
        align: "center",
        // formatCellValue(value, record, rowNum, colNum, grid) {
        //     return (value ? "ریلی  " + value : "جاده‌ای"
        //     )
        // },
        // validOperators: ["equals", "isNull", "notNull"],
        // filterEditorProperties: {
        //     showPickerIcon: true,
        //     // showPickerIconOnFocus:true,
        //     picker: isc.FormLayout.create({
        //         visibility: "hidden",
        //         backgroundColor: "white",
        //         items: [{
        //             showTitle: false, type: "radioGroup",
        //             valueMap: {notNull: "ریلی", isNull: "جاده‌ای"},
        //             change: function (f, i, value) {
        //                 const criteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
        //                 criteria.criteria = criteria.criteria.filter(c => c.fieldName !== 'containerNo3');
        //                 criteria.criteria.add({
        //                     fieldName: "containerNo3",
        //                     operator: value
        //                 })
        //                 // console.log(criteria)
        //                 ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(criteria);
        //                 return this.Super("change", arguments)
        //             },
        //         }]
        //     })
        // }
        // alwaysShowOperatorIcon:true,
    },
    {
        name: "vazn",
        title: "<spring:message code='Tozin.vazn'/>",
        align: "center",
        type: "number",
        showHover: true,
        width: "10%",
        summaryFunction: "sum",
    },
    {
        name: "sourceId",showGridSummary:false,
        type: "number",
        // filterEditorProperties: {editorType: "comboBox"},
        filterEditorProperties: {
            editorType: "selectItem",
            multiple: true,
            type: "number",
            click() {
            },
            // defaultValue: StorageUtil.get('on_way_product_defaultTargetId')
        },
        filterOperator: "inSet",
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.delete('on_way_product_defaultSourceId');
            StorageUtil.save('on_way_product_defaultSourceId', value)
            return value;
        },

        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        valueMap: {
            2421: "<spring:message code='tabriz.train.station'/>",
            1540: "<spring:message code='shahrbabak-miduk.copper.complex'/>",
            1541: "<spring:message code='sungun.copper.complex'/>",
            1000: "<spring:message code='sarcheshme.copper.complex'/>",
            1021: "<spring:message code='khaton.abad-shahrbabak.copper.complex'/>",
            2509: "<spring:message code='non-governmental.companies.and.subsidiaries'/>",
            2555: "<spring:message code='shahid.rejaee.wharf'/>",
        },
        title: "<spring:message code='Tozin.sourceId'/>",
        align: "center"
    },
    {
        name: "targetId",showGridSummary:false,
        type: "number",
        filterEditorProperties: {
            editorType: "selectItem",
            click() {
            },
            multiple: true,
            type: "number",
            // defaultValue: StorageUtil.get('on_way_product_defaultTargetId')
        },
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.delete('on_way_product_defaultTargetId')
            StorageUtil.save('on_way_product_defaultTargetId', value)
            return value;
        },
        filterOperator: "inSet",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        valueMap: {
            2320:"<spring:message code='shahid.rejaee.wharf.tidewater'/>",
            1000:"<spring:message code='sarcheshme.copper.complex'/>",
            2340:"<spring:message code='shahid.rejaee.no20.warehouse'/>",
            2555:"<spring:message code='shahid.rejaee.wharf'/>",
        },
        showHover: true,
        title: "<spring:message code='Tozin.targetId'/>",
        align: "center",
    },
    {
        name: "havalehCode",hidden:true,
        title: "<spring:message code='Tozin.haveCode'/>",
        align: "center"
    },
    {name: "isRail", type: "boolean", title: "<spring:message code='warehouseCad.with.rail'/>"}
];
const tozinFields = _ => [...tozinLiteFields(),

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


];
const createdTozinList = [];

function ListGrid_Tozin_IN_ONWAYPRODUCT_refresh() {
    ListGrid_Tozin_IN_ONWAYPRODUCT.invalidateCache();
}

async function onWayProductFetch(classUrl, operator = "and", criteria = []) {
    const response = await fetch('/sales/api/'
        + classUrl + '/spec-list?operator=' + operator + '&' +
        criteria.map(c => 'criteria=' + encodeURIComponent(JSON.stringify(c))).join('&'),
        {headers: SalesConfigs.httpHeaders});
    // if(response.status>=200 && response.status<300) {
    const json = await response.json();
    return json
    // }
    // return response
}

function mainOnWayProduct() {
    const owpTab={
        DynamicForm:{Form:{},Field:{}}
    };
    async function getMaxDateInDestionationTozin(codeKala) {
        // const criteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
        const criteria = {
            criteria: [
                {
                    fieldName: "tozinId",
                    operator: "iStartsWith",
                    value: "3"
                },
                {
                    fieldName: "codeKala",
                    operator: "equals",
                    value: Number(codeKala)
                },
                {
                    fieldName: "sourceId",
                    operator: "notEqual",
                    value: 2555
                },
            ]
        };
        const option = await fetch(
            'api/tozin/lite/spec-list?_startRow=0&_endRow=1&_sortBy=-date&operator=and&criteria='
            + criteria
                .criteria
                .map(_ => {
                    return JSON.stringify(_)
                })
                .join('&criteria=')
            , {headers: SalesConfigs.httpHeaders})
        const response = await option.json();
        dbg(option)
        if (option.ok && response.response && response.response.data && response.response.data.length > 0) {
            const date = response.response.data[0].date;
            const year = date.toString().substr(0,4)
            const month = date.toString().substr(4,2)
            const day = date.toString().substr(6,2)
            stats.setValue(codeKala.toString(),year + '/' + month + '/' + day)
            //dbg(true,response)
        }
    }

    dbg(getMaxDateInDestionationTozin);
    const restDataSource_Tozin_Lite = {
        fields: tozinLiteFields(),
        fetchDataURL: "${contextPath}/api/tozin/lite/spec-list"
    };
    const Menu_ListGrid_OnWayProduct = isc.Menu.create({
        width: 150,
        data: [{
            title: " <spring:message code='Tozin.new'/> <spring:message code='bijack'/>",
            icon: "product/warehouses.png",
            click() {
                if (ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecords().length < 1)
                    return isc.warn("<spring:message code='please.fill.tozin'/>");


                onWayProductCreateRemittance();
            }
        }]
    });
    const ToolStripButton_Tozin_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Tozin_IN_ONWAYPRODUCT_refresh();
        }
    });
    const excel = isc.DynamicForm.create({
        method: "POST",
        action: "${contextPath}/tozin/print/",
        autoDraw: true,
        visibility: "hidden",
        target: "_Blank",
        fields: [
            {name: "top"},
            {name: "fields"},
            {name: "headers"},
            {name: "criteria"}
        ]
    });

    const ToolStripButton_Tozin_Report = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/excel-512.png",
        title: "<spring:message code='global.form.export.excel'/>",
        visibility: "hidden",
        click: function () {
            const fieldsGrid = tozinFields().filter(
                function (q) {
                    return q.name.toString().toLowerCase() != '$74y';
                });
            const fields = [];
            fieldsGrid.forEach(function (f) {
                if (!['driverName', 'havalehCode'].contains(f.name))
                    fields.add(f.name)
            });
            const headers = [];
            fieldsGrid.forEach(function (f) {
                if (!['driverName', 'havalehCode'].contains(f.name))
                    headers.add(f.title)
            });

            const top = "";
            const filterEditorCriteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
            const criterias = [];
            filterEditorCriteria.criteria.forEach(function (key) {
                criterias.add(key);
            });
            filterEditorCriteria.criteria = criterias;
            const criteria = JSON.stringify(filterEditorCriteria);
            excel.setValues({
                top: top,
                fields: fields,
                headers: headers,
                criteria: criteria
            });
            excel.submitForm();
        }
    });

    const pdf = isc.DynamicForm.create({
        method: "POST",
        action: "${contextPath}/tozin/report",
        autoDraw: true,
        visibility: "hidden",
        target: "_Blank",
        fields:
            [
                {name: "type"},
                {name: "dateaval"},
                {name: "datedovom"},
                {name: "kala"},
                {name: "tolid"},
                // {name: "haml"},
                {name: "criteria"},
            ]
    });

    const Jasper_Pdf = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/pdf.png",
        title: "<spring:message code='global.form.export.pdf'/>",
        click: function () {


            const criteria1 = ListGrid_Tozin_IN_ONWAYPRODUCT.getCriteria();
            criteria1.criteria.forEach(c=>{
                if(c.fieldName==="dateStr")c.fieldName="date"
            })
            const criteria = JSON.stringify(criteria1);
            pdf.setValue("criteria", criteria);
            pdf.setValue("type", "pdf");

            // const dateaval = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria().criteria.find(c => c.fieldName === 'date').value
            pdf.setValue("dateaval", owpTab.DynamicForm.Form.ToDate.getValue("fromDate"));
            pdf.setValue("datedovom", owpTab.DynamicForm.Form.ToDate.getValue("fromDate"));
            pdf.setValue("kala", SalesBaseParameters.getSavedMaterialItemParameter().find(
                sp => sp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria()
                    .criteria.find(c => c.fieldName === 'codeKala').value
            )['gdsName']);
            pdf.setValue("tolid", SalesBaseParameters.getSavedWarehouseParameter().find(
                sp => sp.id === Number(ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria()
                    .criteria.find(c => c.fieldName === 'sourceId').value[0]
                ))['name']);

            // console.log(pdf.getValues());

            pdf.submitForm();


        }
    });

    const onWayProduct_searchBtn = isc.IButton.create({
        width: 120,
        title: "<spring:message code='global.search'/>",
        icon: "icon/search.png",
        click: _ => {
            const filterEditorCriteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
            ListGrid_Tozin_IN_ONWAYPRODUCT.filterData(filterEditorCriteria)}
    });

    const HLayout_onWayProduct_searchBtn = isc.HLayout.create({
        align: "center",
        members:
            [
                onWayProduct_searchBtn
            ]
    });

    const ToolStrip_Actions_Tozin = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 10,
        align: "center",
        members: [
            //    <sec:authorize access="hasAuthority('C_REMITTANCE')">
            isc.IButton.create({
                title: Menu_ListGrid_OnWayProduct.data[0].title,
                click: Menu_ListGrid_OnWayProduct.data[0].click
            }),
            //    </sec:authorize>
           owpTab.DynamicForm.Form.ToDate= isc.DynamicForm.create({
               numCols:4,
                fields:[
                    owpTab.DynamicForm.Field.FromDate=isc.FormItem.create({
                    title:"<spring:message code='dailyWarehouse.fromDay'/>",
                        name:'fromDate',
                        defaultValue:new persianDate().subtract('days',7       ).format('YYYY/MM/DD'),
                        wrapTitle:false,
                        icons: [{
                            src: "pieces/pcal.png",
                            click: function (form, item, icon) {
                                // console.log(form)
                                displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                            }
                        }],
                        width:150,
                    }),
                    owpTab.DynamicForm.Field.ToDate=isc.FormItem.create({
                    title:"<spring:message code='dailyWarehouse.toDay'/>",
                        name:'toDate',
                        defaultValue:new persianDate().format('YYYY/MM/DD'),
                        wrapTitle:false,
                        icons: [{
                            src: "pieces/pcal.png",
                            click: function (form, item, icon) {
                                // console.log(form)
                                displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                            }
                        }],
                        width:150,
                    }),
                ],
            }),
            HLayout_onWayProduct_searchBtn,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    isc.ToolStripButtonRefresh.create({
                        title: "<spring:message code='global.form.refresh.parameters'/>",
                        visibility: "hidden",
                        click: function () {
                            SalesBaseParameters.getAllParameters(true).then(
                                res => {
                                }
                            );
                        }
                    }),
                    ToolStripButton_Tozin_Refresh, ToolStripButton_Tozin_Report, Jasper_Pdf
                ]
            })

        ]
    });

    const HLayout_Tozin_Actions = isc.HLayout.create({
        width: "100%",
        overflow: "auto",
        height: 56,
        members:
            [
                ToolStrip_Actions_Tozin
            ]
    });
    const ListGrid_Tozin_IN_ONWAYPRODUCT = isc.ListGrid.create({
        ID: "ListGrid_Tozin_IN_ONWAYPRODUCT",
        alternateRecordStyles: true,
        width: "100%",
        height: "100%",
        showRowNumbers: true,
        showFilterEditor: true,
        allowAdvancedCriteria: true,
        filterOnKeypress: false,
        canHover: true,
        selectionType: "single",
        sortField: 'date',

        filterData(criteria, callback, requestProperties) {
            // dbg(false, 'async filterData(criteria', arguments)
            // criteria.criteria.add({"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"})
            if(criteria && criteria.criteria && criteria.criteria.length>0)
                criteria.criteria=criteria.criteria.filter(_=>_.fieldName!=='date');
            if (!criteria.criteria.find(t => t.fieldName === "sourceId")) {
                isc.say('<spring:message code="please.fill.source"/>')
                throw '<spring:message code="please.fill.source"/>'
            }
            if (!criteria.criteria.find(t => t.fieldName === "targetId")) {
                isc.say('<spring:message code="please.fill.target"/>')
                throw "<spring:message code='shipment.Bol.tblPortByDischarge'/> چی شد"
            }
            if (!criteria.criteria.find(t => t.fieldName === "codeKala")) {
                isc.say('<spring:message code="please.fill.product"/>')
                throw "<spring:message code='goods.title'/> چی شد"
            }
            if (!criteria.criteria.find(_ => _.fieldName === "tozinId" && _.operator === "iNotStartsWith" && _.value === "3-"))
                criteria.criteria.add({"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"})
            if (!criteria.criteria.find(_ => _.fieldName === "tozinTable" && _.operator === "isNull"))
                criteria.criteria.add({"fieldName": "tozinTable", "operator": "isNull"})
            const foundDateStr = criteria.criteria.find(_ => _.fieldName === "dateStr" && _["operator"] === "iBetweenInclusive");
            if (!foundDateStr){
                criteria.criteria.add({"fieldName": "dateStr", "operator": "iBetweenInclusive",
                    "start":owpTab.DynamicForm.Form.ToDate.getValue('fromDate').toString().replaceAll("/",""),
                    "end":owpTab.DynamicForm.Form.ToDate.getValue('toDate').toString().replaceAll("/","")
                })
            }

            if (foundDateStr)
            {   foundDateStr[ "start"]=owpTab.DynamicForm.Form.ToDate.getValue('fromDate').toString().replaceAll("/","");
            foundDateStr["end"]=owpTab.DynamicForm.Form.ToDate.getValue('toDate').toString().replaceAll("/","");
            }


            dbg(true,arguments)
            return this.Super('filterData', arguments);
            // await criteriaBuildForListGrid()
            // arguments[0] = this.getFilterEditorCriteria();
            // return this.Super("filterData", arguments)
        },

        // filterLocalData: true,
        autoFitMaxRecords: 10,
        dataSource: isc.MyRestDataSource.create(restDataSource_Tozin_Lite),
        // initialCriteria: RestDataSource_TozinInitialCriteria,
        //    <sec:authorize access="hasAuthority('C_REMITTANCE')">
        contextMenu: Menu_ListGrid_OnWayProduct,
        //     </sec:authorize>
        autoFetchData: false,
        useClientFiltering: false,
        fields: tozinLiteFields(),
        showGridSummary:true,
    });

    let stats;
    const VLayout_Tozin_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Tozin_IN_ONWAYPRODUCT,
        ]
    });
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_Actions,             stats = isc.DynamicForm.create({
                numCols: 8,
                fields: [
                    {name: "info", title: "<spring:message code='lastArrival.to.BandarAbbas.warehouse'/>", type: "staticText"},
                    {name: "11", title: "<spring:message code='cathode.title'/>", type: "staticText"},
                    {name: "97", title: "<spring:message code='molybdenum.title'/>", type: "staticText"},
                    {name: "8", title: "<spring:message code='Tozin.copper.concentrate'/>", type: "staticText"}
                ]
            }),
            VLayout_Tozin_Grid
        ]
    })

    const listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "date",
            operator: "greaterOrEqual",
            value: new persianDate().subtract('d', 14).format('YYYY/MM/DD'),
        },
            // {"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"}
        ]
    };
    if ((targetId = StorageUtil.get('on_way_product_defaultTargetId'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "targetId",
            operator: 'inSet',
            value: targetId
        })
    }
    if ((sourceId = StorageUtil.get('on_way_product_defaultSourceId'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "sourceId",
            operator: 'inSet',
            value: sourceId
        })
    }
    if ((codeKala = StorageUtil.get('on_way_product_defaultCodeKala'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "codeKala",
            operator: 'equals',
            value: codeKala
        })
    }


    ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria)

    getMaxDateInDestionationTozin(11)
    getMaxDateInDestionationTozin(8)
    getMaxDateInDestionationTozin(97)
}

mainOnWayProduct()


//</script>