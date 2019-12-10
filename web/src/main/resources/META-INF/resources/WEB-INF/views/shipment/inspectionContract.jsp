<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

var main="";
var emailCCByBady="";

    var RestDataSource_PersonByInspectionContract_EmailCC  = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},

            {name: "contactId"},

            {name: "contact.nameFA"},



            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 400
            },
            {name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 400},
            {
                name: "title",
                title: "<spring:message code='person.title'/>",
                type: 'text',
                width: 400,
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 400,regex:"^([a-zA-Z0-9_.\\-+])+@(([a-zA-Z0-9\\-])+\\.)+[a-zA-Z0-9]{2,4}$"},
            {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
            {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400},
        ],

        fetchDataURL: "${contextPath}/api/person/spec-list"
    });


        //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Add by JZ  RestdataSource   */
            var RestDataSource_Shipment__SHIPMENT = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "contactId", type: 'long', hidden: true},
            {name: "contract.contact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: 180
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: 180
            },
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {
                name: "laycan",
                title: "<spring:message code='shipmentContract.laycanStart'/>",
                type: 'integer',
                width: "10%",
                align: "center",
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: 400,
                valueMap: {"b": "bulk", "c": "container"}
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "portByLoadingId", title: "<spring:message code='shipment.loading'/>", type: 'text', width: "10%"},
            {
                name: "portByLoading.port",
                title: "<spring:message code='shipment.loading'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByDischargeId",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                width: "10%"
            },
            {name: "dischargeAddress", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', width: "10%"},
            {name: "switchPort.port", title: "<spring:message code='port.switchPort'/>", type: 'text', width: "50%"},//jz
            {name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', width: "10%"},
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
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {name: "createDate", title: "<spring:message code='shipment.createDate'/>", type: 'text', width: "10%"},
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });
/* End Rest data Source*/

/*List Grid for Shipment bala */
        var ListGrid_Shipment = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
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
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
/*Add By JZ*/
            {
            name: "bookingCat",
            title: "<spring:message code='shipment.bookingCat'/>",
            type: 'text',
            width: "10%",
            showHover: true
            },
/*END By JZ*/
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },

            {
                name: "portByLoading.port",
                title: "<spring:message	code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },

            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "status",
                title: "<spring:message	code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            }
        ],
        recordClick: function(viewer, record, recordNum, field, fieldNum, value, rawValue){
            ListGrid_InspectionContract.fetchData({
            "operator": "and",
            "criteria": [{
            "fieldName":
            "shipmentId",
            "operator": "equals",
            "value": record.id
            }]
            });this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue);},

        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentEmail.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentEmail.setData(data);
            });
            contractId = record.contractId;
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: false
    });

    var HLayout_Grid_ShipmentByInspectionContract = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment
        ]
    });

    var VLayout_Body_ShipmentByInspectionContract = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByInspectionContract
        ]
    });
 /*End List Grid */
//-------------------------------------------Email----------------------------------------------------------------------

var RestDataSource_InspectionContract = isc.MyRestDataSource.create({
    fields:
    [
        {name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},

        {name:"shipment.id", title:"<spring:message code='contact.name'/>",align:"center",hidden: true},
        {name: "contactId", type: 'long', hidden: true},
        {name:"shipment.contact.nameEN", title:"<spring:message code='contact.name'/>",align:"center" , width :"10%"},
        {name:"emailType",title:"<spring:message code='shipment.emailType'/>",align:"center" , width :"10%"},
        {name:"emailSubject",title:"<spring:message code='global.emailSubject'/>",align:"center" , width :"10%"},
        {name:"emailTo",title:"<spring:message code='global.emailTo'/>",align:"center" , width :"10%"},
        {name:"emailCC",title:"<spring:message code='global.emailCC'/>",align:"center" , width :"10%"},
        {name:"emailBody",title:"<spring:message code='global.emailBody'/>",align:"center" , width :"10%"},
        {name:"emailRespond",title:"<spring:message code='global.emailRespond'/>",align:"center" , width :"10%"},
        {name:"createUser" ,title:"<spring:message code='global.createUser'/>",align:"center" , width :"10%"},
        {name:"createDate",title:"<spring:message code='global.createDate'/>",align:"center" , width :"10%"},
    ],
    fetchDataURL: "${contextPath}/api/inspectionContract/spec-list"
});

