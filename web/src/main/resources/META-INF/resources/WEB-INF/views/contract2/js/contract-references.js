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
                Object.assign({
                    name: "loadPortId",
                    title: "<spring:message code='shipment.loading'/>",

                    align: "center"
                }, getFieldProperties("Reference", "Port")),
                {
                    name: "quantity",
                    title: "<spring:message code='global.quantity'/>",
                    width: "10%",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true
                    }]
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
                        }]
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: "date",
                    required: false,
                    width: "10%",
                    wrapTitle: false
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
        case 'RateReference':
            url = "";
            break;
        case 'PriceBaseReference':
            url = "";
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
                keyPressFilter: "[0-9.]"
            };
        case 'Integer':
        case 'Long':
            return {
                type: "integer",
                keyPressFilter: "[0-9]"
            };
        case 'String':
            return {
                type: "text",
            };
        case 'Reference':
            return {
                width: "100%",
                type: "integer",
                editorType: "SelectItem",
                valueField: "id",
                autoFetchData: false,
                optionDataSource: isc.MyRestDataSource.create({
                    fields: getReferenceFields(reference),
                    fetchDataURL: "${contextPath}/api/" + reference.toLowerCase() + "/spec-list"
                }),
                displayField: getReferenceFields(reference)[1].name
            };
        case 'Column':
        default:
            break;
    }

    return null;
}
