//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>

// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace evaluation {

    //------------------------------------------ Classes -------------------------------------------

    export class BasicFormUtil {

        static getDefaultBasicForm(creator: JSPTabVariable, gridFields: Array<Partial<isc.ListGridField>>, formFields: Array<Partial<isc.FormItem>>, fetchDataUrl: string, criteria: Criteria): isc.VLayout {

            // @ts-ignore
            let dynamicForm = isc.DynamicForm.evaluation.getDefault(formFields);
            // @ts-ignore
            let dataSource = isc.RestDataSource.evaluation.getDefault(fetchDataUrl, gridFields);
            // @ts-ignore
            let grid = isc.ListGrid.evaluation.getDefault(gridFields, dataSource);

            let crudActions: any[4] = [];
            crudActions.add(creator.method.refresh(grid));
            crudActions.add(creator.method.newForm(dynamicForm));
            crudActions.add(creator.method.editForm(grid, dynamicForm));
            crudActions.add(creator.method.delete(grid));
            // @ts-ignore
            let menu = isc.Menu.evaluation.getDefault(crudActions);
            // @ts-ignore
            isc.ListGrid.evaluation.changeProperties(grid, "contextMenu", menu);
            // @ts-ignore
            var toolStrip = isc.ToolStrip.evaluation.getDefault(crudActions);

            // @ts-ignore
            return isc.VLayout.evaluation.getDefault([toolStrip, grid]);
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//