// <%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<script>
const tozinLiteFields = [
    {
        name: "date",
        type: "text",
        filterEditorProperties: {
            // defaultValue: new persianDate().subtract('d', 14).format('YYYYMMDD'),
            keyPressFilter: "[0-9/]",
            parseEditorValue: function (value, record, form, item) {
                if (value === undefined || value == null || value === '') return value;
                return value.replace(/\//g, '').padEnd(8, "01");
            },
            icons: [{
                src: "pieces/pcal.png",
                click: function (form, item, icon) {
                    // console.log(form)
                    displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                }
            }],
        },
        filterOperator: "greaterOrEqual",
        title: "<spring:message code='Tozin.date'/>",
        align: "center"
    },
    {
        name: "tozinId",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.tozinPlantId'/>"
    },
    {
        name: "driverName",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.driver'/>"
    },
    {
        name: "codeKala",
        type: "number",
        filterEditorProperties: {editorType: "comboBox"},
        valueMap: {11: 'كاتد صادراتي', 8: 'كنسانتره مس ', 97: 'اكسيد موليبدن'},
        title: "<spring:message code='Tozin.codeKala'/>",
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultCodeKala', value)
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
        name: "containerNo1",
        title: "<spring:message code='Tozin.containerNo1'/>",
        align: "center"
    },
    {
        name: "containerNo3",
        type: "number",
        title: "<spring:message code='Tozin.containerNo3'/>",
        align: "center",
        // alwaysShowOperatorIcon:true,
    },
    {
        name: "vazn",
        title: "<spring:message code='Tozin.vazn'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "sourceId",
        type: "number",
        filterEditorProperties: {editorType: "comboBox"},
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultSourceId', value)
            return value;
        },
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "<spring:message code='Tozin.sourceId'/>",
        align: "center"
    },
    {
        name: "targetId",
        type: "number",
        filterEditorProperties: {
            editorType: "comboBox",
            type: "number",
            // defaultValue: StorageUtil.get('on_way_product_defaultTargetId')
        },
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultTargetId', value)
            return value;
        },
        filterOperator: "equals",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "<spring:message code='Tozin.targetId'/>",
        align: "center",
    },
    {
        name: "havalehCode",
        title: "<spring:message code='Tozin.haveCode'/>",
        align: "center"
    },
];
const tozinFields = [...tozinLiteFields,

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

function ListGrid_Tozin_IN_ONWAYPRODUCT_refresh() {
    ListGrid_Tozin_IN_ONWAYPRODUCT.invalidateCache();
}

async function onWayProductFetch(classUrl, operator = "and", criteria = []) {
    const response = await fetch('/sales/api/'
        + classUrl + '/spec-list?_startRow=0&_endRow=1000&operator=' + operator + '&' +
        criteria.map(c => 'criteria=' + encodeURIComponent(JSON.stringify(c))).join('&'),
        {headers: SalesConfigs.httpHeaders});
    // if(response.status>=200 && response.status<300) {
    const json = await response.json();
    return json
    // }
    // return response
}

function mainOnWayProduct() {

    const restDataSource_Tozin_Lite = {
        fields: tozinLiteFields,
        fetchDataURL: "${contextPath}/api/tozin/lite/spec-list"
    };
    const Menu_ListGrid_OnWayProduct = isc.Menu.create({
        width: 150,
        data: [{
            title: "<spring:message code='bijack'/>",
            icon: "product/warehouses.png",
            click: onWayProductCreateRemittance
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
        click: function () {
            const fieldsGrid = ListGrid_Tozin_IN_ONWAYPRODUCT.getFields().filter(
                function (q) {
                    return q.name.toString().toLowerCase() != '$74y';
                });
            const fields = fieldsGrid.map(function (f) {
                return f.name
            });
            const headers = fieldsGrid.map(function (f) {
                return f.title
            });
            /*
            const fromDay_Value = DynamicForm_DailyReport_OnWayProduct.getValue("fromDay");
            const toDay_Value = DynamicForm_DailyReport_Tozin1.getValue("toDay");

            const materialId_List = DynamicForm_DailyReport_Tozin2.getField("materialId").getValueMap();
            const materialId_Value = DynamicForm_DailyReport_Tozin2.getValue("materialId");


            const Vahed_tolidi_List = DynamicForm_DailyReport_Tozin3.getField("type").getValueMap();
            const Vahed_tolidi_Value = DynamicForm_DailyReport_Tozin3.getValue("type");

            const movementType_List = DynamicForm_DailyReport_Tozin4.getField("type").getValueMap();
            const movementType_Value = DynamicForm_DailyReport_Tozin4.getValue("type");
            */
            const material = materialId_List[materialId_Value];
            const vahed_tolidi = Vahed_tolidi_List[Vahed_tolidi_Value];
            const movementType = movementType_List[movementType_Value];

            const top =
                " از تاریخ: " + fromDay_Value +
                "------ تا تاریخ: " + toDay_Value +
                "------ محصول: " + material +
                "------ واحد تولیدی: " + vahed_tolidi +
                "------ نوع حمل: " + movementType;

            const filterEditorCriteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getCriteria();
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
                {name: "haml"},
                {name: "criteria"},
            ]
    });

    const Jasper_Pdf = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/pdf.png",
        title: "<spring:message code='global.form.export.pdf'/>",
        click: function () {
            let materialId_List_Pdf = DynamicForm_DailyReport_Tozin2.getField("materialId").getValueMap();
            let materialId_Value_Pdf = DynamicForm_DailyReport_Tozin2.getValue("materialId");
            const material = materialId_List_Pdf[materialId_Value_Pdf];
            let Vahed_tolidi_List_Pdf = DynamicForm_DailyReport_Tozin3.getField("type").getValueMap();
            let Vahed_tolidi_Value_Pdf = DynamicForm_DailyReport_Tozin3.getValue("type");
            const tolidfrom = Vahed_tolidi_List_Pdf[Vahed_tolidi_Value_Pdf];
            if (materialId_List_Pdf != null && materialId_List_Pdf !== 'undefined') {
                const filterEditorCriteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getCriteria();
                const criteria_arr = [];
                filterEditorCriteria.criteria.forEach(key => criteria_arr.add(key));
                filterEditorCriteria.criteria = criteria_arr;
                const criteria = JSON.stringify(filterEditorCriteria);
                pdf.setValue("criteria", criteria);
                pdf.setValue("dateaval", DynamicForm_DailyReport_OnWayProduct.getValue("fromDay"));
                pdf.setValue("datedovom", DynamicForm_DailyReport_Tozin1.getValue("toDay"));
                pdf.setValue("kala", material);
                pdf.setValue("tolid", tolidfrom);
                pdf.setValue("haml", DynamicForm_DailyReport_Tozin4.getValue("type"));
                pdf.setValue("type", "pdf");
                pdf.submitForm();
            } else {
                isc.say("<spring:message code='department.warning.message'/>");
            }
        }
    });

    const onWayProduct_searchBtn = isc.IButton.create({
        width: 120,
        title: "<spring:message code='global.search'/>",
        icon: "icon/search.png",
        click: function () {
            const filterEditorCriteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
            ListGrid_Tozin_IN_ONWAYPRODUCT.fetchData(filterEditorCriteria)
        }
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
            HLayout_onWayProduct_searchBtn,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    isc.ToolStripButtonRefresh.create({
                        title: "<spring:message code='global.form.refresh'/> پارامترها",
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
        sortField: 'date',
        initialCriteria: {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [
                {"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"}
            ]
        },
        filterData(criteria, callback, requestProperties) {
            criteria.criteria.add({"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"})
            return this.Super("filterData", arguments)

        },
        // filterLocalData: true,
        autoFitMaxRecords: 10,
        dataSource: isc.MyRestDataSource.create(restDataSource_Tozin_Lite),
        // initialCriteria: RestDataSource_TozinInitialCriteria,
        contextMenu: Menu_ListGrid_OnWayProduct,
        autoFetchData: false,
        useClientFiltering: false,
        fields: tozinLiteFields
    });

    const VLayout_Tozin_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Tozin_IN_ONWAYPRODUCT
        ]
    });
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_Actions, VLayout_Tozin_Grid
        ]
    })

    const listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "date",
            operator: "greaterOrEqual",
            value: new persianDate().subtract('d', 14).format('YYYYMMDD'),
        },
            {"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"}
        ]
    };
    if ((targetId = StorageUtil.get('on_way_product_defaultTargetId'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "targetId",
            operator: 'equals',
            value: targetId
        })
    }
    if ((targetId = StorageUtil.get('on_way_product_defaultSourceId'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "sourceId",
            operator: 'equals',
            value: targetId
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
}

mainOnWayProduct()
//</script>