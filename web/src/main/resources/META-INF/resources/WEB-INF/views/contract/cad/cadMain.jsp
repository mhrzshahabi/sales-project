<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

  var RestDataSource_Contract = isc.MyRestDataSource.create({
             fields:
                [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "contractDate", title: "<spring:message code='contract.contractDate'/>"},
                {name: "contactId", title: "<spring:message code='contact.name'/>"},
                {name: "contact.nameFA", title: "<spring:message code='contact.name'/>"},
                {name: "incotermsId", title: "<spring:message code='incoterms.name'/>"},
                {name: "incoterms.code", title: "<spring:message code='incoterms.name'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "sideContractDate", ID: "sideContractDate"},
                {name: "refinaryCost", ID: "refinaryCost"},
                {name: "treatCost", ID: "treatCost"},
                ],
                // ######@@@@###&&@@###
                fetchDataURL: "${contextPath}/api/contract/spec-list"
            });

var criteriaCad = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "materialId", operator: "equals", value: 952}]
    };

            var ViewLoader_createTozin = isc.ViewLoader.create({
                        width: "100%",
                        height: "100%",
                        autoDraw: false,
                        loadingMessage: " <spring:message code='global.loadingMessage'/>"
                });

            isc.Window.create({
                    title: "<spring:message code='dailyReport.DailyReportBandarAbbasTest'/> ",
                    width: "100%",
                    height: "100%",
                    autoCenter: true,
                    align: "center",
                    autoDraw: false,
                    dismissOnEscape: true,
                    closeClick: function () {
                    this.Super("closeClick", arguments)
                    },
                    items:
                    [
                    ViewLoader_createTozin
                    ]
            });



              var Window_SelectTypeContact = isc.Window.create({
                            title: "Type Contact",
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

                            ]
                            });

                    var ToolStripButton_Contact_Add = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/add.png",
                            title: "<spring:message code='global.form.new'/>",
                            click: function () {
                            }
                    });

                    var ToolStripButton_Contact_Edit = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/edit.png",
                            title: "<spring:message code='global.form.edit'/>",
                            click: function () {
                            }});

                    var ToolStripButton_Contact_Remove = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/edit.png",
                            title: "<spring:message code='global.form.remove'/>",
                            click: function () {
                            }});

                    var ToolStrip_Actions_Contact = isc.ToolStrip.create({
                        width: "100%",
                        height: "100%",
                        members: [
                             ToolStripButton_Contact_Add,ToolStripButton_Contact_Edit,ToolStripButton_Contact_Remove
                        ]
                        });
                    var HLayout_Actions_Contact = isc.HLayout.create({
                         width: "100%",
                         members: [
                         ToolStrip_Actions_Contact
                        ]
                    });
            var ListGrid_Tozin = isc.ListGrid.create({
                        width: "100%",
                        height: "100%",
                        dataSource: RestDataSource_Contract,
                        initialCriteria: criteriaCad,
                        dataPageSize: 50,
                        showFilterEditor: true,
                        autoFetchData: true,
                        fields:
                        [
                            {name: "id", primaryKey: true, canEdit: false, hidden: true},
                            {name: "contractNo",width: "10%", title: "<spring:message code='contact.no'/>", align: "center",canEdit: false}  ,
                            {name: "contractDate",width: "10%", title: "<spring:message code='contract.contractDate'/>", align: "center",canEdit: true}  ,
                            {name: "contact.nameFA",width: "85%", title: "<spring:message code='contact.name'/>", align: "center"}
                        ]
                        });

           isc.VLayout.create({
                        ID:"VLayout_Tozin_Grid",
                        width: "100%",
                        height: "100%",
                        members: [
                        HLayout_Actions_Contact,
                        ListGrid_Tozin
                        ]
                        });

