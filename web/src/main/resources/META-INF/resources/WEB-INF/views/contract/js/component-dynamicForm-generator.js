var RestDataSource_Material= isc.MyRestDataSource.create({
    fields:
        [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "code", title: "<spring:message code='goods.code'/> "},
            {name: "descEN"},
            {name: "unitId"},
            {name: "unit.nameEN"},
        ],
    fetchDataURL: "${contextPath}/api/material/spec-list"
})

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
var RestDataSource_Contact_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "seller", operator: "equals", value: true}]
};
//*************************************
var dataSourceDetailType = isc.MyRestDataSource.create({
    fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
    },{
        name: "material",
        title: "material"
    }, {
        name: "titleEn",
        title: "titleEn"
    }],
    fetchDataURL: "${contextPath}/api/contract-detail-type/spec-list"
});

isc.defineClass("generatorContractPage", isc.HStack).addProperties({
    autoDraw: false,
    width: "100%",
    height: "100%",
    border: "0px solid blue",
    membersMargin :10,
    // backgroundColor: "#e6e370",
    form: null,
    dynamicFormGenerator: null,
    windowDynamicFormGenerator: null,
    filtersVStack: null,
    layoutSpacerVStack: null,
    formVStack: null,
    formRichTextEditor: null,
    filtersForm: null,
    buttonAllSave:null,
    buttonCreateTemplate:null,
    buttonAllCancel:null,
    sectionStack:null,
    initWidget: function () {
        var fieldsGeneratorDynamicForm=[];
        this.Super("initWidget", arguments);
        let This = this;


        formHTMLFlow = isc.HTMLFlow.create({
            autoDraw:true,
            overflow: "auto",
            padding:5,
            contents:""
            });

        sectionStack = isc.SectionStack.create({
            visibilityMode: "multiple",
            width: "100%",
            height: "100%",
            border:"1px solid blue",
            animateSections: true,
            overflow: "hidden",
            sections: [
                {
                    title: "Contact", expanded: true,items: [

                        isc.headerContractPage.create({
                            disabled: true
                        })

                    ]
                },
                {title: "HTMLFlow", expanded: true, canCollapse: true, items: [ formHTMLFlow ]},
            ]
        });

        filtersVStack = isc.VStack.create({
            backgroundColor: "#d9f7ff",
            padding:"10px",
            autoCenter: true,
            width: "15%",
            members: [],
            border: "1px solid #ECECEB",
            borderRadius: '5px',
            shadowDepth: 2,
            showShadow: true,
        });
        layoutSpacerVStack1 = isc.LayoutSpacer.create({height: "1%"});
        layoutSpacerVStack = isc.LayoutSpacer.create({height: "78%"});
        formVStack = isc.VStack.create({width: "85%",height:"100%",members: []});

        filtersForm = isc.DynamicForm.create({
            numCols: 1,
            width:"25%",
            autoCenter: true,
            titleOrientation:"top",
            wrapItemTitles: false,
            fields: [
                {
                    name: "titleEn",
                    type: 'SelectItem',
                    showTitle: true,
                    title: "Type Article",
                    autoFetchData: false,
                    editorType: "SelectItem",
                    valueField: "id",
                    displayField: "titleEn",
                    pickListWidth: "400",
                    pickListHeight: "300",
                    optionDataSource: dataSourceDetailType,
                    pickListFields: [
                        {
                            name: "titleEn",
                            title: "titleEn"
                        }
                    ],
                    getPickListFilterCriteria: function () {
                        let criterialotTitleEnId = {
                            _constructor: 'AdvancedCriteria',
                            operator: "and",
                            criteria: [{
                                fieldName: "material",
                                operator: "equals",
                                value: dynamicForm_ContactHeader.getValue("material")
                            }]
                        };
                        return criterialotTitleEnId;
                    }
                }
            ]
        });
        buttonCreateTemplate = isc.IButtonSave.create({
                                            title: "create Article",
                                            width:"100",
                                            align: "center",
                                            click: function () {
                                                if(filtersForm.getValue("titleEn")==undefined){
                                                     return isc.warn("please select Type Article");
                                                 }
                                                let typeID = filtersForm.getValue("titleEn");
                                                windowDynamicFormGenerator = isc.Window.create({
                                                    title:(filtersForm.getItem("titleEn").getDisplayValue(filtersForm.getValue("titleEn"))+" From "+filtersForm.getItem("material").getDisplayValue(filtersForm.getValue("material"))).toLocaleUpperCase(),
                                                    width: "50%",
                                                    height: "45%",
                                                    autoCenter: true,
                                                    align: "center",
                                                    autoDraw: true,
                                                    dismissOnEscape: true,
                                                    closeClick: function () {
                                                        this.Super("closeClick", arguments)
                                                    },
                                                    items:
                                                        [
                                                            dynamicFormGenerator = isc.DynamicForm.create({
                                                                    width: "100%",
                                                                    height: "90%",
                                                                    align: "center",
                                                                    overflow:"auto",
                                                                    numCols: 8,
                                                                    canSubmit: true,
                                                                    showErrorText: true,
                                                                    showErrorStyle: true,
                                                                    showInlineErrors: true,
                                                                    errorOrientation: "bottom",
                                                                    border: "1px solid #ECECEB",borderRadius: '5px',
                                                                    shadowDepth: 2,
                                                                    showShadow: true,
                                                                    requiredMessage: '<spring:message code="validator.field.is.required"/>',
                                                                    fields:([]),
                                                                }),
                                                            isc.LayoutSpacer.create({height: "3%"}),
                                                            isc.HLayout.create({
                                                                errorOrientation: "bottom",
                                                                border: "1px solid #ECECEB",borderRadius: '5px',
                                                                align: "center",
                                                                members:
                                                                [
                                                                    isc.IButtonSave.create({
                                                                        title: "Ok",
                                                                        click: function () {
                                                                            dynamicFormGenerator.validate();
                                                                            let detail =[];
                                                                            fieldsGeneratorDynamicForm.forEach(g =>detail.push({"contractDetailId":1,"name":g.title,"key":g.name,"type":g.type,"column":"test","value":g._value}));
                                                                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                                                                actionURL: "${contextPath}/api/contract-detail-value",
                                                                                httpMethod: "POST",
                                                                                data: JSON.stringify(detail),
                                                                                callback: function (RpcResponse_o) {
                                                                                    isc.say("<spring:message code='global.form.request.successful'/>");
                                                                                    windowDynamicFormGenerator.close();
                                                                                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                                                                            actionURL: "${contextPath}/api/contract-detail-type-template/generatorRichTextForm/" + typeID,
                                                                                            httpMethod: "GET",
                                                                                            data: "",
                                                                                            callback: function (RpcResponse_o) {
                                                                                                let keys = [];
                                                                                                let varForReplace=JSON.parse(RpcResponse_o.data)[0].content;
                                                                                                for(let k in dynamicFormGenerator.getValues()) keys.push(k);
                                                                                                let result='';
                                                                                                for(let i=0;i<keys.length;i++){
                                                                                                    result += '$';
                                                                                                    result += '{';
                                                                                                    result += keys[i];
                                                                                                    result += '}';
                                                                                                    varForReplace = varForReplace.replaceAll(result,dynamicFormGenerator.getValue(keys[i]));
                                                                                                    result='';
                                                                                                }
                                                                                                formHTMLFlow.setContents(varForReplace);
                                                                                            }
                                                                                        }));
                                                                                }
                                                                            }));
                                                                    }}),
                                                                    isc.IButtonCancel.create({
                                                                        title: "No",
                                                                        click: function () {
                                                                            windowDynamicFormGenerator.close();
                                                                        }})
                                                                ]
                                                            })

                                                        ]
                                                    });
                                                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                                                actionURL: "${contextPath}/api/contract-detail-type-param/generatorDynamicForm/" + typeID,
                                                                httpMethod: "GET",
                                                                data: "",
                                                                callback: function (RpcResponse_o) {
                                                                    let fields = JSON.parse(RpcResponse_o.data);
                                                                    dynamicFormGenerator.setFields(fields);
                                                                    fields.forEach(g => fieldsGeneratorDynamicForm.push(g));
                                                                }
                                                            }));
                                            }});

        buttonAllSave = isc.IButtonSave.create({
                click: function () {
                }});
        buttonAllCancel = isc.IButtonCancel.create({
                title: "<spring:message code='global.form.save'/>",
                click: function () {
                }});

        filtersVStack.addMember(filtersForm,0);
        filtersVStack.addMember(layoutSpacerVStack1,1);
        filtersVStack.addMember(buttonCreateTemplate,2);
        filtersVStack.addMember(layoutSpacerVStack,3);
        filtersVStack.addMember(isc.HLayout.create({members: [buttonAllSave,buttonAllCancel]}),4);
       // formVStack.addMember(dynamicFormGenerator);
        formVStack.addMember(sectionStack);

        this.addMember(filtersVStack);
        this.addMember(formVStack);
    }
});

isc.generatorContractPage.create({})