<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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
        ID: "BijackViewLoader",
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
                BijackViewLoader
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

            if (record.materialItem.gdsCode === '9' || record.materialItem.gdsCode === '10' || record.materialItem.gdsCode === '11' ||
                record.materialItem.gdsCode === '114' || record.materialItem.gdsCode === '129' || record.materialItem.gdsCode === '86' ||
                record.materialItem.gdsCode === '90' || record.materialItem.gdsCode === '95') {
                BijackViewLoader.setViewURL("warehouseCad/showWarehouseCadForm");
                Window_Bijack.show();
            }
            if (record.materialItem.gdsCode === '97') {
                BijackViewLoader.setViewURL("warehouseCad/showWarehouseMoForm");
                Window_Bijack.show();
            }
            if (record.materialItem.gdsCode === '8') {
                BijackViewLoader.setViewURL("warehouseCad/showWarehouseConcForm");
                Window_Bijack.show();
            }
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
            }
            </sec:authorize>
        ]
    });

    var ToolStripButton_warehouseCAD_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
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

    var excel = isc.DynamicForm.create({
        method: "POST",
        action: "${contextPath}/warehouseCad/print/",
        canSubmit: true,
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
        ID: "exportButton",
        icon: "[SKIN]/actions/excel-512.png",
        title: "<spring:message code='global.form.export'/>",
        click: function () {
            const fieldsGrid = ListGrid_warehouseCAD.getFields().filter(
                function (q) {
                    return q.name.toString().toLowerCase() !== 'grouptitle'
                });

            const fields = fieldsGrid.map(function (f) {
                return f.name
            });
            const headers = fieldsGrid.map(function (f) {
                return f.title
            });

            excel.setValues({
                top: "",
                fields: fields,
                headers: headers,
                criteria: ""
            });
            excel.submitForm();
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

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_warehouseCAD_Refresh, ToolStripButton_WarehouseCAD_Report
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
            contextMenu: Menu_ListGrid_warehouseCAD,
            styleName: 'expandList',
            autoFetchData: true,
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
                    width: "16.66%"
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
            sortField: 0,
            showFilterEditor: true,
            filterOnKeypress: true,
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
                bijackAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
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