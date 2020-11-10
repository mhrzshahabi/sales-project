var RestDataSource_Material = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true,
        },
        {
            name: "code",
            title: "<spring:message code='material.code'/> ",
        },
        {
            name: "descEN",
            title: "<spring:message code='material.descEN'/> ",
        },
        {
            name: "descFA",
            title: "<spring:message code='material.descFA'/> ",
        },
        {
            name: "unitId",
            title: "<spring:message code='MaterialFeature.unit'/>",
        },
        {
            name: "unit.nameFA",
            title: "<spring:message code='MaterialFeature.unit.FA'/>",
            align: "center",
        },
        {
            name: "unit.nameEN",
            title: "<spring:message code='MaterialFeature.unit'/> ",
        },
        {
            name: "abbreviation",
            title: "<spring:message code='material.abbreviation'/> ",
        },
    ],
    fetchDataURL: "${contextPath}" + "/api/material/spec-list",

});
var RestDataSource_MaterialItem_IN_MATERIAL = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true,
        },
        {
            name: "gdsCode",
            title: "<spring:message code='MaterialItem.gdsCode'/> ",
        },
        {
            name: "gdsNameFA",
            title: "<spring:message code='MaterialItem.gdsNameFA'/> ",
        },
        {
            name: "materialId",
            hidden: true,
        },
        {
            name: "miDetailCode",
            title: "<spring:message code='MaterialItem.detailCode'/> ",
        },
        {
            name: "gdsNameEN",
            title: "<spring:message code='MaterialItem.gdsNameEN'/> ",
        },
    ],
    fetchDataURL: "${contextPath}" + "/api/materialItem/spec-list",
});

function ListGrid_Material_refresh() {
    ListGrid_Material.invalidateCache();
}

var ToolStripButton_Material_Refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        ListGrid_Material_refresh();
    }
});

var ToolStrip_Actions_Material = isc.ToolStrip.create({
    width: "100%",
    members: [
        isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: "0px",
            members: [ToolStripButton_Material_Refresh],
        }),
    ],
});

var HLayout_Material_Actions = isc.HLayout.create({
    width: "100%",
    members:
        [
            ToolStrip_Actions_Material
        ]
});

var recordNotFound = isc.Label.create({
    height: 30,
    padding: 10,
    align: "center",
    valign: "center",
    wrap: false,
    contents: "<spring:message code='global.record.find'/>"
});
recordNotFound.hide();

var ListGrid_Material = isc.ListGrid.create({
    showFilterEditor: true,
    width: "100%",
    height: "100%",
    dataSource: RestDataSource_Material,
    styleName: "expandList",
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
    sortField: 2,
    fields: [
        { name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true },
        { name: "code", title: "<spring:message code='material.code'/>", align: "center", showIf: "false" },
        { name: "descEN", title: "<spring:message code='material.descEN'/>", align: "center" },
        { name: "descFA", title: "<spring:message code='material.descFA'/>", align: "center" },
        { name: "abbreviation", title: "<spring:message code='material.abbreviation'/>", align: "center" },
        {
            name: "unit.nameFA",
            title: "<spring:message code='MaterialFeature.unit.FA'/>",
            align: "center",
            sortNormalizer: function (recordObject) {
                return recordObject.unit.nameFA;
            },
        },
        {
            name: "unit.nameEN",
            title: "<spring:message code='MaterialFeature.unit.ENG'/>",
            align: "center",
            sortNormalizer: function (recordObject) {
                return recordObject.unit.nameEN;
            },
        },
    ],
    filterData: function () {
        ListGrid_Material.collapseRecords(ListGrid_Material.getExpandedRecords());
        this.Super("filterData", arguments);
    },
    getExpansionComponent: function (record) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: record.id}],
        };

        ListGrid_MaterialItem.fetchData(
            criteria1,
            function (dsResponse, data, dsRequest) {
                if (data.length == 0) {
                    recordNotFound.show();
                    ListGrid_MaterialItem.hide();
                } else {
                    recordNotFound.hide();
                    ListGrid_MaterialItem.setData(data);
                    ListGrid_MaterialItem.setAutoFitMaxRecords(1);
                    ListGrid_MaterialItem.show();
                }
            },
            { operationId: "00" }
        );

        var layoutMaterial = isc.VLayout.create({
            styleName: "expand-layout",
            padding: 5,
            membersMargin: 10,
            members: [ListGrid_MaterialItem, recordNotFound, ],
        });

        return layoutMaterial;
    },
});

var HLayout_Material_Grid = isc.HLayout.create({
    width: "100%",
    height: "100%",
    members: [
        ListGrid_Material
    ]
});

var VLayout_Material_Body = isc.VLayout.create({
    width: "100%",
    height: "99%",
    members: [
        HLayout_Material_Actions, HLayout_Material_Grid
    ]
});

function ListGrid_MaterialItem_refresh() {
    ListGrid_MaterialItem.invalidateCache();
    var record = ListGrid_Material.getSelectedRecord();
    if (record == null || record.id == null) return;
    var criteria1 = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{ fieldName: "materialId", operator: "equals", value: record.id }],
    };
    ListGrid_MaterialItem.fetchData(
        criteria1,
        function (dsResponse, data, dsRequest) {
            ListGrid_MaterialItem.setData(data);
        },
        { operationId: "00" }
    );
}

var ToolStripButton_MaterialItem_Refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        ListGrid_MaterialItem_refresh();
    }
});

var ToolStrip_Actions_MaterialItem = isc.ToolStrip.create({
    width: "100%",
    members: [

        isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: "0px",
            members: [ToolStripButton_MaterialItem_Refresh],
        }),
    ],
});

var HLayout_MaterialItem_Actions = isc.HLayout.create({
    width: "100%",
    members:
        [
            ToolStrip_Actions_MaterialItem
        ]
});


var ListGrid_MaterialItem = isc.ListGrid.create({
    showFilterEditor: true,
    width: "100%",
    styleName: "listgrid-child",
    height: 180,
    dataSource: RestDataSource_MaterialItem_IN_MATERIAL,
    setAutoFitExtraRecords: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    numCols: 2,
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
        },
        {
            name: "materialId",
            type: "long",
            hidden: true,
        },
        {
            name: "gdsCode",
            width: "48%",
            title: "<spring:message code='MaterialItem.gdsCode'/> ",
            showIf: "false",
        },
        {
            name: "gdsNameFA",
            width: "24%",
            title: "<spring:message code='MaterialItem.gdsNameFA'/> ",
        },
        {
            name: "miDetailCode",
            width: "24%",
            title: "<spring:message code='MaterialItem.detailCode'/> ",
        },
        {
            name: "gdsNameEN",
            width: "24%",
            title: "<spring:message code='MaterialItem.gdsNameEN'/> ",
        },

    ],
    autoFetchData: false,
});

var HLayout_MaterialItem_Grid = isc.HLayout.create({
    width: "100%",
    members: [ListGrid_MaterialItem],
});

var VLayout_MaterialItem_Body = isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [HLayout_MaterialItem_Actions, HLayout_MaterialItem_Grid],
});

isc.SectionStack.create({
    sections: [
        {
            title: "<spring:message code='ProductGroup'/>",
            items: VLayout_Material_Body,
            showHeader: false,
            expanded: true,
        },
        {
            title: "<spring:message code='Product'/>",
            hidden: true,
            items: VLayout_MaterialItem_Body,
            expanded: false,
        },
    ],
    visibilityMode: "multiple",
    animateSections: true,
    height: "100%",
    width: "100%",
    overflow: "hidden",
});