var IButton_InspectionContract_Save = isc.IButton.create({
    top: 260,
    title:"<spring:message code='global.form.save'/>",
    icon: "pieces/16/save.png",

    click : function () {
        DynamicForm_InspectionContract.validate();
        if (DynamicForm_InspectionContract.hasErrors())
            return;
        var date = DynamicForm_InspectionContract.getValues("createDate");


        var data = DynamicForm_InspectionContract.getValues();
        console.log(data);
        var method = "PUT";
        if(data.id == null)
            method="POST";
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
            actionURL: "${contextPath}/api/inspectionContract/",
            httpMethod: method,
            data: JSON.stringify(data),
            callback: function (resp)   {
                if(resp.httpResponseCode == 200 || resp.httpResponseCode == 201 ) {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                    Window_InspectionContract.hide();
                    ListGrid_InspectionContract_refresh();
                    }
                else
                    isc.say(RpcResponse_o.data);
            }
        })
        );
    }
});


    var IButton_InspectionContract_Cancel = isc.IButton.create({
        top: 300,
        title:"<spring:message code='global.cancel'/>",
    layoutMargin: 5,
    membersMargin: 5,
        icon :"pieces/16/icon_delete.png",
        click : function ()
        {
            Window_InspectionContract.close();
        }
    });

    /*JZ*/
    var hLayout_saveButton = isc.HLayout.create({
    width: "100%",
    height: "100%",
    layoutMargin: 30,
    membersMargin: 5,
    textAlign: "center",
    align:"center",
    members: [
    IButton_InspectionContract_Save,
    IButton_InspectionContract_Cancel
    ]
    });
    /*JZ*/


    var VLayout_saveButton = isc.VLayout.create({
    width: "100%",
    height: "100%",
    textAlign: "center",
    align:"center",
    members: [
    hLayout_saveButton

    ]
    });

    function ListGrid_InspectionContract_refresh() {
        ListGrid_InspectionContract.invalidateCache();
        var record = ListGrid_ShipmentByInspectionContract.getSelectedRecord();
        if (record==null || record.id==null)
             return;
        ListGrid_InspectionContract.fetchData({"shipment.id":record.id},function (dsResponse, data, dsRequest) {
             ListGrid_InspectionContract.setData(data);
        },{operationId:"00"});
    }

    function ListGrid_InspectionContract_edit() {
        var record = ListGrid_InspectionContract.getSelectedRecord();
        if(record == null || record.id == null)
        {
                isc.Dialog.create({
                    message : "<spring:message code='global.grid.record.not.selected'/>",
                    icon:"[SKIN]ask.png",
                    title : "<spring:message code='global.message'/>",
                    buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
                    buttonClick : function (){
                        this.hide();
                    }
                });
        } else
        {
            DynamicForm_InspectionContract.editRecord(record);
            Window_InspectionContract.show();
        }
    }
    /*Remove*/
    function ListGrid_InspectionContract_remove() {

        var record = ListGrid_InspectionContract.getSelectedRecord();
        if(record == null || record.id == null){
            isc.Dialog.create({
                message : "<spring:message code='global.grid.record.not.selected'/> !",
                icon:"[SKIN]ask.png",
                title : "<spring:message code='global.message'/>",
                buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
                buttonClick : function () {
                    this.hide();
                }
            });

        } else {
            isc.Dialog.create({
            message : "<spring:message code='global.grid.record.remove.ask'/>",
            icon:"[SKIN]ask.png",
            title : "<spring:message code='global.grid.record.remove.ask.title'/>",
            buttons : [ isc.Button.create({ title:"<spring:message code='global.yes'/>" }), isc.Button.create({ title:"<spring:message code='global.no'/>" })],
            buttonClick : function (button, index) {
                this.hide();

                     if (index == 0) {
                            var inspectionContractId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                    actionURL: "${contextPath}/api/inspectionContract/" + inspectionContractId,
                                    httpMethod: "DELETE",
                                    serverOutputAsString: false,
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_InspectionContract.invalidateCache();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>.");
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
    };

/*End Remove */
var Menu_ListGrid_InspectionContract = isc.Menu.create({
    width:150,
    data:
    [
        {title:"<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
            click: function()
            {
                DynamicForm_InspectionContract.clearValues();
                Window_InspectionContract.show();
            }
        },
        {title:"<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
            click: function() {
            }
        },
        {title:"<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
            click: function(){
                ListGrid_InspectionContract_edit();
            }
        },
        {title:"<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
            click: function() {
                ListGrid_InspectionContract_remove();
            }
        },
            {
                /*Add JZ*/
                /*Change logo */
                title: "<spring:message code='global.form.print.word'/>", icon: "icon/word.png", click: function () {
                    var record = ListGrid_InspectionContract.getSelectedRecord(); //TODO Change ListGrid Set Email OK 200
                    "<spring:url value="/inspectionContract/print/" var="printUrl"/>";
                    window.open('${printUrl}'+record.id);
                }
            }
    ]
});

/*List Grid Bottom*/
    var ListGrid_PersonByInspectionContract_EmailCC = isc.ListGrid.create({
               width: "800",
               height: "400",
              dataSource: RestDataSource_PersonByInspectionContract_EmailCC,
               fields:[
                {
                    name: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "title",
                    title: "<spring:message code='person.title'/>",
                    type: 'text',
                    width: 400,
                    valueMap: {
                        "MR": "<spring:message code='global.MR'/>",
                        "MIS": "<spring:message code='global.MIS'/>",
                        "MS": "<spring:message code='global.MRS'/>",
                    }
                },
                {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 400,regex:"^([a-zA-Z0-9_.\\-+])+@(([a-zA-Z0-9\\-])+\\.)+[a-zA-Z0-9]{2,4}$"},
                {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
                {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400}
               ],
               sortField: 0,
               dataPageSize: 50,
               autoFetchData: true,
               showFilterEditor: true,
               filterOnKeypress: true,
               sortFieldAscendingText: "مرتب سازی صعودی",
               sortFieldDescendingText: "مرتب سازی نزولی",
               configureSortText: "تنظیم مرتب سازی",
               autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
               autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
               filterUsingText: "فیلتر کردن",
               groupByText: "گروه بندی",
               freezeFieldText: "ثابت نگه داشتن",
               startsWithTitle: "tt",
               selectionAppearance : "checkbox"
           });

    /*Person*/
    var Window_InspectionContractEmailCC = isc.Window.create({
                            title: "<spring:message code='person.title'/> ",
                            textAlign:"center",
                            width: "800",
                            height: "100",
                            autoSize:true,
                            autoCenter: true,
                            isModal: true,
                            showModalMask: true,
                            align: "center",
                            autoDraw: false,
                            closeClick : function () { this.Super("closeClick", arguments)},
                            items:
                            [
                                isc.VLayout.create({
                                width: "800",
                                height: "100",
                                members:
                                [
                                  ListGrid_PersonByInspectionContract_EmailCC
                                    ,

                                     hLayout_saveButton = isc.HLayout.create({
                                width: "800",
                                height: "100",
                                layoutMargin: 30,
                                membersMargin: 5,
                                textAlign: "center",
                                align:"center",
                                members: [

                                         isc.Button.create({
                                         title:"<spring:message code='global.ok'/>",
                                        click: function()
                                        {
                                            var selectedPerson = ListGrid_PersonByInspectionContract_EmailCC.getSelection();
                                            if (selectedPerson.length==0){
                                                Window_InspectionContractEmailCC.close();
                                                return;
                                                }
                                            var persons="" ;
                                            var oldPersons;
                                            var check=false;
                                            if(typeof(DynamicForm_InspectionContract.getValue("emailCC"))!='undefined' &&  DynamicForm_InspectionContract.getValue("emailCC")!=null) {
                                                persons = DynamicForm_InspectionContract.getValue("emailCC");
                                                oldPersons=persons.split(",");
                                                check=true;
                                            }
                                            for( i = 0; i < selectedPerson.length; i++)
                                            {
                                                notIn=true;
    <%--                                            if (check)--%>
    <%--                                                for (j=0;j<oldPersons.size();j++)--%>
    <%--                                                    if (oldPersons[j]==selectedPerson[i].email)--%>
    <%--                                                        notIn=false;--%>
                                                if (notIn)
                                                        persons = (persons==""? persons : persons+",")+selectedPerson[i].email ;
                                            }
                                            DynamicForm_InspectionContract.setValue("emailCC",persons);
                                            Window_InspectionContractEmailCC.close();
                                        }
                                      })


                                ]
                                }),



                                ]
                                })

                            ]
                        });

/*Start Email*/
/*Data source Shipment.Contract*/

    var DynamicForm_InspectionContract = isc.DynamicForm.create({
        styleName:"jalal",
        width: 700,
        height: 300,
        setMethod: 'POST',
        align: "left",
        textAlign:"left",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle:true,
        errorOrientation: "left",
        titleWidth: "100",
        titleAlign:"center",
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols:1,
            // showEdges:true,
        fields:
        [
    /*Comment By JZ*/
    <%--{name:"vesselName"                  , title:"<spring:message code='shipmentContract.vesselName'/>" },--%>
    <%--//{name:"tblPortByLoadPort.id"        , title:"<spring:message code='shipmentContract.loadPort'/>"  , hidden: true},--%>
    <%--//{name:"tblPortByLoadPort.port"      , title:"<spring:message code='shipmentContract.loadPort'/>"  ,canEdit:false},--%>
    <%--&lt;%&ndash;{name:"dischargePort"               , title:"<spring:message code='shipmentContract.dischargePort'/>"   },&ndash;%&gt;--%>
    <%--//{name:"tblPortByDischargePort.id"   , title:"<spring:message code='shipmentContract.loadPort'/>"  , hidden: true},--%>
    <%--//{name:"tblPortByDischargePort.port"      , title:"<spring:message code='shipmentContract.dischargePort'/>"  ,canEdit:false, wrapTitle: false},--%>


            {name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},
            {name:"shipment.id", title:"<spring:message code='contact.name'/>",align:"left",hidden: true , textAlign:"left"},
            {name: "superviseWeighing",title: "<spring:message code='inspectionContract.superviseWeighing'/>",type: 'checkbox',width: "20%" , textAlign:"left" , styleName: "customCheckboxTitle",
    },
            {name: "sampling",title: "<spring:message code='inspectionContract.sampling'/>",type: 'checkbox',width:"20%" , textAlign:"left"},
            {name: "moistureDetermination",title: "<spring:message code='inspectionContract.moistureDetermination'/>",type: 'checkbox',width:"20%" , textAlign:"left"},
            {name:"emailType",title:"<spring:message code='shipment.emailType'/>",align:"left" ,  width :"700" , textAlign:"left" , required:true},
            {name:"emailSubject",title:"<spring:message code='global.emailSubject'/>",align:"left" ,  width :"700" , textAlign:"left" , required:true},

            {name: "emailTo", title:"<spring:message code='global.emailTo'/>", type:'text' , width:"700",type:"text" , align:"left" , textAlign:"left" , required:true,
                /*Fix bug For Regex email */
                validators:[
                {
                type:"regexp",
                expression:".+\\@.+\\..+",
                }
                ],
                /*End Fix bug For Regex email */
                },



            {name: "emailCC", title:"<spring:message code='global.emailCC'/>" , width:"700",type: "text" , align:"left" , textAlign:"left" , required:true
                     ,icons: [{
                        src: "icon/loupe.png",
                        click: function(form, item)
                        {
                             Window_InspectionContractEmailCC.show();
                        }
                     }]
            },

            {name:"emailBody",title:"<spring:message code='global.emailBody'/>",align:"left" ,  width :"800",type:"textArea",height:200},

            {name:"emailRespond",title:"<spring:message code='global.emailRespond'/>", align:"left" ,  width :"700" },


                /*Create Date */

                {
                name: "createDate",
                title: "<spring:message code='currencyRate.curDate'/>",
                type: "date",
                format: 'DD-MM-YYYY',
                width: "400"
                },


/*
*
*
*      var d = DynamicForm_ShipmentHeader.getValue("shipmentHeaderDateDummy");
var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
DynamicForm_ShipmentHeader.setValue("shipmentHeaderDate", datestring)
*
* */


<%--{--%>
            <%--    styleName:"fixcalender",--%>
            <%--    name:"createDate",--%>
            <%--    ID:"createDate",--%>
            <%--    title:"<spring:message code='global.createDate'/>",--%>
            <%--    align:"left" ,--%>
            <%--    width :"400", //Fix Width From Right--%>
            <%--    icons: [--%>
            <%--        {src: "pieces/calendar.png" ,--%>
            <%--            click: function ()--%>
            <%--            { displayDatePicker('createDate', this ,'ymd', '/');}--%>
            <%--                        }]  ,--%>
            <%--          blur : function()--%>
            <%--            {--%>
            <%--                // var value = DynamicForm_InspectionContract.getItem('createDate').getValue();--%>
            <%--                // if(value != null && value.length != 10 && value != "")--%>
            <%--                // {--%>
            <%--                //     DynamicForm_InspectionContract.setValue('createDate',CorrectDate(value))--%>
            <%--                // }--%>
            <%--            }--%>
            <%--        },--%>
                ]
            });
    /*End Email */



    var ToolStripButton_InspectionContract_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function()
        {
            ListGrid_InspectionContract_refresh();
        }
    });


    var ToolStripButton_InspectionContract_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click:function()
        {
            var record = ListGrid_Shipment.getSelectedRecord();
            if(record == null || record.id == null){
                isc.Dialog.create({
                    message : "<spring:message code='global.grid.record.not.selected'/>",
                    icon:"[SKIN]ask.png",
                    title : "<spring:message code='global.message'/>",
                    buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],
                    buttonClick : function (){
                        this.hide();
                    }
                });
            } else	{
                DynamicForm_InspectionContract.clearValues();
                // DynamicForm_Instruction.setValue("disableDateDummy", new Date(record.disableDate)); //TODO
                DynamicForm_InspectionContract.setValue("shipmentId",record.id);
                DynamicForm_InspectionContract.setValue("emailType","Inspection Contract");
                DynamicForm_InspectionContract.setValue("emailSubject","ORDER FOR REPRESENTATION ");

                Window_InspectionContract.show();
            }
        }
    });



    var ToolStripButton_InspectionContract_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function()
        {
            ListGrid_InspectionContract_edit();
        }
    });


    var ToolStripButton_InspectionContract_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click:function()
        {
            ListGrid_InspectionContract_remove();
        }
    });


    <%--var ToolStripButton_InspectionContract_Print = isc.ToolStripButton.create({--%>
    <%--     icon: "[SKIN]/actions/print.png",--%>
    <%--     title: "<spring:message code='print'/>",--%>
    <%--    click:function()--%>
    <%--    {--%>
    <%--        var record = ListGrid_InspectionContract.getSelectedRecord();--%>
    <%--        if(record == null || record.id == null){--%>
    <%--        isc.Dialog.create({--%>
    <%--            message : "<spring:message code='global.grid.record.not.selected'/>",--%>
    <%--            icon:"[SKIN]ask.png",--%>
    <%--            title : "<spring:message code='global.message'/>",--%>
    <%--            buttons : [isc.Button.create({ title:"<spring:message code='global.ok'/>" })],--%>
    <%--            buttonClick : function (){--%>
    <%--                this.hide();--%>
    <%--            }--%>
    <%--        });--%>
    <%--        } else{--%>
    <%--            window.open("inspectionContract/printDocx?data="+record.id);--%>
    <%--        }--%>
    <%--    }--%>
    <%--});--%>


    var ToolStrip_Actions_InspectionContract = isc.ToolStrip.create({
        width: "100%",
        members:
        [
            ToolStripButton_InspectionContract_Refresh,
            ToolStripButton_InspectionContract_Add,
            ToolStripButton_InspectionContract_Edit,
            ToolStripButton_InspectionContract_Remove,
        ]
    });

    var HLayout_InspectionContract_Actions = isc.HLayout.create({
        width: "100%",
        members:
        [
            ToolStrip_Actions_InspectionContract
        ]
    });



