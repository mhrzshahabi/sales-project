//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var FilterFormUtil = /** @class */ (function () {
        function FilterFormUtil() {
        }
        FilterFormUtil.createFilterBuilder = function (creator) {
            // @ts-ignore
            creator.filterBuilder.main = isc.FilterBuilder.create({
                // @ts-ignore
                dataSource: creator.restDataSource.main,
                criteria: {
                    // @ts-ignore
                    _constructor: "AdvancedCriteria",
                    operator: "and", criteria: []
                },
                fieldPickerWidth: "200",
                valueItemWidth: "200",
                width: "95%",
                height: "100%",
                margin: 5
            });
            // @ts-ignore
            creator.filterBuilder.main.topOperatorForm.setHeight("95%");
        };
        FilterFormUtil.createButtonLayout = function (creator) {
            var This = this;
            // @ts-ignore
            var cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    // @ts-ignore
                    creator.window.main.close();
                    // @ts-ignore
                    if (creator.variable.owner != null)
                        // @ts-ignore
                        creator.variable.owner.show();
                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            // @ts-ignore
            var ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    // @ts-ignore
                    creator.window.main.close();
                    // @ts-ignore
                    if (creator.variable.owner != null)
                        // @ts-ignore
                        creator.variable.owner.show();
                    // @ts-ignore
                    This.okCallBack(creator.filterBuilder.main.getCriteria());
                },
                icon: "pieces/16/save.png",
                title: '<spring:message code="global.ok" />'
            });
            // @ts-ignore
            creator.hLayout.main = isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        };
        FilterFormUtil.createWindow = function (creator, title) {
            // @ts-ignore
            var width = creator.variable.width ? creator.variable.width : "40%";
            // @ts-ignore
            var height = creator.variable.height ? creator.variable.height : "400";
            // @ts-ignore
            creator.window.main = isc.Window.nicico.getDefault(title, [
                // @ts-ignore
                creator.filterBuilder.main, creator.hLayout.main
            ], width, height);
        };
        FilterFormUtil.show = function (owner, title, restDataSource, width, height) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            var creator = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
            // @ts-ignore
            creator.restDataSource.main = restDataSource;
            // @ts-ignore
            creator.variable.width = width;
            // @ts-ignore
            creator.variable.height = height;
            // @ts-ignore
            creator.variable.owner = owner;
            if (owner != null)
                owner.close();
            this.createFilterBuilder(creator);
            this.createButtonLayout(creator);
            this.createWindow(creator, title);
            // @ts-ignore
            creator.window.main.show();
            // @ts-ignore
            return creator.window.main;
        };
        FilterFormUtil.cancelCallBack = function () {
            return;
        };
        FilterFormUtil.okCallBack = function (criteria) {
            return criteria;
        };
        return FilterFormUtil;
    }());
    nicico.FilterFormUtil = FilterFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
