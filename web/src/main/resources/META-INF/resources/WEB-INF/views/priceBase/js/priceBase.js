var priceBaseTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
priceBaseTab.variable.elementUrl = "http://localhost:8080/sales" + "/api/element/";
priceBaseTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    name: "priceDate",
    width: "10%",
    type: 'date',
    title: "<spring:message code='priceBase.date'/>"
},{
    type: 'number',
    name: "elementId",
    title: "<spring:message code='priceBase.element'/>",
    width: "300",
    required: true,
    autoFetchData: false,
    editorType: "SelectItem",
    valueField: "id",
    displayField: "name",
    pickListHeight: "300",
    optionDataSource: isc.MyRestDataSource.create({
        fields: BaseFormItems.concat([
            {name: "name"}
        ]),
        fetchDataURL: priceBaseTab.variable.elementUrl + "spec-list"
    }),
    pickListFields: [
        {name: "name", title: '<spring:message code="priceBase.element"/>'}
    ]
},{
    name: "priceBaseReference",
    width: "300",
    required: true,
    title: "<spring:message code='priceBase.reference'/>",
    valueMap: {
        0: "LME",
        1: "MetalsWeek"
    }
},{
    name: "price",
    width: "300",
    type: "double",
    title: "<spring:message code='priceBase.price'/>"
}];
Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.listGrid.main.contextMenu = null;
priceBaseTab.dynamicForm.main.windowWidth = 500;
