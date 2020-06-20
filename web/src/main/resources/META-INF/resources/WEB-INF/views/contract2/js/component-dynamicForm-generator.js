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
            height:"100%",
            overflow: "auto",
            padding:5,
            contents:""
            });

        sectionStack = isc.SectionStack.create({
            visibilityMode: "multiple",
            width: "100%", height: "100%",
            border:"3px solid blue",
            animateSections: true,
            overflow: "hidden",
            sections: [
                {
                    title: "Contact", expanded: false,items: []
                },
                {title: "HTMLFlow", expanded: true, canCollapse: true, items: [ formHTMLFlow ]},
            ]
        });

        filtersVStack = isc.VStack.create({padding:"10px",autoCenter: true,width: "15%",members: [],border: "1px solid #ECECEB",borderRadius: '5px',
            shadowDepth: 2,
            showShadow: true,});
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
                    name: "material",
                    editorType: "SelectItem",
                    type: 'SelectItem',
                    autoFetchData: false,
                    optionDataSource: isc.MyRestDataSource.create({
                        fields:
                            [
                                {name: "id", title: "id", primaryKey: true, hidden: true},
                                {name: "code", title: "<spring:message code='goods.code'/> "},
                                {name: "descl"},
                                {name: "unitId"},
                                {name: "unit.nameEN"},
                            ],
                        fetchDataURL: "${contextPath}/api/material/spec-list"
                    }),
                    displayField: "descl",
                    valueField: "id",
                    required: true,
                    title: "Material"
                },{
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
                                value: this.form.getValue("material")
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
                                                                    titleAlign: "right",
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
                                                                        icon: "pieces/16/save.png",
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
                                                                        icon: "pieces/16/save.png",
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
                title: "<spring:message code='global.form.save'/>",
                icon: "pieces/16/save.png",
                click: function () {
                }});
        buttonAllCancel = isc.IButtonCancel.create({
                title: "<spring:message code='global.form.save'/>",
                icon: "pieces/16/save.png",
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