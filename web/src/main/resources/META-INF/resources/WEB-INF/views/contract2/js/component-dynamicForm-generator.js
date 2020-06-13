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
    filtersVStack: null,
    layoutSpacerVStack: null,
    formVStack: null,
    formRichTextEditor: null,
    filtersForm: null,
    initWidget: function () {
        this.Super("initWidget", arguments);
        let This = this;
        dynamicFormGenerator = isc.DynamicForm.create({
            width: "100%",
            height: "30%",
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
            fields: BaseFormItems.concat([])
        });
        filtersVStack = isc.VStack.create({ width: "15%",members: [],border: "1px solid #ECECEB",borderRadius: '5px',
            shadowDepth: 2,
            showShadow: true,});
        layoutSpacerVStack = isc.LayoutSpacer.create({height: "70%"});
        formVStack = isc.VStack.create({width: "83%",height:"100%",members: []});

        filtersForm = isc.DynamicForm.create({
            numCols: 1,
            height: "30%",
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
                    title: "material"
                },{
                    name: "titleEn",
                    type: 'SelectItem',
                    showTitle: true,
                    title: "<spring:message code='unit.title'/>",
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
                    },changed:function (form,item,value) {
                        let typeID = value;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contract-detail-type-param/generatorDynamicForm/" + typeID,
                                httpMethod: "GET",
                                data: "",
                                callback: function (RpcResponse_o) {
                                    let fields = JSON.parse(RpcResponse_o.data);
                                    console.log(fields);
                                    dynamicFormGenerator.setFields(fields);
                                }
                            })
                        );
                    }
                },{
                    name: "contractNumber",
                    type: 'text',
                    title: "contractNumber"
                }
            ]
        })
        formRichTextEditor = isc.RichTextEditor.create({
            autoDraw:true,
            height:"70%",
            overflow:"scroll",
            canDragResize:true,
            canEdit:"false",
            errorOrientation: "bottom",
            border: "1px solid #ECECEB",borderRadius: '5px',
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
            })
        filtersVStack.addMember(filtersForm,0);
        filtersVStack.addMember(layoutSpacerVStack,1);
        formVStack.addMember(dynamicFormGenerator);
        formVStack.addMember(formRichTextEditor);
        this.addMember(filtersVStack);
        this.addMember(formVStack);
    }
});

isc.generatorContractPage.create({})