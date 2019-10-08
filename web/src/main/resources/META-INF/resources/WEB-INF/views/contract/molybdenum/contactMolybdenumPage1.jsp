<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

isc.ValuesManager.create({
         ID: "vm"
    });
isc.ValuesManager.create({
         ID: "contactHeader"
    });


function factoryLableHedear(id,contents,width,height,padding){
        isc.Label.create({
                ID:id,
                width: width,
                height: height,
                styleName: "helloWorldText",
                padding: padding,
                backgroundColor: "#a5ecff",
                align: "center",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: contents
                });
}

function factoryLable(id,contents,width,height,padding){
        isc.Label.create({
                ID:id,
                width: width,
                height: height,
                padding: padding,
                align: "left",
                valign: "left",
                wrap: false,
                contents: contents
                })
}
function factoryLableArticle(id,contents,height,padding){
           isc.Label.create({
                ID:id,
                height: height,
                padding: padding,
                align: "left",
                valign: "left",
                wrap: false,
                contents: contents
                })
}

var RestDataSource_Contact = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {name: "fax", title: "<spring:message code='contact.fax'/>"},
            {name: "address", title: "<spring:message code='contact.address'/>"},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},
            {name: "email", title: "<spring:message code='contact.email'/>"},
            {
                name: "type",
                title: "<spring:message code='contact.type'/>",
                valueMap: {
                    "true": "<spring:message code='contact.type.real'/>",
                    "false": "<spring:message code='contact.type.legal'/>"
                }
            },
            {name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>"},
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "ceoPassportNo"},
            {name: "ceo"},
            {name: "commercialRole"},
            {
                name: "status",
                title: "<spring:message code='contact.status'/>",
                valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
            },
            {name: "tradeMark"},
            {name: "commercialRegistration"},
            {name: "branchName"},
            {name: "countryId", title: "<spring:message code='country.nameFa'/>", type: 'long'},
            {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},
            {name: "contactAccounts"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
});

var RestDataSource_Contact_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contact/list"
});

var RestDataSource_Currency_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/currency/spec-list"
});

var RestDataSource_Parameters = isc.MyRestDataSource.create({
        fields:
        [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: 200},
        {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: 200},
        {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: 200}
        ],
        fetchDataURL: "${contextPath}/api/parameters/spec-list"
});

var RestDataSource_WarehouseLot = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> "},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                {name: "size1Value", title: "<spring:message code='warehouseLot.size1Value'/>", align: "center"},
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                {name: "size2Value", title: "<spring:message code='warehouseLot.size2Value'/>", align: "center"},
                {name: "weightKg", title: "<spring:message code='warehouseLot.weightKg'/>", align: "center"},
                {name: "grossWeight", title: "<spring:message code='grossWeight.weightKg'/>", align: "center"},
                {name: "contractId",title: "contractId", align: "center"},
                {name: "used",type:"boolean",title: "used",canEdit:true, align: "center"}
            ],
        fetchDataURL: "${contextPath}/api/warehouseLot/spec-list"
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

 var RestDataSource_Incoterms = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
    });
    var RestDataSource_Contact_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "seller", operator: "equals", value: true}]
        };
    var RestDataSource_ContactBUYER_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "buyer", operator: "equals", value: true}]
        };
    var RestDataSource_ContactAgentBuyer_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "agentBuyer", operator: "equals", value: true}]
        };
    var RestDataSource_ContactAgentSeller_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "agentSeller", operator: "equals", value: true}]
    };


