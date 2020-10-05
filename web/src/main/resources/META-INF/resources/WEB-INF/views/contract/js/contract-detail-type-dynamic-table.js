contractDetailTypeTab.toolStrip.param =  contractDetailTypeTab.listGrid.param
    .gridComponents
    .find(_=>_.className && _.className.toLowerCase() === 'toolStrip'.toLowerCase())

if(!contractDetailTypeTab.toolStrip.param){throw 'یا خدا'}
contractDetailTypeTab.Fields = {
    DynamicTable:[
        {
            name: 'id',
            title:"<spring:message code='global.id'/>",
            hidden:true
        },
        {
            name: 'colNum',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'cdtpId',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'headerType',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'headerValue',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'valueType',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'required',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'regexValidator',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'defaultValue',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'maxRows',
            title:"<spring:message code=''/>",
            hidden:true
        },
        {
            name: 'description',
            title:"<spring:message code=''/>",
            hidden:true
        },
    ]
}
contractDetailTypeTab.toolStrip.param.addMember(
    isc.ToolStripButton.create({

        // icon: "pieces/16/icon_add.png",
        title: "<spring:message code='contract-detail-type.window.dynamic-table.define'/>",
        click: function (){
            contractDetailTypeTab.window.DynamicTable = isc.Window.create({
                title: "<spring:message code='contact.title'/>",
                width: 700,
                height: 580,
                autoSize: true,
                autoCenter: true,
                isModal: true,
                showModalMask: true,
                align: "center",
                autoDraw: true,
                dismissOnEscape: true,
                closeClick: function () {
                    this.Super("closeClick", arguments)
                },
                members:[isc.ListGrid.create({

                    fields:[
                        {name:""}
                    ]
                })]
            })
        }
    }),3
)