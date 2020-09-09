function getReferenceCriteria(idValues) {
    return {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "id", operator: "equals", value: idValues}
        ]
    }
}

function getReferenceFields(referenceType) {

    switch (referenceType) {
        case 'ContractShipment':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractDetailValueId", hidden: true},
                {
                    name: "loadPortId",
                    type: "integer",
                    width: "100%",
                    title: "<spring:message code='shipment.loading'/>",
                    align: "center",
                    editorType: "SelectItem",
                    valueField: "id",
                    displayField: getReferenceFields("Port")[1].name,
                    autoFetchData: false,
                    optionDataSource: getReferenceDataSource("Port"),
                    showTemplate: true,
                    templateDataFieldName: "loadPort.port"
                },
                {
                    name: "quantity",
                    title: "<spring:message code='global.quantity'/>",
                    width: "10%",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true
                    }],
                    showTemplate: true
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='contractItemShipment.tolorance'/>",
                    keyPressFilter: "[0-9.]",
                    width: "10%",
                    align: "center",
                    validators: [
                        {
                            type: "isInteger",
                            validateOnChange: true,
                            keyPressFilter: "[0-9.]"
                        }],
                    showTemplate: true
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: "date",
                    required: false,
                    width: "10%",
                    showTemplate: true
                }
            ];
        case 'Bank':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'bankName', title: "<spring:message code='bank.nameFa'/>"}
            ]
        case 'Contact':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'nameFA', title: "<spring:message code='contact.nameFa'/>"}
            ]
        case 'Country':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'nameFa', title: "<spring:message code='country.nameFa'/>"}
            ]
        case 'Material':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'descp', title: "<spring:message code='material.descp'/>"}
            ]
        case 'Port':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'port', title: "<spring:message code='port.port'/>"}
            ]
        case 'Unit':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: 'nameFA', title: "<spring:message code='unit.nameFa'/>"}
            ]
        case 'Incoterm':
            return [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "title", title: '<spring:message code="global.title"/>'},
                {name: "incotermVersion", title: '<spring:message code="global.version"/>'}
            ]
        case 'TypicalAssay':
            return [
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
                            {
                                name: "elementName",
                                title: '<spring:message code="assayInspection.materialElement.name"/>'
                            },
                            {name: "material.descl", title: '<spring:message code="material.descl"/>'}
                        ]),
                        fetchDataURL: "${contextPath}/api/materialElement/" + "spec-list"
                    }),
                    pickListFields: [
                        {name: "elementName", title: '<spring:message code="assayInspection.materialElement.name"/>'},
                        {name: "material.descl", title: '<spring:message code="material.descl"/>'}
                    ]
                }
            ]
        case 'RateReference':
            return '';
        case 'PriceBaseReference':
            return '';
        default:
            return null;
    }
}

function getReferenceDataSource(referenceType) {

    let url = "";
    switch (referenceType) {
        case 'ContractShipment':
            url = "${contextPath}" + "/api/contractShipment/spec-list";
            break;
        case 'Bank':
            url = "${contextPath}" + "/api/bank/spec-list";
            break;
        case 'Contact':
            url = "${contextPath}" + "/api/contact/spec-list";
            break;
        case 'Country':
            url = "${contextPath}" + "/api/country/spec-list";
            break;
        case 'Material':
            url = "${contextPath}" + "/api/material/spec-list";
            break;
        case 'Port':
            url = "${contextPath}" + "/api/port/spec-list";
            break;
        case 'Unit':
            url = "${contextPath}" + "/api/unit/spec-list";
            break;
        case 'Incoterm':
            url = "${contextPath}" + "/api/g-incoterm/list-contract";
            break;
        case 'IncotermRules':
            url = "${contextPath}" + "/api/g-incoterm/incoterm-rules";
            break;
        case 'TypicalAssay':
            url = "${contextPath}" + "/api/typicalAssay/spec-list";
            break;
        default:
            return null;
    }

    return isc.MyRestDataSource.create({
        fetchDataURL: url,
        fields: getReferenceFields(referenceType)
    });
}

function getContactByType(contactType) {
    var contactCommons = {
        width: "100%",
        editorType: "SelectItem",
        optionCriteria: {
            operator: 'and',
            criteria: [{
                fieldName: 'buyer',
                operator: 'equals',
                value: true
            }]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "nameFA"},
                {name: "nameEN"}
            ],
            fetchDataURL: "${contextPath}/api/contact/spec-list"
        }),
        autoFetchData: false,
        displayField: "nameEN",
        valueField: "id",
        title: "<spring:message code='contact.commercialRole.buyer'/>"
    };

    switch (contactType) {
        case 'buyer':
            contactCommons.required = true;
            contactCommons.name = "buyerId";
            contactCommons.optionCriteria.criteria[0].fieldName = "buyer";
            contactCommons.title = "<spring:message code='contact.commercialRole.buyer'/>";
            break;
        case 'seller':
            contactCommons.required = true;
            contactCommons.name = "sellerId";
            contactCommons.optionCriteria.criteria[0].fieldName = "seller";
            contactCommons.title = "<spring:message code='contact.commercialRole.seller'/>";
            break;
        case 'agentBuyer':
            contactCommons.name = "agentBuyerId";
            contactCommons.optionCriteria.criteria[0].fieldName = "agentBuyer";
            contactCommons.title = "<spring:message code='contact.commercialRole.agentBuyer'/>";
            break;
        case 'agentSeller':
            contactCommons.name = "agentSellerId";
            contactCommons.optionCriteria.criteria[0].fieldName = "agentSeller";
            contactCommons.title = "<spring:message code='contact.commercialRole.agentSeller'/>";
            break;
    }
    return contactCommons;
}

function getFieldProperties(fieldType, reference) {
    switch (fieldType) {
        case 'PersianDate':
            return {
                length: 10,
                textAlign: "center",
                type: 'text',
                icons: [persianDatePicker]
            };
        case 'GeorgianDate':
            return {
                type: "date",
                textAlign: "center"
            };
        case 'Boolean':
            return {
                type: "boolean"
            };
        case 'BigDecimal':
        case 'Float':
        case 'Double':
            return {
                type: "float",
                keyPressFilter: "[0-9.+-]"
            };
        case 'Integer':
        case 'Long':
            return {
                type: "integer",
                keyPressFilter: "[0-9+-]"
            };
        case 'String':
            return {
                type: "text",
            };
        case 'Reference':
            if (reference == 'Enum_RateReference') {
                return {valueMap: JSON.parse('${Enum_RateReference}')}
            }
            if (reference == 'Enum_PriceBaseReference') {
                return {valueMap: JSON.parse('${Enum_PriceBaseReference}')}
            }
            return {
                width: "100%",
                type: "integer",
                editorType: "SelectItem",
                valueField: "id",
                autoFetchData: false,
                optionDataSource: getReferenceDataSource(reference),
                displayField: getReferenceFields(reference)[1].name
            };
        case 'Column':
        default:
            break;
    }

    return null;
}
