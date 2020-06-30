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
        align: "center",
        formatCellValue(value, record, rowNum, colNum, grid) {
            return (value.substr(0, 4) + "/" + value.substr(4, 2) + "/" + value.substr(-2))
        }
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
        // filterEditorProperties: {editorType: "comboBox"},
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
        // filterEditorProperties: {editorType: "comboBox"},
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultSourceId', value)
            return value;
        },
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
        align: "center"
    },
    {
        name: "targetId",
        type: "number",
        // filterEditorProperties: {
        //     editorType: "comboBox",
        //     type: "number",
        //     // defaultValue: StorageUtil.get('on_way_product_defaultTargetId')
        // },
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultTargetId', value)
            return value;
        },
        filterOperator: "equals",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),

        valueMap: {
            2320: 'بندر شهيد رجايي، روبروي اسكله شانزده ،محوطه فلزات آلياژي شركت تايد واتر',
            1000: 'مجتمع مس سرچشمه',
            2340: 'بندر شهيد رجايي ، انبار كالا شماره 20',
            2555: 'اسكله شهيد رجائي ',
        },
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
            const fieldsGrid = tozinFields.filter(
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


            const criteria = JSON.stringify(ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria());
            pdf.setValue("criteria", criteria);
            pdf.setValue("type", "pdf");


            pdf.setValue("dateaval", ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria()
                .criteria.find(c => c.fieldName === 'date').value);
            pdf.setValue("datedovom", new persianDate().format('YYYY/MM/DD'));
            pdf.setValue("kala", SalesBaseParameters.getSavedMaterialItemParameter().find(
                sp => sp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria()
                    .criteria.find(c => c.fieldName === 'codeKala').value
            )['gdsName']);
            pdf.setValue("tolid", SalesBaseParameters.getSavedWarehouseParameter().find(
                sp => sp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria()
                    .criteria.find(c => c.fieldName === 'targetId').value
            )['name']);

            console.log(pdf.getValues());

            pdf.submitForm();


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
            if (!criteria.criteria.find(t => t.fieldName === "sourceId")) {
                isc.say('فیلتر مقصد خالی‌ می‌یاشد')
                throw 'فیلتر مقصد خالی‌ می‌یاشد'
            }
            if (!criteria.criteria.find(t => t.fieldName === "targetId")) {
                isc.say('فیلتر مقصد خالی‌ می‌یاشد')
                throw "مبدا چی شد"
            }
            if (!criteria.criteria.find(t => t.fieldName === "codeKala")) {
                isc.say('لطفا محصول انتخاب نمایید')
                throw "مبدا چی شد"
            }
            return this.Super("filterData", arguments)

        },
        getFilterEditorCriteria() {
            const criteria = this.Super('getFilterEditorCriteria', arguments);

            if (!criteria.criteria.find(t => t.fieldName === "sourceId")) {
                isc.say('فیلتر مقصد خالی‌ می‌یاشد')
                throw 'فیلتر مقصد خالی‌ می‌یاشد'
            }
            if (!criteria.criteria.find(t => t.fieldName === "targetId")) {
                isc.say('فیلتر مقصد خالی‌ می‌یاشد')
                throw "مبدا چی شد"
            }
            if (!criteria.criteria.find(t => t.fieldName === "codeKala")) {
                isc.say('لطفا محصول انتخاب نمایید')
                throw "مبدا چی شد"
            }

            return criteria;
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
    if ((sourceId = StorageUtil.get('on_way_product_defaultSourceId'))) {
        listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria.criteria.add({
            fieldName: "sourceId",
            operator: 'equals',
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
}

mainOnWayProduct()
//</script>