//Email Window
    var Window_InspectionContract = isc.Window.create({

        title: "<spring:message code='inspectionContract.title'/> ",
        width: 810,
        height: 400,
        autoSize:true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,

        closeClick : function () { this.Super("closeClick", arguments)},
        items:
        [

         isc.VStack.create({
                width:"100%",
                autoCenter: true,
                members:
                [
            DynamicForm_InspectionContract,

            isc.HStack.create({
                styleName:"testjalal",
                backgroundColor: "#fefffd",
                width:"855",
                members:
                [
                 VLayout_saveButton
                ]
            }),]})
        ]
    });

/*grid Bottom*/
    var ListGrid_InspectionContract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_InspectionContract,
        contextMenu: Menu_ListGrid_InspectionContract,
        autoFetchData:false,
        fields:
        [
            {name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},
            {name:"shipment.id", title:"<spring:message code='contact.name'/>",align:"center",hidden: true},
            {name:"shipment.contact.nameEN", title:"<spring:message code='contact.name'/>",align:"center" , width :"10%"},
            {name:"emailType",title:"<spring:message code='shipment.emailType'/>",align:"center" , width :"10%"},
            {name:"emailSubject",title:"<spring:message code='global.emailSubject'/>",align:"center" , width :"10%"},
            {name:"emailTo",title:"<spring:message code='global.emailTo'/>",align:"center" , width :"10%"},
            {name:"emailCC",title:"<spring:message code='global.emailCC'/>",align:"center" , width :"10%"},

        ],
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        // startsWithTitle: "tt",
        recordClick 			:	"this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails 			: function (viewer, record1, recordNum, field, fieldNum, value, rawValue)
        {
            var record = this.getSelectedRecord();
        },
        dataArrived : 	function (startRow, endRow) {
        }

    });

    var HLayout_InspectionContract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_InspectionContract
        ]
    });

    var VLayout_InspectionContract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
        [
            HLayout_InspectionContract_Actions, HLayout_InspectionContract_Grid
        ]
    });

    isc.SectionStack.create({
        ID:"Shipment_Section_Stack",
        sections:
        [
             {title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentByInspectionContract  , expanded:true}
            ,{title:"<spring:message code='inspectionContract.title'/>", items:VLayout_InspectionContract_Body , expanded:true}
        ],
        visibilityMode:"multiple",
        animateSections:true,
        height:"100%",
        width:"100%",
        overflow:"hidden"
    });




















