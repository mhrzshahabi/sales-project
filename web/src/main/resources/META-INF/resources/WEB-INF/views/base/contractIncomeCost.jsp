<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<% String[][] contractIncomeCostFields = (String[][]) request.getAttribute("contractIncomeCostFields"); %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var fields = createFields();

    function createFields() {
        var fields = [];
        <%for (int i = 0; i < contractIncomeCostFields.length; i++) {%>
        fields.add({
            name: "<%=contractIncomeCostFields[i][0] %>",
            title: "<%=contractIncomeCostFields[i][0] %>",
            showIf: "false"
        });
        <%}%>
        return fields;
    }

    function getOrderedFields(fields) {
        var orderedFields = [];
        for (i = 0; i < fields.length; i++) {
            var field = fields[i];
            if (field.showIf != null) orderedFields.add(field);
        }
        return orderedFields;
    }

    function ListGrid_ContractIncomeCost_refresh() {
        ListGrid_ContractIncomeCost.invalidateCache();
    }

    function ListGrid_ContractIncomeCost_field_picker() {
        pickableFields.delayCall("editFields");
    }

    var RestDataSource_ContractIncomeCost = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                <% for(int i=0;i<contractIncomeCostFields.length;i++) { %>
                {
                    name: "<%=contractIncomeCostFields[i][0] %>",
                    title: "<%=contractIncomeCostFields[i][0] %>"
                },
                <% } %>
            ],
        fetchDataURL: "${contextPath}/api/contractIncomeCost/spec-list"
    });

    var fltContractIncomeCost = isc.FilterBuilder.create({dataSource: RestDataSource_ContractIncomeCost});
    var HLayout_ContractIncomeCost_labels = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        height: 22,
        showEdges: false,
        members: [
            isc.IButton.create({
                width: 100,
                height: 22,
                title: "جستجو",
                icon: "icon/search.png",
                click: function () {
                    ListGrid_ContractIncomeCost.filterData(fltContractIncomeCost.getCriteria());
                }
            })
        ]
    });

    var Menu_ListGrid_ContractIncomeCost = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var viewState = ListGrid_ContractIncomeCost.getViewState();
                    viewState = viewState.substring(1, viewState.length - 1);
                    window.open('contractIncomeCost/print/pdf/' +
                        encodeURIComponent(JSON.stringify(fltContractIncomeCost.getCriteria())) + "/" +
                        encodeURIComponent(viewState));
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var viewState = ListGrid_ContractIncomeCost.getViewState();
                    viewState = viewState.substring(1, viewState.length - 1);
                    window.open('contractIncomeCost/print/excel/' +
                        encodeURIComponent(JSON.stringify(fltContractIncomeCost.getCriteria())) + "/" +
                        encodeURIComponent(viewState));
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var viewState = ListGrid_ContractIncomeCost.getViewState();
                    viewState = viewState.substring(1, viewState.length - 1);
                    window.open('contractIncomeCost/print/html/' +
                        encodeURIComponent(JSON.stringify(fltContractIncomeCost.getCriteria())) + "/" +
                        encodeURIComponent(viewState));
                }
            }
        ]
    });

    isc.FieldPicker.addProperties({
        styleName: "fieldpicker_style"
    });

    var ListGrid_ContractIncomeCost = isc.ListGrid.create({
        ID: "pickableFields",

        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContractIncomeCost,
        contextMenu: Menu_ListGrid_ContractIncomeCost,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true,
        filterOnKeypress: true,
        canEditTitles: true,
        useAdvancedFieldPicker: true,
        fields: getOrderedFields(fields)
    });

    pickableFields.delayCall("editFields");

    var ToolStripButton_ContractIncomeCost_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractIncomeCost_refresh();
        }
    });

    var ToolStripButton_ContractIncomeCost_FieldPicker = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.selectfieldpicker'/>",
        click: function () {
            ListGrid_ContractIncomeCost_field_picker();
        }
    });

    var ToolStrip_Actions_ContractIncomeCost = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ContractIncomeCost_Refresh,
                ToolStripButton_ContractIncomeCost_FieldPicker,
                isc.Label.create({
                    width: 25,
                }),
                isc.HTMLFlow.create({
                    contents: "در هنگام چاپ تنها 7 ستون اول از سمت راست نمایش داده می شود",
                    width: "325px",
                    border: "1px solid red"
                })
            ]
    });

    var HLayout_ContractIncomeCost_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ContractIncomeCost
            ]
    });

    var VLayout_fltContractIncomeCost = isc.VLayout.create(
        {
            layoutMargin: 10,
            members: [fltContractIncomeCost]
        }
    );

    var VLayout_ContractIncomeCost_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            VLayout_fltContractIncomeCost,
            HLayout_ContractIncomeCost_labels,
            ListGrid_ContractIncomeCost
        ]
    });
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_ContractIncomeCost_Actions, VLayout_ContractIncomeCost_Grid
        ]
    });