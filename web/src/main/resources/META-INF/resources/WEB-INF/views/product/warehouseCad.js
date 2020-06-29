//<%@ page contentType="text/html;charset=UTF-8" %>
//  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
// <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

isc.VLayout.create({
    members: [
        isc.ListGrid.create({
            showFilterEditor: true,
            allowAdvancedCriteria: true,
            groupByField: "remittance.code",
            dataSource: isc.MyRestDataSource.create({
                fetchDataURL: "api/remittance-detail/spec-list",
                fields: [
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

                ]
            }),
            autoFetchData: true
        })
    ]
})