<%--var RestDataSource_ShipmentByInspectionContract = isc.MyRestDataSource.create({--%>
<%--fields: [--%>
<%--    {name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},--%>
<%--    {name: "tblContractItemShipment.id", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },--%>
<%--    {name: "tblContact.id",  type:'long', hidden: true },--%>
<%--    {name: "tblContact.nameFA", title:"<spring:message code='contact.name'/>", type:'text' },--%>
<%--    {name: "tblContract.id",  type:'long', hidden: true },--%>
<%--    {name: "tblContract.contractNo", title:"<spring:message code='contract.contractNo'/>", type:'text' , width: 180},--%>
<%--    {name: "tblContract.contractDate", title:"<spring:message code='contract.contractDate'/>", type:'text' , width: 180},--%>
<%--    {name: "tblMaterial.id", title:"<spring:message code='contact.name'/>", type:'long', hidden: true },--%>
<%--    {name: "tblMaterial.descl", title:"<spring:message code='material.descl'/>", type:'text' },--%>
<%--    {name: "tblMaterial.tblUnit.nameEN", title:"<spring:message code='unit.nameEN'/>", type:'text' },--%>
<%--    {name: "amount", title:"<spring:message code='global.amount'/>", type:'float'},--%>
<%--    {name: "noContainer", title:"<spring:message code='shipment.noContainer'/>", type:'integer'},--%>
<%--    {name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",},--%>
<%--    {name: "shipmentType", title:"<spring:message code='shipment.shipmentType'/>", type:'text', width: 400  ,valueMap:{"b":"bulk", "c":"container"}},--%>
<%--    {name: "loading", title:"<spring:message code='global.address'/>", type:'text', width: "10%" },--%>
<%--    {name: "tblPortByLoading.id", title:"<spring:message code='shipment.loading'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "tblPortByLoading.port", title:"<spring:message code='shipment.loading'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "tblPortByDischarge.id", title:"<spring:message code='shipment.discharge'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "tblPortByDischarge.port", title:"<spring:message code='shipment.discharge'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "description", title:"<spring:message code='shipment.description'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "SWB", title:"<spring:message code='shipment.SWB'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "tblSwitchPort.port", title:"<spring:message code='port.switchPort'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "month", title:"<spring:message code='shipment.month'/>", type:'text', required: true, width: "10%" },--%>
<%--    {name: "status", title:"<spring:message code='shipment.staus'/>", type:'text', width: "10%" ,valueMap:{"Load Ready":"<spring:message code='shipment.loadReady'/>","Resource":"<spring:message code='shipment.resource'/>"}},--%>
<%--    {name: "createDate", title:"<spring:message code='shipment.createDate'/>", type:'text', required: true, width: "10%" },--%>
<%--    ],--%>
<%--dataFormat: "json",--%>
<%--jsonPrefix: "",--%>
<%--jsonSuffix: "",--%>
<%--&lt;%&ndash;fetchDataURL: "${contextPath}/api/contact/spec-list"&ndash;%&gt;--%>
<%--});--%>



<%--     var RestDataSource_ContactByInspection = isc.MyRestDataSource.create({--%>
<%--        fields: [--%>
<%--            {name: "id", primaryKey: true, canEdit: false, hidden: true},--%>
<%--            {name: "code", title: "<spring:message code='contact.code'/>"},--%>
<%--            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},--%>
<%--            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},--%>
<%--            {name: "ceoPassportNo" },--%>
<%--            {name: "ceo" },--%>
<%--            {name: "commercialRegistration" },--%>
<%--            {name: "branchName" },--%>
<%--            {name: "commertialRole" },--%>
<%--            {name: "phone", title: "<spring:message code='contact.phone'/>"},--%>
<%--            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},--%>
<%--            {name: "fax", title: "<spring:message code='contact.fax'/>"},--%>
<%--            {name: "address", title: "<spring:message code='contact.address'/>"},--%>
<%--            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},--%>
<%--            {name: "email", title: "<spring:message code='contact.email'/>"},--%>
<%--            {--%>
<%--                name: "type",--%>
<%--                title: "<spring:message code='contact.type'/>",--%>
<%--                valueMap: {"true": "<spring:message code='contact.type.real'/>", "false": "<spring:message code='contact.type.legal'/>"}--%>
<%--            },--%>
<%--&lt;%&ndash;            {name: "nationalcode", title: "<spring:message code='contact.nationalcode'/>"},&ndash;%&gt;--%>
<%--            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},--%>
<%--            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},--%>
<%--            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},--%>
<%--            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},--%>
<%--            {name: "bankName", title: "<spring:message code='contact.bankName'/>"},--%>
<%--            {name: "contactAccounts"}--%>
<%--        ],--%>
<%--      --%>
<%--        // fetchDataURL: "rest/contact/list"--%>
<%--    });--%>


