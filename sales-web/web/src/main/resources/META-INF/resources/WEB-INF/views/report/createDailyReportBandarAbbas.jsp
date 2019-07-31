<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% List<Object[]> list = (List<Object[]>) request.getAttribute("list"); %>
<% String[] names = (String[]) request.getAttribute("names"); %>
<% String day = request.getAttribute("day").toString(); %>

//<script>

    var vmDailyeReport = isc.ValuesManager.create({});

    var DynamicForm_Create_DailyReport1 = isc.DynamicForm.create({
        width: "365",
        height: "100%",
        wrapItemTitles: false,
        valuesManager: "vmDailyeReport",
        setMethod: 'POST',
        align: "center",
        action: "/report/createDailyReportBandarAbbas",
        target: "_Blank",
        margin: 0, cellPadding: 0, showTitle: false, align: "center",
        numCols: 4, colWidths: [60, "*"], border: "1px solid blue",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields:
            [
                <% for (int j = 0; j < list.size(); j++) {
                    Object[] result = list.get(j);
                    for (int i = 2; i < 6; i++) { %>

                {
                    name: "<%=names[i] + j %>",
                    ID: "<%=names[i] + j %>",
                    showTitle: false,
                    type: 'text',
                    align: "center",
                    width: 90,
                    colSpan: 1,
                    defaultValue: "<%=result[i].toString() %>"
                },
                <% } %>
                {ID: "id", hidden: true, defaultValue: "<%=result[names.length - 1].toString() %>"},
                <% }%>
            ]
    });
    var DynamicForm_Create_DailyReport2 = isc.DynamicForm.create({
        width: "365",
        height: "100%",
        wrapItemTitles: false,
        valuesManager: "vmDailyeReport",
        setMethod: 'POST',
        align: "center",
        action: "/report/createDailyReportBandarAbbas",
        target: "_Blank",
        margin: 0, cellPadding: 0, showTitle: false, align: "center",
        numCols: 4, colWidths: [60, "*"], border: "1px solid blue",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields:
            [
                <% for (int j = 0; j < list.size(); j++) {
                    Object[] result = list.get(j);
                    for (int i = 6; i < 10; i++) { %>

                {
                    name: "<%=names[i] + j %>",
                    ID: "<%=names[i] + j %>",
                    showTitle: false,
                    type: 'text',
                    align: "center",
                    width: 90,
                    colSpan: 1,
                    defaultValue: "<%=result[i].toString() %>"
                },
                <% } %>
                <% }%>
            ]
    });
    var DynamicForm_Create_DailyReport3 = isc.DynamicForm.create({
        width: "365",
        height: "100%",
        wrapItemTitles: false,
        valuesManager: "vmDailyeReport",
        setMethod: 'POST',
        align: "center",
        action: "/report/createDailyReportBandarAbbas",
        target: "_Blank",
        margin: 0, cellPadding: 0, showTitle: false, align: "center",
        numCols: 4, colWidths: [60, "*"], border: "1px solid blue",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields:
            [
                <% for (int j = 0; j < list.size(); j++) {
                    Object[] result = list.get(j);
                    for (int i = 10; i < 14; i++) { %>

                {
                    name: "<%=names[i] + j %>",
                    ID: "<%=names[i] + j %>",
                    showTitle: false,
                    type: 'text',
                    align: "center",
                    width: 90,
                    colSpan: 1,
                    defaultValue: "<%=result[i].toString() %>"
                },
                <% } %>
                <% }%>
            ]
    });
    var DynamicForm_Create_DailyReport4 = isc.DynamicForm.create({
        valuesManager: "vmDailyeReport",
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        action: "/report/createDailyReportBandarAbbas",
        margin: 0, cellPadding: 0, showTitle: false,
        numCols: 6, colWidths: [60, "*"], border: "1px solid blue",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields:
            [

                <% for (int j = 0; j < list.size(); j++) {
                    Object[] result = list.get(j);
                    for (int i = 14; i < 20; i++) { %>
                <%if (i == 19) { %>
                {
                    name: "<%=names[i] + j %>",
                    ID: "<%=names[i] + j %>",
                    showTitle: false,
                    type: 'text',
                    align: "center",
                    colSpan: 1,
                    width: 72,
                    defaultValue: "<%=result[i].toString() %>"
                },
                <%} else { %>
                {
                    name: "<%=names[i] + j %>",
                    ID: "<%=names[i] + j %>",
                    showTitle: false,
                    type: 'text',
                    align: "center",
                    width: 72,
                    colSpan: 1,
                    defaultValue: "<%=result[i].toString() %>"
                },
                <% }
                } %>

                <% }%>
            ]
    });

    var HLayout_Create_DailyReport_Actions = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                DynamicForm_Create_DailyReport1, DynamicForm_Create_DailyReport2, DynamicForm_Create_DailyReport3, DynamicForm_Create_DailyReport4
            ]
    });

    var VLayout_Create_DailyReport_Actions = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                isc.HLayout.create({
                    width: "100%",
                    height: "50",
                    members:
                        [
                            isc.Label.create({
                                height: "50",
                                width: "273",
                                contents: "<%= day %>",
                                border: "1px solid blue",
                                align: "center",

                            }),
                            isc.Label.create({
                                height: "50",
                                width: "92",
                                contents: "موجودی (پایان روز)",
                                border: "1px solid blue",
                                align: "center",

                            }),
//*********************************************day********************************
                        isc.VLayout.create({
                            width: "365",
                            height: "50",
                            members:
                                [
                                    isc.Label.create({
                                        height: "25",
                                        width: "365",
                                        contents: "روز",
                                        border: "1px solid blue",
                                        align: "center",

                                    }),
                                    isc.HLayout.create({
                                        width: "365",
                                        height: "25",
                                        members:
                                            [
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "92",
                                                    contents: "موجودی اولیه",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "ورودی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "خروجی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "تعدیل",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                            ]
                                    })
                                ]
                        }),
//*********************************************month********************************
                        isc.VLayout.create({
                            width: "365",
                            height: "50",
                            members:
                                [
                                    isc.Label.create({
                                        height: "25",
                                        width: "365",
                                        contents: "ماه",
                                        border: "1px solid blue",
                                        align: "center",

                                    }),
                                    isc.HLayout.create({
                                        width: "365",
                                        height: "25",
                                        members:
                                            [
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "92",
                                                    contents: "موجودی اولیه",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "ورودی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "خروجی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "تعدیل",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                            ]
                                    })
                                ]
                        }),
//*********************************************year********************************

                        isc.VLayout.create({
                            width: "363",
                            height: "50",
                            members:
                                [
                                    isc.Label.create({
                                        height: "25",
                                        width: "363",
                                        contents: "سال",
                                        border: "1px solid blue",
                                        align: "center",

                                    }),
                                    isc.HLayout.create({
                                        width: "363",
                                        height: "25",
                                        members:
                                            [
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "92",
                                                    contents: "موجودی اولیه",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "90",
                                                    contents: "ورودی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "90",
                                                    contents: "خروجی",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                                isc.Label.create({
                                                    height: "100%",
                                                    width: "91",
                                                    contents: "تعدیل",
                                                    border: "1px solid blue",
                                                    align: "center",

                                                }),
                                            ]
                                    })
                                ]
                        }),
//*****************************************************************
                        isc.Label.create({
                            height: "50",
                            width: "92",
                            contents: "درصد تعدیل سال (پایان روز)",
                            border: "1px solid blue",
                            align: "center",

                        }),
                    ]
                }),
                HLayout_Create_DailyReport_Actions,

                isc.IButton.create({
                    top: 260,
                    title: "<spring:message code='global.form.save'/>",
                    icon: "pieces/16/save.png",
                    click: function () {

                        if (DynamicForm_Create_DailyReport1.hasErrors() || DynamicForm_Create_DailyReport2.hasErrors() || DynamicForm_Create_DailyReport3.hasErrors() || DynamicForm_Create_DailyReport4.hasErrors())
                            return;

                        DynamicForm_Create_DailyReport1.setValue("TO_DAY", "<%=day%>");

                        var data = vmDailyeReport.getValues();
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/dailyReportBandarAbbas/add",
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: false,
                            data: JSON.stringify(data),
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    isc.say("<spring:message code='global.form.request.successful'/>.");
                                    ListGrid_ContractPenalty_refresh();
                                    Window_ContractPenalty.close();
                                } else
                                    isc.say(RpcResponse_o.data);
                            }
                        });
                    }//fun

                })

            ]
    });