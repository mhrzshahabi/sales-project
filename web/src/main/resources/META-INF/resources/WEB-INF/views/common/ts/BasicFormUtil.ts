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

        static createToolStrip(creator): void {
            // @ts-ignore
            creator.toolStrip.main = isc.ToolStrip.create({
                width: "100%",
                members: [

                    // <c:if test = "${c_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonAdd.create({
                        title: "<spring:message code='global.form.new'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.newForm('<spring:message code="global.form.new"/>', creator.listGrid.main, creator.dynamicForm.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonEdit.create({
                        icon: "[SKIN]/actions/edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonRemove.create({
                        icon: "[SKIN]/actions/remove.png",
                        title: "<spring:message code='global.form.remove'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${a_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        visibility: "hidden",
                        // @ts-ignore
                        role: "activateRecord",
                        icon: "[SKIN]/actions/configure.png",
                        title: "<spring:message code='global.active'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.activate(creator.listGrid.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${i_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        visibility: "hidden",
                        // @ts-ignore
                        role: "deactivateRecord",
                        icon: "[SKIN]/actions/exclamation.png",
                        title: "<spring:message code='global.inactive'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.deactivate(creator.listGrid.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${f_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        visibility: "hidden",
                        // @ts-ignore
                        role: "finalizeRecord",
                        icon: "[SKIN]/actions/accept.png",
                        title: "<spring:message code='global.form.accept'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.finalize(creator.listGrid.main)
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${o_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        visibility: "hidden",
                        // @ts-ignore
                        role: "disapproveRecord",
                        icon: "[SKIN]/actions/refresh.png",
                        title: "<spring:message code='global.form.disapprove'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.disapprove(creator.listGrid.main)
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
                                    click: function () {
                                        // @ts-ignore
                                        creator.method.refresh(creator.listGrid.main)
                                    }
                                })
                            ]
                        })
                ]
            });
        }

        static createRestDataSource(creator): void {
            // @ts-ignore
            creator.restDataSource.main = isc.RestDataSource.nicico.getDefault(creator.variable.url + "spec-list", creator.listGrid.fields, creator.method.transformRequest);
        }

        static createListGrid(creator): void {
            // @ts-ignore
            creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, creator.listGrid.criteria);
        }

        static createListGridMenu(creator): void {
            // @ts-ignore
            creator.menu.main = isc.Menu.create({
                width: 150,
                items: [
                    {
                        icon: "pieces/16/refresh.png",
                        title: '<spring:message code="global.form.refresh"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.refresh(creator.listGrid.main)
                        }
                    },
                    // <c:if test = "${c_entity}">
                    {
                        icon: "pieces/16/icon_add.png",
                        title: '<spring:message code="global.form.new"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.newForm('<spring:message code="global.form.new"/>', creator.listGrid.main, creator.dynamicForm.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    {
                        icon: "pieces/16/icon_edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    {
                        icon: "pieces/16/icon_delete.png",
                        title: '<spring:message code="global.form.remove"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${a_entity}">
                    {
                        // @ts-ignore
                        role: "activateRecord",
                        icon: "pieces/16/configure.png",
                        title: '<spring:message code="global.active"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.activate(creator.listGrid.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${i_entity}">
                    {
                        // @ts-ignore
                        role: "deactivateRecord",
                        icon: "pieces/16/exclamation.png",
                        title: '<spring:message code="global.inactive"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.deactivate(creator.listGrid.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${f_entity}">
                    {
                        // @ts-ignore
                        role: "finalizeRecord",
                        icon: "pieces/16/accept.png",
                        title: '<spring:message code="global.form.accept"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.finalize(creator.listGrid.main)
                        }
                    },
                    // </c:if>
                    // <c:if test = "${o_entity}">
                    {
                        // @ts-ignore
                        role: "disapproveRecord",
                        icon: "pieces/16/refresh.png",
                        title: '<spring:message code="global.form.disapprove"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.disapprove(creator.listGrid.main)
                        }
                    }
                    // </c:if>
                ]
            });
            // @ts-ignore
            isc.Canvas.nicico.changeProperties(creator.listGrid.main, "contextMenu", creator.menu.main);
        }

        static createDynamicForm(creator): void {
            // @ts-ignore
            creator.dynamicForm.main = isc.DynamicForm.nicico.getDefault(creator.dynamicForm.fields);
            // @ts-ignore
            creator.dynamicForm.main.hide();
        }

        static createVLayout(creator): void {
            // @ts-ignore
            creator.vLayout.main = isc.VLayout.create({

                width: "100%",
                // @ts-ignore
                members: [creator.toolStrip.main, creator.listGrid.main]
            });
        }

        static getDefaultBasicForm(creator: JSPTabVariable, restControllerUrl: string, createWindowHook: any): isc.VLayout {

            // @ts-ignore
            creator.variable.url += restControllerUrl.replaceAll(new RegExp("^/|/$"), '') + '/';

            this.createDynamicForm(creator);
            this.createRestDataSource(creator);
            this.createListGrid(creator);
            // <c:if test = "${u_entity}">
            // @ts-ignore
            creator.listGrid.main.recordDoubleClick = function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                // @ts-ignore
                creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main)
            }
            // </c:if>
            this.createListGridMenu(creator);
            this.createToolStrip(creator);

            if (createWindowHook && createWindowHook instanceof Function)
                createWindowHook(creator);

            this.createVLayout(creator);

            // @ts-ignore
            return creator.vLayout.main;
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