//START PAGE ONE
     factoryLableHedear("LablePage",'<b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b>',"100%","2%",20)
     factoryLable("lableNameContact",'<b><font size=4px>Molybdenum Oxide Contract-BAPCO/NICICO</font><b>',"100%",'2%',2);
     factoryLable("lableArticle2",'<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>',"100%",'2%',20);
     factoryLable("lableArticle3",'<b><font size=4px>ARTICLE 3 -QUANTITY :</font><b>',"100%",'2%',20);
     factoryLable("lableImportantNote",'<b><font size=4px>IMPORTANT Note :</font><b>',"100%",'2%',20);
     factoryLableArticle("lableArticle1",'<b><font size=4px>ARTICLE 1 -</font><b>',"30",5)
     factoryLableArticle("lableArticle6",'<b><font size=4px>ARTICLE 6 -</font><b>',"30",5)
     factoryLableArticle("lableArticle7",'<b><font size=4px>ARTICLE 7 -</font><b>','30',5);
     factoryLableArticle("lableArticle8",'<b><font size=4px>ARTICLE 8 -</font><b>','30',5);
     factoryLableArticle("lableArticle9",'<b><font size=4px>ARTICLE 9 -</font><b>','30',5);
     factoryLableArticle("lableArticle10",'<b><font size=4px>ARTICLE 10  - CURRENCY OPTION:</font><b>','30',5);
     factoryLableArticle("lableContainerized",'<b><font size=4px>CONTAINERIZED DELIVERY:</font><b>',"30",5)
      var lable_article2_1 =isc.Label.create({
                wrap: false,
                padding: 5,
                contents: '<b><font size=2px>  OPTION WILL BE CONSIDERED FOR EACH SHIPMENT QUANTITY.</font><b>'
                })
      var DynamicForm_ContactHeader = isc.DynamicForm.create({
                valuesManager:"contactHeader",
                wrapItemTitles:false,
                setMethod: 'POST',
                width: "100%",
                height: "100%",
                align: "left",
                canSubmit: true,
                showInlineErrors: true,
                showErrorText: true,
                showErrorStyle: true,
                errorOrientation: "right",
                titleWidth: "80",
                titleAlign: "right",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                cellPadding: 2,
                numCols: 4,
                fields: [
                {name: "id", hidden: true},
                {
                name: "Date",
                type:"date",
                title: "<spring:message code='contact.date'/>",
                required: true,
                readonly: true,
                width: "90%",
                wrapTitle: false
                },
                {
                name: "NO",
                title: "<spring:message code='contact.no'/>",
                required: true,
                readonly: true,
                width: "90%",
                wrapTitle: false
                }
                ]
                });
        var DynamicForm_ContactCustomer = isc.DynamicForm.create({
                setMethod: 'POST',
                valuesManager:"contactHeader",
                width: "100%",
                height: "100%",
                numCols: 4,
                wrapItemTitles:false,
                align: "center",
                canSubmit: true,
                showInlineErrors: true,
                showErrorText: true,
                showErrorStyle: true,
                errorOrientation: "right",
                titleWidth: "80",
                titleAlign: "right",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                fields: [
                            {name: "id",canEdit: false, hidden: true},
                            {
                            name: "Customer",
                            showHover: true,
                            autoFetchData: false,
                            title: "<spring:message code='contact.name'/>",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Contact,
                            optionCriteria: RestDataSource_ContactBUYER_optionCriteria,
                            displayField: "nameFA",
                            valueField: "id",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "nameFA", width: "45%", align: "center"},
                            {name: "nameEN", width: "45%", align: "center"},
                            {name: "code", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                               makeBodyDynamicFormPage1(1);
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                                dynamicForm_Contact1.setValue("address",address);
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                                dynamicForm_Contact1.setValue("name",name);
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                                dynamicForm_Contact1.setValue("phone",phone);
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                                dynamicForm_Contact1.setValue("phone",phone);
                            }
                            }
                            },
                            {
                            name: "Agent Buyer",
                            showHover: true,
                            autoFetchData: false,
                            title: "<spring:message code='contact.commercialRole.agentBuyer'/>",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Contact,
                            optionCriteria: RestDataSource_ContactAgentBuyer_optionCriteria,
                            displayField: "nameFA",
                            valueField: "id",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "nameFA", width: "45%", align: "center"},
                            {name: "nameEN", width: "45%", align: "center"},
                            {name: "code", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                                makeBodyDynamicFormPage1(2);
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                                dynamicForm_Contact2.setValue("address",address);
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                                dynamicForm_Contact2.setValue("name",name);
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                                dynamicForm_Contact2.setValue("phone",phone);
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                                dynamicForm_Contact2.setValue("mobile",mobile);
                            }
                            }
                            }
                ]
                });
                var DynamicForm_ContactSeller = isc.DynamicForm.create({
                            valuesManager:"contactHeader",
                            width: "100%",
                            height: "100%",
                            numCols: 4,
                            setMethod: 'POST',
                            align: "center",
                            canSubmit: true,
                            showInlineErrors: true,
                            wrapItemTitles:false,
                            showErrorText: true,
                            showErrorStyle: true,
                            errorOrientation: "right",
                            titleAlign: "right",
                            requiredMessage: "<spring:message code='validator.field.is.required'/>",
                            fields: [
                            {name: "id", canEdit: false, hidden: true},
                            {
                            name: "Seller",
                            numCols: 2,
                            showHover: true,
                            autoFetchData: false,
                            title: "Seller",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Contact,
                            optionCriteria: RestDataSource_Contact_optionCriteria,
                            displayField: "nameFA",
                            valueField: "id",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "nameFA", width: "45%", align: "center"},
                            {name: "nameEN", width: "45%", align: "center"},
                            {name: "code", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                                makeBodyDynamicFormPage1(3);
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                                dynamicForm_Contact3.setValue("address",address);
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                                dynamicForm_Contact3.setValue("name",name);
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                                dynamicForm_Contact3.setValue("phone",phone);
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                                dynamicForm_Contact3.setValue("mobile",mobile);
                            }
                            }
                            },
                            {
                            name: "Agent Seller",
                            numCols: 2,
                            showHover: true,
                            autoFetchData: false,
                            title: "Agent Seller",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Contact,
                            optionCriteria: RestDataSource_ContactAgentSeller_optionCriteria,
                            displayField: "nameFA",
                            valueField: "id",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "nameFA", width: "45%", align: "center"},
                            {name: "nameEN", width: "45%", align: "center"},
                            {name: "code", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                                makeBodyDynamicFormPage1(4);
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                            if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                                 dynamicForm_Contact4.setValue("address",address);
                            }
                            if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                                 dynamicForm_Contact4.setValue("name",name);
                            }
                            if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                                 dynamicForm_Contact4.setValue("phone",phone);
                            }
                            if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                                 dynamicForm_Contact4.setValue("mobile",mobile);
                            }
                            }
                            }
                            ]
                            });

                var DynamicForm_ContactParameter_number8 = isc.DynamicForm.create({
                            valuesManager:"vm",
                            padding: 5,
                            width: "100%",
                            height: "100%",
                 //           isGroup:true,
                            numCols: 4,
                            setMethod: 'POST',
                            align: "left",
                            canSubmit: true,
                            showInlineErrors: true,
                            wrapItemTitles:false,
                            showErrorText: true,
                            showErrorStyle: true,
                            errorOrientation: "right",
                            titleAlign: "right",
                            requiredMessage: "<spring:message code='validator.field.is.required'/>",
                            fields: [
                            {
                            name: "parameter",
                            showHover: true,
                            autoFetchData: false,
                            title: "Parameter",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Parameters,
                            displayField: "paramName",
                            valueField: "id",
                            showTitle: false,
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "paramName", width: "45%", align: "center"},
                            {name: "paramType", width: "45%", align: "center"},
                            {name: "paramValue", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                            var paramValue="";
                                if(paramValue !=undefined){paramValue=item.getSelectedRecord().paramValue};
                                DynamicForm_ContactParameter_ValueNumber8.setValue("value",paramValue)
                            }
                            }
                            ]
                            });
                isc.DynamicForm.create({
                        ID:"DynamicForm_ContactParameter_ValueNumber8",
                        valuesManager:"vm",
                        height: "20",
                        width: "50%",
                        wrapItemTitles:true,
                        items:[
                             {name: "value",
                                 type: "text",
                                 length: 5000,
                                 showTitle: false,
                                 colSpan: 2,
                                 width: "*",
                                 title: "NAME"
                            }
                        ]
                    })
                var article2 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "50%",
                        numCols: 14,
                        wrapItemTitles:false,
                        items:[
                            {type: "number",width: "80", name: "article2_number10",defaultValue: "",title:"",showTitle:false,
                             changed : function (form, item, value) {
                                article2.setValue("english",numberToEnglish(value))
                            }
                            },
                            {type: "text",styleName:"textToLable",width: "200", name: "english",title:"",showTitle:false,disabled:"true"},
                            {
                                name: "article2_number12",
                                title: "",
                                type: 'long',
                                width: "150",
                                editorType: "SelectItem",
                                optionDataSource: RestDataSource_Unit,
                                displayField: "nameEN",
                                valueField: "id",
                                pickListWidth: "500",
                                pickListHeight: "500",
                                pickListProperties: {showFilterEditor: true},
                                pickListFields: [
                                    {name: "id", title: "id",canEdit: false, hidden: true},
                                    {name: "nameEN", width: 440, align: "center"}
                                ]
                            },
                            {type: "text",width: "80", name: "telorans",title:"+/-",defaultValue: "10" },
                            {
                                type: "text",
                                width: "100",
                                name: "option",
                                startRow: false,
                                title: '<b><font size=2px>(IN</font><b>',
                                 valueMap: {
                                        "1": "SELLERS",
                                        "2": "BUYER"
                                },
                                changed : function (form, item, value) {
                                        var data=DynamicForm_ContactSeller.getValues();
                                        console.log(data,"*****************************************")
                                        var RestDataSourceTest = {
                                                _constructor: "AdvancedCriteria",
                                                operator: "and",
                                                criteria: [{fieldName: "id", operator: "equals", value: data}]
                                                };
                                        setTimeout(function(){RestDataSource_Contact.fetchData(RestDataSourceTest,
                                                            function (dsResponse, data) {})} , 1000)

                                    }
                            },
                            {
                                type: "text",
                                name: "ProducedAddress",
                                width: "500",
                                startRow: false,
                                title: '<b><font size=2px>OPTION) PRODUCED IN</font><b>'
                            }
                        ]
                    });
