<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page  import="com.nicico.copper.core.SecurityUtil" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    var c_record = "${SecurityUtil.hasAuthority('C_CONTRACT')}";
    var d_record = "${SecurityUtil.hasAuthority('U_CONTRACT')}";

var RestDataSource_Contract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "contractDate", title: "<spring:message code='contract.contractDate'/>"},
                {name: "contactId", title: "<spring:message code='contact.name'/> "},
                {name: "contact.nameFA", title: "<spring:message code='contact.name'/> "},
                {name: "incotermsId", title: "<spring:message code='incoterms.name'/>"},
                {name: "incoterms.code", title: "<spring:message code='incoterms.name'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
              //  {name: "sideContractDate"},
             //   {name: "refinaryCost"},
            //    {name: "treatCost"},
                {name: "material.descl", title: "materialId"}
            ],
        fetchDataURL: "${contextPath}/api/contract/spec-list"
    });
    var RestDataSource_ContractAudit = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id.id", title: "id", primaryKey: true},
                {name: "id.rev", title: "rev"},
                {name: "revType", title: "revtype"},
                {name: "contractDate",title: "<spring:message code='contract.contractDate'/>"},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "createdBy", title: "createdBy"},
                {name: "createdDate", title: "createdDate"},
                {name: "lastModifiedBy", title: "lastModifiedBy"},
                {name: "lastModifiedDate", title: "lastModifiedDate"}
            ],
        fetchDataURL: "${contextPath}/api/contract/audit/spec-list"
    });

    var RestDataSource_Contact = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/> "},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/> "}
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_Incoterms = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
    });

    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descl"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });

    var RestDataSource_Unit = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='unit.code'/> "},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });




    var salesContractCADButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractCADButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin: "35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsCadTab'/>", "<spring:url value="/contact/cadMain"/>")
            Window_SelectTypeContactMain.close();
        }
    });


    var salesContractConcButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractConcButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin: "35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsConcTab'/>", "<spring:url value="/contact/concMain"/>")
            Window_SelectTypeContactMain.close();
        }
    });


    var salesContractMoButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractMoButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin: "35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='salesContractMoButton.title'/>", "<spring:url value="/contact/contactMolybdenum"/>")
            Window_SelectTypeContactMain.close();
        }
    });


    var Window_SelectTypeContactMain = isc.Window.create({
        title: "<spring:message code='global.menu.contract.type.contract'/>",
        width: "50%",
        height: "20%",
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.HLayout.create({
                autoCenter: true,
                members: [salesContractMoButtonMain, salesContractCADButtonMain, salesContractConcButtonMain]
            })
        ]
    });



    function ListGrid_Contract_refresh() {
        ListGrid_Contract.invalidateCache();
        companyName.setTitle('Contracts');
    }


    function ListGrid_Contract_remove() {
        var record = ListGrid_Contract.getSelectedRecord();
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
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/contract/" + record.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    ListGrid_Contract_refresh();
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        }))
                    }
                }
            });
        }
    }

    var RestDataSource_Contact_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "seller", operator: "equals", value: true}]
    };



    var ToolStripButton_Contract_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Contract_refresh();
        }
    });


    var ToolStripButton_Contract_Add = isc.ToolStripMenuButton.create({
        showSelectedIcon: false,
        showRollOverIcon: false,
        showMenuOnRollOver: true,
        disabledCursor: "not-allowed",
        title: "&nbsp <spring:message code='global.menu.contract.management'/> &nbsp",
        showDownIcon: false,
        baseStyle: "contract-menu",
        menuAlign: "center",
        menu: isc.Menu.create({
            data: [{
                title: "<spring:message code='salesContractMoButton.title'/>",
                click: function () {
                    createTab("<spring:message code='salesContractMoButton.title'/>", "<spring:url value="/contact/contactMolybdenum"/>")
                }
            },
                {isSeparator: true},
                {
                    title: "<spring:message code='salesContractConcButton.title'/>",
                    click: function () {
                        createTab("<spring:message code='main.contractsConcTab'/>", "<spring:url value="/contact/concMain"/>")
                    }
                }, {isSeparator: true},
                {
                    title: "<spring:message code='salesContractCADButton.title'/>",
                    click: function () {
                        createTab("<spring:message code='main.contractsCadTab'/>", "<spring:url value="/contact/cadMain"/>")
                    }
                }

            ]
        })
    });

    <sec:authorize access="hasAuthority('O_CONTRACT')">
    var ToolStripButton_Contract_Print = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/print.png",
        showIf: "true",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            var printSelectID = ListGrid_Contract.getSelectedRecord();
            if (printSelectID == null || printSelectID.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            }
            else {
                "<spring:url value="/contract/print" var="printUrl"/>";
                var recordIdPrint = ListGrid_Contract.getSelectedRecord();
                window.open('${printUrl}' + "/" + recordIdPrint.id);
            }
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_CONTRACT')">
    var ToolStripButton_Contract_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Contract_remove();
        }
    });
    </sec:authorize>


    var ToolStrip_Actions_Contract = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 15,
        members:
            [
                ToolStripButton_Contract_Add,

                <sec:authorize access="hasAuthority('D_CONTRACT')">
                ToolStripButton_Contract_Remove,
                </sec:authorize>

                <sec:authorize access="hasAuthority('O_CONTRACT')">
                ToolStripButton_Contract_Print,
                </sec:authorize>


                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Contract_Refresh
                    ]
                })
            ]
    });

    var HLayout_Contract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Contract
            ]
    });


    var contractAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: ""
    });

    var hLayoutViewLoaderContract = isc.HLayout.create({
        width: "100%",
        height: 200,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            contractAttachmentViewLoader
        ]
    });
    hLayoutViewLoaderContract.hide();


    var ListGrid_Contract = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Contract,
        styleName: 'expandList',
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
        fields:
            [
                {name: "id", hidden: true},
                {
                    name: "material.descl",
                    title: "<spring:message code='material.title'/>",
                    hidden: false,
                    width: "5%",
                    align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.material.descl;
                    }
                },
                {
                    name: "contractNo",
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'text',
                    width: "12%",
                    align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.contact.nameFA;
                    }
                },
                {
                    name: "incoterms.code",
                    title: "<spring:message code='incoterms.name'/>",
                    width: "10%",
                    align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.incoterms.code;
                    }
                },
                {
                    name: "amount",
                    title: "<spring:message code='contract.amount'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                }
            ],
        getExpansionComponent: function (record) {
            var dccTableId = record.id;
            var dccTableName = "TBL_CONTRACT";
            contractAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId+ "?d_record="
+ d_record + "&c_record=" + c_record);
            hLayoutViewLoaderContract.show();
            var layoutContract = isc.VLayout.create({
                styleName: "expand-layout",
                padding: 5,
                membersMargin: 10,
                members: [
                    hLayoutViewLoaderContract
                ]
            });
            return layoutContract;
        },
        rollOverCanvasProperties: {
            vertical: false, capSize: 7,
            src: "other/cellOverRecticle.png"
        }
    });


    var HLayout_Contract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Contract
        ]
    });
    var labelMO = isc.Label.create({
        height: 20,
        width: 100,
        padding: 2,
        margin: 3,
        backgroundColor: "#f0c85a",
        align: "center",
        contents: "MOLYBDENUM"
    })
    var labelCa = isc.Label.create({
        height: 20,
        width: 100,
        padding: 2,
        margin: 3,
        backgroundColor: "#5ec4aa",
        align: "center",
        contents: "CATHODS"
    })
    var labelCopperMatte = isc.Label.create({
        height: 20,
        width: 100,
        padding: 2,
        margin: 3,
        backgroundColor: "#c0110c",
        align: "center",
        contents: "Matte"
    })
    var labelConcentrate = isc.Label.create({
        height: 20,
        width: 100,
        padding: 2,
        margin: 3,
        backgroundColor: "#6aa6de",
        align: "center",
        contents: "Concentrates"
    })
    var VLayout_Contract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",

        members: [
            HLayout_Contract_Actions,
            isc.HLayout.create({
                showIf: "false",
                height: "30",
                align: "left",
                members: [labelMO, labelCa, labelCopperMatte, labelConcentrate]
            })
            , HLayout_Contract_Grid
        ]
    });

    //$$$$

    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
// ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/port/spec-list"
    });


    function loadWindowFeatureList(record) {
        var dccTableId = record.id;
        var dccTableName = "TBL_CONTRACT";
        var window_view_url = isc.Window.create({
            title: "<spring:message code='global.Attachment'/>", pane: contractAttachmentViewLoader,
            width: "80%",
            height: "40%",
            autoCenter: true,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: false,
            dismissOnEscape: true,
            closeClick: function () {
                this.Super("closeClick", arguments)
            },
            items:
                [
                    isc.ViewLoader.create({
                        autoDraw: true,
                        viewURL: "dcc/showForm/" + dccTableName + "/" + dccTableId,
                        loadingMessage: "<spring:message code='global.loadingMessage'/>"
                    })
                ]
        });
        window_view_url.show();
}