<%--var RestDataSource_ShipmentContractByInsContract = isc.MyRestDataSource.create({--%>
<%--    fields:--%>
<%--    [--%>
<%--        {name:"id", title:"id", primaryKey:true, canEdit:false, hidden: true},--%>

<%--        {name:"shipmentContractDate"        , title:"<spring:message code='shipmentContract.shipmentContractDate'/>",align:"center",hidden: true},--%>
<%--        {name:"tblContactByOwners.id"       , title:"<spring:message code='shipmentContract.owners'/>",align:"center" , width :"10%"},--%>
<%--        {name:"tblContactByCharterer.id"    , title:"<spring:message code='shipmentContract.charterer'/>",align:"center" , width :"10%"},--%>
<%--        {name:"tblContactByChainOfOwners.id", title:"<spring:message code='shipmentContract.chainOfOwners'/>",align:"center" , width :"10%"},--%>
<%--        {name:"tblCountryFlag.id"           , title:"<spring:message code='shipmentContract.countryFlag'/>",align:"center" , width :"10%"},--%>
<%--        {name:"no"                          , title:"<spring:message code='shipmentContract.no'/>",align:"center" , width :"10%"},--%>
<%--        {name:"capacity"                    , title:"<spring:message code='shipmentContract.capacity'/>",align:"center" , width :"10%"},--%>
<%--        {name:"laycanStart"                 , title:"<spring:message code='shipmentContract.laycanStart'/>",align:"center" , width :"10%"},--%>
<%--        {name:"laycanEnd"                   , title:"<spring:message code='shipmentContract.laycanEnd'/>",align:"center" , width :"10%"},--%>
<%--        {name:"loadingRate"                 , title:"<spring:message code='shipmentContract.loadingRate'/>",align:"center" , width :"10%"},--%>
<%--        {name:"dischargeRate"               , title:"<spring:message code='shipmentContract.dischargeRate'/>",align:"center" , width :"10%"},--%>
<%--        {name:"demurrage"                   , title:"<spring:message code='shipmentContract.demurrage'/>",align:"center" , width :"10%"},--%>
<%--        {name:"dispatch"                    , title:"<spring:message code='shipmentContract.dispatch'/>",align:"center" , width :"10%"},--%>
<%--        {name:"freight"                     , title:"<spring:message code='shipmentContract.freight'/>",align:"center" , width :"10%"},--%>
<%--        {name:"bale"                        , title:"<spring:message code='shipmentContract.bale'/>",align:"center" , width :"10%"},--%>
<%--        {name:"grain"                       , title:"<spring:message code='shipmentContract.grain'/>",align:"center" , width :"10%"},--%>
<%--        {name:"grossWeight"                 , title:"<spring:message code='shipmentContract.grossWeight'/>",align:"center" , width :"10%"},--%>
<%--        {name:"vesselName"                  , title:"<spring:message code='shipmentContract.vesselName'/>",align:"center" , width :"10%"},--%>
<%--        {name:"yearOfBuilt"                 , title:"<spring:message code='shipmentContract.yearOfBuilt'/>",align:"center" , width :"10%"},--%>
<%--        {name:"imoNo"                       , title:"<spring:message code='shipmentContract.imoNo'/>",align:"center" , width :"10%"},--%>
<%--        {name:"officialNo"                  , title:"<spring:message code='shipmentContract.officialNo'/>",align:"center" , width :"10%"},--%>
<%--        {name:"loa"                         , title:"<spring:message code='shipmentContract.loa'/>",align:"center" , width :"10%"},--%>
<%--        {name:"beam"                        , title:"<spring:message code='shipmentContract.beam'/>",align:"center" , width :"10%"},--%>
<%--        {name:"cranes"                      , title:"<spring:message code='shipmentContract.cranes'/>",align:"center" , width :"10%"},--%>
<%--        {name:"holds"                       , title:"<spring:message code='shipmentContract.holds'/>",align:"center" , width :"10%"},--%>
<%--        {name:"hatch"                       , title:"<spring:message code='shipmentContract.hatch'/>",align:"center" , width :"10%"},--%>
<%--        {name:"classType"                   , title:"<spring:message code='shipmentContract.classType'/>",align:"center" , width :"10%"},--%>
<%--        {name:"createUser"                  , title:"<spring:message code='global.createUser'/>",align:"center" , width :"10%"},--%>
<%--        {name:"createDate"                  , title:"<spring:message code='global.createDate'/>",align:"center" , width :"10%"},--%>
<%--    ],--%>
<%--    dataFormat: "json",--%>
<%--    jsonPrefix: "",--%>
<%--    jsonSuffix: "",--%>
<%--        &lt;%&ndash;fetchDataURL: "${contextPath}/api/shipment/spec-list"&ndash;%&gt;--%>
<%--});--%>

