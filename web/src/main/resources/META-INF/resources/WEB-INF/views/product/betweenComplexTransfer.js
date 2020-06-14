//<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
//    <%@ page contentType="text/html;charset=UTF-8" %>
//    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<% DateUtil dateUtil = new DateUtil();%>
//<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

(function () {
    const onWayProductValueMaps = {
        goods: [],
        warehouse: [],
        unit: []
    }

    function setOnWayProductValueMaps(key, value) {
        onWayProductValueMaps[key] = value;
        // console.log(onWayProductValueMaps)
        let allOnWayProductValueMapsAreReady = true;
        Object.values(onWayProductValueMaps).forEach(v => {
            if (v.length === 0) {
                allOnWayProductValueMapsAreReady = false
            }
        })
        if (allOnWayProductValueMapsAreReady) loadOnWayProduct()
    }

    const fieldsAllOnWayProductValueMaps = ['goods', 'warehouse', 'unit']
    fieldsAllOnWayProductValueMaps.forEach(value => {
        SalesBaseParameters.getParameter(value).then(
            js => {
                const theName = value.toLowerCase() !== "unit" ? "name" : "nameFA";
                // console.log(value, theName);
                setOnWayProductValueMaps(value, js.getValueMap("id", theName));
            }
        )


        return;
        fetch(SalesConfigs.Urls.RootUrl + "/api/" + value + "/list", {headers: SalesConfigs.httpHeaders})
            .then(
                response => response.json()
                    .then(
                        js => {
                            const theName = value.toLowerCase() !== "unit" ? "name" : "nameFA";
                            // console.log(value, theName);
                            setOnWayProductValueMaps(value, js.getValueMap("id", theName));
                        }
                    )
            )
    })

    function loadOnWayProduct() {
        function ListGrid_Tozin_IN_ONWAYPRODUCT_refresh() {
            ListGrid_Tozin_IN_ONWAYPRODUCT.invalidateCache();
        }

        const RestDataSource_Tozin_IN_ONWAYPRODUCT = isc.MyRestDataSource.create({
            fields: [
                {
                    name: "source",
                    title: "<spring:message code='Tozin.source'/>",
                    align: "center"
                },
                {
                    name: "tozinId",
                    title: "<spring:message code='Tozin.tozinPlantId'/>",
                    align: "center"
                },
                {
                    name: "nameKala",
                    title: "<spring:message code='Tozin.nameKala'/>",
                    align: "center"
                },
                {
                    name: "codeKala",
                    type: "number",
                    valueMap: onWayProductValueMaps.goods,
                    filterEditorValueMap: onWayProductValueMaps.goods,
                    title: "<spring:message code='Tozin.codeKala'/>",
                    align: "center"
                },
                {
                    name: "target",
                    title: "<spring:message code='Tozin.target'/>",
                    align: "center"
                },
                {
                    name: "cardId",
                    title: "<spring:message code='Tozin.cardId'/>",
                    align: "center"
                },
                {
                    name: "plak",
                    title: "<spring:message code='Tozin.plak'/>",
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
                    align: "center"
                },
                {
                    name: "containerNo1",
                    title: "<spring:message code='Tozin.containerNo1'/>",
                    align: "center"
                },
                {
                    name: "containerNo3",
                    title: "<spring:message code='Tozin.containerNo3'/>",
                    align: "center"
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
                    name: "vazn",
                    title: "<spring:message code='Tozin.vazn'/>",
                    align: "center"
                },
                {
                    name: "tedad",
                    title: "<spring:message code='Tozin.tedad'/>",
                    align: "center"
                },
                {
                    name: "unitKala",
                    type: "number",
                    valueMap: onWayProductValueMaps.unit,
                    filterEditorValueMap: onWayProductValueMaps.unit,
                    title: "<spring:message code='Tozin.unitKala'/>",
                    align: "center"
                },
                {
                    name: "packName",
                    title: "<spring:message code='Tozin.packName'/>",
                    align: "center"
                },
                {
                    name: "haveCode",
                    title: "<spring:message code='Tozin.haveCode'/>",
                    align: "center"
                },
                {
                    name: "date",
                    title: "<spring:message code='Tozin.date'/>",
                    align: "center"
                },
                {
                    name: "tozinDate",
                    title: "<spring:message code='Tozin.tozinDate'/>",
                    align: "center"
                },
                {
                    name: "tozinTime",
                    title: "<spring:message code='Tozin.tozinTime'/>",
                    align: "center"
                },
                {
                    name: "sourceId",
                    type: "number",
                    title: "<spring:message code='Tozin.sourceId'/>",
                    align: "center"
                },
                {
                    name: "targetId",
                    type: "number",
                    title: "<spring:message code='Tozin.targetId'/>",
                    align: "center",
                    valueMap: onWayProductValueMaps.warehouse,
                    filterEditorValueMap: onWayProductValueMaps.warehouse

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
                    name: "havalehTo",
                    title: "<spring:message code='Tozin.havalehTo'/>",
                    align: "center"
                },
                {
                    name: "havalehDate",
                    title: "<spring:message code='Tozin.havalehDate'/>",
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
                }
            ],
            fetchDataURL: "${contextPath}/api/tozin/spec-list"
        });

        const RestDataSource_MaterialItem_IN_ONWAYPRODUCT = isc.MyRestDataSource.create({
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    hidden: true
                },
                {
                    name: "gdsCode",
                    title: "<spring:message code='goods.code'/> "
                },
                {
                    name: "gdsName"
                },
                {
                    name: "materialId"
                }
            ],
            fetchDataURL: "${contextPath}/api/materialItem/spec-list"
        });

        const DynamicForm_DailyReport_OnWayProduct = isc.DynamicForm.create({
            wrapItemTitles: false,
            target: "_Blank",
            visibility: 'hidden', numCols: 4,
            fields: [{
                name: "fromDay", visibility: 'hidden',
                ID: "fromDayDate",
                title: "<spring:message code='dailyWarehouse.fromDay'/>",
                type: 'text',
                align: "center",
                width: 130,
                colSpan: 1,
                titleColSpan: 1,
                icons: [{
                    src: "pieces/pcal.png",
                    click: function () {
                        displayDatePicker('fromDayDate', this, 'ymd', '/');
                    }
                }],
                defaultValue: "1399/01/01"
            }]
        });

        const DynamicForm_DailyReport_Tozin1 = isc.DynamicForm.create({
            wrapItemTitles: false,
            action: "report/printDailyReportBandarAbbas",
            target: "_Blank",
            titleWidth: "200", visibility: 'hidden',
            numCols: 4,
            fields: [{
                name: "toDay",
                ID: "toDayDateOnWayProduct",
                title: "<spring:message code='dailyWarehouse.toDay'/>",
                type: 'text',
                align: "center",
                width: 130,
                colSpan: 1,
                titleColSpan: 1,
                icons: [{
                    src: "pieces/pcal.png",
                    click: function () {
                        displayDatePicker('toDayDateOnWayProduct', this, 'ymd', '/');
                    }
                }],
                defaultValue: "<%=DateUtil.todayDate()%>"
            }]
        });

        const DynamicForm_DailyReport_Tozin2 = isc.DynamicForm.create({
            wrapItemTitles: false,
            target: "_Blank", visibility: 'hidden',
            titleWidth: "200",
            numCols: 4,
            fields: [{
                name: "materialId",
                colSpan: 3,
                titleColSpan: 1,
                showHover: true,
                autoFetchData: false,
                title: "<spring:message code='contractItem.material'/>",
                type: 'long',
                editorType: "SelectItem",
                optionDataSource: RestDataSource_MaterialItem_IN_ONWAYPRODUCT,
                displayField: "gdsName",
                valueField: "gdsCode",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [{
                    name: "gdsName",
                    align: "center"
                }],
                defaultValue: 11
            }]
        });

        const DynamicForm_DailyReport_Tozin3 = isc.DynamicForm.create({
            wrapItemTitles: false,
            target: "_Blank", visibility: 'hidden',
            numCols: 4,
            fields: [{
                name: "type",
                title: "<spring:message code='dailyWarehouse.plant'/>",
                valueMap: {
                    "1-": "<spring:message code='global.Sarcheshmeh'/>",
                    "2-": "<spring:message code='global.KhatonAbad'/>",
                    "4-": "<spring:message code='global.Miduk'/>",
                    "5-": "<spring:message code='global.Sungun'/>"
                },
                defaultValue: "1-"
            }]
        });

        const DynamicForm_DailyReport_Tozin4 = isc.DynamicForm.create({
            wrapItemTitles: false,
            target: "_Blank", visibility: 'hidden',
            titleWidth: "200",
            numCols: 4,
            fields: [{
                name: "type",
                width: 130,
                title: "<spring:message code='warehouseCad.movementType'/>",
                valueMap: {
                    "جاده ای": "جاده ای",
                    "ریلی": "ریلی"
                },
                defaultValue: "ریلی"
            },]
        });

        const Menu_ListGrid_OnWayProduct = isc.Menu.create({
            width: 150,
            data: [{
                title: "<spring:message code='bijack'/>",
                icon: "product/warehouses.png",
                click: function () {
                    var record = ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord();
                    if (record.codeKala === 9 || record.codeKala === 10 || record.codeKala === 11 ||
                        record.codeKala === 114 || record.codeKala === 129 || record.codeKala === 86 ||
                        record.codeKala === 90 || record.codeKala === 95) {
                        OnWayProductViewLoader.setViewURL("tozin/showWarehouseCadForm");
                        Window_BijackOnWayProduct.show();
                    }
                    if (record.codeKala === 97 || record.codeKala === 100) {
                        OnWayProductViewLoader.setViewURL("tozin/showWarehouseMoForm");
                        Window_BijackOnWayProduct.show();
                    }
                    if (record.codeKala === 8) {
                        OnWayProductViewLoader.setViewURL("tozin/showWarehouseConcForm");
                        Window_BijackOnWayProduct.show();
                    }
                }
            }]
        });

        isc.ViewLoader.create({
            ID: "OnWayProductViewLoader",
            width: 830,
            height: 630,
            autoDraw: false,
            loadingMessage: " <spring:message code='global.loadingMessage'/>"
        });

        const Window_BijackOnWayProduct = isc.Window.create({
            title: "<spring:message code='bijack'/> ",
            width: 830,
            height: 630,
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
                OnWayProductViewLoader
            ]
        });

        const ToolStripButton_Tozin_Refresh = isc.ToolStripButtonRefresh.create({
            title: "<spring:message code='global.form.refresh'/>",
            click: function () {
                ListGrid_Tozin_IN_ONWAYPRODUCT_refresh();
            }
        });
        const ToolStripButton_Parameters_Refresh = isc.ToolStripButtonRefresh.create({
            title: "<spring:message code='global.form.refresh'/> پارامترها",
            click: function () {
                SalesBaseParameters.getAllParameters(true).then(
                    res => {
                        console.log('ToolStripButton_Parameters_Refresh', res);
                        onWayProductValueMaps['goods'] = res['goods'];
                        onWayProductValueMaps['unit'] = res['unit'];
                        onWayProductValueMaps['warehouse'] = res['warehouse'];
                        ListGrid_Tozin_IN_ONWAYPRODUCT.setFieldValueMap('sourceId', res['warehouse'])
                        ListGrid_Tozin_IN_ONWAYPRODUCT.setFieldValueMap('targetId', res['warehouse'])
                        ListGrid_Tozin_IN_ONWAYPRODUCT.setFieldValueMap('codeKala', res['goods'])
                        ListGrid_Tozin_IN_ONWAYPRODUCT.setFieldValueMap('unitKala', res['unit'])
                    }
                );
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

                const fromDay_Value = DynamicForm_DailyReport_OnWayProduct.getValue("fromDay");
                const toDay_Value = DynamicForm_DailyReport_Tozin1.getValue("toDay");

                const materialId_List = DynamicForm_DailyReport_Tozin2.getField("materialId").getValueMap();
                const materialId_Value = DynamicForm_DailyReport_Tozin2.getValue("materialId");


                const Vahed_tolidi_List = DynamicForm_DailyReport_Tozin3.getField("type").getValueMap();
                const Vahed_tolidi_Value = DynamicForm_DailyReport_Tozin3.getValue("type");

                const movementType_List = DynamicForm_DailyReport_Tozin4.getField("type").getValueMap();
                const movementType_Value = DynamicForm_DailyReport_Tozin4.getValue("type");

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
            width: 110,
            height: 40,
            margin: 5,
            title: "<spring:message code='global.search'/>",
            icon: "icon/search.png",
            click: function () {
                ListGrid_Tozin_IN_ONWAYPRODUCT.fetchData(ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria())
            }
        });


        const onWayProduct_ClearBtn = isc.IButton.create({
            width: 150,
            height: 40,
            margin: 5,
            title: "<spring:message code='global.clear.filters'/>",
            icon: "pieces/16/icon_delete.png",
            click: function () {
                ListGrid_Tozin_IN_ONWAYPRODUCT.clearFilterValues()
            }
        });


        const HLayout_onWayProduct_searchBtn = isc.HLayout.create({
            align: "center",
            members:
                [
                    onWayProduct_searchBtn, onWayProduct_ClearBtn
                ]
        });

        const ToolStrip_Actions_Tozin = isc.ToolStrip.create({
            width: "100%",
            membersMargin: 10,
            align: "center",
            members: [
                // DynamicForm_DailyReport_OnWayProduct,
                //DynamicForm_DailyReport_Tozin1,
                //DynamicForm_DailyReport_Tozin2,
                //DynamicForm_DailyReport_Tozin3,
                //DynamicForm_DailyReport_Tozin4,
                HLayout_onWayProduct_searchBtn,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Parameters_Refresh, ToolStripButton_Tozin_Refresh, ToolStripButton_Tozin_Report, Jasper_Pdf
                    ]
                })

            ]
        });

        const HLayout_Tozin_Actions = isc.HLayout.create({
            width: "100%",
            overflow: "auto",
            height: "7%",
            members:
                [
                    ToolStrip_Actions_Tozin,
                ]
        });

        const RestDataSource_TozinInitialCriteria = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [
                {
                    fieldName: "tozinDate",
                    operator: "greaterOrEqual",
                    value: DynamicForm_DailyReport_OnWayProduct.getValues().fromDay
                },
                {
                    fieldName: "tozinDate",
                    operator: "lessOrEqual",
                    value: DynamicForm_DailyReport_Tozin1.getValues().toDay
                },
                {
                    fieldName: "codeKala",
                    operator: "equals",
                    value: DynamicForm_DailyReport_Tozin2.getValues().materialId
                },
                {
                    fieldName: "tozinId",
                    operator: "contains",
                    value: DynamicForm_DailyReport_Tozin3.getValues().type
                },
                {
                    fieldName: "target",
                    operator: "iContains",
                    value: "رجا"
                },
                {
                    fieldName: "carName",
                    operator: "contains",
                    value: 'انتينر'
                }
            ]
        };

        const ListGrid_Tozin_IN_ONWAYPRODUCT = isc.ListGrid.create({
            alternateRecordStyles: true,
            width: "100%",
            height: "100%",
            showRowNumbers: true,
            showFilterEditor: true,
            filterOnKeypress: false,
            allowAdvancedCriteria: true,
            filterLocalData: false,
            autoFitMaxRecords: 10,
            dataSource: RestDataSource_Tozin_IN_ONWAYPRODUCT,
            // initialCriteria: RestDataSource_TozinInitialCriteria,
            // contextMenu: Menu_ListGrid_OnWayProduct,
            autoFetchData: false,
            useClientFiltering: false,
            sortField: 'tozinDate',
            fields: [
                {
                    name: "tozinDate",
                    filterOperator: "greaterOrEqual",
                    filterEditorProperties: {
                        defaultValue: new persianDate().toLocale('en').subtract('d', 14).format('YYYY/MM/DD'),
                        icons: [{
                            src: "pieces/pcal.png",
                            click: function (form, item, icon) {
                                // console.log(form)
                                displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                            }
                        }],
                    },
                    showHover: true,
                    width: "10%",
                    title: "<spring:message code='Tozin.tozinDate'/>"
                },
                {
                    name: "plak",
                    title: "<spring:message code='Tozin.plak.container'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "containerId",
                    title: "<spring:message code='Tozin.containerId'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "vazn",
                    title: "<spring:message code='Tozin.vazn'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "tedad",
                    title: "<spring:message code='Tozin.tedad'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "codeKala",
                    type: "number",
                    valueMap: onWayProductValueMaps.goods,
                    filterEditorValueMap: onWayProductValueMaps.goods,
                    title: "<spring:message code='Tozin.nameKala'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "sourceId",
                    filterEditorProperties: {editorType: "comboBox"},
                    type: "number",
                    title: "<spring:message code='Tozin.source'/>",
                    align: "center",
                    showHover: true,
                    valueMap: onWayProductValueMaps.warehouse,
                    filterEditorValueMap: onWayProductValueMaps.warehouse,

                    width: "10%"
                },
                {
                    name: "targetId",
                    filterEditorProperties: {editorType: "comboBox"},
                    type: "number",
                    title: "<spring:message code='Tozin.target'/>",
                    align: "center",
                    showHover: true,
                    width: "10%",
                    valueMap: onWayProductValueMaps.warehouse,
                    filterEditorValueMap: onWayProductValueMaps.warehouse
                },
                {
                    name: "haveCode",
                    title: "<spring:message code='Tozin.haveCode'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "unitKala",
                    type: "number",
                    valueMap: onWayProductValueMaps.unit,
                    filterEditorValueMap: onWayProductValueMaps.unit,
                    title: "<spring:message code='Tozin.packName'/>",
                    align: "center",
                    showHover: true,
                    width: "10%"
                },
                {
                    name: "tozinId",
                    showHover: true,
                    width: "10%",
                    title: "<spring:message code='Tozin.tozinPlantId'/>"
                },

            ]
        });

        const VLayout_Tozin_Grid = isc.VLayout.create({
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Tozin_IN_ONWAYPRODUCT
            ]
        });
        mainTabSet.getTab(mainTabSet.selectedTab).setPane(isc.VLayout.create({
            width: "100%",
            height: "100%",
            members: [
                HLayout_Tozin_Actions
                , VLayout_Tozin_Grid
            ]
        }))
    }
})()