var article2_1 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "100%",
                        numCols: 6,
                        wrapItemTitles:false,
                        items:[
                            {
                                type: "text",
                                name: "teloransOption",
                                width: "50",
                                startRow: false,
                                title: '<b><font size=2px>THE TOLERENCE OF +/-%</font><b>'
                            },
                             {
                                type: "text",
                                width: "150",
                                name: "responsibleTelerons",
                                startRow: false,
                                title: '<b><font size=2px>(IN</font><b>',
                                 valueMap: {
                                        "1": "SELLERS",
                                        "2": "BUYER"
                                }
                            }
                        ]
                    })

var lotList  = isc.ListGrid.create({
                        dataSource: RestDataSource_WarehouseLot,
                        dataPageSize: 50,
                        autoFetchData: true,
                        fields:
                        [
                            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                            {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                            {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                            {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> "},
                            {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                            {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                            {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                            {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                            {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                            {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                            {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                            {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                            {name: "contractId",title: "contractId", align: "center"},
                            {name: "used",type:"boolean",title:"used", align: "center",canEdit: true,
                            changed : function (form, item, value) {
                               console.log(value);
                            }
                            }




                        ]
                        });

var dynamicForm1 = isc.HLayout.create({align: "center",members:[]});
var dynamicForm2 = isc.HLayout.create({align: "center",members:[]});
var dynamicForm3 = isc.HLayout.create({align: "center",members:[]});
var dynamicForm4 = isc.HLayout.create({align: "center",members:[]});

var vlayoutBody=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({align: "left",  members:[DynamicForm_ContactHeader]}),
                        isc.HLayout.create({height:"50",align: "left",  members:[lableNameContact]}),
                        isc.HLayout.create({align: "left",  members:[DynamicForm_ContactCustomer]}),
                        isc.HLayout.create({ID:"dynamicForm1And2",align: "center",members:[dynamicForm1,dynamicForm2]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactSeller]}),
                        isc.HLayout.create({ID:"dynamicForm3And4",align: "center",members:[dynamicForm3,dynamicForm4]})
                         ]
                    });
var vlayoutArticle1=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({align: "left",members:[lableArticle1,DynamicForm_ContactParameter_number8]}),
                        isc.HLayout.create({align: "left",members:[DynamicForm_ContactParameter_ValueNumber8]})
                         ]
                    });
var vlayoutArticle2=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"50",align: "center",members:[lableArticle2]}),
                        isc.HLayout.create({align: "left",  members:[article2]}),
                        isc.HLayout.create({align: "left",  members:[article2_1,lable_article2_1]})
                         ]
                    });
var vlayoutArticle3=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"30",align: "left",  members:[lableArticle3]}),
                        isc.HLayout.create({width: "80%",align: "center",  members:[lotList]})
                         ]
                    });
var VLayout_PageOne_Contract = isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    backgroundImage: "backgrounds/leaves.jpg",
                    members: [
                        LablePage,
                        vlayoutBody,
                        vlayoutArticle1,
                        vlayoutArticle2,
                        vlayoutArticle3
                    ]
                    });
//END PAGE ONE

