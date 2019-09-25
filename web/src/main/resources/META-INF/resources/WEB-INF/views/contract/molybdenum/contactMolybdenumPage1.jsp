<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

isc.ValuesManager.create({
         ID: "vm"
    });

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
                {name: "grossWeight", title: "<spring:message code='grossWeight.weightKg'/>", align: "center"}
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
        var LablePage =isc.Label.create({
                width: "100%",
                height: "2%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#a5ecff",
                align: "center",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: '<b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b>'
                });
        var lableNameContact =isc.Label.create({
                width: "100%",
                height: "2%",
                padding: 2,
                align: "left",
                valign: "left",
                wrap: false,
                contents: '<b><font size=4px>Molybdenum Oxide Contract-BAPCO/NICICO</font><b>'
                })
        var lablePage1 =isc.Label.create({
                width: "50%",
                height: "20%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#fcfffa",
                align: "left",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: 'Please select an item Customer'
                })
        var LablePage2 =isc.Label.create({
                width: "50%",
                height: "20%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#fcfffa",
                align: "left",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: 'Please select an item Agent Buyer'
                })
        var lablePage3 =isc.Label.create({
                width: "50%",
                height: "20%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#fcfffa",
                align: "left",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: 'Please select an item Seller'
                })
        var lablePage4 =isc.Label.create({
                width: "50%",
                height: "20%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#fcfffa",
                align: "left",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: 'Please select an item Agent Seller'
                })
        var lablePage5 =isc.Label.create({
                width: "100%",
                height: "20%",
                styleName: "helloWorldText",
                padding: 20,
                backgroundColor: "#fcfffa",
                align: "left",
                valign: "center",
                wrap: false,
                showEdges: true,
                showShadow: true,
                icon: "icons/16/world.png",
                contents: 'Please select an item Parameter'
                })
        var lableArticle2 =isc.Label.create({
                width: "100%",
                height: "2%",
                padding: 20,
                align: "left",
                valign: "left",
                wrap: false,
                contents: '<b><font size=2px>ARTICLE 2 -QUANTITY :</font><b>'
                })
        var lable_article2_1 =isc.Label.create({
                wrap: false,
                padding: 5,
                contents: '<b><font size=2px>  OPTION WILL BE CONSIDERED FOR EACH SHIPMENT QUANTITY.</font><b>'
                })
         var lableArticle3 =isc.Label.create({
                width: "100%",
                height: "2%",
                padding: 20,
                align: "left",
                valign: "left",
                wrap: false,
                contents: '<b><font size=2px>ARTICLE 3 -QUANTITY :</font><b>'
                })
        var DynamicForm_ContactHeader = isc.DynamicForm.create({
                 valuesManager:"vm",
          //      isGroup:true,
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
                valuesManager:"vm",
          //      isGroup:true,
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
         //       isGrouped:"true",
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
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                            }
                                lablePage1.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
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
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                            }
                                LablePage2.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
                            }
                            }
                ]
                });
                var DynamicForm_ContactSeller = isc.DynamicForm.create({
                            valuesManager:"vm",
                            width: "100%",
                            height: "100%",
                 //           isGroup:true,
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
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                                if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                            }
                                if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                            }
                                if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                            }
                                if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                            }
                                lablePage3.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
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
                                var address="";
                                var name="";
                                var phone="";
                                var mobile="";
                            if(item.getSelectedRecord().address != undefined){
                                address=item.getSelectedRecord().address;
                            }
                            if(item.getSelectedRecord().nameEN != undefined){
                                name=item.getSelectedRecord().nameEN;
                            }
                            if(item.getSelectedRecord().phone != undefined){
                                phone=item.getSelectedRecord().phone;
                            }
                            if(item.getSelectedRecord().mobile != undefined){
                                mobile=item.getSelectedRecord().mobile;
                            }
                                lablePage4.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
                            }
                            }
                            ]
                            });

                var DynamicForm_ContactParameter = isc.DynamicForm.create({
                            valuesManager:"vm",
                            width: "100%",
                            height: "100%",
                 //           isGroup:true,
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
                            pickListProperties: {showFilterEditor: true},
                            pickListFields: [
                            {name: "paramName", width: "45%", align: "center"},
                            {name: "paramType", width: "45%", align: "center"},
                            {name: "paramValue", width: "10%", align: "center"}
                            ],
                            changed : function (form, item, value) {
                            var paramValue="";
                                if(paramValue !=undefined){paramValue=item.getSelectedRecord().paramValue};
                                lablePage5.setContents(paramValue);
                            }
                            }
                            ]
                            });

                var article2 = isc.DynamicForm.create({
                        valuesManager:"vm",
                        height: "50%",
                        numCols: 14,
                        wrapItemTitles:false,
                        items:[
                            {type: "number",width: "80", name: "number",defaultValue: "",title:"",showTitle:false,
                             changed : function (form, item, value) {
                                article2.setValue("english",numberToEnglish(value))
                            }
                            },
                            {type: "text",styleName:"textToLable",width: "200", name: "english",title:"",showTitle:false,disabled:"true"},
                            {
                                name: "unitId",
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
                                                            function (dsResponse, data) {
                                                                        console.log(data[0],"////////")
                                                                        console.log(dsResponse,",,,,,,,,,,")
                                                                    })} , 1000)
                                       // alert(JSON.stringify(data));
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

var testList  = isc.ListGrid.create({
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
                        ]
                        });

var VLayout_PageOne_Contact = isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    backgroundImage: "backgrounds/leaves.jpg",
                    members: [
                        LablePage,
                        isc.HLayout.create({align: "left",  members:[DynamicForm_ContactHeader]}),
                        isc.HLayout.create({height:"50",align: "left",  members:[lableNameContact]}),
                        isc.HLayout.create({align: "left",  members:[DynamicForm_ContactCustomer]}),
                        isc.HLayout.create({align: "center",members:[lablePage1,LablePage2]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactSeller]}),
                        isc.HLayout.create({align: "center",members:[lablePage3,lablePage4]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactParameter]}),
                        isc.HLayout.create({align: "center",members:[lablePage5]}),
                        isc.HLayout.create({height:"50",align: "center",members:[lableArticle2]}),
                        isc.HLayout.create({align: "left",  members:[article2]}),
                        isc.HLayout.create({align: "left",  members:[article2_1,lable_article2_1]}),
                        isc.HLayout.create({height:"50",align: "left",  members:[lableArticle3]}),
                        isc.HLayout.create({width: "80%",align: "center",  members:[testList]})
                    ]
                    });

//END PAGE ONE
var contactTabs = isc.TabSet.create({
                            width: "100%",
                            height: "97%",
                            tabs: [
                            {title: "page1", canClose: false,
                                pane: VLayout_PageOne_Contact
                            },
                            {title: "page2", canClose: false,
                            pane: isc.Img.create({autoDraw: false, width: 48, height: 48, src: "pieces/48/pawn_yellow.png"})},
                            {title: "page3", canClose: false, ID: "validatedTab",
                            pane: isc.Img.create({autoDraw: false, width: 48, height: 48, src: "pieces/48/pawn_yellow.png"})},
                            {title: "page4", canEditTitle: false,
                            pane: isc.Img.create({autoDraw: false, width: 48, height: 48, src: "pieces/48/pawn_red.png"})}
                            ]
                        });




var IButton_Contact_Save = isc.IButton.create({
                            top: 260,
                            title: "<spring:message code='global.form.save'/>",
                            icon: "pieces/16/save.png",
                            click: function () {
                            alert(JSON.stringify(vm.getValues()));
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


