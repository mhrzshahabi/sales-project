var typicalAssayTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

typicalAssayTab.dynamicForm.fields = BaseFormItems.concat([
    {name: "id", hidden: true, width: "10%"},
    {
        name: "minValue",
        title: "<spring:message code='MaterialFeature.minValue'/>",
        width: "100%"
    },
    {
        name: "maxValue",
        title: "<spring:message code='MaterialFeature.maxValue'/>",
        width: "100%"
    },
    {
        name: "unitId",
        title: "<spring:message code='global.unit'/>",
        width: "100%",
        type: "long",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameEN",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "nameFA"},
                {name: "nameEN"}
            ]),
            fetchDataURL: "${contextPath}/api/unit/" + "spec-list"
        }),
        pickListFields: [
            {name: "nameFA", title: '<spring:message code="unit.nameFa"/>'},
            {name: "nameEN", title: '<spring:message code="unit.nameEN"/>'}
        ]
    },
    {
        name: "materialElementId",
        title: "<spring:message code='assayInspection.materialElement'/>",
        width: "100%",
        type: "long",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "elementName",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "elementName", title: '<spring:message code="assayInspection.materialElement.name"/>'},
                {name: "material.descl", title: '<spring:message code="material.descl"/>'}
            ]),
            fetchDataURL: "${contextPath}/api/materialElement/" + "spec-list"
        }),
        pickListFields: [
            {name: "elementName", title: '<spring:message code="assayInspection.materialElement.name"/>'},
            {name: "material.descl", title: '<spring:message code="material.descl"/>'}
        ]/*,
        changed: function (form,item,value) {
            item.getSelectedRecord().elementname = item.getSelectedRecord().element.name
            item.redraw();
        }*/
    }
]);

Object.assign(typicalAssayTab.listGrid.fields, typicalAssayTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(typicalAssayTab, "api/typicalAssay");
typicalAssayTab.dynamicForm.main.windowWidth = 700;