//START PAGE TOW
        factoryLableHedear("LablePageTwo",'<b>Page 2 of Molybdenum Oxide Contact - BAPCO/NICIO<b>',"100%","2%",20)
        factoryLableArticle("lableArticle4",'<b><font size=4px>ARTICLE 4 - </font><b>','2%',1);
        factoryLableArticle("lableArticle5",'<b><font size=4px>ARTICLE 5 - </font><b>',"20",1)
        var dynamicForm_article3 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "4%",
                        numCols: 8,
                        wrapItemTitles:false,
                        items:[
                            {
                                type: "text",
                                name: "article3_number17",
                                showTitle:false,
                                width: "150",
                                startRow: false,
                                title: ''
                            },{
                                type: "text",
                                name: "article3_number17_7",
                                showTitle:false,
                                width: "350",
                                startRow: false,
                                title: 'article3_number17_7'
                            },{
                                type: "text",
                                name: "article3_number17_8",
                                showTitle:false,
                                width: "50",
                                startRow: false,
                                title: 'article3_number17_8'
                            },{
                                type: "text",
                                name: "article3_number17_9",
                                showTitle:false,
                                width: "50",
                                startRow: false,
                                title: '+/-'
                            },{
                                type: "text",
                                name: "article3_number17_10",
                                showTitle:false,
                                width: "350",
                                defaultValue: "IN SELLER 'S OPTION)WHICH WILL BE PERFORMED AT ",
                                startRow: false,
                                title: 'article3_number17_10'
                            },{
                                type: "text",
                                name: "article3_number17_11",
                                showTitle:false,
                                width: "50",
                                startRow: false,
                                title: 'quantity_number17_11'
                            },{
                                type: "text",
                                name: "article3_number17_12",
                                showTitle:false,
                                width: "350",
                                startRow: false,
                                defaultValue: "IS FINAL AND BINDING FOR SETTLEMENT PURPOSES.",
                                title: 'quantity_number17_12'
                            }
                        ]
                    })

        dynamicForm_article3.setValue("quantity_number17_7","ANALYSIS RESULTS FOR THE REMAINING QUANTITY(");

        var dynamicForm_article3_1 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        wrapItemTitles:false,
                        items:[
                            {
                            name: "article3_number17_1",
                            showHover: true,
                            autoFetchData: false,
                            title: "",
                            hint: "AHK",
                            width: "150",
                            showHintInField: true,
                            showTitle:false,
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Parameters,
                            displayField: "paramName",
                            valueField: "paramName",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "paramName", width: "45%", align: "center"},
                            {name: "paramType", width: "45%", align: "center"},
                            {name: "paramValue", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                                dynamicForm_article3.setValue("quantity_number17",value);
                                dynamicForm_article3.setValue("quantity_number17_11",value);
                            }
                            }
                        ]
                    })
        var dynamicForm_article3_2 = isc.DynamicForm.create({
                        height: "20",
                        width: "50%",
                        wrapItemTitles:true,
                        items:[
                                 {name: "article3_number17_2",
                                 type: "text",
                                 length: 150,
                                 showTitle:false,
                                 colSpan: 2,
                                 width: "*",
                                 title: "quantity_number17_2"
                             }
                        ]
                    })
        dynamicForm_article3_2.setValue("quantity_number17_2","'S ANALYSIS RESULTS AS PER ABOVE ASSYS WHICH IS BIENG PERFORMED AT AHK IS FINAL AND BINDING FOR SETTLEMENT PURPOSES.");

         var dynamicForm_article3_3 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "50",
                        numCols: 8,
                        wrapItemTitles:false,
                        items:[
                            {
                                type: "text",
                                name: "article3_number17_3",
                                showTitle:true,
                                length: 100,
                                width: "100",
                                hint: "210MT",
                                showHintInField: true,
                                startRow: false,
                                title: '- ',
                                changed : function (form, item, value) {
                                dynamicForm_article3.setValue("quantity_number17_8",value);
                                dynamicForm_article5_number29_1.setValue("article5_number29_2",value);
                                }
                            },{
                                type: "text",
                                name: "article3_number17_4",
                                showTitle:true,
                                length: 100,
                                width: "100",
                                hint: "10%",
                                showHintInField: true,
                                startRow: false,
                                title: '+/-',
                                changed : function (form, item, value) {
                                dynamicForm_article3.setValue("article3_number17_9",value);
                                dynamicForm_article5_number29_1.setValue("article5_number29_3",value);
                                }
                            },{
                                type: "text",
                                name: "article3_number17_5",
                                showTitle:false,
                                width: "500",
                                wrap:false,
                                defaultValue: "(SELLER 'S OPTION) IN PARTIAL SHIPMENT",
                                startRow: false,
                                title: 'quantity_number17_5'
                            },{
                                type: "text",
                                name: "article3_number17_6",
                                showTitle:false,
                                width: "500",
                                hint: "TILL 15 MARCH 2019",
                                showHintInField: true,
                                startRow: false,
                                title: 'quantity_number17_6',
                                changed : function (form, item, value) {
                                    dynamicForm_article5_number24_number25_number26.setValue("article5_number26",value);
                                    dynamicForm_article5_number29_1.setValue("article5_number29_5",value);
                                }
                            }
                        ]
                    })
        var dynamicForm_article4_number18 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "100%",
                        wrapItemTitles:false,
                        items:[
                            {
                                name: "article4_number18",
                                showTitle:false,
                                defaultValue: "PACKING",
                                width: "100",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article4_1_number19 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "100%",
                        numCols: 6,
                        wrapItemTitles:false,
                        items:[
                            {
                                name: "amount_number19",
                                showTitle:false,
                                width: "250",
                                defaultValue: "IN STEEL DRUMS OF ",
                                startRow: false,
                                title: ''
                            },{
                                name: "amount_number19_1",
                                showTitle:false,
                                width: "70",
                                hint: "220",
                                showHintInField: true,
                                startRow: false,
                                title: ''
                            },{
                                name: "amount_number19_2",
                                showTitle:false,
                                width: "350",
                                defaultValue: " LITERS,WITH LIDS SECURED BY RINGS ON PALLETS.",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article5_number20 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        wrapItemTitles:false,
                        items:[
                            {
                                name: "shipment_number20",
                                showTitle:false,
                                hint: "SHIPMENT",
                                showHintInField: true,
                                width: "100",
                                startRow: false
                            }
                        ]
                    })
        var dynamicForm_article5_number21 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 14,
                        wrapItemTitles:false,
                        items:[
                            {
                                name: "article5_number21",
                                showTitle:true,
                                hint: "AFTER RECEIPT",
                                showHintInField: true,
                                width: "150",
                                startRow: false,
                                title: 'SHIPMENT SHALL BE PERFORMED'
                            },{
                                name: "article5_number22",
                                showTitle:true,
                                width: "100",
                                hint: "105%",
                                showHintInField: true,
                                startRow: false,
                                title: 'OF',
                                changed : function (form, item, value) {
                                            dynamicForm_article9_number46.setValue("article9_number22",value);
                                            dynamicForm_article9_number46.setValue("article9_Englishi_number22",numberToEnglish(value)+" PERCENT")
                                }
                            },{
                                name: "article5_number23",
                                showTitle:true,
                                width: "250",
                                hint: "PROFORMA/PROVISIONAL",
                                showHintInField: true,
                                startRow: false,
                                title: 'OF VALUE AMOUNT OF ',
                                changed : function (form, item, value) {
                                            dynamicForm_article9_number46.setValue("article9_number23",value);
                                }
                            },{
                                name: "article5_number21_6",
                                showTitle:false,
                                width: "150",
                                hint: " INVOICE PRIOR EACH",
                                showHintInField: true,
                                startRow: false
                            }
                        ]
                    })
        var dynamicForm_article5_number24_number25_number26 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 8,
                        wrapItemTitles:false,
                        items:[
                             {
                                name: "article5_number24_number25",
                                width: "250",
                                hint: "NOVEMBER/DECEMBER 2018",
                                showHintInField: true,
                                startRow: false,
                                showTitle:true,
                                title: 'SHIPMENT COMMENCING FROM ',
                                changed : function (form, item, value) {
                                        dynamicForm_article5_number28_number29.setValue("article5_number28",value);
                                }
                            },{
                                name: "article5_number26",
                                width: "150",
                                hint: "TILL 15 MARCH 2019",
                                showHintInField: true,
                                startRow: false,
                                title: ''
                            },{
                                name: "article5_number26_1",
                                width: "200",
                                defaultValue: "AS PER FOLLOWING:",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article5_number28_number29 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        wrapItemTitles:false,
                        numCols: 4,
                        items:[
                             {
                                name: "article5_number28",
                                width: "250",
                                showTitle:true,
                                hint: "NOVEMBER/DECEMBER 2018",
                                showHintInField: true,
                                startRow: false,
                                title: '-'
                            },{
                                name: "article5_number29",
                                width: "100",
                                showTitle:false,
                                hint: "90MT +/-10",
                                showHintInField: true,
                                startRow: false,
                                title: '-'
                            }
                        ]
                    })
        var dynamicForm_article5_number29_1 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        wrapItemTitles:false,
                        numCols: 10,
                        items:[
                             {
                                name: "article5_number29_2",
                                width: "50",
                                showTitle:true,
                                hint: "210MT",
                                showHintInField: true,
                                startRow: false,
                                title: '- REMAINING QUANTITY('
                            },{
                                name: "article5_number29_3",
                                width: "50",
                                showTitle:true,
                                hint: "10",
                                showHintInField: true,
                                startRow: false,
                                title: '+/-'
                            },{
                                name: "article5_number29_5",
                                width: "150",
                                showTitle:true,
                                hint: "15 MARCH 2019",
                                showHintInField: true,
                                startRow: false,
                                title: ')SHALL BE SHIPPED UP TO'
                            }
                        ]
                    })
         var dynamicForm_article5_Note1 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        wrapItemTitles:false,
                        width: "20%",
                        numCols: 2,
                        items:[
                            {
                                name: "article5_Note1_lable",
                                width: "150",
                                height: "40",
                                showTitle:false,
                                defaultValue:"Note1",
                                startRow: false,
                                title: ''
                            },
                             {
                                 name: "article5_Note1_value",
                                 type: "text",
                                 length: 3000,
                                 showTitle: false,
                                 wrap:false,
                                 colSpan: 2,
                                 defaultValue: "MAXIMUM ONE WEEK AFTER CONTRACT SIGNATURE/STAMP BUYER IS OBLIGED TO INFORM SELLER OF ITS SHIPMENT SCHEDULE FOR THE REMAINING QUANTITY I.E",
                                 title: "article5_Note1",
                                 width: "*"
                            }
                            ]
            })
        var dynamicForm_article5_Note2_number30 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 2,
                        width: "20%",
                        wrapItemTitles:false,
                        items:[
                             {
                                name: "article5_Note2_number30",
                                width: "150",
                                height: "40",
                                showTitle:false,
                                showHintInField: true,
                                hint: "Note2",
                                startRow: false,
                                title: ''
                            },
                            {
                                 name: "article5_Note2",
                                 type: "text",
                                 length: 3000,
                                 showTitle: false,
                                 wrap:false,
                                 colSpan: 2,
                                 defaultValue: "",
                                 title: "article5_Note2",
                                 width: "*"
                            }
                        ]
                    })
        var dynamicForm_article6_number31 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 4,
                        width: "20%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {
                                name: "article6_number31",
                                width: "200",
                                showTitle:false,
                                showHintInField: true,
                                hint: "DELIVERY TERMS",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article6_number32_33_34_35 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {
                                name: "article6_number31_1",
                                width: "470",
                                showTitle:false,
                                defaultValue: "THE MATERIAL SHALL BE DELIVERED BY SELLER TO BUYER ON",
                                startRow: false,
                                title: ''
                            },
                            {
                            name: "article6_number32",
                            colSpan: 3,
                            titleColSpan: 1,
                            width: "150",
                            tabIndex: 6,
                            showTitle:false,
                            showHover: true,
                            showHintInField: true,
                            hint: "FOB",
                            required: true,
                            title: "<spring:message code='incoterms.name'/>",
                            type: 'long',
                            numCols: 4,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Incoterms,
                            displayField: "code",
                            valueField: "id",
                            pickListWidth: "500",
                            pickListHeight: "500",
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                                {name: "code", width: 440, align: "center"}
                            ],
                             changed : function (form, item, value) {
                                    dynamicForm_article6_Containerized_3.setValue("article6_Containerized_number32",value);
                                }
                            },
                            {
                                name: "article6_number32_1",
                                width: "100",
                                showTitle:false,
                                defaultValue: "STOWED",
                                startRow: false,
                                title: ''
                            },{
                                name: "article6_number33",
                                width: "200",
                                showTitle:false,
                                startRow: false,
                                showHintInField: true,
                                hint: "BANDAR ABBAS",
                                title: '',
                                changed : function (form, item, value) {
                                    dynamicForm_article6_Containerized.setValue("article6_Containerized_number33",value);
                                    dynamicForm_article6_Containerized_2.setValue("article6_Containerized_number33_1",value);
                                }
                            }, {
                                name: "article6_number34",
                                width: "100",
                                showTitle:false,
                                showHintInField: true,
                                hint: "IRAN",
                                startRow: false,
                                title: ''
                            },{
                                name: "article6_number35",
                                width: "250",
                                showTitle:false,
                                showHintInField: true,
                                hint: "(INCOTERMS 2010).",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })

        var dynamicForm_article6_Containerized = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized ",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "6.1.BUYER SGALL INTRODUCTE TO SELLER THE FULL PARTICULARS OF THE CONTAINER LINE NOMINATEDTED GIVIN FULL NAME REGISTERED ADDRESS TELEPHONE & FAX NUMBERS AND PERSONS IN CHARGE OF THEIR REPRESENTATIVES IN",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized ",
                                 width: "*"
                            },
                            ,{
                                name: "article6_Containerized_number36",
                                width: "100",
                                height: "50",
                                showTitle:false,
                                showHintInField: true,
                                hint: "TEHRAN",
                                startRow: false,
                                title: ''
                            },{
                                name: "article6_Containerized_number36_1",
                                width: "250",
                                height: "50",
                                showTitle:false,
                                defaultValue: "AS WELL AS AT THE PORT OF",
                                startRow: false,
                                title: ''
                            },{
                                name: "article6_Containerized_number33",
                                width: "150",
                                height: "50",
                                showTitle:false,
                                defaultValue: "BANDAR ABBAS",
                                startRow: false,
                                title: ''
                            }
                              ]
                })
        var dynamicForm_article6_Containerized_1 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized_number37_1",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "FOR FURTHER COORDINATIONS.LOCAL AGENTS AT THE LOADPORT SHALL BE ACCESSIBLE DURING FULL PERIOD OF LOAFOMG.IN ADDITION FOR EACH SHIPMENT.",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized_number37_1",
                                 width: "*"
                            }
                     ]
                })
        var dynamicForm_article6_Containerized_2 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized_number37_2",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "6.2.BUYER SHALL INTRODUCT TO SELLER THE NECESSARY ARRANGEMENTS FOR THE CONTAINERS TO BE PROVIDED AND POSITIONED AT THE EXPORT AREA INSIDE THE CONTAINER YARD OF",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized_number37_2",
                                 width: "*"
                            },{
                                name: "article6_Containerized_number33_1",
                                width: "150",
                                height: "50",
                                showTitle:false,
                                defaultValue: "BANDAR ABBAS",
                                startRow: false,
                                title: ''
                            }
                     ]
                })
        var dynamicForm_article6_Containerized_3 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized_number37_3",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "6.3.HOWEVER,COST OF MOVING THE LOADED CONTAINERS FROM EXPORT AREA TO THE",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized_number37_3",
                                 width: "*"
                            },
                             {
                                name: "article6_Containerized_number32",
                                colSpan: 3,
                                titleColSpan: 1,
                                width: "150",
                                height: "50",
                                tabIndex: 6,
                                showTitle:false,
                                showHover: true,
                                showHintInField: true,
                                hint: "FOB",
                                required: true,
                                title: "<spring:message code='incoterms.name'/>",
                                type: 'long',
                                numCols: 4,
                                editorType: "SelectItem",
                                optionDataSource: RestDataSource_Incoterms,
                                displayField: "code",
                                valueField: "id",
                                pickListWidth: "500",
                                pickListHeight: "500",
                                pickListProperties: {showFilterEditor: true},
                                pickListFields: [
                                    {name: "code", width: 440, align: "center"}
                                ]
                            }
                     ]
                })
        var dynamicForm_article6_Containerized_4 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized_4",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "AFTER POSITIONING THE REQUIRED EMPTY CONTAINERS BUYER WILL INFORM IMMEDIATELY THE TYPE(20/40FT) AND NUMBER OF CONTAINERS RELEVANT SERIAL NUMBERS TO SELLER.",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized_4",
                                 width: "*"
                            }
                            ]
                })
        var dynamicForm_article6_Containerized_5 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 12,
                        width: "50%",
                        wrapItemTitles:false,
                        padding: 2,
                        items:[
                             {name: "article6_Containerized_5",
                                 type: "text",
                                 height: "50",
                                 length: 3000,
                                 defaultValue: "6.5.PRIOR TO STUFFING THE CARGO,NOMINATED INSPECTION COMPANY 'S REPRESENTATIVE IF APPOINTED,OTHER WISE SELLER 'S STAFF WILL CHECK THE CONTAINERS TO APPROVE THEIR FITNESS FOR ACCEPTING THE CARGO.",
                                 showTitle: false,
                                 colSpan: 6,
                                 title: "article6_Containerized_4",
                                 width: "*"
                            }
                            ]
                })
        var vlayoutArticle3_1=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({align: "left",  members:[dynamicForm_article3_1,dynamicForm_article3_2]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article3_3]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article3]})
                         ]
                    });
        var vlayoutArticle4=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                            isc.HLayout.create({height:"50",align: "left",  members:[lableArticle4,dynamicForm_article4_number18]}),
                            isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article4_1_number19]})
                         ]
                    });
        var vlayoutArticle5=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"50",align: "left",  members:[lableArticle5,dynamicForm_article5_number20]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_number21]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_number24_number25_number26]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_number28_number29]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_number29_1]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_Note1]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article5_Note2_number30]})
                         ]
                    });
        var vlayoutArticle6=isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"50",align: "left",  members:[lableArticle6,dynamicForm_article6_number31]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_number32_33_34_35]}),
                        isc.HLayout.create({height:"50",align: "left",  members:[lableContainerized]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized_1]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized_2]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized_3]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized_4]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article6_Containerized_5]})
                         ]
                    });

        var VLayout_PageTwo_Contract = isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    backgroundImage: "backgrounds/leaves.jpg",
                    members: [
                        LablePageTwo,
                        vlayoutArticle3_1,
                        vlayoutArticle4,
                        vlayoutArticle5,
                        vlayoutArticle6
                    ]
                    });
