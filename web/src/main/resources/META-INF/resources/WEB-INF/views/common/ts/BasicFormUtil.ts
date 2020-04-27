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

        static getDefaultBasicForm(entity: string, creator: JSPTabVariable, gridFields: Array<Partial<isc.ListGridField>>, formFields: Array<Partial<isc.FormItem>>, fetchDataUrl: string, criteria: Criteria): isc.VLayout {

            // @ts-ignore
            let dynamicForm = isc.DynamicForm.nicico.getDefault(formFields);
            // @ts-ignore
            let dataSource = isc.RestDataSource.nicico.getDefault(fetchDataUrl, gridFields);
            // @ts-ignore
            let grid = isc.ListGrid.nicico.getDefault(gridFields, dataSource, criteria);

            entity = entity.toUpperCase();
            let menu = isc.Menu.create({

                width: 150,
                data: [
                    // @ts-ignore
                    // <sec:authorize access="hasAuthority('C_' + entity)">
                    {
                        icon: "pieces/16/icon_add.png",
                        title: '<spring:message code="global.form.new"/>',
                        click: creator.method.newForm(dynamicForm)
                    },
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('U_' + entity)">
                    {
                        icon: "pieces/16/icon_edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: creator.method.editForm(grid, dynamicForm)
                    },
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('D_' + entity')">
                    {
                        icon: "pieces/16/icon_delete.png",
                        title: '<spring:message code="global.form.remove"/>',
                        click: creator.method.delete(grid)
                    },
                    // </sec:authorize>
                    {
                        icon: "pieces/16/refresh.png",
                        title: '<spring:message code="global.form.refresh"/>',
                        click: creator.method.refresh(grid)
                    }
                ]
            });
            // @ts-ignore
            isc.Canvas.nicico.changeProperties(grid, "contextMenu", menu);

            // @ts-ignore
            let toolStrip = isc.ToolStrip.create({
                width: "100%",
                members: [
                    ,
                    // <sec:authorize access="hasAuthority('C_' + entity)">
                    // @ts-ignore
                    isc.ToolStripButtonAdd.create({
                        click: creator.method.newForm(dynamicForm),
                        title: "<spring:message code='global.form.new'/>"
                    }),
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('U_' + entity)">
                    // @ts-ignore
                    isc.ToolStripButtonEdit.create({
                        icon: "[SKIN]/actions/edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: creator.method.editForm(grid, dynamicForm)
                    }),
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('D_' + entity)">
                    // @ts-ignore
                    isc.ToolStripButtonRemove.create({
                        icon: "[SKIN]/actions/remove.png",
                        title: "<spring:message code='global.form.remove'/>",
                        click: creator.method.delete(grid)
                    }),
                    // </sec:authorize>

                    isc.ToolStrip.create(
                        {
                            width: "100%",
                            align: "left",
                            border: '0px',
                            members: [
                                // @ts-ignore
                                isc.ToolStripButtonRefresh.create({
                                    click: creator.method.refresh(grid),
                                    title: "<spring:message code='global.form.refresh'/>"
                                })
                            ]
                        })
                ]
            });

            return isc.VLayout.create({

                width: "100%",
                members: [toolStrip, grid]
            });
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
