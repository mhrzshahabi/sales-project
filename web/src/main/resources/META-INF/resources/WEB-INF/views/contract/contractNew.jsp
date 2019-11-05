<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

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
                Window_Contact.animateShow();
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
                              //  Window_Contact.animateShow();
                            }
                    });

                    var ToolStrip_Actions_Contact = isc.ToolStrip.create({
                        width: "100%",
                        height: "100%",
                        members: [
                             ToolStripButton_Contact_Add
                        ]
                        });
                    var HLayout_Actions_Contact = isc.HLayout.create({
                         width: "100%",
                         members: [
                         ToolStrip_Actions_Contact
                        ]
                    });
            var RestDataSource_Contact = isc.MyRestDataSource.create({
                        fields: [
                        {name: "id", primaryKey: true, canEdit: false, hidden: true},
                        {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                        {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                        {name: "code", title: "<spring:message code='contact.code'/>"}
                        ],
                        fetchDataURL: "${contextPath}/api/contact/spec-list"
                        });

            var ListGrid_Tozin = isc.ListGrid.create({
                        width: "100%",
                        height: "100%",
                        dataSource: RestDataSource_Contact,
                        dataPageSize: 50,
                        autoFetchData: true,
                        fields:
                        [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>", align: "center",canEdit: true}  ,
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>", align: "center"},
                {name: "code", title: "<spring:message code='contact.code'/>", align: "center"}
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

           function saveContact(value){
                // alert(JSON.stringify(value));
                var contactData = Object.assign(value);
                httpMethod = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contact",
                    httpMethod: httpMethod,
                    data: JSON.stringify(contactData),
                    callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                    ListGrid_Contact.invalidateCache();
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    Window_Contact.close();
                    } else
                    isc.say(RpcResponse_o.data);
                    }
                }))
            };