//END PAGE TWO
//START PAGE THREE
 var dynamicForm_article7_number41 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 2,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article7_number41",
                                width: "200",
                                showTitle:false,
                                showHintInField: true,
                                hint: "PRICE",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
var dynamicForm_article7_number3_number37_number38 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 8,
                        wrapItemTitles:false,
                        padding: 3,
                        items:[
                             {
                                name: "article7_number3",
                                width: "200",
                                showTitle:true,
                                startRow: false,
                                defaultValue: "MOLYBDENUM OXIDE",
                                title: 'PRICE FOR',
                                changed : function (form, item, value) {
                                    dynamicForm_article7_number3.setValue("article7_number3_1",value);
                                    dynamicForm_article8_3.setValue("article8_3",value);
                                }
                            },{
                                name: "article7_number37",
                                width: "250",
                                showTitle:true,
                                startRow: false,
                                defaultValue: "PLATTS METALS WEEK",
                                title: 'WILL BE BASED ON THE',
                                changed : function (form, item, value) {
                                    dynamicForm_article7_number39_number40.setValue("article7_number39_1","OF "+value+"UNDER THE HEADING");
                                }
                            },{
                                name: "article7_number38",
                                width: "250",
                                showTitle:false,
                                startRow: false,
                                defaultValue: "MONTHLY AVERAGE",
                                title: 'WILL BE BASED ON THE'
                            },{
                                name: "article7_number3_1",
                                width: "250",
                                showTitle:true,
                                defaultValue: "MOLYBDENUM OXIDE",
                                startRow: false,
                                title: 'FOR'
                            }
                        ]
                    })

