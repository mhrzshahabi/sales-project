<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

var RestDataSource_Contact = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contact/spec-list"
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
                })
        var LablePage1 =isc.Label.create({
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
        var LablePage3 =isc.Label.create({
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
        var LablePage4 =isc.Label.create({
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
        var LablePage5 =isc.Label.create({
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
        var LableArticle2 =isc.Label.create({
                width: "100%",
                height: "2%",
                padding: 20,
                align: "left",
                valign: "left",
                wrap: false,
                contents: '<font size=10px><b>ARTICLE-OUANTITY :<b></font>'
                })
        var DynamicForm_ContactHeader = isc.DynamicForm.create({
                isGroup:true,
                wrapItemTitles:false,
                setMethod: 'POST',
                width: "100%",
                height: "100%",
                align: "center",
                canSubmit: true,
                showInlineErrors: true,
                showErrorText: true,
                showErrorStyle: true,
                errorOrientation: "right",
               // isGrouped:"true",
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
                isGroup:true,
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
                isGrouped:"true",
                titleWidth: "80",
                titleAlign: "right",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                fields: [
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
                                LablePage1.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
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
                            width: "100%",
                            height: "100%",
                            isGroup:true,
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
                                LablePage3.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
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
                                LablePage4.setContents("Name: "+name+'<br>'+"Address: "+address+'<br>'+"phone: "+phone+'<br>'+"Mobile: "+mobile);
                            }
                            }
                            ]
                            });

                var DynamicForm_ContactParameter = isc.DynamicForm.create({
                            width: "100%",
                            height: "100%",
                            isGroup:true,
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
                            LablePage5.setContents(paramValue);
                            }
                            }
                            ]
                            });


isc.VLayout.create({
                    ID:"VLayout_DynamicForm_Contact",
                    width: "100%",
                    height: "100%",
                    align: "center",
                    overflow:"scroll",
                    members: [
                        LablePage,
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactHeader]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactCustomer]}),
                        isc.HLayout.create({align: "center",members:[LablePage1,LablePage2]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactSeller]}),
                        isc.HLayout.create({align: "center",members:[LablePage3,LablePage4]}),
                        isc.HLayout.create({align: "center",members:[DynamicForm_ContactParameter]}),
                        isc.HLayout.create({align: "center",members:[LablePage5]}),
                        isc.HLayout.create({align: "center",members:[LableArticle2]})
                    ]
                    });


