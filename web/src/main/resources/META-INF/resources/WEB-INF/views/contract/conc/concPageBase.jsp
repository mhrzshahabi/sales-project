<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>


function factoryLableHedear(id, contents, width, height, padding) {
        isc.Label.create({
            ID: id,
            width: width,
            height: height,
            styleName: "helloWorldText",
            padding: padding,
            backgroundColor: "#84c1ed",
            align: "center",
            valign: "center",
            wrap: false,
            showEdges: true,
            showShadow: true,
            contents: contents
        });
    }

    function factoryLable(id, contents, width, height, padding) {
        isc.Label.create({
            ID: id,
            width: width,
            height: height,
            padding: padding,
            align: "left",
            valign: "left",
            wrap: false,
            contents: contents
        })
    }

    function factoryLableArticle(id, contents, height, padding) {
        isc.Label.create({
            ID: id,
            height: height,
            padding: padding,
            align: "left",
            valign: "left",
            wrap: false,
            contents: contents
        })
    }

var contactConcTabs = isc.TabSet.create({
        width: "100%",
        height: "97%",
        tabs: [
            {
                title: "page1", canClose: false,
                pane: isc.ViewLoader.create({
                                    ID: "ViewLoaderpage1",
                                    autoDraw:false,
                                    viewURL:"<spring:url value="/contact/concPage1" />",
                                    loadingMessage:"Loading Page.."
                                    })
            },
            {
                title: "page2", canClose: false,
                pane: isc.ViewLoader.create({
                                    ID: "ViewLoaderpage2",
                                    autoDraw:false,
                                    viewURL:"<spring:url value="/contact/concPage2" />",
                                    loadingMessage:"Loading Page.."
                                    })
            }
        ]
    });
isc.IButton.create({
    ID:"IButton_ContactConc_Save",
    title: "save",
    icon: "pieces/16/save.png",
    iconOrientation: "right",
    click: function(){
         var dataSaveAndUpdateContractConc={};
                    dataSaveAndUpdateContractConc.contractDate= contactHeaderConc.getValue("createDateDumy");
                    dataSaveAndUpdateContractConc.contractNo=contactHeaderConc.getValue("contractNo");
                    dataSaveAndUpdateContractConc.contactId=contactHeaderConc.getValue("contactId");
                    dataSaveAndUpdateContractConc.contactByBuyerAgentId=contactHeaderConc.getValue("contactByBuyerAgentId");
                    dataSaveAndUpdateContractConc.contactBySellerId=contactHeaderConc.getValue("contactBySellerId");
                    dataSaveAndUpdateContractConc.contactBySellerAgentId=contactHeaderConc.getValue("contactBySellerAgentId");
                    dataSaveAndUpdateContractConc.amount=valuesManagerArticle2.getValue("amount");
                    dataSaveAndUpdateContractConc.amount_en=valuesManagerArticle2.getValue("amount_en");
                    dataSaveAndUpdateContractConc.unitId=valuesManagerArticle2.getValue("unitId");
                    dataSaveAndUpdateContractConc.cathodesTolorance=valuesManagerArticle2.getValue("cathodesTolorance");
                    dataSaveAndUpdateContractConc.optional=valuesManagerArticle2.getValue("optional");
                    dataSaveAndUpdateContractConc.plant=valuesManagerArticle2.getValue("plant");
                    dataSaveAndUpdateContractConc.materialId=-42;
         alert(JSON.stringify(dataSaveAndUpdateContractConc));
    }
})
var contactFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        showEdges: true,
        backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_ContactConc_Save
        ]
    });

VLayout_contactMain=isc.VLayout.create({
            width: "100%",
            height: "100%",
            align: "center",
            overflow: "scroll",
            autoCenter: true,
            isModal: true,
            showModalMask: true,
            autoScroller:true,
            closeClick: function () {
            this.Super("closeClick", arguments);
            },
            members: [
                contactConcTabs,
                contactFormButtonSaveLayout
            ]
            })


function clearAdd(){
        contactConcTabs.selectTab(0);
        contactHeaderConc.clearValues();
        contactHeaderConcAgent.clearValues();
        valuesManagerConcArticle1.clearValues();
        valuesManagerConcArticle2.clearValues();
}