var dynamicForm_article7_number39_number40 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 8,
                        wrapItemTitles:false,
                        padding: 3,
                        items:[
                               {
                                name: "article7_number39",
                                width: "200",
                                showTitle:true,
                                startRow: false,
                                defaultValue: "MONTHLY REPORT",
                                title: 'AS PUBLISHED IN '
                                },{
                                name: "article7_number39_1",
                                width: "350",
                                showTitle:false,
                                startRow: false,
                                title: 'article7_number39_1'
                                },{
                                name: "article7_number40",
                                width: "250",
                                showTitle:false,
                                startRow: false,
                                defaultValue: "DEALER OXIDE MIDPOINT/MEAN",
                                title: 'article7_number40'
                                },{
                                name: "article7_number40_1",
                                width: "150",
                                showTitle:false,
                                startRow: false,
                                defaultValue: "PER POUND",
                                title: 'article7_number40_1'
                                }
                            ]
                        });
 var dynamicForm_article7_number40_2 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 2,
                        width: "10%",
                        wrapItemTitles:false,
                        padding: 3,
                        items:[
                                {
                                name: "article7_number40_2",
                                width: "450",
                                height: "40",
                                showTitle:false,
                                defaultValue:"OF MOLYBDENUM CONTENT WITH DISCOUNTS AS BELOW",
                                startRow: false,
                                title: ''
                            },
                               {name: "article7_number40_3",
                                 type: "text",
                                 height: "100",
                                 length: 3000,
                                 defaultValue: "",
                                 showTitle: false,
                                 colSpan: 4,
                                 title: "article7_number40_3",
                                 width: "*"
                            }
                               ]
                        });

        var vlayoutArticle7=isc.VLayout.create({
                    width: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"50",align: "left",  members:[lableArticle7,dynamicForm_article7_number41]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article7_number3_number37_number38]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article7_number39_number40]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article7_number40_2]})
                         ]
                    });

        var dynamicForm_article8_number42 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 2,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article8_number42",
                                width: "200",
                                showTitle:false,
                                showHintInField: true,
                                hint: "OUOTATIONAL PERIOD",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article8_3 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article8_3",
                                width: "200",
                                showTitle:true,
                                startRow: false,
                                title: 'QUOTATIONAL PERIOD FOR'
                            },{
                                name: "article8_value",
                                width: "450",
                                defaultValue: "MONTH FOLLOWING MONTH OF ACTUAL SHIPMENT",
                                showTitle:true,
                                startRow: false,
                                title: 'SHALL BE THE AVERAGE OF THE '
                            },
                             {
                                name: "article8_number43",
                                width: "80",
                                showTitle:true,
                                startRow: false,
                                title: '('
                            },
                             {
                                name: "article8_number44",
                                width: "80",
                                showTitle:true,
                                startRow: false,
                                title: '+'
                            },{
                                name: "article8_number44_1",
                                width: "400",
                                defaultValue: "FROM THE PORT OF LOADING AS EVIDENCED BY THE B/L DATE.",
                                showTitle:true,
                                startRow: false,
                                title: ')'
                            }
                        ]
                    })

        var vlayoutArticle8=isc.VLayout.create({
                    width: "100%",
                    height: "50",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"30",align: "left",  members:[lableArticle8,dynamicForm_article8_number42]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article8_3]})
                         ]
                    });

        var dynamicForm_article9_number45 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 2,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article9_number45",
                                width: "200",
                                showTitle:false,
                                showHintInField: true,
                                hint: "PAYMENT",
                                startRow: false,
                                title: ''
                            }
                        ]
                    })
        var dynamicForm_article9_number46_number47_number48_number49 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article9_number45_number46",
                                width: "200",
                                showTitle:true,
                                title: '1.BUYER SHALL PAY',
                                defaultValue:"BEFORE EACH SHIPMENT",
                                startRow: false
                            },
                            {
                                name: "article9_number22",
                                width: "100",
                                showTitle:false,
                                showHintInField: true,
                                hint: "105",
                                title: 'article9_number22',
                                startRow: false
                            },{
                                name: "article9_Englishi_number22",
                                disabled:"true",
                                width: "200",
                                showTitle:false,
                                title: 'article9_Englishi_number22',
                                startRow: false
                            },{
                                name: "article9_number23",
                                width: "200",
                                showTitle:true,
                                title: 'OF',
                                startRow: false
                            },{
                                name: "article9_number47",
                                width: "100",
                                showTitle:true,
                                startRow: false,//TO DO currency
                                 valueMap: {
                                    "1": "EURO",
                                    "2": "dollar",
                                    "3": "AED"
                                },
                                title: 'INVOICE VALUE AMOUNT IN'
                            },{
                                name: "article9_number48",
                                width: "100",
                                showTitle:true,
                                startRow: false,
                                valueMap: {
                                    "1": "EURO",
                                    "2": "dollar",
                                    "3": "AED"
                                },
                                title: 'OF'
                            },{
                                name: "article9_number49",
                                width: "250",
                                showTitle:true,
                                startRow: false,        /// TO DO PAYMENT OPTION
                                title: 'PROMPT NET CASH PAYABLE BY'
                            },{
                                name: "article9_number49_1",
                                width: "300",
                                showTitle:true,
                                defaultValue:"IRREVOCABLE LETTER OF CREDIT AT SIGHT",
                                startRow: false,
                                title: 'OR UNDER AN'
                            }
                        ]
                    })
        var dynamicForm_article9_number50_number51_number52 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             ,{
                                name: "article9_number50",
                                width: "150",
                                showTitle:true,
                                defaultValue:"",
                                startRow: false,
                                showHintInField: true,
                                title: 'TO A BANK WHICH IS NOMINATED BY SELLER PROFORMA/PROVISIONAL INVOICE AMOUNT CALCULATED BASED ON PROVISIONAL PRICE WHICH IS AVERAGE OF'
                            },{
                                name: "article9_number51",
                                width: "150",
                                showTitle:true,
                                defaultValue:"PRIOR",
                                startRow: false,
                                showHintInField: true,
                                title: 'PRICE'
                            },{
                                name: "article9_number52",
                                width: "150",
                                showTitle:false,
                                defaultValue:"",
                                hint: "DATE",
                                startRow: false,
                                showHintInField: true,
                                title: ''
                            },{
                                name: "article9_number52_1",
                                width: "150",
                                showTitle:false,
                                startRow: false,
                                title: '',
                                valueMap: {
                                    "FINAL": "FINAL",
                                    "TYPICAL": "TYPICAL"
                                }
                            }
                        ]
                    })
         var dynamicForm_article9_number54 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                             {
                                name: "article9_number54",
                                width: "150",
                                showTitle:true,
                                defaultValue:"",
                                startRow: false,
                                hint: "PLATTS",
                                showHintInField: true,
                                title: 'ASSAY OUBLISHED BY'
                             },{
                                name: "article9_number54_1",
                                width: "600",
                                showTitle:false,
                                defaultValue:"EVERY FRIDAY UNDER HEADING OF WEEKLY AVERAGE MINUS THE APPLICABLE DISCOUNT.",
                                startRow: false
                             }
                        ]
                    });
        var dynamicForm_article9_number55 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        width: "10%",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 5,
                        items:[
                            {name: "article9_number55",
                                 type: "text",
                                 height: "100",
                                 length: 3000,
                                 defaultValue: "",
                                 showTitle: false,
                                 colSpan: 4,
                                 title: "article9_number55",
                                 width: "*"
                            }
                        ]
                    })

        var vlayoutArticle9=isc.VLayout.create({
                    width: "100%",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"30",align: "left",  members:[lableArticle9,dynamicForm_article9_number45]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article9_number46_number47_number48_number49]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article9_number50_number51_number52]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article9_number54]}),
                        isc.HLayout.create({height:"30",align: "left",  members:[dynamicForm_article9_number55]}),
                            ]
                    });

        var dynamicForm_article10_number56 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "20",
                        width: "100",
                        numCols: 10,
                        wrapItemTitles:false,
                        padding: 8,
                        items:[
                            {
                            name: "currency",
                            showHover: true,
                            autoFetchData: false,
                            title: "currency",
                            required: true,
                            editorType: "SelectItem",
                            optionDataSource: RestDataSource_Currency_list,
                            displayField: "nameEn",
                            valueField: "id",
                            showTitle: false,
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "nameEn", width: "45%", align: "center"},
                            {name: "nameFa", width: "45%", align: "center"}
                            ],
                            multiple: true,
                            multipleAppearance:"picklist",
                              changed : function (form, item, value) {
                                    var currencyValue= item.getSelectedRecord().nameEn;
                                    makeBodyDynamicFormCurrency(currencyValue,value)
                                }
                            }
                        ]
                    })


        var vlayoutCurrency=isc.VLayout.create({align: "center",members: [] });

        var vlayoutArticle10=isc.VLayout.create({
                    width: "100%",
                    height: "50",
                    styleName:"box-shaddow",
                    members: [
                        isc.HLayout.create({height:"30",align: "left",  members:[lableArticle10,dynamicForm_article10_number56]}),
                        isc.HLayout.create({height:"30",align: "center",  members:[vlayoutCurrency]})
                            ]
                    });
        var VLayout_PageThree_Contract = isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    backgroundImage: "backgrounds/leaves.jpg",
                    members: [
                        vlayoutArticle7,
                        vlayoutArticle8,
                        vlayoutArticle9,
                        isc.HLayout.create({height:"30",align: "left",members:[lableImportantNote]}),
                        vlayoutArticle10
                    ]
                    });
