var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.url = "${contextPath}" + "/api/g-contract/"
contractTab.dynamicForm.fields.no = {
    name: "no",
    width: "10%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='contract.form.no'/>"
};
contractTab.dynamicForm.fields.date = {
    name: "date",
    type: "date",
    width: "10%",
    required: true,
    title: "<spring:message code='global.date'/>"
};
contractTab.dynamicForm.fields.affectFrom = {
    name: "affectFrom",
    type: "date",
    width: "10%",
    required: true,
    title: "affectFrom"
};
contractTab.dynamicForm.fields.affectUpTo = {
    name: "affectUpTo",
    type: "date",
    width: "10%",
    required: true,
    title: "affectUpTo"
};
contractTab.dynamicForm.fields.content = {
    name: "content",
    width: "10%",
    required: true,
    title: "<spring:message code='global.content'/>"
};
contractTab.dynamicForm.fields.description = {
    name: "description",
    width: "10%",
    required: true,
    title: "<spring:message code='global.description'/>"
};
contractTab.dynamicForm = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    align: "center",
    titleAlign: "right",
    numCols: 8,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields.no,
        contractTab.dynamicForm.fields.date,
        contractTab.dynamicForm.fields.affectFrom,
        contractTab.dynamicForm.fields.affectUpTo,
        contractTab.dynamicForm.fields.content,
        contractTab.dynamicForm.fields.description
    ], true)
});

contractTab.restDataSource = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields
    ], false),
    fetchDataURL: contractTab.variable.url + "spec-list"
});

contractTab.listGrid = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    dataSource: contractTab.restDataSource
});

contractTab.hLayout.saveOrExitHlayout = isc.HLayout.create({

    height: "5%",
    width: "100%",
    showEdges: false,
    alignLayout: "center",
    padding: 10,
    layoutMargin: 5,
    membersMargin: 10,
    members: [
        isc.IButtonSave.create({

            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
            }
        }),
        isc.IButtonCancel.create({

            width: 100,
            orientation: "vertical",
            icon: "pieces/16/icon_delete.png",
            title: "<spring:message code='global.close'/>",
            click: function () {
                contractTab.window.close();
            }
        })
    ]
});

contractTab.window = isc.Window.nicico.getDefault(null, [
    contractTab.dynamicForm,
    contractTab.hLayout.saveOrExitHlayout
], "85%", null);

contractTab.toolStrip.actions = isc.ToolStrip.create({
    width: "100%",
    members: []
});
// <sec:authorize access="hasAuthority('C_CONTRACT2')">
contractTab.toolStrip.add = isc.ToolStripButtonAdd.create({
    title: "<spring:message code='global.form.new'/>",
    click: function () {
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.add);
// </sec:authorize>
// <sec:authorize access="hasAuthority('U_CONTRACT2')">
contractTab.toolStrip.edit = isc.ToolStripButtonEdit.create({
    icon: "[SKIN]/actions/edit.png",
    title: "<spring:message code='global.form.edit'/>",
    click: function () {
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.edit);
// </sec:authorize>
// <sec:authorize access="hasAuthority('D_CONTRACT2')">
contractTab.toolStrip.remove = isc.ToolStripButtonRemove.create({
    icon: "[SKIN]/actions/remove.png",
    title: '<spring:message code="global.form.remove" />',
    click: function () {
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.remove);
// </sec:authorize>
contractTab.toolStrip.refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
    }
});
contractTab.toolStrip.actions.addMember(isc.ToolStrip.create({
    width: "100%",
    align: "left",
    border: '0px',
    members: [contractTab.toolStrip.refresh]
}));

contractTab.vLayout.body = isc.VLayout.create({

    width: "100%",
    height: "100%",
    members: [contractTab.toolStrip.actions, contractTab.listGrid]
});
