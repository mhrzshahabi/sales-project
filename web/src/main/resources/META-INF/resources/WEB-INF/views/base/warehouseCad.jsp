<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
            name: "materialItemgdsName", dataPath:"materialItem.gdsName"  ,
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
        height: 700,
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });

    var Window_Bijack = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        width: 830,
        height: 700,
        autoSize:true,
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
               buttonClick: function() {
                   this.hide();
               }
           });
       } else {
           if (record.materialItemId === 4 || record.materialItemId === 5 || record.materialItemId === 6 ||
               record.materialItemId === 15 || record.materialItemId === 18 || record.materialItemId === 22 ||
               record.materialItemId === 25 || record.materialItemId === 26) {
               BijackViewLoader.setViewURL("warehouseCad/showWarehouseCadForm");
               Window_Bijack.show();
           }
           if (record.materialItemId === 13 || record.materialItemId === 27) {
               BijackViewLoader.setViewURL("warehouseCad/showWarehouseMoForm");
               Window_Bijack.show();
           }
           if (record.materialItemId === 3) {
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
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_warehouseCAD_edit();
                }
            }/*,
            {
                title: "<spring:message code='global.form.print'/>", icon: "icon/word.png", click: function () {
                    var record = ListGrid_warehouseCAD.getSelectedRecord();
                    "<spring:url value="/warehouseCad/print/" var="printUrl"/>"
                    window.open('${printUrl}'+record.id);
                }
            }*/
        ]
    });

    var ToolStripButton_warehouseCAD_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_warehouseCAD_refresh();
        }
    });

    var ToolStripButton_warehouseCAD_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_warehouseCAD_edit();
        }
    });

    var ToolStrip_Actions_warehouseCAD = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_warehouseCAD_Refresh,
                ToolStripButton_warehouseCAD_Edit
            ]
    });

    var HLayout_warehouseCAD_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_warehouseCAD
            ]
    });

    var ListGrid_warehouseCAD = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseCad,
        contextMenu: Menu_ListGrid_warehouseCAD,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bijackNo", width: "16.66%"},
                {name: "warehouseNo" , width: "16.66%"},
                {name: "materialItem.gdsName", width: "16.66%"},
                {name: "movementType", width: "16.66%"},
                {name: "plant", width: "16.66%"},
                {name: "sourceLoadDate", width: "16.66%"},
                {name: "destinationUnloadDate",width: "16.66%"}
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }
    });

    var HLayout_warehouseCAD_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_warehouseCAD
        ]
    });

    VLayout_Body_WarehouseCad = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_warehouseCAD_Actions, HLayout_warehouseCAD_Grid
        ]
    });

    isc.ViewLoader.create({
        ID: "bijackAttachmentViewLoader",
        autoDraw: false,
        loadingMessage: ""
    });

    isc.TabSet.create({
        ID: "bijackMainTabSet",
        tabBarPosition: "top",
        width: "100%",
        height: "100%",
        tabs: [
            {
                ID: "bijackTab",
                title: "<spring:message code='bijack'/>",
                icon: "",
                iconSize: 16,
                pane: VLayout_Body_WarehouseCad
            },
            {
                title: "<spring:message code='bijackAttach.title'/>",
                icon: "",
                iconSize: 16,
                pane: bijackAttachmentViewLoader,
                tabSelected: function (form, item, value) {
                    var record = ListGrid_warehouseCAD.getSelectedRecord();
                    if (record == null || record.id == null) {
                        isc.Dialog.create({
                            message: "<spring:message code='global.grid.record.not.selected'/>",
                            icon: "[SKIN]ask.png",
                            title: "<spring:message code='global.message'/>",
                            buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                            buttonClick: function () {
                                this.hide();
                            }
                        });
                        record.id = null;
                    }
                    var dccTableId = record.id;
                    var dccTableName = "TBL_WAREHOUSE_CAD";
                    bijackAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
                }
            }
        ]
    });
    isc.VLayout.create({
        ID: "bijackMainVLayout",
        width: "100%",
        height: "100%",
        backgroundColor: "",
        members: [bijackMainTabSet]
    });