//END PAGE THREE

        var contactTabs = isc.TabSet.create({
                            width: "100%",
                            height: "97%",
                            tabs: [
                            {title: "page1", canClose: false,
                                pane: VLayout_PageOne_Contract
                            },
                            {title: "page2", canClose: false,
                                pane: VLayout_PageTwo_Contract
                            },
                            {title: "page3", canClose: false,
                                pane: VLayout_PageThree_Contract    },
                            {title: "page4", canEditTitle: false,
                            pane: isc.Img.create({autoDraw: false, width: 48, height: 48, src: "pieces/48/pawn_red.png"})}
                            ]
                        });




        var IButton_Contact_Save = isc.IButton.create({
                            top: 260,
                            title: "<spring:message code='global.form.save'/>",
                            icon: "pieces/16/save.png",
                            click: function () {
                            // alert(JSON.stringify(contactHeaderBody1.getValues()));
                            // alert(JSON.stringify(contactHeader.getValues()));
                            // alert(JSON.stringify(contactHeaderBody2.getValues()));
                            }
                            });

        var contactFormButtonSaveLayout = isc.HStack.create({
                        width: "100%",
                        height: "3%",
                        align: "center",
                        showEdges:true,
                        backgroundColor:"#CCFFFF",
                        membersMargin:5,
                        layoutMargin:10,
                        members:[
                                IButton_Contact_Save
                        ]
                        });

        isc.VLayout.create({
                    ID:"VLayout_contactMain",
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    members: [
                        contactTabs,
                        contactFormButtonSaveLayout
                    ]
                    });


