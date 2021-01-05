//**********************************************************************************************************************

var materialElementField = {
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
                name: "element.name",
                title: '<spring:message code="assayInspection.materialElement.name"/>'
            },
            {name: "material.descEN", title: '<spring:message code="material.descEN"/>'}
        ]),
        fetchDataURL: "${contextPath}/api/materialElement/spec-list"
    }),
    pickListFields: [
        {name: "element.name", title: '<spring:message code="assayInspection.materialElement.name"/>'},
        {name: "material.descEN", title: '<spring:message code="material.descEN"/>'}
    ],
    pickListProperties: {
        showFilterEditor: true
    }
};

//**********************************************************************************************************************

function getAllFields(_object) {

    if (typeof (_object) !== 'object') return [_object];

    const keys = (_object == null ? [] : Object.keys(_object));
    const fields = keys.filter(_ => !_.toString().startsWith('_') && !_.toString().startsWith('$') && typeof _object[_] !== 'object');
    const internalObj = keys.filter(_ => !_.toString().startsWith('_') && !_.toString().startsWith('$') && typeof _object[_] === 'object');
    internalObj.forEach(_ => fields.addList(getAllFields(_object[_]).map(__ => _ + '.' + __)));

    return fields;
}

//**********************************************************************************************************************

function getReferenceDisplayField(referenceType) {

    let first = getReferenceFields(referenceType).filter(q => q.forDisplayField).first();
    return first ? first.name : null;
}

function getReferenceFields(referenceType) {

    switch (referenceType) {
        case 'ContractShipment':
            return BaseFormItems.concat([
                {name: "contractDetailValueId", hidden: true},
                {
                    name: "loadPortId",
                    type: "integer",
                    width: "100%",
                    title: "<spring:message code='shipment.loading'/>",
                    align: "center",
                    editorType: "SelectItem",
                    valueField: "id",
                    displayField: getReferenceDisplayField("Port"),
                    autoFetchData: false,
                    optionDataSource: getReferenceDataSource("Port"),
                    templateFieldName: "loadPort." + getReferenceDisplayField("Port"),
                },
                {
                    name: "quantity",
                    title: "<spring:message code='global.quantity'/>",
                    width: "100%",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true
                    }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    name: "tolerance",
                    title: "<spring:message code='contractItemShipment.tolerance'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    forDisplayField: true,
                    width: "100%",
                    name: "sendDate",
                    required: false,
                    title: "<spring:message code='global.sendDate'/>",
                    type: "date",
                    dateFormatter: "toJapanShortDate",
                    formatCellValue: function (value, record, rowNum, colNum, grid) {
                        return new Date(value);
                    }
                }
            ]);
        case 'Bank':
            return BaseFormItems.concat([
                {name: 'name', title: "<spring:message code='bank.nameFa'/>", forDisplayField: true}
            ]);
        case 'Contact':
            return BaseFormItems.concat([
                {name: 'name', title: "<spring:message code='contact.nameFa'/>", forDisplayField: true}
            ]);
        case 'Country':
            return BaseFormItems.concat([
                {name: 'name', title: "<spring:message code='country.nameFa'/>", forDisplayField: true}
            ]);
        case 'Material':
            return BaseFormItems.concat([
                {name: 'desc', title: "<spring:message code='material.descFA'/>", forDisplayField: true}
            ]);
        case 'Port':
            return BaseFormItems.concat([
                {name: 'port', title: "<spring:message code='port.port'/>", forDisplayField: true}
            ]);
        case 'Unit':
            return BaseFormItems.concat([
                {name: 'name', title: "<spring:message code='unit.nameFa'/>", forDisplayField: true}
            ]);
        case 'Incoterm':
            return BaseFormItems.concat([
                {name: "description", title: '<spring:message code="global.title"/>', forDisplayField: true}
            ]);
        case 'TypicalAssay':
            return BaseFormItems.concat([
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
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
                    ],
                    templateFieldName: "unit.nameEN",
                },
                Object.assign(materialElementField, {
                    forDisplayField: true,
                    templateFieldName: "materialElement.elementName"
                })
            ]);
        case 'Deduction':
            return BaseFormItems.concat([
                {
                    name: "treatmentCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
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
                    ],
                    templateFieldName: "unit.nameEN",
                },
                Object.assign(materialElementField, {
                    forDisplayField: true,
                    templateFieldName: "materialElement.elementName"
                })
            ]);
        case 'Discount':
            return BaseFormItems.concat([
                {
                    name: "lowerBound",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    name: "upperBound",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                {
                    name: "discount",
                    title: "<spring:message code='contract.discount'/>",
                    width: "100%",
                    align: "center",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnChange: true,
                        }],
                    formatCellValue: function (value, record, rowNum, colNum) {

                        if (value != null)
                            return value.toString();

                        return value;
                    }
                },
                Object.assign(materialElementField, {
                    forDisplayField: true,
                    templateFieldName: "materialElement.elementName"
                })
            ]);
        case 'RateReference':
        case 'Enum_RateReference':
            return '';
        case 'PriceBaseReference':
        case 'Enum_PriceBaseReference':
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
        case 'TypicalAssay':
            url = "${contextPath}" + "/api/typicalAssay/spec-list";
            break;
        case 'Deduction':
            url = "${contextPath}" + "/api/deduction/spec-list";
            break;
        case 'Discount':
            url = "${contextPath}" + "/api/contract-discount/spec-list";
            break;
        default:
            return null;
    }

    return isc.MyRestDataSource.create({
        fetchDataURL: url,
        fields: getReferenceFields(referenceType)
    });
}

//**********************************************************************************************************************

function getContactFieldByType(contactType) {
    var contactCommons = {
        width: "100%",
        filterOperator: 'equals',
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

//**********************************************************************************************************************

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
                textAlign: "center",
                dateFormatter: "toJapanShortDate",
                formatCellValue: function (value, record, rowNum, colNum, grid) {
                    return new Date(value);
                }
            };
        case 'Boolean':
            return {
                type: "boolean"
            };
        case 'BigDecimal':
            return {
                type: "float",
                keyPressFilter: "[0-9.+-]"
            };
        case 'Integer':
            return {
                type: "integer",
                keyPressFilter: "[0-9+-]"
            };
        case 'String':
            return {
                type: "text",
            };
        case 'TextArea':
            return {
                type: "TextArea"
            };
        case 'Reference':
            if (reference.contains('Enum_')) return {valueMap: ReferenceEnums[reference]}
            return {
                type: "integer",
                valueField: "id",
                autoFetchData: false,
                editorType: "SelectItem",
                displayField: getReferenceDisplayField(reference),
                optionDataSource: getReferenceDataSource(reference)
            };
        default:
            return null;
    }
}

//**********************************************************************************************************************