/*JZ*/
<%--var RestDataSource_PersonByInspectionContract_EmailCC = isc.MyRestDataSource.create({--%>
<%--        fields: [--%>
<%--        {name: "id", title: "id", primaryKey:true, canEdit:false, hidden: true},--%>
<%--        {name: "tblContact.id"},--%>
<%--        {name: "tblContact.nameFA"},--%>
<%--        {name: "fullName", title:"<spring:message code='person.fullName'/>", type:'text', required: true, width: 400 },--%>
<%--        {name: "jobTitle", title:"<spring:message code='person.jobTitle'/>", type:'text', width: 400 },--%>
<%--        {name: "title", title:"<spring:message code='person.title'/>", type:'text', width: 400,valueMap:{"MR":"<spring:message code='global.MR'/>","MIS":"<spring:message code='global.MIS'/>","MRS":"<spring:message code='global.MRS'/>",} },--%>
<%--        {name: "email", title:"<spring:message code='person.email'/>", type:'text', required: true, width: 400 },--%>
<%--        {name: "email1", title:"<spring:message code='person.email1'/>", type:'text', width: 400 },--%>
<%--        {name: "email2", title:"<spring:message code='person.email2'/>", type:'text', width: 400 }--%>
<%--        ],--%>
<%--        fetchDataURL: "${contextPath}/api/person/spec-list"--%>
<%--});--%>