function makeBodyDynamicFormCurrency(value,id){
    isc.DynamicForm.create({
                        ID:"dynamicForm_Currency"+id,
                        valuesManager:"vm",
                        height: "20",
                        width: "50%",
                        numCols: 10,
                        isGroup: true,
                        groupTitle: value,
                        wrapItemTitles:true,
                        items:[
                            {    name: "currency"+value,
                                 type: "text",
                                 length: 5000,
                                 showTitle: false,
                                 colSpan: 8,
                                 defaultValue: "",
                                 title: value,
                                 width: "*"
                            },
                            {
                                type: "button",
                                title: "remove",
                                width: 100,
                                startRow: false,
                                align: "center",
                                icon: "icons/16/message.png",
                                click: function(){
                                        vlayoutCurrency.removeMember("dynamicForm_Currency"+id);
                                    }
                            }
                            ]
    });
    vlayoutCurrency.addMember("dynamicForm_Currency"+id,id);
    dynamicForm_article10_number56.clearValues ()
}


function makeBodyDynamicFormPage1(value){
        isc.ValuesManager.create({
            ID: "contactHeaderBody"+value
            });
        isc.DynamicForm.create({
                        ID:"dynamicForm_Contact"+value,
                        valuesManager:"contactHeaderBody"+value,
                        height: "20",
                        width: "50%",
                        disabled:"true",
                        wrapItemTitles:true,
                        items:[
                             {name: "name",
                                 type: "text",
                                 length: 250,
                                 showTitle: true,
                                 colSpan: 2,
                                 width: "*",
                                 title: "NAME"
                             }
                            ,{name: "phone",
                                 type: "text",
                                 length: 100,
                                 showTitle: true,
                                 colSpan: 2,
                                 title: "Phone",
                                 width: "*"
                            },{name: "mobile",
                                 type: "text",
                                 length: 100,
                                 showTitle: true,
                                 colSpan: 2,
                                 title: "Mobile",
                                 width: "*"
                            },
                            {name: "address",
                                 type: "text",
                                 length: 5000,
                                 showTitle: true,
                                 colSpan: 2,
                                 title: "Address",
                                 width: "*"
                            }
                        ]
                    })
    switch(value) {
          case 1:
                dynamicForm1.addMember("dynamicForm_Contact"+value,value);
            break;
          case 2:
                dynamicForm2.addMember("dynamicForm_Contact"+value,value);
            break;
          case 3:
                dynamicForm3.addMember("dynamicForm_Contact"+value,value);
            break;
          case 4:
                dynamicForm4.addMember("dynamicForm_Contact"+value,value);
            break;
        }
};