//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class BasicFormUtil {

        static getDefaultBasicForm(creator: JSPTabVariable, restControllerUrl: string): isc.VLayout {

            // @ts-ignore
            creator.variable.url += restControllerUrl.replaceAll(new RegExp("^/|/$"),'') + '/';
            // @ts-ignore
            creator.dynamicForm.main = isc.DynamicForm.nicico.getDefault(creator.dynamicForm.fields);
            // @ts-ignore
            creator.dynamicForm.main.hide();
            // @ts-ignore
            creator.restDataSource.main = isc.RestDataSource.nicico.getDefault(creator.variable.url + "spec-list", creator.listGrid.fields);
            // @ts-ignore
            creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, creator.listGrid.criteria);

            // @ts-ignore
            creator.menu.main = isc.Menu.create({

                width: 150,
                data: [
                    // <c:if test = "${c_entity}">
                    {
                        icon: "pieces/16/icon_add.png",
                        title: '<spring:message code="global.form.new"/>',
                        click: function() {
                            // @ts-ignore
                            creator.method.newForm("", creator.listGrid.main, creator.dynamicForm.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    {
                        icon: "pieces/16/icon_edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function() {
                            // @ts-ignore
                            creator.method.editForm("", creator.listGrid.main, creator.dynamicForm.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    {
                        icon: "pieces/16/icon_delete.png",
                        title: '<spring:message code="global.form.remove"/>',
                        click: function() {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main)
                        }
                    },
                    // </c:if>
                    {
                        icon: "pieces/16/refresh.png",
                        title: '<spring:message code="global.form.refresh"/>',
                        click: function() {
                            // @ts-ignore
                            creator.method.refresh(creator.listGrid.main)
                        }
                    }
                ]
            });
            // @ts-ignore
            isc.Canvas.nicico.changeProperties(creator.listGrid.main, "contextMenu", creator.menu.main);

            // @ts-ignore
            creator.toolStrip.main = isc.ToolStrip.create({
                width: "100%",
                members: [

                    // <c:if test = "${c_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonAdd.create({
                        title: "<spring:message code='global.form.new'/>",
                        click: function() {
                            // @ts-ignore
                            creator.method.newForm("", creator.listGrid.main, creator.dynamicForm.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonEdit.create({
                        icon: "[SKIN]/actions/edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function() {
                            // @ts-ignore
                            creator.method.editForm("", creator.listGrid.main, creator.dynamicForm.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonRemove.create({
                        icon: "[SKIN]/actions/remove.png",
                        title: "<spring:message code='global.form.remove'/>",
                        click: function() {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main)
                        }
                    }),
                    // </c:if>
                    isc.ToolStrip.create(
                        {
                            width: "100%",
                            align: "left",
                            border: '0px',
                            members: [
                                // @ts-ignore
                                isc.ToolStripButtonRefresh.create({
                                    title: "<spring:message code='global.form.refresh'/>",
                                    click: function() {
                                        // @ts-ignore
                                        creator.method.refresh(creator.listGrid.main)
                                    }
                                })
                            ]
                        })
                ]
            });

            // @ts-ignore
            creator.vLayout.main = isc.VLayout.create({

                width: "100%",
                // @ts-ignore
                members: [creator.toolStrip.main, creator.listGrid.main]
            });

            // @ts-ignore
            return creator.vLayout.main;
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
