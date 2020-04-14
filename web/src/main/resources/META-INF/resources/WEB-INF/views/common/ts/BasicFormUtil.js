//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var BasicFormUtil = /** @class */ (function () {
        function BasicFormUtil() {
        }
        BasicFormUtil.getDefaultBasicForm = function (creator, gridFields, formFields, fetchDataUrl, criteria) {
            // @ts-ignore
            var dynamicForm = isc.DynamicForm.evaluation.getDefault(formFields);
            // @ts-ignore
            var dataSource = isc.RestDataSource.evaluation.getDefault(fetchDataUrl, gridFields);
            // @ts-ignore
            var grid = isc.ListGrid.evaluation.getDefault(gridFields, dataSource);
            var crudActions = [];
            crudActions.add(creator.method.refresh(grid));
            crudActions.add(creator.method.newForm(dynamicForm));
            crudActions.add(creator.method.editForm(grid, dynamicForm));
            crudActions.add(creator.method["delete"](grid));
            // @ts-ignore
            var menu = isc.Menu.evaluation.getDefault(crudActions);
            // @ts-ignore
            isc.ListGrid.evaluation.changeProperties(grid, "contextMenu", menu);
            // @ts-ignore
            var toolStrip = isc.ToolStrip.evaluation.getDefault(crudActions);
            // @ts-ignore
            return isc.VLayout.evaluation.getDefault([toolStrip, grid]);
        };
        return BasicFormUtil;
    }());
    evaluation.BasicFormUtil = BasicFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//
