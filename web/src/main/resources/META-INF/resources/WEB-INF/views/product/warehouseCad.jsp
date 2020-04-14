<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_MaterialItem_IN_WAREHOUSECAD = isc.MyRestDataSource.create({
        fields: [{
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

    var RestDataSource_WarehouseCad = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "bijackNo",
            title: "<spring:message code='warehouseCad.bijackNo'/>",
            type: 'text'
        }, {
            name: "materialItem.gdsName",
            title: "<spring:message code='contractItem.material'/>",
            type: 'text'
        }, {
            name: "plant",
            title: "<spring:message code='contractItem.plant'/>",
            type: 'text'
        }, {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCad.warehouseNo'/>",
            type: 'text'
        }, {
            name: "movementType",
            title: "<spring:message code='warehouseCad.movementType'/>",
            type: 'text'
        }, {
            name: "sourceTozinPlantId"
        }, {
            name: "destinationTozinPlantId",
        }, {
            name: "yard",
            title: "<spring:message code='warehouseCad.yard'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "sourceLoadDate",
            title: "<spring:message code='warehouseCad.sourceLoadDate'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "destinationUnloadDate",
            title: "<spring:message code='warehouseCad.destinationUnloadDate'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "rahahanPolompNo",
            title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "herasatPolompNo",
            title: "<spring:message code='warehouseCad.herasatPolompNo'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "containerNo",
            title: "<spring:message code='warehouseCad.containerNo'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "sourceBundleSum",
            title: "<spring:message code='warehouseCad.sourceBundleSum'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "destinationBundleSum",
            title: "<spring:message code='warehouseCad.destinationBundleSum'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "sourceSheetSum",
            title: "<spring:message code='warehouseCad.sourceSheetSum'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "destinationSheetSum",
            title: "<spring:message code='warehouseCad.destinationSheetSum'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }],
        fetchDataURL: "${contextPath}/api/warehouseCad/spec-list"
    });

    isc.ViewLoader.create({
        ID: "WarehouseCadViewLoader",
        width: 830,
        height: 800,
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });

    var Window_Bijack = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        width: 810,
        height: 800,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                WarehouseCadViewLoader
            ]
    });

    function ListGrid_warehouseCAD_refresh() {
        ListGrid_warehouseCAD.invalidateCache();
    }

    function ListGrid_warehouseCAD_edit() {
        var record = ListGrid_warehouseCAD.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message code='global.ok'/>"
                })],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {

            if (record.materialItem.gdsCode == 9 || record.materialItem.gdsCode == 10 || record.materialItem.gdsCode == 11 ||
                record.materialItem.gdsCode == 114 || record.materialItem.gdsCode == 129 || record.materialItem.gdsCode == 86 ||
                record.materialItem.gdsCode == 90 || record.materialItem.gdsCode == 95) {
                WarehouseCadViewLoader.setViewURL("warehouseCad/showWarehouseCadForm");
                Window_Bijack.show();
            }
            if (record.materialItem.gdsCode == 97) {
                WarehouseCadViewLoader.setViewURL("warehouseCad/showWarehouseMoForm");
                Window_Bijack.show();
            }
            if (record.materialItem.gdsCode == 8) {
                WarehouseCadViewLoader.setViewURL("warehouseCad/showWarehouseConcForm");
                Window_Bijack.show();
            }
        }
    }

    function ListGrid_warehouseCAD_remove() {
        var record = ListGrid_warehouseCAD.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [
                        isc.IButtonSave.create(
                            {
                                title: "<spring:message code='global.yes'/>"
                            }),
                        isc.IButtonCancel.create(
                            {
                                title: "<spring:message code='global.no'/>"
                            })
                    ],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var warehouseCadId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/warehouseCad/" + warehouseCadId,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_warehouseCAD_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_warehouseCAD = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_warehouseCAD_refresh();
                }
            },
            <sec:authorize access="hasAuthority('U_WAREHOUSE_CAD')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_warehouseCAD_edit();
                }
            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('D_WAREHOUSE_CAD')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_remove.png",
                click: function () {
                    ListGrid_warehouseCAD_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var ToolStripButton_warehouseCAD_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_warehouseCAD_refresh();
        }
    });

    <sec:authorize access="hasAuthority('U_WAREHOUSE_CAD')">
    var ToolStripButton_warehouseCAD_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_warehouseCAD_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_WAREHOUSE_CAD')">
    var ToolStripButton_warehouseCAD_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_warehouseCAD_remove();
        }
    });
    </sec:authorize>

    var excel = isc.DynamicForm.create({
        method: "POST",
        action: "${contextPath}/warehouseCad/print/",

        autoDraw: true,
        visibility: "hidden",
        target: "_Blank",
        fields: [
            {name: "top", type: "hidden"},
            {name: "fields", type: "hidden"},
            {name: "headers", type: "hidden"},
            {name: "criteria", type: "hidden"}
        ]
    });

    ToolStripButton_WarehouseCAD_Report = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/excel-512.png",
        title: "<spring:message code='global.form.export'/>",
        click: function () {
            const fieldsGrid = ListGrid_warehouseCAD.getFields().filter(
                function (q) {
                    return q.name.toString().toLowerCase() != '$74y'
                });

            const fields = fieldsGrid.map(function (f) {
                return f.name
            });
            const headers = fieldsGrid.map(function (f) {
                return f.title
            });

            var materialId_List = DynamicForm_Material_WarehouseCad.getField("materialId").getValueMap();
            var materialId_Value = DynamicForm_Material_WarehouseCad.getValue("materialId");

            var plant_List = DynamicForm_Plant_WarehouseCad.getField("type").getValueMap();
            var plant_Value = DynamicForm_Plant_WarehouseCad.getValue("type");

            var movementType_List = DynamicForm_MovementType_WarehouseCad.getField("type").getValueMap();
            var movementType_Value = DynamicForm_MovementType_WarehouseCad.getValue("type");

            const material = materialId_List[materialId_Value];
            const plant = plant_List[plant_Value];
            const movementType = movementType_List[movementType_Value];

            const top =
                "------ محصول: " + material +
                "------ واحد تولیدی: " + plant +
                "------ نوع حمل: " + movementType;
            const filterEditorCriteria = ListGrid_warehouseCAD.getCriteria();
            const criterias = [];
            fields.splice(0, 1);
            headers.splice(0, 1);
            if (filterEditorCriteria.criteria == undefined) {
                excel.setValues({
                    top: "",
                    fields: fields,
                    headers: headers,
                    criteria: JSON.stringify({})
                });
            } else {
                filterEditorCriteria.criteria.forEach(function (key, index) {
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
            }
            excel.submitForm();
        }
    });

    var pdf = isc.DynamicForm.create({
        method: "POST",
        action: "${contextPath}/warehouseCad/printJasper",
        autoDraw: true,
        visibility: "hidden",
        target: "_Blank",
        fields:
            [
                {name: "type"},
                {name: "mahsool"},
                {name: "vahed"},
                {name: "haml"},
                {name: "criteria"},
            ]
    });

    var JasperReport_Pdf = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/pdf.png",
        title: "<spring:message code='global.form.export.pdf'/>",

        click: function () {
            let materialId_List_Pdf = DynamicForm_Material_WarehouseCad.getField("materialId").getValueMap();
            let materialId_Value_Pdf = DynamicForm_Material_WarehouseCad.getValue("materialId");
            const material = materialId_List_Pdf[materialId_Value_Pdf];

            let Vahed_tolidi_List_Pdf = DynamicForm_Plant_WarehouseCad.getField("type").getValueMap();
            let Vahed_tolidi_Value_Pdf = DynamicForm_Plant_WarehouseCad.getValue("type");
            const tolidfrom = Vahed_tolidi_List_Pdf[Vahed_tolidi_Value_Pdf];

            if (materialId_List_Pdf != null && materialId_List_Pdf !== 'undefined') {
                const filterEditorCriteria = ListGrid_warehouseCAD.getCriteria();
                const criteria_arr = [];
                filterEditorCriteria.criteria.forEach(key => criteria_arr.add(key));
                filterEditorCriteria.criteria = criteria_arr;
                const criteria = JSON.stringify(filterEditorCriteria);
                pdf.setValue("criteria", criteria);
                pdf.setValue("mahsool", material);
                pdf.setValue("vahed", tolidfrom);
                pdf.setValue("haml", DynamicForm_MovementType_WarehouseCad.getValue("type"));
                pdf.setValue("type", "pdf");
                pdf.submitForm();
            } else {
                isc.say("<spring:message code='department.warning.message'/>");
            }
        }
    });

    var DynamicForm_Material_WarehouseCad = isc.DynamicForm.create({
        wrapItemTitles: false,
        target: "_Blank",
        titleWidth: "200",
        numCols: 4,
        fields: [{
            name: "materialId",
            colSpan: 3,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='contractItem.material'/>",
            type: 'Long',
            editorType: "SelectItem",
            optionDataSource: RestDataSource_MaterialItem_IN_WAREHOUSECAD,
            displayField: "gdsName",
            valueField: "gdsCode",
            pickListProperties: {
                showFilterEditor: true
            },
            pickListFields: [{
                name: "gdsName",
                align: "center"
            },
            // {
            //    name: "id",
            //    hidden: true
            // }
            ],
            defaultValue: 11
        }]
    });

    var DynamicForm_Plant_WarehouseCad = isc.DynamicForm.create({
        wrapItemTitles: false,
        target: "_Blank",
        numCols: 4,
        fields: [{
            name: "type",
            title: "<spring:message code='dailyWarehouse.plant'/>",
            valueMap: {
                "Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
                "Miduk": "<spring:message code='global.Miduk'/>",
                "خاتون": "<spring:message code='global.KhatonAbad'/>",
                "sungun": "<spring:message code='global.Sungun'/>"
            },
            defaultValue: "Sarcheshmeh"
        }]
    });

    var DynamicForm_MovementType_WarehouseCad = isc.DynamicForm.create({
        wrapItemTitles: false,
        target: "_Blank",
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
        }]
    });

    var bijack_criteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {
                fieldName: "materialItem.gdsCode",
                operator: "equals",
                value: DynamicForm_Material_WarehouseCad.getValues().materialId
            },
            {
                fieldName: "plant",
                operator: "contains",
                value: DynamicForm_Plant_WarehouseCad.getValues().type
            },
            {
                fieldName: "movementType",
                operator: "contains",
                value: DynamicForm_MovementType_WarehouseCad.getValues().type
            }
        ]
    };

    var warehouseCAD_searchBtn = isc.IButton.create({
        width: 120,
        title: "<spring:message code='global.search'/>",
        icon: "icon/search.png",
        click: function () {
            var bijack_criteria = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [
                    {
                        fieldName: "materialItem.gdsCode",
                        operator: "equals",
                        value: DynamicForm_Material_WarehouseCad.getValues().materialId
                    },
                    {
                        fieldName: "plant",
                        operator: "contains",
                        value: DynamicForm_Plant_WarehouseCad.getValues().type
                    },
                    {
                        fieldName: "movementType",
                        operator: "contains",
                        value: DynamicForm_MovementType_WarehouseCad.getValues().type
                    }
                ]
            };
            ListGrid_warehouseCAD.setCriteria(bijack_criteria);
            ListGrid_warehouseCAD_refresh();
        }
    });

    var ToolStrip_Actions_warehouseCAD = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                <sec:authorize access="hasAuthority('U_WAREHOUSE_CAD')">
                ToolStripButton_warehouseCAD_Edit,
                </sec:authorize>
                <sec:authorize access="hasAuthority('D_WAREHOUSE_CAD')">
                ToolStripButton_warehouseCAD_Remove,
                </sec:authorize>
                DynamicForm_Material_WarehouseCad,
                DynamicForm_Plant_WarehouseCad,
                DynamicForm_MovementType_WarehouseCad,
                warehouseCAD_searchBtn,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_warehouseCAD_Refresh,
                        ToolStripButton_WarehouseCAD_Report,
                        JasperReport_Pdf
                    ]
                })

            ]
    });

    var HLayout_warehouseCAD_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_warehouseCAD
            ]
    });

    var bijackAttachmentViewLoader = isc.ViewLoader.create(
        {
            autoDraw: false,
            loadingMessage: ""
        });

    var hLayoutViewLoader = isc.HLayout.create({
        width: "100%",
        height: 180,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            bijackAttachmentViewLoader
        ]
    });
    hLayoutViewLoader.hide();

    var ListGrid_warehouseCAD = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_WarehouseCad,
            initialCriteria: bijack_criteria,
            contextMenu: Menu_ListGrid_warehouseCAD,
            styleName: 'expandList',
            autoFetchData: true,
            useClientFiltering: false,
            alternateRecordStyles: true,
            canExpandRecords: true,
            canExpandMultipleRecords: false,
            wrapCells: false,
            showRollOver: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            autoFitExpandField: true,
            virtualScrolling: true,
            loadOnExpand: true,
            loaded: false,
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
                    width: "16.66%"
                },
                {
                    name: "warehouseNo",
                    width: "16.66%"
                },
                {
                    name: "materialItem.gdsName",
                    width: "16.66%",
                    sortNormalizer: function (recordObject) {
                        return recordObject.materialItem.gdsName;
                    }
                },
                {
                    name: "movementType",
                    width: "16.66%"
                },
                {
                    name: "plant",
                    width: "16.66%"
                },
                {
                    name: "sourceLoadDate",
                    width: "16.66%"
                },
                {
                    name: "destinationUnloadDate",
                    width: "16.66%"
                }],
            getExpansionComponent: function (record) {
                if (record == null || record.id == null) {
                    isc.Dialog.create({
                        message: "<spring:message code='global.grid.record.not.selected'/>",
                        icon: "[SKIN]ask.png",
                        title: "<spring:message code='global.message'/>",
                        buttons: [isc.Button.create({
                            title: "<spring:message code='global.ok'/>"
                        })],
                        buttonClick: function () {
                            this.hide();
                        }
                    });
                    record.id = null;
                }
                var dccTableId = record.id;
                var dccTableName = "TBL_WAREHOUSE_CAD";
                bijackAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId);
                hLayoutViewLoader.show();
                var layoutWarehouseCad = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [hLayoutViewLoader]
                });
                return layoutWarehouseCad;
            }
        });

    var HLayout_warehouseCAD_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_warehouseCAD
        ]
    });

    var VLayout_Body_WarehouseCad = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_warehouseCAD_Actions, HLayout_warehouseCAD_Grid
        ]
    });

    isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            border: "1px solid black",
            layoutTopMargin: 5,
            members: [
                isc.SectionStack.create({
                    sections: [{
                        title: "<spring:message code='bijack'/>",
                        items: VLayout_Body_WarehouseCad,
                        showHeader: false,
                        expanded: true
                    }],
                    visibilityMode: "multiple",
                    animateSections: true,
                    height: "100%",
                    width: "100%",
                    overflow: "hidden"
                })
            ]
        });