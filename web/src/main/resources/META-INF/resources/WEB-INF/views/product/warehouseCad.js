//<%@ page contentType="text/html;charset=UTF-8" %>
//  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
// <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

const randIntID = Math.random().toString().substr(-6);
const remittanceDetailFields = [
    {name: "remittance.code", title: "شماره بیجک"},
    {
        name: "sourceTozin.tozinId",
        title: "توزین مبدا",
    },
    {
        name: "destinationTozin.tozinId",
        title: "توزین مقصد",
    },
    {name: "id", hidden: true, type: "number"},
    {name: "remittance.id", hidden: true},
    {
        name: "inventory.label",
        title: "سریال محصول",
    },
    {
        name: "amount",
        title: "تعداد محصول",
    },
    {
        name: "unit.id",
        valueMap: SalesBaseParameters.getSavedUnitParameter().getValueMap('id', 'nameFA'),
        type: "number",
        title: "واحد",

    },
    {
        name: "inventory.materialItem.id",
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
        type: "number",
        title: "محصول",

    },
    {
        name: "destinationTozin.sourceId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مبدا",

    },
    {
        name: "destinationTozin.date",
        title: "تاریخ توزین مقصد",

    },
    {
        name: "destinationTozin.targetId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مقصد",

    },
    {
        name: "description",
        title: "توضیحات",
    },
    {
        name: "weight",
        title: "وزن",
    },
    {
        name: "securityPolompNo",
        title: "پلمپ حراست",
    },
    {
        name: "railPolompNo",
        title: "پلمپ راه‌آهن",
    },

];
const remittanceDetailDS = {
    fetchDataURL: "api/remittance-detail/spec-list",
    fields: remittanceDetailFields
};
const remittanceDetailLG = {
    ID: "remittance_detail_tab_list_grid" + randIntID,
    showFilterEditor: true,
    allowAdvancedCriteria: true,
    groupByField: "remittance.code",
    // dataSource: isc.MyRestDataSource.create(remittanceDetailDS),
    autoFetchData: true
}
isc.VLayout.create({
    members: [
        isc.ToolStrip.create({
            members: [
                isc.ToolStripButtonRefresh.create({
                    click() {
                        window[remittanceDetailLG['ID']].invalidateCache()
                    }
                })]
        }),
        isc.ListGrid.create({
            ...remittanceDetailLG,
            dataSource: isc.MyRestDataSource.create(remittanceDetailDS),
        })
    ]
})