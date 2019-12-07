<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

var RestDataSource_contractDetail_list = isc.MyRestDataSource.create({
    fetchDataURL: "${contextPath}/api/contractDetail/spec-list"
});

function ValuesManager(valueId) {
            isc.ValuesManager.create({
            ID: valueId
        })
}
var DynamicForm_ContactParameter_ValueNumber8;

    ValuesManager("contactHeader");
    ValuesManager("contactHeaderAgent");
    ValuesManager("valuesManagerArticle1");
    ValuesManager("valuesManagerArticle2");
    ValuesManager("valuesManagerArticle3");
    ValuesManager("valuesManagerArticle4");
    ValuesManager("valuesManagerArticle5");
    ValuesManager("valuesManagerArticle6");
    ValuesManager("valuesManagerArticle7");
    ValuesManager("valuesManagerArticle8");
    ValuesManager("valuesManagerArticle9");
    ValuesManager("valuesManagerArticle10");

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


        isc.Label.create({ID:"Label_Contact_Type",padding: 20,width: "100%",height: "1%",styleName: "helloWorldText",contents:  'Please select the type of contract.'});
        isc.IButton.create({ID:"Button_MO_OX",width: "200",height: "30",title: "Molybdenum",icon: "icons/16/world.png",iconOrientation: "right",click:function () {
                Window_SelectTypeContact.close();
                Window_Contact.show();
        }})


        isc.HLayout.create({ID:"HLayout_button_TypeMoliden",align: "center",width: "30%",height: "20%",align: "center",members:[Button_MO_OX]});
        isc.HStack.create({ID:"HLayout_button_TypeMoliden3",layoutMargin:10,align: "center",width: "100%",height: "80%",align: "center",members:[HLayout_button_TypeMoliden]});
        isc.VLayout.create({ID:"button_VLayout",width: "100%",height: "100%",align: "center",members:[Label_Contact_Type,HLayout_button_TypeMoliden3]});

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
                                button_VLayout
                            ]
                            });
             var Window_Contact = isc.Window.create({
                    title: "<spring:message code='contact.title'/>",
                    width: "100%",
                    height: "100%",
                    autoCenter: true,
                    isModal: true,
                    showModalMask: true,
                    align: "center",
                    autoDraw: false,
                    autoScroller:true,
                    closeClick: function () {
                    this.Super("closeClick", arguments)
                    },
                    items: [
                    isc.ViewLoader.create({
                                    autoDraw:false,
                                    viewURL:"<spring:url value="/contact/contactMolybdenum" />",
                                    loadingMessage:"Loading Grid.."
                                    })
                    ]
                    });

                    var ToolStripButton_Contact_Add = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/add.png",
                            title: "<spring:message code='global.form.new'/>",
                            click: function () {
                                Window_SelectTypeContact.animateShow();
                            }
                    });
                    var ToolStripButton_Contact_Edit = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/edit.png",
                            title: "<spring:message code='global.form.edit'/>",
                            click: function () {
                                var record = ListGrid_Tozin.getSelectedRecord();
                                if (record == null || record.id == null) {
                                    isc.Dialog.create({
                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                        icon: "[SKIN]ask.png",
                                        title: "<spring:message code='global.message'/>",
                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                        buttonClick: function () {
                                            this.hide();
                                        }});
                            } else {
                                    contactHeader.editRecord(record);

                            var criteria1={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contract_id",operator:"equals",value:record.id}]};
                                        RestDataSource_contractDetail_list.fetchData(criteria1,function (dsResponse, data, dsRequest) {
                                    console.log();
                                    var feild_all_defintitons_save =   JSON.parse(data[0].feild_all_defintitons_save)
                                    contactHeaderAgent.editRecord(data[0]);
                                    valuesManagerArticle1.editRecord(data[0]);
                                    for (const [key, value] of Object.entries(feild_all_defintitons_save)) {
                                    valuesManagerArticle1.setValue(key,value);
                                    if(key != 'definitionsOne'){
                                        itemsEditDefinitions(key,value)
                                      }
                                    }
                                    valuesManagerArticle2.editRecord(data);
                                    valuesManagerArticle3.editRecord(data);
                                    valuesManagerArticle4.editRecord(data);
                                    valuesManagerArticle5.editRecord(data);
                                    valuesManagerArticle6.editRecord(data);
                                    valuesManagerArticle7.editRecord(data);
                                    valuesManagerArticle8.editRecord(data);
                                    valuesManagerArticle9.editRecord(data);
                                    valuesManagerArticle10.editRecord(data);
                                    })
                                Window_Contact.show();
                                    }
                            }});

                    var ToolStrip_Actions_Contact = isc.ToolStrip.create({
                        width: "100%",
                        height: "100%",
                        members: [
                             ToolStripButton_Contact_Add,ToolStripButton_Contact_Edit
                        ]
                        });
                    var HLayout_Actions_Contact = isc.HLayout.create({
                         width: "100%",
                         members: [
                         ToolStrip_Actions_Contact
                        ]
                    });
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
            var ListGrid_Tozin = isc.ListGrid.create({
                        width: "100%",
                        height: "100%",
                        dataSource: RestDataSource_Contract,
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


function itemsEditDefinitions(key,value) {
        alert(value);
       DynamicForm_ContactParameter_ValueNumber8.addFields([
                {
                    name: key,
                    type: "text",
                    length: 5000,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    defaultValue:value,
                    displayField: "paramValue",
                    valueField: "paramValue",
                    showTitle: false,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:1}]
                    },
                    showTitle: false,
                    startRow: false,
                    width: "1500",
                    height: "30",
                    title: "NAME",
                    changed: function (form, item, value) {
                        DynamicForm_ContactParameter_ValueNumber8.setValue(key, (item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue))
                    }
                }
            ]);
    }