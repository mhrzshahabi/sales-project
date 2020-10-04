//<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
//    <%@ page contentType="text/html;charset=UTF-8" %>
//    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<% DateUtil dateUtil = new DateUtil();%>
//<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

// (function () {
// SalesBaseParameters.getAllParameters().then(all => loadOnWayProduct(all))
function loadOnWayProduct() {
    const paramaters = SalesBaseParameters.getAllSavedParameter();
    function ListGrid_Tozin_IN_ONWAYPRODUCT_refresh() {
        ListGrid_Tozin_IN_ONWAYPRODUCT.invalidateCache();
    }
    const tozinFields = [
        {
            name: "tozinDate",
            filterOperator: "greaterOrEqual",
            filterEditorProperties: {
                // defaultValue: new persianDate().toLocale('en').subtract('d', 14).format('YYYY/MM/DD'),
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
            valueMap: paramaters.materialItem.getValueMap('id', 'gdsName'),
            // filterEditorValueMap: onWayProductValueMaps.goods,
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
            valueMap: paramaters.warehouse.getValueMap('id', 'name'),
            // filterEditorValueMap: onWayProductValueMaps.warehouse,
            width: "10%",

        },
        {
            name: "targetId",
            filterEditorProperties: {editorType: "comboBox"},
            type: "number",
            title: "<spring:message code='Tozin.target'/>",
            align: "center",
            showHover: true,
            width: "10%",
            valueMap: paramaters.warehouse.getValueMap('id', 'name'),
            // filterEditorValueMap: onWayProductValueMaps.warehouse
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
            valueMap: paramaters.unit.getValueMap('id', 'name'),
            // filterEditorValueMap: onWayProductValueMaps.unit,
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

    ];
    const RestDataSource_Tozin_IN_ONWAYPRODUCT = isc.MyRestDataSource.create({
        fields: tozinFields,
        fetchDataURL: "${contextPath}/api/tozin/spec-list"
    });
    const ToolStripButton_Tozin_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Tozin_IN_ONWAYPRODUCT_refresh();
        }
    });
    const ToolStripButton_Parameters_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/> پارامترها",
        visibility: "hidden",
        click: function () {
            SalesBaseParameters.getAllParameters(true).then(
                res => {

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
        visibility: "hidden",

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
                {name: "haml"},
                {name: "criteria"},
            ]
    });

    const Jasper_Pdf = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/pdf.png",
        title: "<spring:message code='global.form.export.pdf'/>",
        visibility: "hidden",

        click: function () {


            const criteria = JSON.stringify(ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria());
            pdf.setValue("criteria", criteria);

            pdf.setValue("type", "pdf");
            pdf.submitForm();

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
            },
            {
                fieldName: "tozinDate",
                operator: "lessOrEqual",
            },
            {
                fieldName: "codeKala",
                operator: "equals",
            },
            {
                fieldName: "tozinId",
                operator: "contains",
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
                    // defaultValue: new persianDate().toLocale('en').subtract('d', 14).format('YYYY/MM/DD'),
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
                valueMap: paramaters.materialItem.getValueMap('id', 'gdsName'),
                // filterEditorValueMap: onWayProductValueMaps.goods,
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
                valueMap: paramaters.warehouse.getValueMap('id', 'name'),
                // filterEditorValueMap: onWayProductValueMaps.warehouse,
                width: "10%",

            },
            {
                name: "targetId",
                filterEditorProperties: {editorType: "comboBox"},
                type: "number",
                title: "<spring:message code='Tozin.target'/>",
                align: "center",
                showHover: true,
                width: "10%",
                valueMap: paramaters.warehouse.getValueMap('id', 'name'),
                // filterEditorValueMap: onWayProductValueMaps.warehouse
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
                valueMap: paramaters.unit.getValueMap('id', 'name'),
                // filterEditorValueMap: onWayProductValueMaps.unit,
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
    // mainTabSet.getTab(mainTabSet.selectedTab).setPane(
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_Actions
            , VLayout_Tozin_Grid
        ]
    });
    // )
    const listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "tozinDate",
            operator: "greaterOrEqual",
            value: new persianDate().subtract('d', 14).format('YYYY/MM/DD'),
        },
            // {"fieldName": "tozinId", "operator": "iNotStartsWith", "value": "3-"}
        ]
    };
    ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(listGrid_Tozin_IN_ONWAYPRODUCT_fiter_editor_criteria)

}

loadOnWayProduct()
// })()

