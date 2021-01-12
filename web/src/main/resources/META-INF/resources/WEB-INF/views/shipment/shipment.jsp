<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../common/ts/FileUtil.js" %>

//<script>


    function toEnglishDigits(str) {
        const persianNumbers = ["۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹", "۰"]
        const arabicNumbers = ["١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩", "٠"]
        const englishNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        return str.split("").map(c => englishNumbers[persianNumbers.indexOf(c)] ||
            englishNumbers[arabicNumbers.indexOf(c)] || c).join("")
    };

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var contractId;
    var materialId;
    var printTemplateList;
    var oldPrintTemplateList;
    var attachFileList = [];

    function getAttachFileList() {

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            actionURL: "${contextPath}/api/files/byEntityName",
            params: {
                entityName: "Shipment"
            },
            callback: function (resp) {
                let data = JSON.parse(resp.httpResponseText);
                attachFileList = data.filter(q => q.fileStatus !== "DELETED");
            }
        }));
    }

    getAttachFileList();

    function attachFileListSize(record) {
        return attachFileList.filter(q => q.recordId == record.id).size();
    };

    nicico.FileUtil.okCallBack = function (files) {
        getAttachFileList();
        fetchPrintTemplateListAndRefreshGrid();
    };

    function fetchPrintTemplateListAndRefreshGrid() {
        printTemplateList = [];
        oldPrintTemplateList = [];
        fetch("${contextPath}/api/files/byEntityName?entityName=ShipmentPrint", {
            headers: SalesConfigs.httpHeaders
        })
            .then(response => response.json())
            .then(data => {
                if (data && data.size() > 0)
                    data.forEach(d => {
                        let materialAndShipmentType = calcMaterialAndShipmentType(d.recordId);
                        let tmp = {
                            id: d.id,
                            shipmentType: materialAndShipmentType.shipmentType,
                            material: materialAndShipmentType.material,
                            fileKey: d.fileKey
                        };
                        if (tmp.material && tmp.shipmentType)
                            printTemplateList.add(tmp);
                    });
                ListGrid_Shipment.invalidateCache();
                ListGrid_Shipment.fetchData();
            });
    }

    fetchPrintTemplateListAndRefreshGrid();

    function calcMaterialAndShipmentType(recordId) {
        return {
            material: Math.floor(recordId / 100),
            shipmentType: recordId - 100 * Math.floor(recordId / 100)
        }
    }

    function calcRecordId(record) {
        return (record.shipmentTypeId ? record.shipmentTypeId : record.shipmentType) +
            100 * (record.materialId ? record.materialId : record.material);
    }

    function transformResponsePrintAttachment(res) {
        res.forEach(_ => _.material = calcMaterialAndShipmentType(_.recordId).material);
        res.forEach(_ => _.shipmentType = calcMaterialAndShipmentType(_.recordId).shipmentType);
        Object.assign(oldPrintTemplateList, res);
        return res;
    }

    function transformRequestPrintAttachment(req) {
        let gridValues = req.fileUploadForm.grid.getData();
        let gridDataDeleted = oldPrintTemplateList && (oldPrintTemplateList.length > 0)
            && (gridValues.filter(rn => !rn.fileKey).length < oldPrintTemplateList.length);
        if (gridDataDeleted) {
            let deletedRecords = oldPrintTemplateList.filter(ro =>
                !gridValues.map(rn => rn.fileKey).includes(ro.fileKey));
            if (deletedRecords && deletedRecords.length > 0) {
                deletedRecords.forEach(dr => {
                    let allRecordsOfOneIdDeleted = !gridValues.map(_ => _.recordId).includes(dr);
                    if (allRecordsOfOneIdDeleted)
                        gridValues.add({recordId: dr.recordId, accessLevel: dr.accessLevel, entityName: "DELETED"});
                });
            }

            req.fileUploadForm.grid.setData(gridValues);
        }
        return req;
    }

    function afterAddItem(item, form) {
        item.recordId = calcRecordId(form.getValues());
        item.shipmentType = calcMaterialAndShipmentType(item.recordId).shipmentType;
        item.material = calcMaterialAndShipmentType(item.recordId).material;
        debugger
        return item;
    }

    var RestDataSource_Contact__SHIPMENT = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "phone", title: "<spring:message code='contact.phone'/>"},
                {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
                {
                    name: "type", title: "<spring:message code='contact.type'/>",
                    valueMap: {
                        "true": "<spring:message code='contact.type.real'/>",
                        "false": "<spring:message code='contact.type.legal'/>"
                    }
                },
                {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
                {
                    name: "status", title: "<spring:message code='contact.status'/>",
                    valueMap: {
                        "true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"
                    }
                },
                {name: "contactAccounts"},
                {name: "country.name", title: "<spring:message code='country'/>"},

                {name: "bookingCat", title: "<spring:message code='shipment.bookingCat'/>", align: "center"}


            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_LoadingPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "beam", title: "<spring:message code='port.port'/>", width: 200},
                {name: "loa", title: "<spring:message code='port.port'/>", width: 200},
                {name: "arrival", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.name", title: "<spring:message code='country'/>", width: 200}
            ],

        fetchDataURL: "${contextPath}/api/port/spec-list"
    });

    var RestDataSource_VesselInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "name", title: "<spring:message code='vessel.name'/>"},
                {name: "type", title: "<spring:message code='vessel.type'/>"},
                {name: "imo", title: "<spring:message code='vessel.imo'/>"},
                {name: "yearOfBuild", title: "<spring:message code='vessel.year.of.build'/>"},
                {name: "length", title: "<spring:message code='vessel.length'/>"},
                {name: "beam", title: "<spring:message code='vessel.beam'/>"}
            ],

        fetchDataURL: "${contextPath}/api/vessel/spec-list"
    });

    var RestDataSource_UnitInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "name", title: "<spring:message code='unit.name'/>"},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/>"},
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    var RestDataSource_ShipmentTypeInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentType", title: "<spring:message code='shipment.type'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentType/spec-list"
    });

    var RestDataSource_ShipmentMethodInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentMethod", title: "<spring:message code='shipment.method'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentMethod/spec-list"
    });

    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='billOfLanding.port.of.discharge'/>"},
            ],
        fetchDataURL: "${contextPath}/api/port/spec-list"
    });

    var RestDataSource_pickShipmentItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "cisId", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "quantity", title: "<spring:message code='global.quantity'/> "},
                {name: "sendDate", title: "<spring:message code='global.sendDate'/> "},
                {name: "contractId", title: "contractId"},
                {name: "loadPortId", title: "<spring:message code='shipment.loading'/>"},
            ],
        transformRequest: function (dsRequest) {

            dsRequest.params = {
                code: JSON.parse('${Enum_EContractDetailTypeCode}').Shipment,
                contractDetailValueKey: JSON.parse('${Enum_EContractDetailValueKey}').CONTRACT_SHIPMENT
            };

            let contractId1 = DynamicForm_Shipment.getValue("contractId");
            if (contractId1)
                dsRequest.params.contractId = contractId1;

            this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${contextPath}/api/g-contract/latest-version-of-data-response"
    });

    var RestDataSource_pickContractItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "no", title: "<spring:message code='contract.contractNo'/>"},
                {name: "date", title: "<spring:message code='contract.contractDate'/>", type: "date"},

            ],
        fetchDataURL: "${contextPath}/api/g-contract/spec-list"
    });

    var RestDataSource_incotermRules = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "incoterm.title", title: "<spring:message code='entity.incoterm'/>"},
                {name: "incotermRule.titleEn", title: "<spring:message code='entity.incoterm-rule'/>"},

            ],
        fetchDataURL: "${contextPath}/api/incoterm-rules/spec-list"
    });

    var RestDataSource_Shipment__SHIPMENT = isc.MyRestDataSource.create({
        fields: [
            {type: "Header", defaultValue: ""},
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "contractShipmentId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true
            },
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contact.name",
                type: 'text'
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contractShipment.contract.no",
                type: 'text',
                width: 180
            },
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descEN", title: "<spring:message code='material.descEN'/>", type: 'text'},
            {name: "material.descFA", title: "<spring:message code='material.descFA'/>", type: 'text'},
            {name: "material.desc", title: "<spring:message code='material.title'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "unitId", title: "<spring:message code='unit.title'/>"},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPallet", title: "<spring:message code='shipment.noPallet'/>", type: 'integer'},
            {name: "weightGW", title: "<spring:message code='shipment.gross'/>"},
            {name: "weightND", title: "<spring:message code='shipment.net'/>"},
            {name: "moisture", title: "<spring:message code='shipment.moisture'/>"},
            {name: "vgm", title: "<spring:message code='shipment.vgm'/>"},
            {
                name: "shipmentType.shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
            },
            {
                name: "shipmentMethod.shipmentMethod",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                type: 'text',
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true,

            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "status",
                title: "<spring:message code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {
                name: "sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                showHover: true,
            },
            {
                name: "createdDate",
                type: 'text'
            },
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "contactAgent.name",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vessel.name",
                title: "<spring:message code='vessel.name'/>",
                type: 'text',
            },
            {
                name: "shipmentTypeId",
                hidden: true
            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });
    var RestDataSource_ShipmentTypeInShipmentDcc = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentType", title: "<spring:message code='shipment.type'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentType/spec-list"
    });

    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descEN"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });

    var Menu_ListGrid_Shipment = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    fetchPrintTemplateListAndRefreshGrid();
                }
            },
            <sec:authorize access="hasAuthority('C_SHIPMENT')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    ListGrid_Shipment_add();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_SHIPMENT')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Shipment_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_SHIPMENT')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Shipment_remove();
                }
            },
            </sec:authorize>

        ]
    });

    function setBuyerName(buyerId) {
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contact/" + buyerId,
                httpMethod: "GET",
                callback: function (RpcResponse_o) {
                    DynamicForm_Shipment.setValue("contract.contact.name", JSON.parse(RpcResponse_o.data).name);
                }
            })
        );
    }

    var dash = "\n";

    var DynamicForm_Shipment = isc.DynamicForm.create({
        numCols: 4,
        width: "100%",
        height: "100%",
        wrapItemTitles: false,
        cellPadding: "10",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        fields: [
            {type: "header"},
            {name: "id", hidden: true},
            {name: "contactId", hidden: true},
            {name: "loadPortId", hidden: true},
            {name: "materialId", hidden: true,},
            {
                name: "contractId", ID: "abal", colSpan: 1,
                title: "<spring:message code='contract.contractNo'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_pickContractItem,
                optionCriteria: {
                    operator: "and", criteria: [{fieldName: "parentId", operator: "isNull"},
                        {fieldName: "eStatusId", "operator": "greaterOrEqual", value: 4}]
                },
                displayField: "no",
                valueField: "id",
                pickListHeight: "500",
                pickListFields: [
                    {
                        name: "no",
                        width: "10%",
                        align: "center"
                    },
                    {
                        name: "date",
                        width: "10%",
                        align: "center",
                        dateFormatter: "toJapanShortDate",
                    }
                ],
                changed: function (form, item, value) {
                    let record = item.getSelectedRecord();
                    materialId = record.materialId;
                    contractId = value;
                    let buyerId = record.contractContacts.filter(c => (c.commercialRole === 'Buyer'))[0].contactId;
                    setBuyerName(buyerId);
                    DynamicForm_Shipment.setValue("material.desc", record.material.desc);
                    DynamicForm_Shipment.setValue("contactId", buyerId);
                    DynamicForm_Shipment.setValue("materialId", materialId);
                    DynamicForm_Shipment.getItem("showArticle").setDisabled(false);
                }
            },
            {
                name: "contractShipmentId", ID: "shipment",
                title: "<spring:message code='shipmentContract.list'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_pickShipmentItem,
                valueField: "id",
                pickListHeight: "500",
                autoFetchData: false,
                pickListFields: [
                    {name: "loadPort.port", title: "<spring:message code='shipment.loading'/>"},
                    {name: "quantity"},
                    {name: "sendDate"},
                ],
                changed: function (form, item, value) {
                    let d = new Date(item.getSelectedRecord().sendDate);
                    DynamicForm_Shipment.setValue("sendDate", d);
                    DynamicForm_Shipment.setValue("loadPortId", item.getSelectedRecord().loadPortId);
                },
                mapValueToDisplay: function (value) {
                    if (!value) return;
                    let selectedRecord = this.getSelectedRecord();
                    if (!selectedRecord) return '';
                    return selectedRecord.loadPort.port + "&nbsp&nbsp&nbsp(" + selectedRecord.sendDate + ")&nbsp";
                }
            },
            {
                name: "shipmentSendDate", ID: "shipmentSendDate",
                title: "<spring:message code='shipmentContract.list'/>",
                hidden: true,
                type: "staticText",
            },
            {
                name: "contract.contact.name",
                title: "<spring:message code='contact.name'/>",
                type: "staticText"
            },
            {
                name: "material.desc",
                title: "<spring:message code='material.title'/>",
                type: "staticText"
            },
            {
                name: "incotermRulesId",
                title: "<spring:message code='entity.incoterm'/>",
                required: true,
                width: "100%",
                displayField: "id",
                valueField: "id",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_incotermRules,
                pickListProperties: {showFilterEditor: true},
                pickListHeight: "500",
                pickListFields: [
                    {
                        name: "id",
                        hidden: true
                    }, {
                        name: "incoterm.title",
                        width: "10%",
                        align: "center",
                        sortNormalizer: function (recordObject) {
                            return recordObject.incoterm.title;
                        }
                    }, {
                        name: "incotermRule.titleEn",
                        width: "10%",
                        align: "center",
                        sortNormalizer: function (recordObject) {
                            return recordObject.incotermRule.titleEn;
                        }
                    }],
                mapValueToDisplay: function (value) {

                    let selectedRecord = this.getSelectedRecord();
                    if (!selectedRecord) return '';
                    return selectedRecord.incoterm.title + " (" + selectedRecord.incotermRule.titleEn + ")";
                },
            },
            {
                name: "showArticle",
                title: "<spring:message code='shipment.showArticle'/>",
                type: "button",
                endRow: false, startRow: false,
                icon: "pieces/16/icon_add.png",
                disabled: true,
                click: function (form, item) {

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/g-contract/get-delivery-article/" + materialId + "/" + contractId,
                        httpMethod: "GET",
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {

                                articleElement.setContents("<span style='display: block; text-align: left'>" + RpcResponse_o.httpResponseText + "</span>");
                                Window_Article.show();
                            } else isc.say("<spring:message code='shipment.show.article.empty'/>");
                        }
                    }));
                }
            },
            {
                name: "sendDate",
                type: "date",
                title: "<spring:message code='global.sendDate'/>",
            },
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                ID: "automationLetterDateId",
                width: 200,
                icons: [{
                    src: "pieces/pcal.png",
                    click: function () {
                        displayDatePicker('automationLetterDateId', this, 'ymd', '/');
                    }
                }],
            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                length: "100",
                width: "100%",
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "100%",
            },

            {
                name: "arrivalDateFrom",
                type: "date",
                title: "<spring:message code='shipment.arrivalDateFrom'/>",
            },
            {
                name: "arrivalDateTo",
                type: "date",
                title: "<spring:message code='shipment.arrivalDateTo'/>",
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'float',
                width: "100%",
                length: 9,
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isFloat",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "lastDeliveryLetterDate",
                type: "date",
                title: "<spring:message code='shipment.lastDeliveryLetterDate'/>",
            },
            {
                name: "unitId",
                title: "<spring:message code='unit.title'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_UnitInShipment,
                optionCriteria: RestDataSource_UNIT_optionCriteria,
                displayField: "name",
                valueField: "id",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {
                        name: "name",
                        width: "10%",
                        align: "center"
                    }
                ]
            },
            {
                name: "noBLs",
                title: "<spring:message code='shipment.numberOfBLs'/>",
                type: 'long',
                width: "100%",
                keyPressFilter: "[0-9]",
            },
            {
                name: "shipmentTypeId",
                displayField: "shipmentType",
                valueField: "id",
                title: "<spring:message code='shipment.shipmentType'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentTypeInShipment,
                pickListProperties: {showFilterEditor: true},

                pickListFields: [
                    {
                        name: "shipmentType",
                        width: "10%",
                        align: "center"
                    }],
                pickListHeight: "500",
            },
            {
                name: "shipmentMethodId",

                displayField: "shipmentMethod",
                valueField: "id",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentMethodInShipment,
                pickListHeight: "500",
            },
            {
                name: "noPackages",
                title: "<spring:message code='shipment.noPackages'/>",
                width: "100%",
                type: "long",
                length: 10,
                keyPressFilter: "[0-9.]",
            },
            {
                name: "weightGW",
                length: 10,
                title: "<spring:message code='shipment.gross'/>",
                type: "float",
                width: "100%",
                keyPressFilter: "[0-9.]",
            },
            {
                name: "weightND",
                length: 10,
                keyPressFilter: "[0-9.]",
                title: "<spring:message code='shipment.net'/>",
                type: "float",
                width: "100%",
            },
            {
                name: "moisture",
                title: "<spring:message code='shipment.moisture'/>",
                type: "staticText",
                width: "100%",
            },
            {
                name: "vgm",
                title: "<spring:message code='shipment.vgm'/>",
                type: "float",
                width: "100%",
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer',
                width: "100%",
                keyPressFilter: "[0-9.]",
            },
            {
                name: "containerType",
                title: "<spring:message code='billOfLanding.container.type'/>",
                type: 'text',
                width: "100%",
            },
            {
                name: "noPallet",
                title: "<spring:message code='shipment.noPalette'/>",
                type: 'integer',
                width: "100%",
                length: 6,
                keyPressFilter: "[0-9.]",
            },
            {
                name: "contactAgentId",
                title: "<spring:message code='shipment.agent'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact__SHIPMENT,
                optionCriteria: RestDataSource_Contact_optionCriteria__SHIPMENT,
                displayField: "name",
                valueField: "id",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "name", align: "center"},
                    {name: "country.name", align: "center"}
                ],
            },
            {
                name: "vesselId",
                title: "<spring:message code='vessel.name'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_VesselInShipment,
                type: 'long',
                width: "100%",
                displayField: "name",
                valueField: "id",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [
                    {
                        name: "name",
                    },
                    {
                        name: "type"
                    }],
            },
            {
                name: "dischargePortId",
                title: "<spring:message code='billOfLanding.port.of.discharge'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Port,
                type: 'long',
                displayField: "port",
                valueField: "id",
                width: "100%",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [
                    {
                        name: "port",
                    }],
            },
        ]
    });

    var RestDataSource_Contact_optionCriteria__SHIPMENT = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "transporter", operator: "equals", value: true}]
    };

    var RestDataSource_UNIT_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria:
            [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Weight
            }],

    };

    var IButton_Shipment_Save = isc.IButtonSave.create({
        click: async function () {
            let validate = DynamicForm_Shipment.validate();
            if (!validate)
                return false;
            validate = datesValidation();
            if (!validate)
                return false;
            validate = portValidation();
            if (!validate)
                return false;
            validate = await checkRepeatedContractShipment(DynamicForm_Shipment.getItem("contractShipmentId").getValue());
            if (!validate)
                return false;
            let automationLetterDate = toEnglishDigits(DynamicForm_Shipment.getValue("automationLetterDate"));
            DynamicForm_Shipment.setValue("automationLetterDate",
                new Date(new persianDate(automationLetterDate.split("/").map(x => +x)).format('X') * 1000));
            let allDataShipment = DynamicForm_Shipment.getValues();
            let dataShipment = Object.assign(allDataShipment);
            let methodXXXX = "PUT";
            if ((dataShipment.id == null) || (dataShipment.id == 'undefiend')) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipment/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(dataShipment),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            fetchPrintTemplateListAndRefreshGrid();
                            Window_Shipment.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var fillScreenWindow_letter = isc.Window.create({
        placement: "fillScreen",
        autoDraw: false,
        title: "<spring:message code='global.form.help'/>",
        items: [
            isc.HLayout.create({
                width: "100%",
                layoutMargin: 5,
                membersMargin: 10,
                members: [
                    isc.HTMLPane.create({
                        ID: "myPane",
                        showEdges: true,
                        <c:if test="${pageContext.response.locale == 'fa'}">
                        contentsURL: "/sales/help/LoadingLetter.html",
                        </c:if>
                        <c:if test="${pageContext.response.locale == 'en'}">
                        contentsURL: "/sales/help/LoadingLetterEn.html",
                        </c:if>


                        contentsType: "page"
                    })
                ]
            })
        ]
    });

    var ShipmentCancelBtn_Help_shipment = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/help.png",
        title: "<spring:message code='global.form.help'/>",
        click: function () {
            fillScreenWindow_letter.show();
        }
    });

    let articleElement = isc.HTMLFlow.create({
        width: "100%",
        padding: 10
    });

    var ShipmentCancelBtn = isc.IButtonCancel.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        click: function () {
            Window_Shipment.close();
        }
    });

    var ArticleCancelBtn = isc.IButtonCancel.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        click: function () {
            Window_Article.close();
        }
    });

    var hLayout_saveButton = isc.HLayout.create({
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        members: [
            IButton_Shipment_Save,
            ShipmentCancelBtn
        ]
    });

    var hLayout_buttonArticle = isc.HLayout.create({
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        members: [
            ArticleCancelBtn
        ]
    });

    var Window_Shipment = isc.Window.create({
        title: "<spring:message code='Shipment.extraInfo'/>",
        width: 1000,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_Shipment,
            hLayout_saveButton
        ]
    });

    var Window_Article = isc.Window.create({
        title: "<spring:message code='shipment.showArticle'/>",
        width: 1000,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            articleElement,
            hLayout_buttonArticle
        ]
    });

    function ListGrid_Shipment_remove() {
        let record = ListGrid_Shipment.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/shipment/" + shipmentId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Shipment.invalidateCache();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

    function ListGrid_Shipment_add() {
        DynamicForm_Shipment.clearValues();
        abal.enable();
        abal.fetchData();
        shipment.enable();
        DynamicForm_Shipment.getItem("showArticle").setDisabled(true);
        DynamicForm_Shipment.getItem("contractShipmentId").show();
        DynamicForm_Shipment.getItem("shipmentSendDate").hide();
        Window_Shipment.animateShow();
    }

    function ListGrid_Shipment_edit() {
        let record = ListGrid_Shipment.getSelectedRecord();
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
        } else {
            contractId = record.contractShipment.contractId;
            materialId = record.materialId;
            DynamicForm_Shipment.clearValues();
            //DynamicForm_Shipment.setValue("contractId", record.contractShipment.contractId);
            // DynamicForm_Shipment.getItem("contractShipmentId").setOptionDataSource(null);
            DynamicForm_Shipment.editRecord(record);
            DynamicForm_Shipment.setValue("contractId", contractId);
            //DynamicForm_Shipment.getItem("contractShipmentId").setValue(record.contractShipment.sendDate);
            DynamicForm_Shipment.setValue("automationLetterDate", new Date(parseInt(record.automationLetterDate)).toLocaleDateString('fa-IR'));
            DynamicForm_Shipment.setValue("arrivalDateTo", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().arrivalDateTo)));
            DynamicForm_Shipment.setValue("arrivalDateFrom", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().arrivalDateFrom)));
            DynamicForm_Shipment.setValue("sendDate", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().sendDate)));
            DynamicForm_Shipment.setValue("lastDeliveryLetterDate", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().lastDeliveryLetterDate)));
            DynamicForm_Shipment.setValue("loadPortId", record.contractShipment.loadPortId);
            setBuyerName(record.contactId);
            abal.disable();
            shipment.disable();
            Window_Shipment.animateShow();
            DynamicForm_Shipment.getItem("contractShipmentId").hide();
            DynamicForm_Shipment.getItem("shipmentSendDate").show();
            let displayValue = ListGrid_Shipment.getSelectedRecord().contractShipment.loadPort.port + "&nbsp&nbsp&nbsp(" + ListGrid_Shipment.getSelectedRecord().contractShipment.sendDate + ")&nbsp";
            DynamicForm_Shipment.getItem("shipmentSendDate").setValue(displayValue);
            DynamicForm_Shipment.getItem("showArticle").setDisabled(false);
        }
    }

    function printTemplateListSize(record) {
        return printTemplateList
            .filter(x => x.shipmentType == record.shipmentTypeId)
            .filter(x => x.material == record.materialId).size();
    }

    var ToolStripButton_Shipment_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            fetchPrintTemplateListAndRefreshGrid();
        }
    });

    <sec:authorize access="hasAuthority('C_SHIPMENT')">
    let ToolStripButton_Shipment_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_Shipment_add();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_SHIPMENT')">
    let ToolStripButton_Shipment_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Shipment_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_SHIPMENT')">
    let ToolStripButton_Shipment_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_remove();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('C_SHIPMENT_DCC')">
    let ToolStripButton_Shipment_dcc = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='shipment.loading.pattern.attachment'/>",
        click: function () {
            nicico.FileUtil.addSomeFeatures(true,
                [{
                    name: "material",
                    title: "<spring:message code='material.title'/>",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descEN",
                    valueField: "id",
                },
                    {
                        name: "shipmentType",
                        title: "<spring:message code='shipment.shipmentType'/>",
                        displayField: "shipmentType",
                        valueField: "id",
                        optionDataSource: RestDataSource_ShipmentTypeInShipmentDcc,
                    }],
                transformRequestPrintAttachment, transformResponsePrintAttachment, afterAddItem);

            nicico.FileUtil.show(null, "<spring:message
	code='shipment.loading.pattern.attachment'/> ", null, null, "ShipmentPrint", null);
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Shipment = isc.ToolStrip.create({
        width: "100%",
        members: [
            <sec:authorize access="hasAuthority('C_SHIPMENT')">
            ToolStripButton_Shipment_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_SHIPMENT')">
            ToolStripButton_Shipment_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_SHIPMENT')">
            ToolStripButton_Shipment_Remove,
            </sec:authorize>

            <sec:authorize access="hasAuthority('C_SHIPMENT_DCC')">
            ToolStripButton_Shipment_dcc,
            </sec:authorize>

            <sec:authorize access="hasAuthority('C_SHIPMENT') or hasAuthority('U_SHIPMENT')">
            isc.ToolStripButton.create({
                visibility: "visible",
                icon: "pieces/512/attachment.png",
                title: "<spring:message code='global.attach.file'/>",
                click: function () {
                    let record = ListGrid_Shipment.getSelectedRecord();
                    if (record == null || record.id == null) {
                        isc.warn("<spring:message code='global.grid.record.not.selected'/>");
                        return;
                    }
                    nicico.FileUtil.addSomeFeatures(false, null, null, null);
                    nicico.FileUtil.show(null, '<spring:message code="global.attach.file"/> <spring:message code="entity.shipment"/>',
                        record.id, null, "Shipment", null);
                }
            }),
            </sec:authorize>

            ShipmentCancelBtn_Help_shipment,

            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Shipment_Refresh,
                ]
            })
        ]
    });

    var HLayout_Actions_Shipment = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Shipment
        ]
    });

    var ListGrid_Shipment = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        contextMenu: Menu_ListGrid_Shipment,
        alternateRecordStyles: true,
        wrapCells: false,
        showRollOver: false,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        autoFitExpandField: true,
        virtualScrolling: true,
        loadOnExpand: true,
        loaded: false,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {
                name: "contact.name",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contact.name
                }
            },
            {
                name: "contractShipment.contract.no",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contractShipment.contract.no
                }
            },
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                formatCellValue: (value) => {
                    return new persianDate(Number.parseInt(value)).format('YYYY/MM/DD')
                },
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descEN",
                title: "<spring:message code='material.descEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.material.descEN
                }
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "shipmentType.shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "shipmentMethod.shipmentMethod",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'date',
                inputFormat: "YMD",
                width: "10%",
                align: "center",
                showHover: true,
                formatCellValue: (value) => {
                    return new Date(Number.parseInt(value))
                },
            },
            {
                name: "createdDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                formatCellValue: (value) => {
                    return new persianDate(Number.parseInt(value)).format('YYYY/MM/DD')
                },
            },
            {
                name: "contactAgent.name",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contactAgent.name
                }
            },
            {
                name: "vessel.name",
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.vessel.name
                }
            },
            {name: "printIcon", align: "center", width: "4%", title: "<spring:message code='global.form.print'/>"},
            {name: "attachIcon", align: "center", width: 70, title: "<spring:message code='global.Attachment'/>"}
        ],
        doubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
            <sec:authorize access="hasAuthority('U_SHIPMENT')">
            ListGrid_Shipment_edit();
            </sec:authorize>
        },
        createRecordComponent: function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            if (fieldName == "printIcon") {
                let listSize = printTemplateListSize(record);
                if (listSize == 0)
                    return null;
                let cntnt = (listSize > 1) ? "(" + listSize + ")" : "";
                var printImg = isc.Label.create({
                    contents: cntnt,
                    showDown: false,
                    showRollOver: false,
                    icon: "[SKIN]/actions/print.png",
                    cursor: "hand",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {
                        let selectReportForm = new nicico.FormUtil();
                        let fileUploadForm = isc.FileUploadForm.create({
                            entityName: "ShipmentPrint",
                            recordId: calcRecordId(record),
                            canAddFile: false,
                            canRemoveFile: false,
                            canDownloadFile: false,
                            height: "100",
                            margin: 5
                        });
                        fileUploadForm.grid.recordDoubleClick = function (viewer, printRecord, recordNum, field, fieldNum, value, rawValue) {
                            window.open('${contextPath}/shipment/print/' + record.id + "/" + printRecord.fileKey);
                        }
                        if (printTemplateListSize(record) > 1) {
                            selectReportForm.showForm(null, "<spring:message
    code='global.form.select.print.template'/>", fileUploadForm, null, "100", false);
                            selectReportForm.bodyWidget.getObject().reloadData();
                        } else {
                            window.open('${contextPath}/shipment/print/' + record.id + "/" + printTemplateList[0].fileKey);
                        }
                    }
                });
                return printImg;
            } else if (fieldName == "attachIcon") {

                let listSize = attachFileListSize(record);
                if (listSize == 0)
                    return null;
                let cntnt = (listSize > 1) ? "(" + listSize + ")" : "";
                var printImg = isc.Label.create({
                    contents: cntnt,
                    showDown: false,
                    showRollOver: false,
                    icon: "pieces/512/attachment.png",
                    height: 16,
                    width: 16,
                    cursor: "hand",
                    grid: this,
                    click: function () {

                        let selectReportForm = new nicico.FormUtil();
                        selectReportForm.showForm(null, "<spring:message code="global.attach.file"/>",
                            isc.FileUploadForm.create({
                                entityName: "Shipment",
                                recordId: record.id,
                                canAddFile: false,
                                canRemoveFile: false,
                                canDownloadFile: true,
                                height: "300",
                                margin: 5
                            }),
                            null, "300"
                        );
                        selectReportForm.bodyWidget.getObject().reloadData();
                    }
                });
                return printImg;

            } else {
                return null;
            }
        }

    });

    var HLayout_Grid_Shipment = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment
        ]
    });

    var VLayout_Body_Shipment = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Shipment, HLayout_Grid_Shipment
        ]
    });

    isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            layoutTopMargin: 5,
            members: [
                isc.SectionStack.create({
                    sections: [{
                        title: "<spring:message code='Shipment.title'/>",
                        items: VLayout_Body_Shipment,
                        showHeader: false,
                        expanded: true
                    }
                    ],
                    visibilityMode: "multiple",
                    animateSections: true,
                    height: "100%",
                    width: "100%",
                    overflow: "hidden"
                })
            ]
        });

    async function checkRepeatedContractShipment(contractShipmentId) {
        if (contractShipmentId == null)
            return false;
        const resp = await fetch("${contextPath}/api/shipment/spec-list?criteria=" + JSON.stringify({
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "contractShipmentId", operator: "equals", value: contractShipmentId}]
        }), {
            headers: SalesConfigs.httpHeaders,
        })
        if (!resp.ok) {
            return false
        }
        const respdata = await resp.json()
        const resData = respdata.response.data
        if (resData == null || resData.length == 0)
            return true;
        let shipmentId = DynamicForm_Shipment.getItem("id").getValue();
        let x = resData.find(d => (d != null && (d.id != shipmentId)));
        if (x != null && x.contractShipmentId != null) {
            let msg = "<spring:message code='shipment.contractShipment.repeated.warn'/> ";
            isc.warn(msg, "");
            return false;
        } else
            return true;

        return false
    }

    function datesValidation() {
        if (DynamicForm_Shipment.getField("arrivalDateTo").getValue() <
            DynamicForm_Shipment.getField("arrivalDateFrom").getValue()) {
            let msg = "<spring:message code='shipment.arrivalDate.warn'/> ";
            isc.warn(msg, "");
            return false;
        }
        return true;
    }

    function portValidation() {
        if (DynamicForm_Shipment.getField("dischargePortId").getValue() == DynamicForm_Shipment.getField("loadPortId").getValue()) {
            let msg = "<spring:message code='shipment.loadPort.dischargePort.warn'/> ";
            isc.warn(msg, "");
            return false;
        }
        return true;
    }

    //</script>





